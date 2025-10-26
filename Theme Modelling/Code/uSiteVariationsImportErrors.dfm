object SiteVariationsImportErrors: TSiteVariationsImportErrors
  Left = 670
  Top = 337
  BorderStyle = bsSingle
  Caption = 'Site Variations - Import Errors'
  ClientHeight = 110
  ClientWidth = 313
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 294
    Height = 65
    AutoSize = False
    Caption = 
      'No data was imported, as one or more invalid variation values we' +
      're entered.'#13#10'Please select "Details" to see what sites and colum' +
      'ns need to be corrected.'
    WordWrap = True
  end
  object btnDetails: TButton
    Left = 152
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Details'
    TabOrder = 0
    OnClick = btnDetailsClick
  end
  object btnOk: TButton
    Left = 232
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
end
