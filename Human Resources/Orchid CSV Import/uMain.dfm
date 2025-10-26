object frmCSVImport: TfrmCSVImport
  Left = 545
  Top = 342
  Width = 488
  Height = 157
  Caption = 'Employee Import Tool'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    480
    130)
  PixelsPerInch = 96
  TextHeight = 13
  object bvlBevel: TBevel
    Left = 3
    Top = 67
    Width = 468
    Height = 4
  end
  object lblImportPath: TLabel
    Left = 5
    Top = 16
    Width = 54
    Height = 13
    Caption = 'Import Path'
  end
  object btnImport: TButton
    Left = 314
    Top = 98
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Import'
    Enabled = False
    TabOrder = 0
    OnClick = btnImportClick
  end
  object btnCancel: TButton
    Left = 401
    Top = 98
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object CSVImportBar: TAztecProgressBar
    Left = 3
    Top = 76
    width = 468
    height = 16
    orientation = boHorizontal
    barKind = bkCylinder
    barLook = blMetal
    roundCorner = True
    backgroundColor = clSilver
    barColor = clBlue
    startColor = clBlue
    finalColor = clSilver
    showInactivePos = False
    invertInactPos = False
    inactivePosColor = clWindow
    shaped = True
    shapeColor = clSilver
    blockSize = 0
    spaceSize = 0
    showFullBlock = False
    maximum = 100
    position = 50
    captionAlign = taLeftJustify
    font.Charset = DEFAULT_CHARSET
    font.Color = clWindowText
    font.Height = -11
    font.Name = 'MS Sans Serif'
    font.Style = []
    AutoCaption = False
    AutoHint = False
    ShowPosAsPct = False
    Visible = False
  end
  object fedImportFile: TFilenameEdit
    Left = 4
    Top = 36
    Width = 468
    Height = 21
    Filter = 'CSV Files|*.csv'
    DirectInput = False
    NumGlyphs = 1
    TabOrder = 3
    OnChange = fedImportFileChange
  end
  object AztecConn: TADOConnection
    CommandTimeout = 0
    Left = 127
    Top = 103
  end
  object qryOrchidImport: TADOQuery
    CommandTimeout = 0
    Parameters = <>
    Left = 193
    Top = 96
  end
  object qryInsertRecords: TADOQuery
    AutoCalcFields = False
    Parameters = <>
    Left = 59
    Top = 97
  end
end
