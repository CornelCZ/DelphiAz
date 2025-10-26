object frmPassword: TfrmPassword
  Left = 451
  Top = 242
  HelpContext = 100
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Log in...'
  ClientHeight = 111
  ClientWidth = 279
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 5
    Top = 43
    Width = 60
    Height = 16
    Caption = 'Password:'
  end
  object Label2: TLabel
    Left = 5
    Top = 11
    Width = 68
    Height = 16
    Caption = 'User Name:'
  end
  object edtPassword: TEdit
    Left = 83
    Top = 39
    Width = 189
    Height = 24
    PasswordChar = '*'
    TabOrder = 1
    OnKeyPress = edtPasswordKeyPress
  end
  object btnOK: TButton
    Left = 37
    Top = 73
    Width = 92
    Height = 30
    Caption = '&OK'
    TabOrder = 2
    OnClick = btnOKClick
  end
  object CancelBtn: TButton
    Left = 152
    Top = 73
    Width = 92
    Height = 30
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 3
    OnClick = CancelBtnClick
  end
  object edtUserName: TEdit
    Left = 83
    Top = 7
    Width = 189
    Height = 24
    TabOrder = 0
    OnKeyPress = edtUserNameKeyPress
  end
end
