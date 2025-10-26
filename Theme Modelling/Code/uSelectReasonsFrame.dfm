object SelectReasonsFrame: TSelectReasonsFrame
  Left = 0
  Top = 0
  Width = 562
  Height = 386
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  TabOrder = 0
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 562
    Height = 344
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Constraints.MinHeight = 250
    Constraints.MinWidth = 500
    TabOrder = 0
    OnResize = pnlClientResize
    object pnlLeft: TPanel
      Left = 2
      Top = 2
      Width = 315
      Height = 340
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        315
        340)
      object lblAvailableReasons: TLabel
        Left = 12
        Top = 12
        Width = 88
        Height = 13
        Caption = 'Available Reasons'
      end
      object lbAvailableReasons: TListBox
        Left = 12
        Top = 32
        Width = 242
        Height = 298
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
      end
      object pnlButtons: TPanel
        Left = 260
        Top = 0
        Width = 55
        Height = 340
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          55
          340)
        object btnSelect: TButton
          Left = 16
          Top = 136
          Width = 25
          Height = 25
          Action = actMoveToSelected
          Anchors = []
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object btnDeselect: TButton
          Left = 16
          Top = 163
          Width = 25
          Height = 25
          Action = actMoveToAvailable
          Anchors = []
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
      end
    end
    object pnlRight: TPanel
      Left = 317
      Top = 2
      Width = 243
      Height = 340
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        243
        340)
      object lblSelectedReasons: TLabel
        Left = 6
        Top = 12
        Width = 87
        Height = 13
        Caption = 'Selected Reasons'
      end
      object lbSelectedReasons: TListBox
        Left = 6
        Top = 32
        Width = 225
        Height = 298
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 344
    Width = 562
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      562
      42)
    object btnSave: TButton
      Left = 382
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Save'
      Enabled = False
      ModalResult = 1
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnCancel: TButton
      Left = 465
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      Default = True
      Enabled = False
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object actlSelectReasons: TActionList
    Left = 4
    Top = 344
    object actMoveToAvailable: TAction
      Caption = '<'
      OnExecute = actMoveToAvailableExecute
      OnUpdate = actMoveToAvailableUpdate
    end
    object actMoveToSelected: TAction
      Caption = '>'
      OnExecute = actMoveToSelectedExecute
      OnUpdate = actMoveToSelectedUpdate
    end
  end
end
