object AddEditTicketSequence: TAddEditTicketSequence
  Left = 1287
  Top = 122
  Width = 313
  Height = 504
  HelpContext = 5038
  BorderIcons = [biSystemMenu]
  Caption = 'AddEditTicketSequence'
  Color = clBtnFace
  Constraints.MaxWidth = 313
  Constraints.MinHeight = 504
  Constraints.MinWidth = 313
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    297
    466)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 24
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 152
    Top = 24
    Width = 51
    Height = 13
    Caption = 'Reset time'
  end
  object Label3: TLabel
    Left = 8
    Top = 126
    Width = 77
    Height = 13
    Caption = 'Ticket Products:'
  end
  object Label4: TLabel
    Left = 16
    Top = 142
    Width = 273
    Height = 29
    AutoSize = False
    Caption = 
      'These products will automatically print tickets and can be eithe' +
      'r Standard Lines or Recipes'
    WordWrap = True
  end
  object Label5: TLabel
    Left = 8
    Top = 8
    Width = 73
    Height = 13
    Caption = 'Ticket settings:'
  end
  object Label6: TLabel
    Left = 8
    Top = 390
    Width = 59
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Ticket image'
  end
  object Label7: TLabel
    Left = 168
    Top = 390
    Width = 59
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Lines before'
  end
  object Label8: TLabel
    Left = 240
    Top = 390
    Width = 51
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Lines after'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 318
    Width = 281
    Height = 2
    Anchors = [akLeft, akBottom]
  end
  object Bevel2: TBevel
    Left = 8
    Top = 118
    Width = 281
    Height = 2
  end
  object Label9: TLabel
    Left = 8
    Top = 326
    Width = 63
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Lines before:'
  end
  object Label10: TLabel
    Left = 16
    Top = 342
    Width = 61
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Seq. number'
  end
  object Label11: TLabel
    Left = 160
    Top = 326
    Width = 60
    Height = 26
    Anchors = [akLeft, akBottom]
    Caption = 'Lines before'#13#10'second copy'
  end
  object Bevel3: TBevel
    Left = 8
    Top = 382
    Width = 281
    Height = 2
    Anchors = [akLeft, akBottom]
  end
  object Label12: TLabel
    Left = 88
    Top = 342
    Width = 47
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Prod. info'
  end
  object edName: TEdit
    Left = 8
    Top = 40
    Width = 137
    Height = 21
    MaxLength = 8
    TabOrder = 0
    Text = 'WWWWWWWW'
  end
  object cbPerTerminal: TCheckBox
    Left = 8
    Top = 64
    Width = 185
    Height = 17
    Caption = 'Separate sequence per terminal'
    TabOrder = 2
    OnClick = cbPerTerminalClick
  end
  object dtpReset: TDateTimePicker
    Left = 152
    Top = 40
    Width = 73
    Height = 21
    CalAlignment = dtaLeft
    Date = 38366.4669708796
    Time = 38366.4669708796
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkTime
    ParseInput = False
    TabOrder = 1
  end
  object lbProducts: TListBox
    Left = 8
    Top = 174
    Width = 281
    Height = 105
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 4
  end
  object btAdd: TButton
    Left = 8
    Top = 286
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Add'
    TabOrder = 5
    OnClick = btAddClick
  end
  object btDelete: TButton
    Left = 88
    Top = 286
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Delete'
    TabOrder = 6
    OnClick = btDeleteClick
  end
  object btCancel: TButton
    Left = 216
    Top = 438
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 19
    OnClick = btCancelClick
  end
  object btOk: TButton
    Left = 136
    Top = 438
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Ok'
    Default = True
    TabOrder = 18
    OnClick = btOkClick
  end
  object cbPrintTwoCopies: TCheckBox
    Left = 8
    Top = 80
    Width = 185
    Height = 17
    Caption = 'Print two copies'
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnClick = cbPerTerminalClick
  end
  object cmbTicketImage: TComboBox
    Left = 8
    Top = 406
    Width = 153
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    ItemHeight = 13
    TabOrder = 13
    OnChange = cmbTicketImageChange
  end
  object edLinesBeforeImage: TEdit
    Left = 168
    Top = 406
    Width = 25
    Height = 21
    Anchors = [akLeft, akBottom]
    MaxLength = 2
    TabOrder = 14
    Text = '0'
  end
  object udLinesBeforeImage: TUpDown
    Left = 193
    Top = 406
    Width = 16
    Height = 21
    Anchors = [akLeft, akBottom]
    Associate = edLinesBeforeImage
    Min = 0
    Max = 99
    Position = 0
    TabOrder = 15
    Wrap = False
  end
  object edLinesAfterImage: TEdit
    Left = 240
    Top = 406
    Width = 25
    Height = 21
    Anchors = [akLeft, akBottom]
    MaxLength = 2
    TabOrder = 16
    Text = '0'
  end
  object udLinesAfterImage: TUpDown
    Left = 265
    Top = 406
    Width = 16
    Height = 21
    Anchors = [akLeft, akBottom]
    Associate = edLinesAfterImage
    Min = 0
    Max = 99
    Position = 0
    TabOrder = 17
    Wrap = False
  end
  object edLinesBeforeSequenceNumber: TEdit
    Left = 16
    Top = 358
    Width = 25
    Height = 21
    Anchors = [akLeft, akBottom]
    MaxLength = 2
    TabOrder = 7
    Text = '2'
  end
  object udLinesBeforeSequenceNumber: TUpDown
    Left = 41
    Top = 358
    Width = 16
    Height = 21
    Anchors = [akLeft, akBottom]
    Associate = edLinesBeforeSequenceNumber
    Min = 0
    Max = 99
    Position = 2
    TabOrder = 8
    Wrap = False
  end
  object edLinesBeforeProductInfo: TEdit
    Left = 88
    Top = 358
    Width = 25
    Height = 21
    Anchors = [akLeft, akBottom]
    MaxLength = 2
    TabOrder = 9
    Text = '2'
  end
  object udLinesBeforeProductInfo: TUpDown
    Left = 113
    Top = 358
    Width = 16
    Height = 21
    Anchors = [akLeft, akBottom]
    Associate = edLinesBeforeProductInfo
    Min = 0
    Max = 99
    Position = 2
    TabOrder = 10
    Wrap = False
  end
  object edLinesBetweeProductTicketPair: TEdit
    Left = 160
    Top = 358
    Width = 25
    Height = 21
    Anchors = [akLeft, akBottom]
    MaxLength = 2
    TabOrder = 11
    Text = '3'
  end
  object udLinesBetweenProductTicketPair: TUpDown
    Left = 185
    Top = 358
    Width = 16
    Height = 21
    Anchors = [akLeft, akBottom]
    Associate = edLinesBetweeProductTicketPair
    Min = 0
    Max = 99
    Position = 3
    TabOrder = 12
    Wrap = False
  end
  object cbPrintTicketNumber: TCheckBox
    Left = 8
    Top = 96
    Width = 193
    Height = 17
    Caption = 'Print Ticket No. on receipt'
    Checked = True
    State = cbChecked
    TabOrder = 20
    OnClick = cbPrintTicketNumberClick
  end
end
