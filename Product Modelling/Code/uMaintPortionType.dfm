object fMaintPortionType: TfMaintPortionType
  Left = 467
  Top = 222
  Width = 328
  Height = 411
  Caption = 'New Portion Type'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 320
    Height = 24
    Align = alTop
    Alignment = taCenter
    Caption = 'New Portion Type'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 76
    Top = 44
    Width = 38
    Height = 13
    Alignment = taRightJustify
    Caption = '* Name:'
  end
  object Label4: TLabel
    Left = 35
    Top = 176
    Width = 79
    Height = 13
    Alignment = taRightJustify
    Caption = 'Course Override:'
  end
  object Label3: TLabel
    Left = 58
    Top = 73
    Width = 56
    Height = 13
    Alignment = taRightJustify
    Caption = 'Description:'
  end
  object Label5: TLabel
    Left = 16
    Top = 101
    Width = 98
    Height = 13
    Alignment = taRightJustify
    Caption = '* EPoS Panel Name:'
  end
  object Label6: TLabel
    Left = 61
    Top = 293
    Width = 53
    Height = 13
    Caption = 'Applies To:'
  end
  object Label7: TLabel
    Left = 47
    Top = 205
    Width = 67
    Height = 13
    Caption = '* Price Factor:'
  end
  object MandatoryFieldLabel: TLabel
    Left = 4
    Top = 366
    Width = 122
    Height = 13
    Caption = '* denotes mandatory field.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object edtName: TEdit
    Left = 127
    Top = 40
    Width = 185
    Height = 21
    MaxLength = 16
    TabOrder = 0
  end
  object btnOK: TBitBtn
    Left = 164
    Top = 354
    Width = 75
    Height = 25
    TabOrder = 8
    OnClick = btnOKClick
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 242
    Top = 354
    Width = 75
    Height = 25
    TabOrder = 9
    OnClick = btnCancelClick
    Kind = bkCancel
  end
  object edtDescription: TEdit
    Left = 127
    Top = 69
    Width = 185
    Height = 21
    MaxLength = 20
    TabOrder = 1
  end
  object edtEpos1: TEdit
    Left = 127
    Top = 97
    Width = 103
    Height = 21
    MaxLength = 8
    TabOrder = 2
  end
  object edtEpos2: TEdit
    Left = 127
    Top = 120
    Width = 103
    Height = 21
    MaxLength = 8
    TabOrder = 3
  end
  object edtEpos3: TEdit
    Left = 127
    Top = 143
    Width = 103
    Height = 21
    MaxLength = 8
    TabOrder = 4
  end
  object GroupBox1: TGroupBox
    Left = 128
    Top = 287
    Width = 185
    Height = 57
    TabOrder = 7
    object rbNextSel: TRadioButton
      Left = 16
      Top = 12
      Width = 129
      Height = 17
      Caption = 'Next Selection Only'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbAllSel: TRadioButton
      Left = 16
      Top = 34
      Width = 161
      Height = 17
      Caption = 'All Selections Until Cancelled'
      TabOrder = 1
    end
  end
  object edtPriceFactor: TEdit
    Left = 128
    Top = 201
    Width = 101
    Height = 21
    MaxLength = 5
    TabOrder = 5
    Text = '1'
    OnKeyPress = edtPriceFactorKeyPress
  end
  object chkAutoAnd: TCheckBox
    Left = 66
    Top = 266
    Width = 75
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Auto And:'
    TabOrder = 6
  end
  object PriceFactorGroupBox: TGroupBox
    Left = 128
    Top = 226
    Width = 185
    Height = 33
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 10
    object PercentageRadioButton: TRadioButton
      Left = 16
      Top = 11
      Width = 80
      Height = 17
      Caption = 'Percentage'
      TabOrder = 0
      OnClick = PriceFactorChange
    end
    object FactorRadioButton: TRadioButton
      Left = 109
      Top = 11
      Width = 51
      Height = 17
      Caption = 'Factor'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = PriceFactorChange
    end
  end
  object CourseOverrideComboBox: TComboBox
    Left = 127
    Top = 172
    Width = 103
    Height = 21
    ItemHeight = 13
    TabOrder = 11
    OnChange = CourseOverrideComboBoxChange
  end
  object tblPortionType: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'PortionType'
    Top = 24
  end
  object dsPortion: TDataSource
    DataSet = tblCourses
    Left = 32
    Top = 24
  end
  object tblCourses: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'Courses'
    Left = 80
    Top = 24
  end
  object dsCourses: TDataSource
    DataSet = tblCourses
    Left = 112
    Top = 24
  end
end
