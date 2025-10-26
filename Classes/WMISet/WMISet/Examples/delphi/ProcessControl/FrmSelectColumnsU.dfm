object FrmSelectColumns: TFrmSelectColumns
  Left = 326
  Top = 186
  BorderStyle = bsDialog
  Caption = 'Select columns'
  ClientHeight = 368
  ClientWidth = 373
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
  object Bevel1: TBevel
    Left = 12
    Top = 316
    Width = 349
    Height = 10
    Shape = bsBottomLine
  end
  object chbImageName: TCheckBox
    Left = 12
    Top = 12
    Width = 162
    Height = 18
    Caption = 'Image Name'
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 0
  end
  object chbIOOther: TCheckBox
    Left = 224
    Top = 12
    Width = 133
    Height = 18
    Caption = 'I/O Other'
    TabOrder = 1
  end
  object chbPID: TCheckBox
    Left = 12
    Top = 41
    Width = 162
    Height = 16
    Caption = 'PID (Process Identifer)'
    TabOrder = 2
  end
  object chbIOOtherBytes: TCheckBox
    Left = 224
    Top = 41
    Width = 142
    Height = 16
    Caption = 'I/O Other Bytes'
    TabOrder = 3
  end
  object chbCpuUsage: TCheckBox
    Left = 12
    Top = 68
    Width = 162
    Height = 17
    Caption = 'CPU Usage'
    TabOrder = 4
  end
  object chbPagedPool: TCheckBox
    Left = 224
    Top = 68
    Width = 142
    Height = 17
    Caption = 'Paged Pool'
    TabOrder = 5
  end
  object chbCpuTime: TCheckBox
    Left = 12
    Top = 96
    Width = 162
    Height = 17
    Caption = 'CPU Time'
    TabOrder = 6
  end
  object chbNonPagedPool: TCheckBox
    Left = 224
    Top = 96
    Width = 137
    Height = 17
    Caption = 'Non-paged Pool'
    TabOrder = 7
  end
  object chbMemoryUsage: TCheckBox
    Left = 12
    Top = 124
    Width = 162
    Height = 18
    Caption = 'Memory Usage'
    TabOrder = 8
  end
  object chbBasePriority: TCheckBox
    Left = 224
    Top = 124
    Width = 142
    Height = 18
    Caption = 'Base Priority'
    TabOrder = 9
  end
  object chbPeakMemoryUsage: TCheckBox
    Left = 12
    Top = 153
    Width = 157
    Height = 16
    Caption = 'Peak Memory Usage'
    TabOrder = 10
  end
  object chbHandleCount: TCheckBox
    Left = 224
    Top = 153
    Width = 145
    Height = 16
    Caption = 'Handle Count'
    TabOrder = 11
  end
  object chbPageFaults: TCheckBox
    Left = 12
    Top = 180
    Width = 157
    Height = 17
    Caption = 'Page Faults'
    TabOrder = 12
  end
  object chbThreadCount: TCheckBox
    Left = 224
    Top = 180
    Width = 142
    Height = 17
    Caption = 'Thread Count'
    TabOrder = 13
  end
  object chbIOReads: TCheckBox
    Left = 12
    Top = 208
    Width = 162
    Height = 17
    Caption = 'I/O Reads'
    TabOrder = 14
  end
  object chbVirtualMemory: TCheckBox
    Left = 224
    Top = 208
    Width = 142
    Height = 17
    Caption = 'Virtual Memory'
    TabOrder = 15
  end
  object chbIOReadBytes: TCheckBox
    Left = 12
    Top = 236
    Width = 162
    Height = 18
    Caption = 'I/O Read Bytes'
    TabOrder = 16
  end
  object chbSessionId: TCheckBox
    Left = 224
    Top = 236
    Width = 97
    Height = 18
    Caption = 'Session ID'
    TabOrder = 17
  end
  object chbIOWrites: TCheckBox
    Left = 12
    Top = 265
    Width = 165
    Height = 16
    Caption = 'I/O Writes'
    TabOrder = 18
  end
  object chbStartedAt: TCheckBox
    Left = 224
    Top = 265
    Width = 97
    Height = 16
    Caption = 'Started At'
    TabOrder = 19
  end
  object chbIOWriteBytes: TCheckBox
    Left = 12
    Top = 292
    Width = 165
    Height = 17
    Caption = 'I/O Write Bytes'
    TabOrder = 20
  end
  object chbFullPath: TCheckBox
    Left = 224
    Top = 292
    Width = 97
    Height = 17
    Caption = 'Full Path'
    TabOrder = 21
  end
  object btnOk: TButton
    Left = 172
    Top = 336
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 22
  end
  object btnCancel: TButton
    Left = 265
    Top = 336
    Width = 96
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 23
  end
end
