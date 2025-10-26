object ProductInPanelReport: TProductInPanelReport
  Left = 240
  Top = 158
  Width = 1040
  Height = 793
  Caption = 'ProductInPanelReport'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object LocalPanelResults: TQuickRep
    Left = 8
    Top = 10
    Width = 794
    Height = 1123
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    DataSet = qLocalPanels
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'QRSTRINGSBAND1'
      'QRSTRINGSBAND2')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      #39#39
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Values = (
      100
      2970
      100
      2100
      100
      100
      0)
    PrinterSettings.Copies = 1
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.OutputBin = Auto
    PrintIfEmpty = True
    SnapToGrid = True
    Units = Pixels
    Zoom = 100
    object QRBand1: TQRBand
      Left = 38
      Top = 38
      Width = 718
      Height = 123
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        325.4375
        1899.70833333333)
      BandType = rbTitle
      object HeaderRect: TQRShape
        Left = 0
        Top = 0
        Width = 718
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          171.979166666667
          0
          0
          1899.70833333333)
        Shape = qrsRectangle
      end
      object QRLabel13: TQRLabel
        Left = 8
        Top = 40
        Width = 60
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          21.1666666666667
          105.833333333333
          158.75)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'Site'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel12: TQRLabel
        Left = 8
        Top = 24
        Width = 60
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          21.1666666666667
          63.5
          158.75)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'Area'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel11: TQRLabel
        Left = 8
        Top = 8
        Width = 60
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          21.1666666666667
          21.1666666666667
          158.75)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'Company'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel9: TQRLabel
        Left = 300
        Top = 8
        Width = 132
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          793.75
          21.1666666666667
          349.25)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Product in panel report'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsUnderline]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel8: TQRLabel
        Left = 536
        Top = 8
        Width = 46
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1418.16666666667
          21.1666666666667
          121.708333333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Printed:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRExpr7: TQRExpr
        Left = 332
        Top = 32
        Width = 54
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          878.416666666667
          84.6666666666667
          142.875)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRExpr8: TQRExpr
        Left = 584
        Top = 8
        Width = 105
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1545.16666666667
          21.1666666666667
          277.8125)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'TIME + '#39' '#39' + DATE'
        FontSize = 10
      end
      object QRLabel5: TQRLabel
        Left = 72
        Top = 40
        Width = 21
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          190.5
          105.833333333333
          55.5625)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'N/a'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel6: TQRLabel
        Left = 72
        Top = 24
        Width = 21
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          190.5
          63.5
          55.5625)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'N/a'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel14: TQRLabel
        Left = 8
        Top = 72
        Width = 50
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          21.1666666666667
          190.5
          132.291666666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Product:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object lbProductName: TQRLabel
        Left = 64
        Top = 72
        Width = 90
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          169.333333333333
          190.5
          238.125)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'lbProductName'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel18: TQRLabel
        Left = 410
        Top = 72
        Width = 99
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1084.79166666667
          190.5
          261.9375)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '(Panel names in '
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel19: TQRLabel
        Left = 508
        Top = 72
        Width = 29
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1344.08333333333
          190.5
          76.7291666666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'bold'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel20: TQRLabel
        Left = 540
        Top = 72
        Width = 171
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1428.75
          190.5
          452.4375)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'contain the specified product)'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel21: TQRLabel
        Left = 72
        Top = 8
        Width = 21
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          190.5
          21.1666666666667
          55.5625)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'N/a'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
    object QRGroup1: TQRGroup
      Left = 38
      Top = 161
      Width = 718
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        84.6666666666667
        1899.70833333333)
      Expression = 'qLocalPanels.Theme'
      Master = LocalPanelResults
      ReprintOnNewPage = False
      object QRLabel2: TQRLabel
        Left = 8
        Top = 8
        Width = 44
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          21.1666666666667
          21.1666666666667
          116.416666666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Theme:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText1: TQRDBText
        Left = 56
        Top = 8
        Width = 40
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          148.166666666667
          21.1666666666667
          105.833333333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qLocalPanels
        DataField = 'Theme'
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
    object QRGroup2: TQRGroup
      Left = 38
      Top = 193
      Width = 718
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        84.6666666666667
        1899.70833333333)
      Expression = 'qLocalPanels.PanelDesign'
      Master = LocalPanelResults
      ReprintOnNewPage = False
      object QRLabel1: TQRLabel
        Left = 40
        Top = 8
        Width = 82
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          105.833333333333
          21.1666666666667
          216.958333333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Panel Design:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText2: TQRDBText
        Left = 128
        Top = 8
        Width = 74
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          338.666666666667
          21.1666666666667
          195.791666666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qLocalPanels
        DataField = 'PanelDesign'
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
    object QRGroup3: TQRGroup
      Left = 38
      Top = 225
      Width = 718
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      BeforePrint = HandleBandBeforePrint
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        84.6666666666667
        1899.70833333333)
      Expression = 'qLocalPanels.Panel'
      Master = LocalPanelResults
      ReprintOnNewPage = False
      object QRLabel3: TQRLabel
        Left = 72
        Top = 8
        Width = 38
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          190.5
          21.1666666666667
          100.541666666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Panel:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object lbLocalPanelData: TQRDBText
        Tag = 1
        Left = 114
        Top = 8
        Width = 34
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          301.625
          21.1666666666667
          89.9583333333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qLocalPanels
        DataField = 'Panel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object lbLocalPanelOccurences: TQRLabel
        Tag = 2
        Left = 552
        Top = 8
        Width = 79
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1460.5
          21.1666666666667
          209.020833333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Occurrences:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object lbLocalPanelOccurencesData: TQRDBText
        Tag = 2
        Left = 640
        Top = 8
        Width = 71
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1693.33333333333
          21.1666666666667
          187.854166666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qLocalPanels
        DataField = 'Occurences'
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
    object QRGroup4: TQRGroup
      Tag = 1
      Left = 38
      Top = 257
      Width = 718
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      BeforePrint = HandleBandBeforePrint
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        84.6666666666667
        1899.70833333333)
      Expression = 'qLocalPanels.SubPanel'
      Master = LocalPanelResults
      ReprintOnNewPage = False
      object QRLabel4: TQRLabel
        Left = 104
        Top = 8
        Width = 65
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          275.166666666667
          21.1666666666667
          171.979166666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Sub Panel:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText7: TQRDBText
        Tag = 1
        Left = 174
        Top = 8
        Width = 63
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          460.375
          21.1666666666667
          166.6875)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qLocalPanels
        DataField = 'SubPanel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel10: TQRLabel
        Tag = 2
        Left = 552
        Top = 8
        Width = 75
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1460.5
          21.1666666666667
          198.4375)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Occurences:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText5: TQRDBText
        Tag = 2
        Left = 640
        Top = 8
        Width = 71
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1693.33333333333
          21.1666666666667
          187.854166666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qLocalPanels
        DataField = 'Occurences'
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
  end
  object VariationPanelResults: TQuickRep
    Left = 130
    Top = 312
    Width = 794
    Height = 1123
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    DataSet = qVariationPanels
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Values = (
      100
      2970
      100
      2100
      100
      100
      0)
    PrinterSettings.Copies = 1
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.OutputBin = Auto
    PrintIfEmpty = True
    SnapToGrid = True
    Units = MM
    Zoom = 100
    object QRGroup5: TQRGroup
      Left = 38
      Top = 38
      Width = 718
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        84.6666666666667
        1899.70833333333)
      Expression = 'qVariationPanels.VariationGroup'
      Master = VariationPanelResults
      ReprintOnNewPage = False
      object lbSharedPanelOrVariationGroup: TQRLabel
        Left = 8
        Top = 8
        Width = 95
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          21.1666666666667
          21.1666666666667
          251.354166666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Variation Group:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object lbSharedPanelData: TQRDBText
        Tag = 1
        Left = 109
        Top = 8
        Width = 87
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          288.395833333333
          21.1666666666667
          230.1875)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qVariationPanels
        DataField = 'VariationGroup'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
    object QRGroup6: TQRGroup
      Left = 38
      Top = 70
      Width = 718
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      BeforePrint = HandleBandBeforePrint
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        84.6666666666667
        1899.70833333333)
      Expression = 'qVariationPanels.Panel'
      Master = VariationPanelResults
      ReprintOnNewPage = False
      object QRLabel15: TQRLabel
        Left = 40
        Top = 8
        Width = 56
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          105.833333333333
          21.1666666666667
          148.166666666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Variation:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText9: TQRDBText
        Tag = 1
        Left = 102
        Top = 8
        Width = 38
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          269.875
          21.1666666666667
          100.541666666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qVariationPanels
        DataField = 'Panel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel17: TQRLabel
        Tag = 2
        Left = 552
        Top = 8
        Width = 79
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1460.5
          21.1666666666667
          209.020833333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Occurrences:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText11: TQRDBText
        Tag = 2
        Left = 640
        Top = 8
        Width = 71
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1693.33333333333
          21.1666666666667
          187.854166666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qVariationPanels
        DataField = 'Occurences'
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
    object QRGroup7: TQRGroup
      Tag = 1
      Left = 38
      Top = 102
      Width = 718
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      BeforePrint = HandleBandBeforePrint
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        84.6666666666667
        1899.70833333333)
      Expression = 'qVariationPanels.SubPanel'
      Master = VariationPanelResults
      ReprintOnNewPage = False
      object QRLabel7: TQRLabel
        Left = 72
        Top = 8
        Width = 65
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          190.5
          21.1666666666667
          171.979166666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Sub Panel:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText3: TQRDBText
        Tag = 1
        Left = 143
        Top = 8
        Width = 63
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          378.354166666667
          21.1666666666667
          166.6875)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qVariationPanels
        DataField = 'SubPanel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel16: TQRLabel
        Tag = 2
        Left = 552
        Top = 8
        Width = 75
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1460.5
          21.1666666666667
          198.4375)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Occurences:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText4: TQRDBText
        Tag = 2
        Left = 640
        Top = 8
        Width = 71
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1693.33333333333
          21.1666666666667
          187.854166666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qVariationPanels
        DataField = 'Occurences'
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
  end
  object SharedPanelResults: TQuickRep
    Left = 223
    Top = 456
    Width = 794
    Height = 1123
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    DataSet = qSharedPanels
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'QRSTRINGSBAND1'
      'QRSTRINGSBAND2')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      #39#39
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Values = (
      100
      2970
      100
      2100
      100
      100
      0)
    PrinterSettings.Copies = 1
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.OutputBin = Auto
    PrintIfEmpty = True
    SnapToGrid = True
    Units = Pixels
    Zoom = 100
    object QRGroup10: TQRGroup
      Left = 38
      Top = 38
      Width = 718
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      BeforePrint = HandleBandBeforePrint
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        84.6666666666667
        1899.70833333333)
      Expression = 'qSharedPanels.Panel'
      Master = SharedPanelResults
      ReprintOnNewPage = False
      object lbSharedPanel: TQRLabel
        Left = 8
        Top = 8
        Width = 83
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          21.1666666666667
          21.1666666666667
          219.604166666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Shared Panel:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object lbSharedPanelData2: TQRDBText
        Tag = 1
        Left = 97
        Top = 8
        Width = 34
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          256.645833333333
          21.1666666666667
          89.9583333333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qSharedPanels
        DataField = 'Panel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel30: TQRLabel
        Tag = 2
        Left = 552
        Top = 8
        Width = 79
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1460.5
          21.1666666666667
          209.020833333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Occurrences:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText14: TQRDBText
        Tag = 2
        Left = 640
        Top = 8
        Width = 71
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1693.33333333333
          21.1666666666667
          187.854166666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qSharedPanels
        DataField = 'Occurences'
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
    object QRGroup11: TQRGroup
      Tag = 1
      Left = 38
      Top = 70
      Width = 718
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      BeforePrint = HandleBandBeforePrint
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        84.6666666666667
        1899.70833333333)
      Expression = 'qSharedPanels.SubPanel'
      Master = SharedPanelResults
      ReprintOnNewPage = False
      object QRLabel31: TQRLabel
        Left = 40
        Top = 8
        Width = 65
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          105.833333333333
          21.1666666666667
          171.979166666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Sub Panel:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText15: TQRDBText
        Tag = 1
        Left = 111
        Top = 8
        Width = 63
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          293.6875
          21.1666666666667
          166.6875)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qSharedPanels
        DataField = 'SubPanel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel32: TQRLabel
        Tag = 2
        Left = 552
        Top = 8
        Width = 75
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1460.5
          21.1666666666667
          198.4375)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Occurences:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText16: TQRDBText
        Tag = 2
        Left = 640
        Top = 8
        Width = 71
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1693.33333333333
          21.1666666666667
          187.854166666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qSharedPanels
        DataField = 'Occurences'
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
  end
  object qSiteDetails: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select top 1 [company name] from company')
    Left = 88
    Top = 16
  end
  object qLocalPanels: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'ProductID'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'declare @ProductID varchar(50)'
      'set @ProductID = :ProductID'
      ''
      'declare @tmpbuttons table (panelid bigint, buttonid bigint)'
      'insert @tmpbuttons'
      'select panelid, buttonid'
      'from ThemePanelButton '
      'where '
      
        '  ButtonTypeChoiceID = (select ID from ThemeButtonTypeChoiceLook' +
        'up where Name = '#39'RingUpProduct'#39')'
      '  and ButtonTypeChoiceAttr01 = @ProductID'
      ''
      'select * from '
      '('
      
        'select Theme.Name as Theme, ThemePanelDesign.Name as PanelDesign' +
        ', ThemePanel.Name as Panel, null as SubPanel, count(*) as Occure' +
        'nces'
      'from @TmpButtons a'
      'join ThemePanel on a.PanelID = ThemePanel.PanelID'
      'join ThemePanelDesign on '
      '  ThemePanel.PanelDesignID = ThemePanelDesign.PanelDesignID '
      'join Theme on ThemePanelDesign.ThemeID = Theme.ThemeID'
      'where ThemePanel.PanelType = 3'
      'group by Theme.Name, ThemePanelDesign.Name, ThemePanel.Name'
      'union all'
      
        'select Theme.Name as Theme, ThemePanelDesign.Name as PanelDesign' +
        ', ThemePanel.Name as Panel, ThemePanelSubPanel.Name as SubPanel,' +
        ' count(*) as Occurences'
      'from @TmpButtons a'
      'join ThemePanelSubPanel on a.PanelID = SubPanelID'
      'join ThemePanel on ParentPanelID = ThemePanel.PanelID'
      'join ThemePanelDesign on '
      '  ThemePanel.PanelDesignID = ThemePanelDesign.PanelDesignID '
      'join Theme on ThemePanelDesign.ThemeID = Theme.ThemeID'
      
        'group by Theme.Name, ThemePanelDesign.Name, ThemePanel.Name, The' +
        'mePanelSubPanel.Name'
      ''
      ''
      'union all'
      
        'select Theme.Name as Theme, ThemePanelDesign.Name as PanelDesign' +
        ', ThemePanel.Name as Panel, null as SubPanel, 0 as Occurences'
      'from @TmpButtons a'
      'join ThemePanelSubPanel on a.PanelID = SubPanelID'
      'join ThemePanel on ParentPanelID = ThemePanel.PanelID'
      'join ThemePanelDesign on '
      '  ThemePanel.PanelDesignID = ThemePanelDesign.PanelDesignID '
      'join Theme on ThemePanelDesign.ThemeID = Theme.ThemeID'
      'where ParentPanelID not in (select panelid from @tmpbuttons)'
      'group by Theme.Name, ThemePanelDesign.Name, ThemePanel.Name'
      ') a'
      'order by 1, 2, 3, 4')
    Left = 120
    Top = 16
  end
  object qSharedPanels: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'ProductID'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'declare @ProductID varchar(50)'
      'set @ProductID = :ProductID'
      ''
      'declare @tmpbuttons table (panelid bigint, buttonid bigint)'
      'insert @tmpbuttons'
      'select panelid, buttonid'
      'from ThemePanelButton '
      'where '
      
        '  ButtonTypeChoiceID = (select ID from ThemeButtonTypeChoiceLook' +
        'up where Name = '#39'RingUpProduct'#39')'
      '  and ButtonTypeChoiceAttr01 = @ProductID'
      ''
      'select * from '
      '('
      
        'select ThemePanel.Name as Panel, null as SubPanel, count(b.panel' +
        'id) as Occurences'
      ''
      'from ('
      'select PanelID from @TmpButtons'
      'union Select ParentPanelID from ThemePanelSubPanel'
      ') a'
      'join ThemePanel on a.PanelID = ThemePanel.PanelID'
      'left outer join @TmpButtons b on a.PanelID = b.PanelID'
      
        'where PanelType = 2 and ThemePanel.PanelID not in (select paneli' +
        'd from ThemePanelVariationGroup)'
      'group by ThemePanel.Name'
      'union all'
      ''
      
        'select ThemePanel.Name as Panel, ThemePanelSubPanel.Name as SubP' +
        'anel, count(*) as Occurences'
      'from @TmpButtons a'
      'join ThemePanelSubPanel on a.PanelID = SubPanelID'
      'join ThemePanel on ParentPanelID = ThemePanel.PanelID'
      
        'where PanelType = 2 and ThemePanel.PanelID not in (select paneli' +
        'd from ThemePanelVariationGroup)'
      'group by ThemePanel.Name, ThemePanelSubPanel.Name'
      ''
      ') sub'
      'order by 1, 2')
    Left = 152
    Top = 16
  end
  object QRCompositeReport1: TQRCompositeReport
    OnAddReports = QRCompositeReport1AddReports
    OnFinished = QRCompositeReport1Finished
    Options = []
    PrinterSettings.Copies = 1
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.OutputBin = Auto
    PrinterSettings.Orientation = poPortrait
    PrinterSettings.PaperSize = Letter
    Left = 32
    Top = 56
  end
  object qVariationPanels: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'ProductID'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'declare @ProductID varchar(50)'
      'set @ProductID = :ProductID'
      ''
      'declare @tmpbuttons table (panelid bigint, buttonid bigint)'
      'insert @tmpbuttons'
      'select panelid, buttonid'
      'from ThemePanelButton '
      'where '
      
        '  ButtonTypeChoiceID = (select ID from ThemeButtonTypeChoiceLook' +
        'up where Name = '#39'RingUpProduct'#39')'
      '  and ButtonTypeChoiceAttr01 = @ProductID'
      ''
      'select * from '
      '('
      
        'select c.Name as VariationGroup, ThemePanel.Name as Panel, null ' +
        'as SubPanel, count(b.panelid) as Occurences'
      ''
      'from ('
      'select PanelID from @TmpButtons'
      'union Select ParentPanelID from ThemePanelSubPanel'
      ') a'
      'join ThemePanel on a.PanelID = ThemePanel.PanelID'
      '--left outer'
      ' join @TmpButtons b on a.PanelID = b.PanelID'
      'join ThemePanelVariation on a.PanelID = VariationPanelID'
      'join ThemePanel c on ThemePanelVariation.PanelID = c.PanelID '
      'where ThemePanel.PanelType = 6'
      'group by c.Name, ThemePanel.Name'
      'union all'
      ''
      
        'select c.Name as VariationGroup,  ThemePanel.Name as Panel, Them' +
        'ePanelSubPanel.Name as SubPanel, count(*) as Occurences'
      'from @TmpButtons a'
      'join ThemePanelSubPanel on a.PanelID = SubPanelID'
      'join ThemePanel on ParentPanelID = ThemePanel.PanelID'
      
        'join ThemePanelVariation on ThemePanel.PanelID = VariationPanelI' +
        'D'
      'join ThemePanel c on ThemePanelVariation.PanelID = c.PanelID'
      'where ThemePanel.PanelType = 6'
      'group by c.Name, ThemePanel.Name, ThemePanelSubPanel.Name'
      ''
      ') sub'
      'order by 1, 2')
    Left = 184
    Top = 16
  end
end
