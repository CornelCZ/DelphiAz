object frmInvoiceNumMask: TfrmInvoiceNumMask
  Left = 396
  Top = 300
  Width = 759
  Height = 507
  Caption = 'frmInvoiceNumMask'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlSelectSupplier: TPanel
    Left = 0
    Top = 0
    Width = 751
    Height = 67
    Align = alTop
    TabOrder = 0
    object Label2: TLabel
      Left = 23
      Top = 16
      Width = 41
      Height = 13
      Caption = 'Supplier:'
    end
    object Label3: TLabel
      Left = 200
      Top = 16
      Width = 29
      Height = 13
      Caption = 'Mask:'
    end
    object SupplierLookUp: TwwDBLookupCombo
      Left = 23
      Top = 30
      Width = 151
      Height = 21
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Supplier Name'#9'20'#9'Supplier Name'#9#9)
      LookupTable = qrySuppliers
      LookupField = 'Supplier Name'
      Style = csDropDownList
      TabOrder = 0
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
      OnChange = SupplierLookUpChange
      OnBeforeDropDown = SupplierLookUpBeforeDropDown
    end
    object MaskLookUp: TwwDBLookupCombo
      Left = 200
      Top = 30
      Width = 166
      Height = 21
      DropDownAlignment = taLeftJustify
      Style = csDropDownList
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      UseTFields = False
      AllowClearKey = False
      OnChange = MaskLookUpChange
    end
    object btnNewMask: TBitBtn
      Left = 379
      Top = 28
      Width = 59
      Height = 25
      Action = NewMaskAction
      Caption = 'New Mask'
      TabOrder = 2
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 67
    Width = 751
    Height = 387
    Align = alClient
    TabOrder = 1
    object pnlTestMask: TPanel
      Left = 1
      Top = 340
      Width = 749
      Height = 46
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object Panel2: TPanel
        Left = 226
        Top = 0
        Width = 318
        Height = 46
        Align = alClient
        TabOrder = 1
        object cbxCurrentMask: TCheckBox
          Left = 25
          Top = 14
          Width = 144
          Height = 17
          Caption = 'Current mask for supplier'
          TabOrder = 0
          OnClick = cbxCurrentMaskClick
        end
        object btnSave: TBitBtn
          Left = 219
          Top = 11
          Width = 75
          Height = 25
          Action = SaveAction
          Caption = '&Save Mask'
          TabOrder = 1
          NumGlyphs = 2
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 226
        Height = 46
        Align = alLeft
        TabOrder = 0
        object Label1: TLabel
          Left = 23
          Top = 5
          Width = 94
          Height = 13
          Caption = 'Test the mask here:'
        end
        object MaskExample: TMaskEdit
          Left = 23
          Top = 18
          Width = 173
          Height = 21
          MaxLength = 16
          TabOrder = 0
          Text = 'WWWWWWWWWWWWWWW'
        end
      end
      object Panel4: TPanel
        Left = 544
        Top = 0
        Width = 205
        Height = 46
        Align = alRight
        TabOrder = 2
        object btnOK: TBitBtn
          Left = 116
          Top = 11
          Width = 75
          Height = 25
          Caption = '&Close'
          ModalResult = 1
          TabOrder = 0
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
            F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
            000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
            338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
            45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
            3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
            F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
            000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
            338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
            4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
            8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
            333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
            0000}
          NumGlyphs = 2
        end
      end
    end
    object pnlEditMask: TPanel
      Left = 1
      Top = 1
      Width = 749
      Height = 339
      Align = alClient
      TabOrder = 1
      object Label4: TLabel
        Left = 23
        Top = 18
        Width = 295
        Height = 13
        Caption = 'Press the numbered speedbuttons to edit the mask characters.'
      end
      object pnlAttributes: TPanel
        Left = 24
        Top = 111
        Width = 210
        Height = 196
        TabOrder = 15
        TabStop = True
        Visible = False
        object Image2: TImage
          Left = 0
          Top = 0
          Width = 19
          Height = 18
          Center = True
          Picture.Data = {
            07544269746D617042020000424D420200000000000042000000280000001000
            0000100000000100100003000000000200000000000000000000000000000000
            0000007C0000E00300001F0000001F7C1F7C1F7C1F7C1F7C1F7C000000000000
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C0000
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C0000
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C0000
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C0000
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C0000
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000000000007C0000
            0000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C007C007C007C007C
            007C007C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C007C007C007C
            007C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C007C007C007C
            007C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C007C007C
            00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C007C007C
            00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C0000
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C0000
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C}
          Transparent = True
        end
        object btnDeleteChar: TBitBtn
          Left = 26
          Top = 163
          Width = 69
          Height = 25
          Action = DeleteCharAction
          Caption = '&Delete Char.'
          TabOrder = 3
        end
        object rgpCharType: TRadioGroup
          Left = 3
          Top = 21
          Width = 103
          Height = 130
          Caption = 'Type of character'
          Items.Strings = (
            'Alphabetic'
            'Numeric'
            'AlphaNumeric'
            'Any type'
            'Literal')
          TabOrder = 0
          TabStop = True
          OnClick = rgpCharTypeClick
        end
        object rgpCase: TRadioGroup
          Left = 106
          Top = 21
          Width = 100
          Height = 88
          Caption = 'Select case'
          Items.Strings = (
            'Upper case'
            'Lower case'
            'Doesn'#39't matter')
          TabOrder = 1
          TabStop = True
          Visible = False
          OnClick = rgpCaseClick
        end
        object gpLiteralChar: TGroupBox
          Left = 106
          Top = 108
          Width = 88
          Height = 43
          Caption = 'Enter character'
          TabOrder = 2
          TabStop = True
          Visible = False
          object editLiteralChar: TEdit
            Left = 10
            Top = 17
            Width = 25
            Height = 21
            MaxLength = 1
            TabOrder = 0
            OnChange = editLiteralCharChange
          end
        end
        object btnCloseAttr: TBitBtn
          Left = 115
          Top = 163
          Width = 69
          Height = 25
          Action = CloseAttrPanelAction
          Caption = 'Close'
          TabOrder = 4
        end
      end
      object Char2Btn: TBitBtn
        Tag = 2
        Left = 59
        Top = 84
        Width = 23
        Height = 22
        Action = Action2
        Caption = '2'
        TabOrder = 1
      end
      object Char3Btn: TBitBtn
        Tag = 3
        Left = 96
        Top = 84
        Width = 23
        Height = 22
        Action = Action3
        Caption = '3'
        TabOrder = 2
      end
      object Char4Btn: TBitBtn
        Tag = 4
        Left = 133
        Top = 84
        Width = 23
        Height = 22
        Action = Action4
        Caption = '4'
        TabOrder = 3
      end
      object Char5Btn: TBitBtn
        Tag = 5
        Left = 170
        Top = 84
        Width = 23
        Height = 22
        Action = Action5
        Caption = '5'
        TabOrder = 4
      end
      object Char6Btn: TBitBtn
        Tag = 6
        Left = 207
        Top = 84
        Width = 23
        Height = 22
        Action = Action6
        Caption = '6'
        TabOrder = 5
      end
      object Char7Btn: TBitBtn
        Tag = 7
        Left = 244
        Top = 84
        Width = 23
        Height = 22
        Action = Action7
        Caption = '7'
        TabOrder = 6
      end
      object Char8Btn: TBitBtn
        Tag = 8
        Left = 281
        Top = 84
        Width = 23
        Height = 22
        Action = Action8
        Caption = '8'
        TabOrder = 7
      end
      object Char9Btn: TBitBtn
        Tag = 9
        Left = 318
        Top = 84
        Width = 23
        Height = 22
        Action = Action9
        Caption = '9'
        TabOrder = 8
      end
      object Char10Btn: TBitBtn
        Tag = 10
        Left = 355
        Top = 84
        Width = 23
        Height = 22
        Action = Action10
        Caption = '10'
        TabOrder = 9
      end
      object Char11Btn: TBitBtn
        Tag = 11
        Left = 392
        Top = 84
        Width = 23
        Height = 22
        Action = Action11
        Caption = '11'
        TabOrder = 10
      end
      object Char12Btn: TBitBtn
        Tag = 12
        Left = 429
        Top = 84
        Width = 23
        Height = 22
        Action = Action12
        Caption = '12'
        TabOrder = 11
      end
      object Char13Btn: TBitBtn
        Tag = 13
        Left = 466
        Top = 84
        Width = 23
        Height = 22
        Action = Action13
        Caption = '13'
        TabOrder = 12
      end
      object Char14Btn: TBitBtn
        Tag = 14
        Left = 503
        Top = 84
        Width = 23
        Height = 22
        Action = Action14
        Caption = '14'
        TabOrder = 13
      end
      object Char15Btn: TBitBtn
        Tag = 15
        Left = 540
        Top = 84
        Width = 23
        Height = 22
        Action = Action15
        Caption = '15'
        TabOrder = 14
      end
      object Char1Btn: TBitBtn
        Tag = 1
        Left = 23
        Top = 84
        Width = 23
        Height = 22
        Action = Action1
        Caption = '1'
        TabOrder = 0
      end
      object edit2: TEdit
        Tag = 2
        Left = 59
        Top = 48
        Width = 23
        Height = 21
        TabStop = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 17
      end
      object edit3: TEdit
        Tag = 3
        Left = 96
        Top = 48
        Width = 23
        Height = 21
        TabStop = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 18
      end
      object edit4: TEdit
        Tag = 4
        Left = 133
        Top = 48
        Width = 23
        Height = 21
        TabStop = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 19
      end
      object edit5: TEdit
        Tag = 5
        Left = 170
        Top = 48
        Width = 23
        Height = 21
        TabStop = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 20
      end
      object edit6: TEdit
        Tag = 6
        Left = 206
        Top = 48
        Width = 23
        Height = 21
        TabStop = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 21
      end
      object edit7: TEdit
        Tag = 7
        Left = 243
        Top = 48
        Width = 23
        Height = 21
        TabStop = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 22
      end
      object edit8: TEdit
        Tag = 8
        Left = 280
        Top = 48
        Width = 23
        Height = 21
        TabStop = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 23
      end
      object edit9: TEdit
        Tag = 9
        Left = 317
        Top = 48
        Width = 23
        Height = 21
        TabStop = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 24
      end
      object edit10: TEdit
        Tag = 10
        Left = 354
        Top = 48
        Width = 23
        Height = 21
        TabStop = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 25
      end
      object edit11: TEdit
        Tag = 11
        Left = 390
        Top = 48
        Width = 23
        Height = 21
        TabStop = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 26
      end
      object edit12: TEdit
        Tag = 12
        Left = 427
        Top = 48
        Width = 23
        Height = 21
        TabStop = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 27
      end
      object edit13: TEdit
        Tag = 13
        Left = 464
        Top = 48
        Width = 23
        Height = 21
        TabStop = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 28
      end
      object edit14: TEdit
        Tag = 14
        Left = 501
        Top = 48
        Width = 23
        Height = 21
        TabStop = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 29
      end
      object edit15: TEdit
        Tag = 15
        Left = 538
        Top = 48
        Width = 23
        Height = 21
        TabStop = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 30
      end
      object edit1: TEdit
        Tag = 1
        Left = 23
        Top = 48
        Width = 23
        Height = 21
        TabStop = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 16
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 454
    Width = 751
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object CharActionList: TActionList
    Left = 618
    Top = 6
    object DeleteCharAction: TAction
      Caption = '&Delete Char.'
      OnExecute = DeleteCharActionExecute
      OnUpdate = DeleteCharActionUpdate
    end
    object Action1: TAction
      Tag = 1
      Caption = '1'
      OnExecute = CharBtnActionExecute
      OnUpdate = CharBtnActionUpdate
    end
    object Action2: TAction
      Tag = 2
      Caption = '2'
      OnExecute = CharBtnActionExecute
      OnUpdate = CharBtnActionUpdate
    end
    object Action3: TAction
      Tag = 3
      Caption = '3'
      OnExecute = CharBtnActionExecute
      OnUpdate = CharBtnActionUpdate
    end
    object Action4: TAction
      Tag = 4
      Caption = '4'
      OnExecute = CharBtnActionExecute
      OnUpdate = CharBtnActionUpdate
    end
    object Action5: TAction
      Tag = 5
      Caption = '5'
      OnExecute = CharBtnActionExecute
      OnUpdate = CharBtnActionUpdate
    end
    object Action6: TAction
      Tag = 6
      Caption = '6'
      OnExecute = CharBtnActionExecute
      OnUpdate = CharBtnActionUpdate
    end
    object Action7: TAction
      Tag = 7
      Caption = '7'
      OnExecute = CharBtnActionExecute
      OnUpdate = CharBtnActionUpdate
    end
    object Action8: TAction
      Tag = 8
      Caption = '8'
      OnExecute = CharBtnActionExecute
      OnUpdate = CharBtnActionUpdate
    end
    object Action9: TAction
      Tag = 9
      Caption = '9'
      OnExecute = CharBtnActionExecute
      OnUpdate = CharBtnActionUpdate
    end
    object Action10: TAction
      Tag = 10
      Caption = '10'
      OnExecute = CharBtnActionExecute
      OnUpdate = CharBtnActionUpdate
    end
    object Action11: TAction
      Tag = 11
      Caption = '11'
      OnExecute = CharBtnActionExecute
      OnUpdate = CharBtnActionUpdate
    end
    object Action12: TAction
      Tag = 12
      Caption = '12'
      OnExecute = CharBtnActionExecute
      OnUpdate = CharBtnActionUpdate
    end
    object Action13: TAction
      Tag = 13
      Caption = '13'
      OnExecute = CharBtnActionExecute
      OnUpdate = CharBtnActionUpdate
    end
    object Action14: TAction
      Tag = 14
      Caption = '14'
      OnExecute = CharBtnActionExecute
      OnUpdate = CharBtnActionUpdate
    end
    object Action15: TAction
      Tag = 15
      Caption = '15'
      OnExecute = CharBtnActionExecute
      OnUpdate = CharBtnActionUpdate
    end
  end
  object qrySuppliers: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select [Supplier Name] from Supplier')
    Left = 657
    Top = 6
    object qrySuppliersSupplierName: TStringField
      DisplayWidth = 20
      FieldName = 'Supplier Name'
    end
  end
  object TmpMaskTbl: TADOTable
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Left = 690
    Top = 6
  end
  object MainActionList: TActionList
    Left = 568
    Top = 8
    object SaveAction: TAction
      Caption = '&Save Mask'
      OnExecute = SaveActionExecute
      OnUpdate = SaveActionUpdate
    end
    object NewMaskAction: TAction
      Caption = 'New Mask'
      OnExecute = NewMaskActionExecute
    end
    object CloseAttrPanelAction: TAction
      Caption = 'Close'
      OnExecute = CloseAttrPanelActionExecute
    end
  end
end
