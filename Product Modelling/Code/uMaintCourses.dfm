object fMaintCourses: TfMaintCourses
  Left = 672
  Top = 429
  BorderStyle = bsDialog
  Caption = 'New Course'
  ClientHeight = 218
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    342
    218)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 342
    Height = 24
    Align = alTop
    Alignment = taCenter
    Caption = 'New Course'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 22
    Top = 50
    Width = 38
    Height = 13
    Caption = '* Name:'
  end
  object Label3: TLabel
    Left = 22
    Top = 72
    Width = 62
    Height = 13
    Caption = '  Description:'
  end
  object edtCourseName: TEdit
    Left = 86
    Top = 46
    Width = 250
    Height = 21
    MaxLength = 15
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 180
    Top = 191
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 260
    Top = 191
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object CourseDescMemo: TMemo
    Left = 86
    Top = 72
    Width = 250
    Height = 110
    MaxLength = 250
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
