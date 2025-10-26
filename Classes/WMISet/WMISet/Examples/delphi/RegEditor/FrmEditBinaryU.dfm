object FrmEditBinaryValue: TFrmEditBinaryValue
  Left = 192
  Top = 124
  BorderStyle = bsDialog
  Caption = 'Edit Binary Value'
  ClientHeight = 323
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object lblValueName: TLabel
    Left = 8
    Top = 8
    Width = 75
    Height = 16
    Caption = 'Value name:'
  end
  object lblValueData: TLabel
    Left = 8
    Top = 62
    Width = 68
    Height = 16
    Caption = 'Value data:'
  end
  object edtValueName: TEdit
    Left = 8
    Top = 28
    Width = 460
    Height = 24
    ParentColor = True
    ReadOnly = True
    TabOrder = 0
  end
  object btnOk: TButton
    Left = 304
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 392
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object dgData: TDrawGrid
    Left = 8
    Top = 88
    Width = 457
    Height = 185
    ColCount = 10
    DefaultColWidth = 20
    DefaultRowHeight = 18
    FixedCols = 0
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier'
    Font.Style = []
    Options = [goFixedVertLine, goVertLine, goAlwaysShowEditor]
    ParentFont = False
    TabOrder = 3
    OnDrawCell = dgDataDrawCell
    OnGetEditText = dgDataGetEditText
  end
end
