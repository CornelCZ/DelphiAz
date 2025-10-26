object frmEditValidationConfigs: TfrmEditValidationConfigs
  Left = 503
  Top = 319
  HelpContext = 5078
  BorderStyle = bsSingle
  Caption = 'Card Validation Response'
  ClientHeight = 288
  ClientWidth = 409
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
  object grpbxRegistered: TGroupBox
    Left = 0
    Top = 112
    Width = 409
    Height = 65
    Caption = '  Response if Card is absent  '
    TabOrder = 1
    object lblMessageReg: TLabel
      Left = 8
      Top = 28
      Width = 43
      Height = 13
      Caption = 'Message'
    end
    object edAbsentMsg: TEdit
      Left = 88
      Top = 24
      Width = 281
      Height = 21
      MaxLength = 40
      TabOrder = 0
    end
  end
  object grbxNoResponse: TGroupBox
    Left = 1
    Top = 6
    Width = 408
    Height = 97
    Caption = '  Response if Card Validation is unavailable  '
    TabOrder = 0
    object lblDefaultRating: TLabel
      Left = 8
      Top = 28
      Width = 68
      Height = 13
      Caption = 'Default Rating'
    end
    object lblMessageResponse: TLabel
      Left = 8
      Top = 60
      Width = 43
      Height = 13
      Caption = 'Message'
    end
    object edNoResponseMsg: TEdit
      Left = 88
      Top = 56
      Width = 281
      Height = 21
      MaxLength = 40
      TabOrder = 1
    end
    object cbxDefaultRating: TComboBox
      Left = 88
      Top = 24
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object btnClose: TButton
    Left = 333
    Top = 260
    Width = 75
    Height = 25
    Caption = '&Close'
    ModalResult = 1
    TabOrder = 3
  end
  object grbxNotRegistered: TGroupBox
    Left = 0
    Top = 186
    Width = 409
    Height = 65
    Caption = '  Response if Card is present'
    TabOrder = 2
    object lblMessageNotReg: TLabel
      Left = 8
      Top = 28
      Width = 43
      Height = 13
      Caption = 'Message'
    end
    object edPresentMsg: TEdit
      Left = 88
      Top = 24
      Width = 281
      Height = 21
      MaxLength = 40
      TabOrder = 0
    end
  end
  object qValidConfigs: TADOQuery
    Connection = dmADO_SwipeRange.AztecConn
    Parameters = <
      item
        Name = 'RangeID'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT NoSoapRating, NoSoapMsg, PresentMsg, AbsentMsg '
      '                                FROM CardRangeValidationConfig '
      
        '                          WHERE Deleted = 0 AND RangeID = :Range' +
        'ID')
    Left = 8
    Top = 256
    object qValidConfigsNoSoapRating: TIntegerField
      FieldName = 'NoSoapRating'
    end
    object qValidConfigsNoSoapMsg: TStringField
      FieldName = 'NoSoapMsg'
      Size = 40
    end
    object qValidConfigsPresentMsg: TStringField
      FieldName = 'PresentMsg'
      Size = 40
    end
    object qValidConfigsAbsentMsg: TStringField
      FieldName = 'AbsentMsg'
      Size = 40
    end
  end
end
