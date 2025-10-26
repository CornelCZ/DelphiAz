object FWarn: TFWarn
  Left = 251
  Top = 196
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Schedule Warning Controls'
  ClientHeight = 416
  ClientWidth = 712
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
  object Panel1: TPanel
    Left = 1
    Top = 2
    Width = 709
    Height = 353
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 154
      Height = 16
      Hint = 'Use spage bar or ouse button to change value'
      Caption = 'Warn by Employee Hours'
      ParentShowHint = False
      ShowHint = True
    end
    object Label9: TLabel
      Left = 213
      Top = 20
      Width = 162
      Height = 16
      Caption = 'Maximum Time for Warning'
    end
    object Label16: TLabel
      Left = 213
      Top = 312
      Width = 158
      Height = 16
      Caption = 'Maximum Cost for Warning'
    end
    object Label15: TLabel
      Left = 213
      Top = 270
      Width = 162
      Height = 16
      Caption = 'Maximum Time for Warning'
    end
    object Label14: TLabel
      Left = 213
      Top = 229
      Width = 158
      Height = 16
      Caption = 'Maximum Cost for Warning'
    end
    object Label13: TLabel
      Left = 213
      Top = 187
      Width = 162
      Height = 16
      Caption = 'Maximum Time for Warning'
    end
    object Label12: TLabel
      Left = 213
      Top = 145
      Width = 158
      Height = 16
      Caption = 'Maximum Cost for Warning'
    end
    object Label11: TLabel
      Left = 213
      Top = 103
      Width = 162
      Height = 16
      Caption = 'Maximum Time for Warning'
    end
    object Label10: TLabel
      Left = 213
      Top = 62
      Width = 158
      Height = 16
      Caption = 'Maximum Cost for Warning'
    end
    object label2: TLabel
      Left = 16
      Top = 62
      Width = 145
      Height = 16
      Hint = 'Use spage bar or ouse button to change value'
      Caption = 'Warn by Employee Cost'
      ParentShowHint = False
      ShowHint = True
    end
    object Label3: TLabel
      Left = 16
      Top = 103
      Width = 157
      Height = 16
      Hint = 'Use spage bar or ouse button to change value'
      Caption = 'Warn by Job Week  Hours'
      ParentShowHint = False
      ShowHint = True
    end
    object label4: TLabel
      Left = 16
      Top = 145
      Width = 145
      Height = 16
      Hint = 'Use spage bar or ouse button to change value'
      Caption = 'Warn by Job Week Cost'
      ParentShowHint = False
      ShowHint = True
    end
    object label5: TLabel
      Left = 16
      Top = 187
      Width = 117
      Height = 16
      Hint = 'Use spage bar or ouse button to change value'
      Caption = 'Warn by Day Hours'
      ParentShowHint = False
      ShowHint = True
    end
    object label6: TLabel
      Left = 16
      Top = 229
      Width = 108
      Height = 16
      Hint = 'Use spage bar or ouse button to change value'
      Caption = 'Warn by Day Cost'
      ParentShowHint = False
      ShowHint = True
    end
    object label7: TLabel
      Left = 16
      Top = 270
      Width = 128
      Height = 16
      Hint = 'Use spage bar or ouse button to change value'
      Caption = 'Warn by Week Hours'
      ParentShowHint = False
      ShowHint = True
    end
    object label8: TLabel
      Left = 16
      Top = 312
      Width = 119
      Height = 16
      Hint = 'Use spage bar or ouse button to change value'
      Caption = 'Warn by Week Cost'
      ParentShowHint = False
      ShowHint = True
    end
    object Label17: TLabel
      Left = 440
      Top = 20
      Width = 21
      Height = 16
      Caption = 'Hrs'
    end
    object Label18: TLabel
      Left = 552
      Top = 20
      Width = 28
      Height = 16
      Caption = 'Mins'
    end
    object Label19: TLabel
      Left = 464
      Top = 103
      Width = 21
      Height = 16
      Caption = 'Hrs'
    end
    object Label20: TLabel
      Left = 464
      Top = 187
      Width = 21
      Height = 16
      Caption = 'Hrs'
    end
    object Label21: TLabel
      Left = 464
      Top = 270
      Width = 21
      Height = 16
      Caption = 'Hrs'
    end
    object Label22: TLabel
      Left = 552
      Top = 103
      Width = 28
      Height = 16
      Caption = 'Mins'
    end
    object Label23: TLabel
      Left = 552
      Top = 187
      Width = 28
      Height = 16
      Caption = 'Mins'
    end
    object Label24: TLabel
      Left = 552
      Top = 270
      Width = 28
      Height = 16
      Caption = 'Mins'
    end
    object Emphrsflag: TCheckBox
      Left = 180
      Top = 20
      Width = 17
      Height = 17
      Caption = 'Emphrsflag'
      TabOrder = 0
      OnMouseUp = EmphrsflagMouseUp
    end
    object Empcstflag: TCheckBox
      Left = 180
      Top = 62
      Width = 17
      Height = 17
      Caption = 'Empcstflag'
      TabOrder = 3
      OnMouseUp = EmphrsflagMouseUp
    end
    object weekcstflag: TCheckBox
      Left = 180
      Top = 312
      Width = 17
      Height = 17
      Caption = 'weekcstflag'
      TabOrder = 18
      OnMouseUp = EmphrsflagMouseUp
    end
    object weekhrsflag: TCheckBox
      Left = 180
      Top = 270
      Width = 17
      Height = 17
      Caption = 'weekhrsflag'
      TabOrder = 15
      OnMouseUp = EmphrsflagMouseUp
    end
    object daycstflag: TCheckBox
      Left = 180
      Top = 229
      Width = 17
      Height = 17
      Caption = 'daycstflag'
      TabOrder = 13
      OnMouseUp = EmphrsflagMouseUp
    end
    object dayhrsflag: TCheckBox
      Left = 180
      Top = 187
      Width = 17
      Height = 17
      Caption = 'dayhrsflag'
      TabOrder = 10
      OnMouseUp = EmphrsflagMouseUp
    end
    object Jobcstflag: TCheckBox
      Left = 180
      Top = 145
      Width = 17
      Height = 17
      Caption = 'Jobcstflag'
      TabOrder = 8
      OnMouseUp = EmphrsflagMouseUp
    end
    object Jobhrsflag: TCheckBox
      Left = 180
      Top = 103
      Width = 17
      Height = 17
      Caption = 'Jobhrsflag'
      TabOrder = 5
      OnMouseUp = EmphrsflagMouseUp
    end
    object Panel2: TPanel
      Left = 591
      Top = 0
      Width = 118
      Height = 353
      TabOrder = 21
      object BitBtn4: TBitBtn
        Left = 6
        Top = 112
        Width = 107
        Height = 41
        Hint = 'Switch all warnings on'
        Caption = '&Enable All'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = BitBtn4Click
        Glyph.Data = {
          7E010000424D7E01000000000000760000002800000016000000160000000100
          0400000000000801000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAA00000000
          00008AAAAAAAAAAA08FFF99FFFF08AAAAAAAAAAA08FF9998FFF08AAAAAAAAAAA
          08F99999FFF08AAAAAAAAAAA089998998FF08AAAAAAAAAAA08998F999FF08AAA
          AAAAAAAA08FFF8888888888888AAAAAA08FFF0000000000008AA888808FFF08F
          FF99FFFF08AA000008FFF08FF9998FFF08AA08FF0888808F99999FFF08AA08FF
          00000089998998FF08AA08F99999F08998F999FF08AA08999899808FFFF899FF
          08AA08998F99908FFFFF998F08AA08FFFF89908FFFFF999F08AA08FFFFF9908F
          FFFF899908AA08FFFFF990888888889998AA08FFFFF890000000000999AA0888
          888889998AAAAAAA99AA0000000000999AAAAAAAAAAAAAAAAAAAAAA99AAAAAAA
          AAAA}
      end
      object BitBtn5: TBitBtn
        Left = 6
        Top = 176
        Width = 107
        Height = 41
        Hint = 'Switch all warnings off'
        Caption = '&Disable All'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BitBtn5Click
        Glyph.Data = {
          7E010000424D7E01000000000000760000002800000016000000160000000100
          0400000000000801000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAA00000000
          00008AAAAAAAAAAA08FFFFFFFFF08AAAAAAAAAAA08FFFFFFFFF08AAAAAAAAAAA
          08FFFFFFFFF08AAAAAAAAAAA08FFFFFFFFF08AAAAAAAAAAA08FFFFFFFFF08AAA
          AAAAAAAA08FFF8888888888888AAAAAA08FFF0000000000008AA888808FFF08F
          FFFFFFFF08AA000008FFF08FFFFFFFFF08AA08FF0888808FFFFFFFFF08AA08FF
          0000008FFFFFFFFF08AA08FFFFFFF08FFFFFFFFF08AA08FFFFFFF08FFFFFFFFF
          08AA08FFFFFFF08FFFFFFFFF08AA08FFFFFFF08FFFFFFFFF08AA08FFFFFFF08F
          FFFFFFFF08AA08FFFFFFF0888888888808AA08FFFFFFF000000000000AAA0888
          888888808AAAAAAAAAAA000000000000AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
          AAAA}
      end
    end
    object SpinEdit1: TSpinEdit
      Left = 390
      Top = 15
      Width = 41
      Height = 26
      MaxValue = 99
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnEnter = SpinEdit1Enter
      OnKeyDown = SpinEdit1KeyDown
    end
    object SpinEdit2: TSpinEdit
      Left = 502
      Top = 15
      Width = 41
      Height = 26
      Increment = 10
      MaxValue = 59
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnEnter = SpinEdit1Enter
      OnKeyDown = SpinEdit2KeyDown
    end
    object SpinEdit3: TSpinEdit
      Left = 390
      Top = 99
      Width = 67
      Height = 26
      Increment = 50
      MaxValue = 9999
      MinValue = 0
      TabOrder = 6
      Value = 0
      OnEnter = SpinEdit3Enter
      OnKeyDown = SpinEdit3KeyDown
    end
    object SpinEdit4: TSpinEdit
      Left = 502
      Top = 98
      Width = 41
      Height = 26
      Increment = 10
      MaxValue = 59
      MinValue = 0
      TabOrder = 7
      Value = 0
      OnEnter = SpinEdit3Enter
      OnKeyDown = SpinEdit4KeyDown
    end
    object SpinEdit5: TSpinEdit
      Left = 502
      Top = 182
      Width = 41
      Height = 26
      Increment = 10
      MaxValue = 59
      MinValue = 0
      TabOrder = 12
      Value = 0
      OnEnter = SpinEdit7Enter
      OnKeyDown = SpinEdit5KeyDown
    end
    object SpinEdit6: TSpinEdit
      Left = 502
      Top = 265
      Width = 41
      Height = 26
      Increment = 10
      MaxValue = 59
      MinValue = 0
      TabOrder = 17
      Value = 0
      OnEnter = SpinEdit8Enter
      OnKeyDown = SpinEdit6KeyDown
    end
    object SpinEdit7: TSpinEdit
      Left = 390
      Top = 182
      Width = 67
      Height = 26
      Increment = 10
      MaxValue = 9999
      MinValue = 0
      TabOrder = 11
      Value = 0
      OnEnter = SpinEdit7Enter
      OnKeyDown = SpinEdit7KeyDown
    end
    object SpinEdit8: TSpinEdit
      Left = 390
      Top = 266
      Width = 65
      Height = 26
      Increment = 50
      MaxValue = 9999
      MinValue = 0
      TabOrder = 16
      Value = 0
      OnEnter = SpinEdit8Enter
      OnKeyDown = SpinEdit8KeyDown
    end
    object Emphrsval: TEdit
      Left = 488
      Top = 56
      Width = 17
      Height = 24
      TabOrder = 20
      Text = 'Emphrsval'
      Visible = False
    end
    object Jobhrsval: TEdit
      Left = 488
      Top = 136
      Width = 17
      Height = 24
      TabOrder = 22
      Text = 'Jobhrsval'
      Visible = False
    end
    object Dayhrsval: TEdit
      Left = 488
      Top = 224
      Width = 17
      Height = 24
      TabOrder = 23
      Text = 'Dayhrsval'
      Visible = False
    end
    object Weekhrsval: TEdit
      Left = 488
      Top = 308
      Width = 25
      Height = 24
      TabOrder = 24
      Text = 'Weekhrsval'
      Visible = False
    end
    object wwE: TwwDBEdit
      Left = 390
      Top = 57
      Width = 89
      Height = 24
      DataField = 'Eval'
      DataSource = wwDataSource1
      TabOrder = 4
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnEnter = wwEEnter
      OnKeyDown = wwEKeyDown
    end
    object wwJ: TwwDBEdit
      Left = 390
      Top = 141
      Width = 89
      Height = 24
      DataField = 'Jval'
      DataSource = wwDataSource1
      TabOrder = 9
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnEnter = wwJEnter
      OnKeyDown = wwJKeyDown
    end
    object wwD: TwwDBEdit
      Left = 390
      Top = 224
      Width = 89
      Height = 24
      DataField = 'Dval'
      DataSource = wwDataSource1
      TabOrder = 14
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnEnter = wwDEnter
      OnKeyDown = wwDKeyDown
    end
    object wwW: TwwDBEdit
      Left = 390
      Top = 308
      Width = 89
      Height = 24
      DataField = 'Wval'
      DataSource = wwDataSource1
      TabOrder = 19
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnEnter = wwWEnter
      OnKeyDown = wwWKeyDown
    end
  end
  object btnSaveChanges: TBitBtn
    Left = 131
    Top = 362
    Width = 193
    Height = 47
    Caption = '&Save changes and exit'
    TabOrder = 1
    OnClick = btnSaveChangesClick
    Glyph.Data = {
      8A010000424D8A01000000000000760000002800000018000000170000000100
      0400000000001401000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAAAAAAA
      AAAAAAAAAAAAACCCCCCCCCCCCCCCCCCCCCCCACFFFFCFFCCFFCFFCCCFFCCCACFF
      CCCCFFFFCCFFCCCFFCCCACFFCCCCCFFCCCFFCCCFFCCCACFFFFCCCFFCCCFFCCCF
      FCCCACFFCCCCFFFFCCFFCCCFFCCCACFFFFCFFCCFFCFFCFFFFFFCACCCCCCCCCCC
      CCCCCCCCCCCCAAAAAAAAAAAAAAAAAAAAAAAAAAA70000000000000AAAAAAAAAA0
      33000000FF030AAAAAAAAAA033000000FF030AAAAAAAAAA033000000FF030AAA
      AAAAAAA03300000000030AAAAAAAAAA03333333333330AAAAAAAAAA033000000
      00330AAAAAAAAAA030FAAAAAAA030AAAAAAAAAA030AFAAAAAA030AAAAAAAAAA0
      30AAAAAAAA030AAAAAAAAAA030AAAAAAAA000AAAAAAAAAA030AAAAAAAA0F0AAA
      AAAAAAA00000000000000AAAAAAA}
  end
  object BitBtn3: TBitBtn
    Left = 371
    Top = 362
    Width = 209
    Height = 47
    Caption = 'Discard &changes and exit'
    ModalResult = 2
    TabOrder = 2
    Glyph.Data = {
      8A010000424D8A01000000000000760000002800000018000000170000000100
      0400000000001401000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00ACCCCCCCCCCC
      CCCCCCCCCCCCACFFFFCFFCCFFCFFCCCFFCCCACFFCCCCFFFFCCFFCCCFFCCCACFF
      CCCCCFFCCCFFCCCFFCCCACFFFFCCCFFCCCFFCCCFFCCCACFFCCCCFFFFCCFFCCCF
      FCCCACFFFFCFFCCFFCFFCFFFFFFCACCCCCCCCCCCCCCCCCCCCCCCAAAAAAAAAAAA
      AAAAAAAAAAAAA7000000AAAAAAAAAAAAAAAAA0330000AA00000000AAAAAAA033
      0000AA000FF030AAAAAAA03300000AA00FF030AAAAAAA033000000AA0FF030AA
      AAAAA033333330AA000030AAAAAAA033000000AA033330AAAAAAA030FAAAA0AA
      000330AAAAAAA030AFAA0AAA0AA030AAAAAAA030AAA0AAA0AAA030AAAAAAA030
      AA0AAA0AAAA030AAAAAAA030A0AAA0AAAAA000AAAAAAA00000AA0AAAAAA0F0AA
      AAAAAAAAAAAA0000000000AAAAAA}
  end
  object BitBtn1: TBitBtn
    Left = 243
    Top = 362
    Width = 209
    Height = 47
    Caption = 'Close'
    TabOrder = 3
    Visible = False
    Kind = bkCancel
  end
  object wwDataSource1: TwwDataSource
    DataSet = Warnings
    Left = 49
    Top = 362
  end
  object Warnings: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    TableName = 'Warnings'
    Left = 16
    Top = 360
  end
end
