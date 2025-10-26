object EditTimedJobSecurity: TEditTimedJobSecurity
  Left = 608
  Top = 341
  Width = 248
  Height = 465
  HelpContext = 5035
  BorderWidth = 8
  Caption = 'Edit Button Security'
  Color = clBtnFace
  Constraints.MinHeight = 465
  Constraints.MinWidth = 248
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    216
    411)
  PixelsPerInch = 96
  TextHeight = 13
  object btOk: TButton
    Left = 31
    Top = 386
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Ok'
    TabOrder = 0
    OnClick = btOkClick
  end
  object btCancel: TButton
    Left = 111
    Top = 386
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = btCancelClick
  end
  object chkbxWitnessRequired: TCheckBox
    Left = 0
    Top = 362
    Width = 121
    Height = 17
    Hint = 
      'Specify whether a second user will always'#13#10'be required to witnes' +
      's this button usage.'
    Anchors = [akLeft, akBottom]
    Caption = 'Witness Required'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object gpbxRoleSecurity: TGroupBox
    Left = 0
    Top = 0
    Width = 216
    Height = 357
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Role Security'
    TabOrder = 3
    DesignSize = (
      216
      357)
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 59
      Height = 13
      Caption = 'Time period:'
    end
    object Label1: TLabel
      Left = 8
      Top = 146
      Width = 193
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Only grant access to the following roles:'
    end
    object cbTimePeriods: TComboBox
      Left = 8
      Top = 32
      Width = 200
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbTimePeriodsChange
      OnCloseUp = cbTimePeriodsCloseUp
      Items.Strings = (
        '(Any time)'
        '09:00 to 11:00'
        '17:00 to 21:00'
        '22:00 to 23:00')
    end
    object btAddTimePeriod: TButton
      Left = 8
      Top = 58
      Width = 60
      Height = 19
      Caption = 'Add'
      TabOrder = 1
      OnClick = btAddTimePeriodClick
    end
    object btEditTimePeriod: TButton
      Left = 78
      Top = 58
      Width = 60
      Height = 19
      Anchors = [akTop]
      Caption = 'Edit'
      TabOrder = 2
      OnClick = btEditTimePeriodClick
    end
    object btRemoveTimePeriod: TButton
      Left = 148
      Top = 58
      Width = 60
      Height = 19
      Anchors = [akTop, akRight]
      Caption = 'Remove'
      TabOrder = 3
      OnClick = btRemoveTimePeriodClick
    end
    object clbRoles: TCheckListBox
      Left = 8
      Top = 162
      Width = 200
      Height = 164
      Anchors = [akLeft, akRight, akBottom]
      ItemHeight = 13
      TabOrder = 4
    end
    object btnSelectAll: TButton
      Left = 40
      Top = 331
      Width = 65
      Height = 19
      Anchors = [akBottom]
      Caption = 'Select All'
      TabOrder = 5
      OnClick = btnSelectAllClick
    end
    object btnDeselectAll: TButton
      Left = 111
      Top = 331
      Width = 66
      Height = 19
      Anchors = [akBottom]
      Caption = 'Deselect All'
      TabOrder = 6
      OnClick = btnDeselectAllClick
    end
    object pnlConditionalSecurity: TPanel
      Left = 8
      Top = 89
      Width = 201
      Height = 53
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 7
      DesignSize = (
        201
        53)
      object lblConditionalSecurity: TLabel
        Left = 4
        Top = 11
        Width = 89
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Security effective:'
      end
      object cmbbxConditionalSecurity: TComboBox
        Left = 4
        Top = 27
        Width = 193
        Height = 21
        Anchors = [akLeft, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
        Text = 'Standard'
        OnChange = cmbbxConditionalSecurityChange
        OnDropDown = cmbbxConditionalSecurityDropDown
        Items.Strings = (
          'Standard'
          'Post Bill Print')
      end
    end
    object cbxUseConditionalSecurity: TCheckBox
      Left = 16
      Top = 82
      Width = 137
      Height = 17
      Caption = 'Use Conditional Security'
      TabOrder = 8
      OnClick = cbxUseConditionalSecurityClick
    end
  end
  object qRun: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 12
    Top = 168
  end
  object alButtonSecurity: TActionList
    Left = 188
    Top = 356
    object actUseConditionalSecurity: TAction
      AutoCheck = True
      Caption = 'Use Conditional Security'
    end
  end
end
