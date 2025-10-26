unit uRepSP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Wwquery, ppBands, ppReport, ppStrtch, ppSubRpt, ppClass,
  ppPrnabl, ppCtrls, ppProd, ppComm, ppCache, ppDB, ppDBBDE, Wwdatsrc,
  ppVar, ppRelatv, ppDBPipe, ADODB, ppMemo, ppRegion, ppTypes;

type
  TfRepSP = class(TDataModule)
    wwds1: TwwDataSource;
    pipe1: TppBDEPipeline;
    ppS_Prep: TppReport;
    ppS_PrepSummaryBand1: TppSummaryBand;
    ppS_PrepDBText1: TppDBText;
    ppS_PrepDBText2: TppDBText;
    ppS_PrepDBText3: TppDBText;
    ppS_PrepDBText4: TppDBText;
    ppS_PrepDBText5: TppDBText;
    ppS_PrepDBText6: TppDBText;
    ppS_PrepDBText7: TppDBText;
    ppS_PrepDBText8: TppDBText;
    ppS_PrepDBText9: TppDBText;
    ppS_PrepDBText10: TppDBText;
    ppS_PrepLabel1: TppLabel;
    ppS_PrepLabel2: TppLabel;
    ppS_PrepLabel3: TppLabel;
    ppS_PrepLabel4: TppLabel;
    ppS_PrepLabel5: TppLabel;
    ppS_PrepLabel6: TppLabel;
    ppS_PrepLabel7: TppLabel;
    ppS_PrepLabel8: TppLabel;
    ppS_PrepLabel9: TppLabel;
    ppS_PrepDBText11: TppDBText;
    ppS_PrepLabel10: TppLabel;
    ppHoldRepLabel1: TppLabel;
    ppHoldRepLabel2: TppLabel;
    ppHoldRepLabel3: TppLabel;
    ppHoldRepLabel4: TppLabel;
    ppltype: TppLabel;
    pplTake: TppLabel;
    pplLen: TppLabel;
    pplAcc: TppLabel;
    ppHoldRepLabel10: TppLabel;
    ppS_PrepLine1: TppLine;
    ppS_PrepLine2: TppLine;
    ppS_PrepLine3: TppLine;
    ppS_PrepLine4: TppLine;
    ppS_PrepLine6: TppLine;
    ppS_PrepLine7: TppLine;
    ppS_PrepLine8: TppLine;
    ppS_PrepLine9: TppLine;
    ppS_PrepLine10: TppLine;
    ppS_PrepLine11: TppLine;
    ppS_PrepLine12: TppLine;
    ppS_PrepLine13: TppLine;
    ppS_PrepLine14: TppLine;
    ppS_PrepLine15: TppLine;
    ppS_PrepLine16: TppLine;
    ppS_PrepLine17: TppLine;
    ppS_PrepLine18: TppLine;
    ppS_PrepLine19: TppLine;
    ppS_PrepLine20: TppLine;
    ppS_PrepLine21: TppLine;
    ppS_PrepLine22: TppLine;
    ppS_PrepLine23: TppLine;
    ppS_PrepLine24: TppLine;
    ppS_PrepLine25: TppLine;
    ppS_PrepLine26: TppLine;
    ppS_PrepLabel11: TppLabel;
    ppS_PrepDBCalc1: TppDBCalc;
    ppS_PrepDBCalc4: TppDBCalc;
    ppS_PrepDBCalc5: TppDBCalc;
    ppS_PrepLine5: TppLine;
    ppS_PrepLine27: TppLine;
    ppS_PrepLine28: TppLine;
    ppS_PrepLine29: TppLine;
    ppS_PrepLine30: TppLine;
    ppS_PrepLine31: TppLine;
    ppS_PrepLine32: TppLine;
    ppS_PrepLine33: TppLine;
    ppS_PrepLine34: TppLine;
    ppS_PrepLine35: TppLine;
    ppS_PrepLine36: TppLine;
    ppS_PrepLine37: TppLine;
    ppS_PrepLine38: TppLine;
    ppS_PrepLine39: TppLine;
    ppS_PrepLine40: TppLine;
    ppS_PrepLine41: TppLine;
    ppS_PrepLine42: TppLine;
    ppS_PrepLine43: TppLine;
    ppS_PrepLine44: TppLine;
    ppS_PrepLine45: TppLine;
    ppS_PrepLabel14: TppLabel;
    ppS_PrepDBCalc6: TppDBCalc;
    ppTotSalInc: TppDBCalc;
    ppSalGP: TppDBCalc;
    ppS_PrepLine46: TppLine;
    ppS_PrepLine47: TppLine;
    ppHoldRepCalc1: TppSystemVariable;
    wwqRun: TADOQuery;
    ppcThVal: TppDBCalc;
    ppcActVal: TppDBCalc;
    ppcNetInc: TppDBCalc;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLine1: TppLine;
    pipeCount: TppBDEPipeline;
    ppCount: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppt2: TppDBText;
    ppt1: TppDBText;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppLine8: TppLine;
    lineD1: TppLine;
    ppLine16: TppLine;
    ppLine17: TppLine;
    lineDTot: TppLine;
    ppSummaryBand1: TppSummaryBand;
    pplTot: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppDBText20: TppDBText;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppl1: TppLabel;
    ppl2: TppLabel;
    ppLine62: TppLine;
    ppLine63: TppLine;
    ppLine64: TppLine;
    ppLine65: TppLine;
    ppLine66: TppLine;
    line1: TppLine;
    ppLine74: TppLine;
    ppLine75: TppLine;
    ppLine76: TppLine;
    ppLine77: TppLine;
    pplCloseQ: TppLabel;
    lineTot: TppLine;
    ppGroupFooterBand1: TppGroupFooterBand;
    line2: TppLine;
    lineD2: TppLine;
    adoqCount: TADOQuery;
    dsCount: TwwDataSource;
    ppLabel13: TppLabel;
    ppLine11: TppLine;
    ppLine12: TppLine;
    ppLine13: TppLine;
    lineS1: TppLine;
    lineS2: TppLine;
    lineSTot: TppLine;
    ppLine21: TppLine;
    ppLine22: TppLine;
    ppLine31: TppLine;
    ppShape1: TppShape;
    pplDiv: TppLabel;
    pplFrom: TppLabel;
    ppShape2: TppShape;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppSystemVariable2: TppSystemVariable;
    pplTimes: TppLabel;
    ppLine23: TppLine;
    pplTid: TppLabel;
    ppShape3: TppShape;
    ppLabel3: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel12: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText12: TppDBText;
    ppSystemVariable3: TppSystemVariable;
    ppLabel16: TppLabel;
    ppLine24: TppLine;
    ppLabel17: TppLabel;
    pptTot: TppDBText;
    ppLabel84: TppLabel;
    ppLabel18: TppLabel;
    ppShape11: TppShape;
    ppShape4: TppShape;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppDBCalc3: TppDBCalc;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    wwqOrphan: TADOQuery;
    pipeOrphan: TppDBPipeline;
    wwsOrphan: TwwDataSource;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppLabel27: TppLabel;
    ppLabel30: TppLabel;
    ppLabel31: TppLabel;
    ppLabel32: TppLabel;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine9: TppLine;
    ppLine25: TppLine;
    ppLine26: TppLine;
    ppLine27: TppLine;
    ppLine28: TppLine;
    ppLabel33: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppDBText1: TppDBText;
    ppDBText4: TppDBText;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppLine29: TppLine;
    ppLine30: TppLine;
    ppLine32: TppLine;
    ppLine33: TppLine;
    ppLine35: TppLine;
    ppLine36: TppLine;
    ppLine37: TppLine;
    ppLine38: TppLine;
    ppSummaryBand2: TppSummaryBand;
    ppShape7: TppShape;
    ppShape8: TppShape;
    ppLine39: TppLine;
    ppLine40: TppLine;
    ppLine41: TppLine;
    ppLine42: TppLine;
    ppLine43: TppLine;
    ppLine44: TppLine;
    ppLine45: TppLine;
    ppLine46: TppLine;
    ppLine47: TppLine;
    ppOrphGP: TppDBCalc;
    ppLabel36: TppLabel;
    ppLabel38: TppLabel;
    ppLabel39: TppLabel;
    ppLine51: TppLine;
    ppS_PrepLine48: TppLine;
    ppGroup3: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppGroupFooterBand3: TppGroupFooterBand;
    ppGroup5: TppGroup;
    ppGroupHeaderBand5: TppGroupHeaderBand;
    ppGroupFooterBand5: TppGroupFooterBand;
    ppLine34: TppLine;
    ppLabel349: TppLabel;
    ppLabel23: TppLabel;
    dsHZMSite: TwwDataSource;
    ppHZMSite: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppShape9: TppShape;
    pplTitle: TppLabel;
    ppLabel34: TppLabel;
    ppLabel37: TppLabel;
    ppLabel40: TppLabel;
    ppLabel41: TppLabel;
    ppSystemVariable4: TppSystemVariable;
    ppDBText18: TppDBText;
    ppDBText19: TppDBText;
    ppDBText21: TppDBText;
    ppSystemVariable5: TppSystemVariable;
    ppLine48: TppLine;
    pplFromTo: TppLabel;
    pplMvBy: TppLabel;
    ppLine49: TppLine;
    ppLine50: TppLine;
    ppLine52: TppLine;
    ppLine53: TppLine;
    ppLine54: TppLine;
    ppLine55: TppLine;
    ppLine56: TppLine;
    ppLine57: TppLine;
    ppLine58: TppLine;
    ppLabel42: TppLabel;
    ppLabel43: TppLabel;
    ppLabel44: TppLabel;
    ppLabel45: TppLabel;
    ppLabel46: TppLabel;
    ppDetailBand3: TppDetailBand;
    ppDBText22: TppDBText;
    ppDBText23: TppDBText;
    ppDBText24: TppDBText;
    ppLine59: TppLine;
    ppLine60: TppLine;
    ppLine61: TppLine;
    ppLine67: TppLine;
    ppLine68: TppLine;
    ppLine69: TppLine;
    ppLine70: TppLine;
    ppDBText25: TppDBText;
    ppLine71: TppLine;
    ppDBText26: TppDBText;
    ppSummaryBand3: TppSummaryBand;
    pipeHZMSite: TppDBPipeline;
    adoqHZMSite: TADOQuery;
    ppGroup6: TppGroup;
    ppGroupHeaderBand6: TppGroupHeaderBand;
    ppGroupFooterBand6: TppGroupFooterBand;
    ppDBText27: TppDBText;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppDBText30: TppDBText;
    ppDBText32: TppDBText;
    ppLabel47: TppLabel;
    ppDBText33: TppDBText;
    ppLine73: TppLine;
    ppLine80: TppLine;
    ppLine88: TppLine;
    ppLabel48: TppLabel;
    ppLabel49: TppLabel;
    ppLabel50: TppLabel;
    ppLabel51: TppLabel;
    ppLabel52: TppLabel;
    ppLine89: TppLine;
    ppLine90: TppLine;
    ppDBMemo1: TppDBMemo;
    ppLine91: TppLine;
    ppLine92: TppLine;
    ppLine93: TppLine;
    ppLabel53: TppLabel;
    ppShape10: TppShape;
    ppShape12: TppShape;
    ppShape13: TppShape;
    ppShape14: TppShape;
    ppShape15: TppShape;
    ppShape16: TppShape;
    ppLabel54: TppLabel;
    ppLabel55: TppLabel;
    adoqHZM1: TADOQuery;
    adoqHZM2: TADOQuery;
    wwDataSource1: TwwDataSource;
    wwDataSource2: TwwDataSource;
    ppDBPipeline1: TppDBPipeline;
    ppDBPipeline2: TppDBPipeline;
    ppReport1: TppReport;
    ppHeaderBand3: TppHeaderBand;
    ppDetailBand5: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppSubReport3: TppSubReport;
    ppChildReport3: TppChildReport;
    ppShape18: TppShape;
    ppTitleBand1: TppTitleBand;
    ppDetailBand6: TppDetailBand;
    ppSummaryBand4: TppSummaryBand;
    ppGroup9: TppGroup;
    ppGroupHeaderBand9: TppGroupHeaderBand;
    ppGroupFooterBand9: TppGroupFooterBand;
    ppGroup10: TppGroup;
    ppGroupHeaderBand10: TppGroupHeaderBand;
    ppGroupFooterBand10: TppGroupFooterBand;
    ppLine625: TppLine;
    ppLabel57: TppLabel;
    ppDBText191: TppDBText;
    ppLabel366: TppLabel;
    ppLabel367: TppLabel;
    ppLabel368: TppLabel;
    lghzLab1: TppLabel;
    lghzHTopLine: TppLine;
    lghzHMidLine: TppLine;
    ppLine623: TppLine;
    ppLine624: TppLine;
    ppLine626: TppLine;
    ppLine627: TppLine;
    ppLine650: TppLine;
    ppLine592: TppLine;
    lghzLab2: TppLabel;
    lghzTLine2: TppLine;
    lghzLab3: TppLabel;
    lghzTLine3: TppLine;
    lghzLab4: TppLabel;
    lghzTLine4: TppLine;
    lghzLab5: TppLabel;
    lghzTLine5: TppLine;
    lghzLab6: TppLabel;
    lghzTLine6: TppLine;
    lghzLab7: TppLabel;
    lghzTLine7: TppLine;
    lghzLab8: TppLabel;
    lghzTLine8: TppLine;
    lghzLab9: TppLabel;
    lghzTLine9: TppLine;
    ppLine109: TppLine;
    ppLine110: TppLine;
    ppLine111: TppLine;
    ppLabel56: TppLabel;
    ppLine112: TppLine;
    ppDBText175: TppDBText;
    ppDBText176: TppDBText;
    ppDBText177: TppDBText;
    ppLine481: TppLine;
    lghzHBotLine: TppLine;
    ppLine532: TppLine;
    ppLine550: TppLine;
    ppLine584: TppLine;
    ppDBText178: TppDBText;
    ppLine591: TppLine;
    lgHZtext2: TppDBText;
    lghzLine2: TppLine;
    lghzText4: TppDBText;
    lghzLine4: TppLine;
    lghzLine3: TppLine;
    lghzText3: TppDBText;
    lghzText5: TppDBText;
    lghzLine5: TppLine;
    lghzText6: TppDBText;
    lghzLine6: TppLine;
    lghzText8: TppDBText;
    lghzLine8: TppLine;
    lghzLine7: TppLine;
    lghzText7: TppDBText;
    lghzText9: TppDBText;
    lghzLine9: TppLine;
    lghzShape1: TppShape;
    lghzTitle: TppLabel;
    ppLabel250: TppLabel;
    ppLabel319: TppLabel;
    ppLabel344: TppLabel;
    lghzLength: TppLabel;
    lghzPrinted: TppLabel;
    lghzPage: TppSystemVariable;
    lghzFrom: TppLabel;
    ppDBText172: TppDBText;
    ppDBText173: TppDBText;
    ppDBText174: TppDBText;
    lghzPrTime: TppSystemVariable;
    ppLine413: TppLine;
    lghzHeader: TppLabel;
    ppDBText34: TppDBText;
    ppDBText35: TppDBText;
    ppDBText36: TppDBText;
    ppLine79: TppLine;
    hzmLMid: TppLine;
    ppLine82: TppLine;
    ppLine83: TppLine;
    ppLine86: TppLine;
    ppDBText37: TppDBText;
    ppLine87: TppLine;
    hzmText2: TppDBText;
    hzmLine2: TppLine;
    hzmText4: TppDBText;
    hzmLine4: TppLine;
    hzmLine3: TppLine;
    hzmText3: TppDBText;
    hzmText5: TppDBText;
    hzmLine5: TppLine;
    hzmText6: TppDBText;
    hzmLine6: TppLine;
    hzmText8: TppDBText;
    hzmLine8: TppLine;
    hzmLine7: TppLine;
    hzmText7: TppDBText;
    hzmText9: TppDBText;
    hzmLine9: TppLine;
    ppLine102: TppLine;
    ppLine103: TppLine;
    hzmLTop: TppLine;
    hzmLRTop: TppLine;
    ppLine104: TppLine;
    hzmLRBot: TppLine;
    hzmLBot: TppLine;
    ppLine81: TppLine;
    ppLabel58: TppLabel;
    ppLine94: TppLine;
    ppDBText31: TppDBText;
    ppLabel213: TppLabel;
    ppLine189: TppLine;
    ppLine190: TppLine;
    ppLine191: TppLine;
    ppLine95: TppLine;
    ppLine96: TppLine;
    ppShape17: TppShape;
    ppl3: TppLabel;
    ppt3: TppDBText;
    lineS3: TppLine;
    lineD3: TppLine;
    line3: TppLine;
    ppShape5: TppShape;
    ppLine10: TppLine;
    ppLabel4: TppLabel;
    ppShape6: TppShape;
    ppDBCalc4: TppDBCalc;
    ppDBText5: TppDBText;
    ppSPslave: TppSubReport;
    ppChildReport2: TppChildReport;
    ppShape19: TppShape;
    adoqSPSlave: TADOQuery;
    dsSPSlave: TDataSource;
    pipeSPSlave: TppDBPipeline;
    ppDBText11: TppDBText;
    ppDetailBand4: TppDetailBand;
    ppDBMemo2: TppDBMemo;
    ppLine98: TppLine;
    ppRegion2: TppRegion;
    ppDBText13: TppDBText;
    ppDBText38: TppDBText;
    ppDBText39: TppDBText;
    ppDBText40: TppDBText;
    ppDBText41: TppDBText;
    ppDBText42: TppDBText;
    ppDBText43: TppDBText;
    ppDBText44: TppDBText;
    ppLine14: TppLine;
    ppLine15: TppLine;
    ppLine18: TppLine;
    ppLine19: TppLine;
    ppLine20: TppLine;
    ppLine72: TppLine;
    ppLine78: TppLine;
    ppLine84: TppLine;
    ppLine85: TppLine;
    ppLine97: TppLine;
    ppRegion1: TppRegion;
    ppSummaryBand5: TppSummaryBand;
    pipeLocationCount: TppBDEPipeline;
    ppLocationCount: TppReport;
    ppHeaderBand4: TppHeaderBand;
    ppShape20: TppShape;
    ppLabel11: TppLabel;
    ppLabel24: TppLabel;
    ppLabel28: TppLabel;
    ppLabel29: TppLabel;
    ppLabel35: TppLabel;
    ppLabel59: TppLabel;
    ppLabel60: TppLabel;
    ppLabel61: TppLabel;
    ppSystemVariable6: TppSystemVariable;
    ppLabel62: TppLabel;
    ppLabel63: TppLabel;
    ppDBText45: TppDBText;
    ppDBText46: TppDBText;
    ppDBText47: TppDBText;
    ppSystemVariable7: TppSystemVariable;
    ppLabel64: TppLabel;
    ppLine99: TppLine;
    ppLabel65: TppLabel;
    ppLabel66: TppLabel;
    ppLabel67: TppLabel;
    ppDetailBand7: TppDetailBand;
    ppDBText48: TppDBText;
    ppDBText49: TppDBText;
    ppDBText51: TppDBText;
    ppLine100: TppLine;
    ppLine101: TppLine;
    ppLine105: TppLine;
    ppLine107: TppLine;
    ppLine108: TppLine;
    ppLine113: TppLine;
    ppLocationsTot: TppDBText;
    ppSummaryBand6: TppSummaryBand;
    ppLabel68: TppLabel;
    ppLabel69: TppLabel;
    ppLabel70: TppLabel;
    ppLabel71: TppLabel;
    ppLine117: TppLine;
    ppLine119: TppLine;
    ppLine120: TppLine;
    ppLine122: TppLine;
    ppLine123: TppLine;
    ppLine125: TppLine;
    ppLabel73: TppLabel;
    ppLine126: TppLine;
    ppLabel74: TppLabel;
    adoqLocationCount: TADOQuery;
    dsLocationCount: TwwDataSource;
    ppLine116: TppLine;
    ppLine118: TppLine;
    ppDBText50: TppDBText;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppLine129: TppLine;
    ppRegion3: TppRegion;
    ppMemoLocNote: TppMemo;
    ppDBTextMustCount: TppDBText;
    ppDBTextMustCountLoc: TppDBText;
    ppCount15: TppReport;
    ppHeaderBand5: TppHeaderBand;
    ppShape21: TppShape;
    ppLabel72: TppLabel;
    ppLabel75: TppLabel;
    ppLabel76: TppLabel;
    ppLabel77: TppLabel;
    ppLabel78: TppLabel;
    ppLabel79: TppLabel;
    ppLabel80: TppLabel;
    ppLabel81: TppLabel;
    ppSystemVariable8: TppSystemVariable;
    ppLabel82: TppLabel;
    ppLabel83: TppLabel;
    ppDBText52: TppDBText;
    ppDBText53: TppDBText;
    ppDBText54: TppDBText;
    ppSystemVariable9: TppSystemVariable;
    ppLabel85: TppLabel;
    ppLine106: TppLine;
    ppLabel86: TppLabel;
    ppLabel87: TppLabel;
    ppLabel88: TppLabel;
    ppDetailBand8: TppDetailBand;
    ppDBText55: TppDBText;
    ppDBText56: TppDBText;
    ppDBText57: TppDBText;
    ppDBText58: TppDBText;
    ppLine114: TppLine;
    ppLine115: TppLine;
    ppLine121: TppLine;
    ppLine124: TppLine;
    ppLine127: TppLine;
    ppLine128: TppLine;
    ppLine130: TppLine;
    ppLine131: TppLine;
    ppDBText59: TppDBText;
    ppDBText60: TppDBText;
    ppLine132: TppLine;
    ppDBText61: TppDBText;
    ppSummaryBand7: TppSummaryBand;
    ppShape22: TppShape;
    ppLabel89: TppLabel;
    ppGroup4: TppGroup;
    ppGroupHeaderBand4: TppGroupHeaderBand;
    ppDBText62: TppDBText;
    ppLabel90: TppLabel;
    ppLabel91: TppLabel;
    ppLabel92: TppLabel;
    ppLabel93: TppLabel;
    ppLine133: TppLine;
    ppLine134: TppLine;
    ppLine135: TppLine;
    ppLine136: TppLine;
    ppLine137: TppLine;
    ppLine138: TppLine;
    ppLine139: TppLine;
    ppLine140: TppLine;
    ppLine141: TppLine;
    ppLine142: TppLine;
    ppLabel94: TppLabel;
    ppLine143: TppLine;
    ppLine144: TppLine;
    ppLabel95: TppLabel;
    ppLabel96: TppLabel;
    ppLine145: TppLine;
    ppGroupFooterBand4: TppGroupFooterBand;
    ppLine146: TppLine;
    ppLine147: TppLine;
    ppLine148: TppLine;
    ppLine149: TppLine;
    ppLine150: TppLine;
    ppLine151: TppLine;
    ppLine152: TppLine;
    ppLine153: TppLine;
    ppLine154: TppLine;
    ppLine155: TppLine;
    ppLocationCount15: TppReport;
    ppHeaderBand6: TppHeaderBand;
    ppShape23: TppShape;
    ppLabel97: TppLabel;
    ppLabel98: TppLabel;
    ppLabel99: TppLabel;
    ppLabel100: TppLabel;
    ppLabel101: TppLabel;
    ppLabel102: TppLabel;
    ppLabel103: TppLabel;
    ppLabel104: TppLabel;
    ppSystemVariable10: TppSystemVariable;
    ppLabel105: TppLabel;
    ppLabel106: TppLabel;
    ppDBText63: TppDBText;
    ppDBText64: TppDBText;
    ppDBText65: TppDBText;
    ppSystemVariable11: TppSystemVariable;
    ppLabel107: TppLabel;
    ppLine156: TppLine;
    ppLabel108: TppLabel;
    ppLabel109: TppLabel;
    ppLabel110: TppLabel;
    ppDetailBandLocationCount15: TppDetailBand;
    ppDBText66: TppDBText;
    ppDBText67: TppDBText;
    ppDBText68: TppDBText;
    ppLine157: TppLine;
    ppLine158: TppLine;
    ppLine159: TppLine;
    ppLine160: TppLine;
    ppLine161: TppLine;
    ppLine162: TppLine;
    ppDBText69: TppDBText;
    ppLine163: TppLine;
    ppDBText70: TppDBText;
    ppDBText71: TppDBText;
    ppSummaryBand8: TppSummaryBand;
    ppRegion4: TppRegion;
    ppLabel111: TppLabel;
    ppMemo1: TppMemo;
    ppGroup7: TppGroup;
    ppGroupHeaderBand7: TppGroupHeaderBand;
    ppLabel112: TppLabel;
    ppLabel113: TppLabel;
    ppLabel114: TppLabel;
    ppLine164: TppLine;
    ppLine165: TppLine;
    ppLine166: TppLine;
    ppLine167: TppLine;
    ppLine168: TppLine;
    ppLine169: TppLine;
    ppLabel115: TppLabel;
    ppLine170: TppLine;
    ppLabel116: TppLabel;
    ppLine171: TppLine;
    ppGroupFooterBand7: TppGroupFooterBand;
    ppLine172: TppLine;
    procedure ppS_PrepPreviewFormCreate(Sender: TObject);
    procedure ppS_PrepGroupFooterBand1BeforePrint(Sender: TObject);
    procedure ppS_PrepHeaderBand1BeforePrint(Sender: TObject);
    procedure ppHeaderBand1BeforePrint(Sender: TObject);
    procedure ppS_PrepDetailBand1BeforePrint(Sender: TObject);
    procedure ppt1GetText(Sender: TObject; var Text: String);
    procedure pplAccPrint(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure ppS_PrepSummaryBand1BeforePrint(Sender: TObject);
    procedure ppLabel39Print(Sender: TObject);
    procedure ppHeaderBand2BeforePrint(Sender: TObject);
    procedure ppDBText23GetText(Sender: TObject; var Text: String);
    procedure ppDetailBand3BeforePrint(Sender: TObject);
    procedure ppDBText178GetText(Sender: TObject; var Text: String);
    procedure ppHeaderBand6BeforePrint(Sender: TObject);
    procedure ppDBText37GetText(Sender: TObject; var Text: String);
    procedure ppCountBeforePrint(Sender: TObject);
    procedure ppHeaderBand4BeforePrint(Sender: TObject);
    procedure ppLocationCountBeforePrint(Sender: TObject);
    procedure ppDBText50GetText(Sender: TObject; var Text: String);
    procedure ppGroupHeaderBand2BeforePrint(Sender: TObject);
    procedure ppDetailBand7BeforePrint(Sender: TObject);
    procedure ppGroupFooterBand2BeforePrint(Sender: TObject);
    procedure ppSummaryBand6BeforePrint(Sender: TObject);
    procedure ppDBText51GetText(Sender: TObject; var Text: String);
    procedure ppLocationsTotGetText(Sender: TObject; var Text: String);
    procedure ppDetailBand1BeforePrint(Sender: TObject);
  private
    { Private declarations }
    procedure setThreadLabelTextAndProperties(var Alabel: TppLabel);
  public
    { Public declarations }
    doTheo, spSlave : boolean;

    procedure ACSprint(fixed : boolean);
    procedure PrintCount;
    procedure PrintLocationCount;
  end;

var
  fRepSP: TfRepSP;

implementation

uses uADO, udata1;

{$R *.DFM}

procedure TfRepSP.ppS_PrepPreviewFormCreate(Sender: TObject);
begin
  dmADO.ALLRepsPreviewFormCreate(Sender, data1.repPaperName);
end;

procedure TfRepSP.ppS_PrepGroupFooterBand1BeforePrint(Sender: TObject);
begin
  if ppcNetInc.Value = 0 then
  begin
    ppLabel1.Caption := '00.00';
    ppLabel2.Caption := '00.00';
  end
  else
  begin
    if data1.curIsGP then
    begin
      ppLabel1.Caption := formatfloat('0.00', ((1 - (ppcThVal.Value / ppcNetInc.Value )) * 100));
      ppLabel2.Caption := formatfloat('0.00', ((1 - (ppcActVal.Value / ppcNetInc.Value )) * 100));
    end
    else
    begin
      ppLabel1.Caption := formatfloat('0.00', ((ppcThVal.Value / ppcNetInc.Value) * 100));
      ppLabel2.Caption := formatfloat('0.00', ((ppcActVal.Value / ppcNetInc.Value) * 100));
    end;
  end;

  ppdbCalc4.Visible := (ppdbCalc4.Value > 0);
  ppLabel4.Visible := ppdbCalc4.Visible;
  ppShape6.Visible := ppdbCalc4.Visible;
end;

procedure TfRepSP.PrintCount;
begin
  if data1.curACSheight = 1.5 then
    ppCount15.Print
  else
    ppCount.Print;
end;

procedure TfRepSP.PrintLocationCount;
begin
  if data1.curACSheight = 1.5 then
    ppLocationCount15.Print
  else
    ppLocationCount.Print;
end;

procedure TfRepSP.ppS_PrepHeaderBand1BeforePrint(Sender: TObject);
var
  s1 :string;
begin
  pplabel84.Text := 'Header: ' + data1.repHdr;
  setThreadLabelTextAndProperties(pplTid);
  pplType.Text := data1.SSbig + ' Type: ' + data1.StkTypeLong;
  pplDiv.Text := 'Division: ' + data1.theDiv;
  pplTake.Text := data1.SSbig + ' Taker: ' + data1.TheStkTkr;
  pplFrom.Text := 'From: ' + formatDateTime(shortdateformat, data1.SDate) + '   To: ' +
    formatDateTime(shortdateformat, data1.EDate);

  if data1.NeedBeg or data1.NeedEnd then
    s1 := 'Sales included only between ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.SDT) +
       ' and ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.EDT)
    else
      s1 := '';

  pplTimes.Text := s1;

  pplLen.Text := 'Period Length: ' + inttostr(trunc(data1.Edate - data1.SDate + 1)) + ' Days';

  if data1.AccDate <> 0 then
    pplAcc.Text := 'Accepted Date: ' + formatDateTime(shortdateformat, data1.AccDate)
  else
    pplAcc.text := 'Not Accepted';

end;

procedure TfRepSP.ppHeaderBand1BeforePrint(Sender: TObject);
var
  s1 :string;
begin
  pplabel18.Text := 'Header: ' + data1.repHdr;
  pplabel17.Text := 'Thread Name: ' + data1.curTidName;
  pplabel8.Text := data1.SSbig + ' Type: ' + data1.StkTypeLong;
  pplabel14.Text := 'Division: ' + data1.theDiv;
  pplabel9.Text := data1.SSbig + ' Taker: ' + data1.TheStkTkr;
  pplabel15.Text := 'From: ' + formatDateTime(shortdateformat, data1.SDate) + '   To: ' +
    formatDateTime(shortdateformat, data1.EDate);

  if data1.NeedBeg or data1.NeedEnd then
    s1 := 'Sales included only between ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.SDT) +
       ' and ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.EDT)
    else
      s1 := '';

  pplabel16.Text := s1;

  pplabel10.Text := 'Period Length: ' + inttostr(trunc(data1.Edate - data1.SDate + 1)) + ' Days';

  if pplabel3.Text <> '"No Location" Count' then
    pplabel3.Text := data1.SSbig + ' Count Sheet';
end;

procedure TfRepSP.ppS_PrepDetailBand1BeforePrint(Sender: TObject);
begin
  ppshape5.Visible := (ppDBText5.Text = '1'); // recipe variance
  ppShape19.Visible := spSlave and
                             (ppdbText11.FieldValue > 0) and (ppS_Prep.DeviceType <> 'Printer');
end;

procedure TfRepSP.ppt1GetText(Sender: TObject; var Text: String);
begin

  if (UpperCase(tppDBText(sender).DataField) = 'PURCHSTK') then
  begin
    if tppDBText(sender).FieldValue = -999999 then
    begin
      Text := 'Prep Item';
      tppDBText(sender).Font.Style := [fsBold];
      exit;
    end
    else
    begin
      tppDBText(sender).Font.Style := [];
    end;
  end;

  if (UpperCase(tppDBText(sender).DataField) = 'OPSTK') then
  begin
    if tppDBText(sender).FieldValue = -888888 then
    begin
      Text := 'New Item';
      tppDBText(sender).Font.Style := [fsBold];
      exit;
    end
    else
    begin
      tppDBText(sender).Font.Style := [];
    end;
  end;

  if tppDBText(sender).DisplayFormat = '#,0.00' then
    Text := data1.fmtRepQtyText(ppdbText3.Text,Text);
end;

//procedure TfRepSP.ppS_PrepChildReport1TitleBand1BeforePrint(
//  Sender: TObject);
//begin
//  if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
//    ppS_PrepChildReport1Label4.Text := 'Sub-Category Name'
//  else
//    ppS_PrepChildReport1Label4.Text := 'Category Name';
//
//end;

procedure TfRepSP.pplAccPrint(Sender: TObject);
begin
  if doTheo then
  begin
    TppLabel(Sender).text := 'NOT AUDITED';
    TppLabel(Sender).Font.Style := [fsBold, fsUnderline];
  end;
end;

//procedure TfRepSP.ppIncExGPPrint(Sender: TObject);
//begin
//  ppIncExGP.Caption := formatfloat(currencyString + '#,0.00',(ppTotExtInc.value + ppSalGP.value + ppOrphGP.value));
//end;

procedure TfRepSP.DataModuleCreate(Sender: TObject);
begin
  pps_prep.PrinterSetup.PaperName := data1.repPaperName;
  ppcount.PrinterSetup.PaperName := data1.repPaperName;
  ppLocationCount.PrinterSetup.PaperName := data1.repPaperName;
  ppcount15.PrinterSetup.PaperName := data1.repPaperName;
  ppLocationCount15.PrinterSetup.PaperName := data1.repPaperName;
end;

procedure TfRepSP.ppS_PrepSummaryBand1BeforePrint(Sender: TObject);
begin
  if ppDBCalc1.Value = 0 then
  begin
    ppLabel19.Caption := '00.00';
    ppLabel20.Caption := '00.00';
  end
  else
  begin
    if data1.curIsGP then
    begin
      ppLabel19.Caption := formatfloat('0.00', ((1 - (ppDBCalc3.Value / ppDBCalc1.Value )) * 100));
      ppLabel20.Caption := formatfloat('0.00', ((1 - (ppDBCalc2.Value / ppDBCalc1.Value )) * 100));
    end
    else
    begin
      ppLabel19.Caption := formatfloat('0.00', ((ppDBCalc3.Value / ppDBCalc1.Value) * 100));
      ppLabel20.Caption := formatfloat('0.00', ((ppDBCalc2.Value / ppDBCalc1.Value) * 100));
    end;
  end;
end;

procedure TfRepSP.ppLabel39Print(Sender: TObject);
begin
  pplabel39.Caption := formatfloat(currencyString + '#,0.00',(ppOrphGP.value + ppSalGP.value));
end;

procedure TfRepSP.ppHeaderBand2BeforePrint(Sender: TObject);
begin
  pplFromTo.Text := 'From: ' + formatDateTime('ddddd hh:nn', data1.SDT) + ' -- To: ' +
    formatDateTime('ddddd hh:nn', data1.EDT);

  pplMvBy.Text := 'Period Length: ' + inttostr(trunc(data1.Edt - data1.SDt + 1)) + ' Days, ' +
    formatDateTime('hh', (data1.Edt - data1.SDt) - (trunc(data1.Edt - data1.SDt))) + ' Hours';

end;

procedure TfRepSP.ppDBText23GetText(Sender: TObject;
  var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText22.Text,Text);
end;

procedure TfRepSP.ppDetailBand3BeforePrint(Sender: TObject);
begin
  if ppDBText33.FieldValue = data1.TheDiv then
    ppShape16.Visible := False
  else
    ppShape16.Visible := True;
end;

procedure TfRepSP.ppDBText178GetText(Sender: TObject;
  var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText176.Text,Text);
end;

procedure TfRepSP.ppHeaderBand6BeforePrint(Sender: TObject);
begin
  lghzFrom.Text := 'From: ' + formatDateTime('ddddd hh:nn', data1.SDT) + ' -- To: ' +
    formatDateTime('ddddd hh:nn', data1.EDT);

  lghzLength.Text := 'Period Length: ' + inttostr(trunc(data1.Edt - data1.SDt + 1)) + ' Days, ' +
    formatDateTime('hh', (data1.Edt - data1.SDt) - (trunc(data1.Edt - data1.SDt))) + ' Hours';

  lghzHeader.Text := 'Header: ' + data1.repHdr;
end;

procedure TfRepSP.ppDBText37GetText(Sender: TObject;
  var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText36.Text,Text);
end;

procedure TfRepSP.ACSprint(fixed : boolean);

  procedure ValidateOptionalFields(var ACSFields: String);
  var
    Weight : integer;
  begin
    Weight := 0;

    if ACSFields[1] = '1' then
      inc(Weight);
    if ACSFields[2] = '1' then
      inc(Weight);
    if ACSFields[3] = '1' then
      inc(Weight);
    if ACSFields[4] = '1' then
      inc(Weight);
    if ACSFields[5] = '1' then
      inc(Weight);
    if ACSFields[6] = '1' then
      inc(Weight, 2);

    if Weight > 3 then
    begin
      ShowMessage('The current field configuration is invalid. ' +
                'The fields included on the count sheet should be reset at Head Office');
      Abort;
    end;
  end;

  procedure RenderField(var RenderingField: Integer;
    Field: String;
    FieldName: String);
  var
    CurrField: Integer;
    NextField: Integer;
    ppDBText: TppDBText;
    ppLabel: TppLabel;
    ppDBTextEnd: TppDBText;
    ppLine_1: TppLine;
    ppLine_2: TppLine;
    ppLine_3: TppLine;
  begin
    ppDBText := nil;
    ppLabel := nil;
    ppDBTextEnd := nil;
    ppLine_1 := nil;
    ppLine_2 := nil;
    ppLine_3 := nil;

    CurrField := RenderingField;
    if (Field = 'ImpExRef') then
      Inc(RenderingField,2)
    else
      Inc(RenderingField);

    NextField := RenderingField - 1;

    case CurrField of
      1: begin
        ppLabel := ppLabel26;
        ppDBText := ppDBText3;
      end;
      2: begin
        ppLabel := ppl1;
        ppDBText := ppt1;
      end;
      3: begin
        ppLabel := ppl2;
        ppDBText := ppt2;
      end;
      4: begin
        ppLabel := ppl3;
        ppDBText := ppt3;
      end;
    end;

    case NextField of
      1: begin
        ppDBTextEnd := ppDBText3;
        ppLine_1 := ppLine74;
        ppLine_2 := ppLine8;
        ppLine_3 := ppLine13;
      end;
      2: begin
        ppDBTextEnd := ppt1;
        ppLine_1 := line1;
        ppLine_2 := lineD1;
        ppLine_3 := lineS1;
      end;
      3: begin
        ppDBTextEnd := ppt2;
        ppLine_1 := line2;
        ppLine_2 := lineD2;
        ppLine_3 := lineS2;
      end;
      4: begin
        ppDBTextEnd := ppt3;
        ppLine_1 := line3;
        ppLine_2 := lineD3;
        ppLine_3 := lineS3;
      end;
    end;

    ppLabel.Caption := FieldName;
    ppLabel.Visible := True;
    ppDBText.DataField := Field;
    if (Field = 'PurchCostPU') or
       (Field = 'NomPricePU') then
    begin
      ppDBText.TextAlignment := taRightJustified;
      ppDBText.DisplayFormat := '$#,0.00'
    end
    else if (Field = 'ImpExRef') or (Field = 'PurchUnit') then
    begin
      ppDBText.TextAlignment := taLeftJustified;
      ppDBText.DisplayFormat := ''
    end
    else begin
      ppDBText.TextAlignment := taRightJustified;
      ppDBText.DisplayFormat := '#,0.00';
    end;

    ppDBText.Visible := True;
    if ppDBText <> ppDBTextEnd then
    begin
      ppDBText.Width := ppDBTextEnd.Left + ppDBTextEnd.width - ppDBtext.Left;
      ppLabel.Width := ppDBText.Width;
    end;
    ppline_1.Visible := True;
    ppLine_2.Visible := True;
    ppLine_3.Visible := True;
  end;

var
  opNames : array [1..6] of string;
  opFields : array [1..6] of string;
  i : smallint;
  Index: Integer;
  NextFreeField: Integer;
  ACSFields: String;
begin
  // what fields to show? fOpQ, fPurQ, fPurC, fNom, fTheoQ

  for i := 1 to 6 do
  begin
    opNames[i] := '';
    opFields[i] := '';
  end; // for..

  i := 0;
  if fixed then
  begin
    opNames[1] := 'Opening Qty';
    opFields[1] := 'opStk';
    opNames[2] := 'Purchased Qty';
    opFields[2] := 'purchStk';
  end
  else
  begin
    ACSFields := data1.curACSfields;

    ValidateOptionalFields(ACSFields);

    if ACSfields[6] = '1' then
    begin
      inc(i);
      opNames[i] := 'Imp/Ex Ref.';
      opFields[i] := 'ImpExRef';
    end;
    //Pretend that 'Unit' is optional - is isn't but should
    //come after the 'Imp/Ex Ref.' optional field if the
    //user has chosen it.
    begin
      inc(i);
      opNames[i] := 'Unit';
      opFields[i] := 'PurchUnit';
    end;
    if ACSfields[1] = '1' then
    begin
      inc(i);
      opNames[i] := 'Opening Qty';
      opFields[i] := 'opStk';
    end;
    if ACSfields[2] = '1' then
    begin
      inc(i);
      opNames[i] := 'Purchased Qty';
      opFields[i] := 'purchStk';
    end;
    if ACSfields[3] = '1' then
    begin
      inc(i);
      opNames[i] := 'Purchase Cost Avg.';
      opFields[i] := 'PurchCostPU';
    end;
    if ACSfields[4] = '1' then
    begin
      inc(i);
      opNames[i] := 'Nominal Price';
      opFields[i] := 'NomPricePU';
    end;
    if ACSfields[5] = '1' then
    begin
      inc(i);
      opNames[i] := 'Theoretical Close Qty';
      opFields[i] := 'ThCloseStk';
    end;
  end;

  NextFreeField := 1;

  for Index:= 1 to 6 do
  begin
    if opNames[Index] <> '' then
      RenderField(NextFreeField,opFields[Index],opNames[Index]);
  end;

  // now NextFreeField is the position of the last label/field to be used...
  case NextFreeField of
    0 : pplCloseQ.Left := ppDbText3.Left;
    1 : pplCloseQ.Left := ppt1.Left;
    2 : pplCloseQ.Left := ppt2.Left;
    3 : pplCloseQ.Left := ppt3.Left;
  end; // case..

  pplCloseQ.Width := ppLine66.Left - pplCloseQ.Left;
end;

procedure TfRepSP.setThreadLabelTextAndProperties(var Alabel: TppLabel);
begin
  if data1.isDeactivatedThread then
  begin
    Alabel.Text := 'Inactive Thread: ' + data1.curTidName;
    Alabel.Font.Style := [fsBold];
    Alabel.Color := clGray;
  end
  else
    Alabel.Text := 'Thread Name: ' + data1.curTidName;
end;

// original Design Time SP query:
//SELECT (a.[Cat]) as SubCatName, a."RetailName", b.portion, p.portiontypename,
//b."producttype", b."salesqty", b."avSalesPrice", b."theocost", b."actCost",
//(CASE
//  WHEN b."income" = 0 then 0
//  ELSE (1- (b."TheoCost" * b."salesqty" / (b."Income" / (1 + (b."vatRate"))))) * 100
// END) as ThGpP,
//(CASE
//  WHEN b."income" = 0 then 0
//  ELSE (1- (b."ActCost" * b."salesqty" / (b."Income" / (1 + (b."vatRate"))))) * 100
// END) as ActGpP,
//b."Income", a."entitycode",
//((b."Income" / (1 + (b."vatRate"))) - (b."ActCost" * b."salesqty")) as GrossProf,
//(b."TheoCost" * b."salesqty") as ThVal,
//(b."ActCost" * b."salesqty") as ActVal,
//(b."Income" / (1 + (b."vatRate"))) as NetInc,
//(CASE
//   WHEN (b."TheoCost" = 0) AND (b."ActCost" = 0) THEN (b."income")
//   ELSE 0
//END) as rcpVar
//
//FROM "stkEntity" a, "StkCrSld" b, portiontype p
//WHERE a."entitycode" = b."entitycode"
//and (b."producttype" not like 'X%'
//       or b."producttype" is null)
//and p.portiontypeid = b.portion
//Order By a.SCat,a."RetailName", b.portion, b."producttype"

procedure TfRepSP.ppCountBeforePrint(Sender: TObject);
begin
   ppSystemVariable3.Visible := false;
   ppLabel12.Caption := 'Printed : ' + ppSystemVariable3.GetText;
end;


procedure TfRepSP.ppHeaderBand4BeforePrint(Sender: TObject);
var
  s1 :string;
begin
  // if this is a Sample sheet from the Location List Config do not change the labels...
  if fRepSP.pplabel66.Text <> 'Header: SAMPLE' then
  begin
    pplabel66.Text := 'Header: ' + data1.repHdr;
    pplabel65.Text := 'Thread Name: ' + data1.curTidName;
    pplabel35.Text := data1.SSbig + ' Type: ' + data1.StkTypeLong;
    pplabel62.Text := 'Division: ' + data1.theDiv;
    pplabel59.Text := data1.SSbig + ' Taker: ' + data1.TheStkTkr;
    pplabel63.Text := 'From: ' + formatDateTime(shortdateformat, data1.SDate) + '   To: ' +
      formatDateTime(shortdateformat, data1.EDate);

    if data1.NeedBeg or data1.NeedEnd then
     s1 := 'Sales included only between ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.SDT) +
       ' and ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.EDT)
      else
        s1 := '';

    pplabel64.Text := s1;

    pplabel60.Text := 'Period Length: ' + inttostr(trunc(data1.Edate - data1.SDate + 1)) + ' Days';
  end;
end;

procedure TfRepSP.ppLocationCountBeforePrint(Sender: TObject);
var
  i: Integer;
begin
  ppSystemVariable7.Visible := false;
  ppLabel61.Caption := 'Printed : ' + ppSystemVariable7.GetText;

  if data1.curACSheight = 1.5 then
  begin
    ppDetailBand7.Height := ppDetailBand7.Height + 0.1221;
    for i := 0 to (ppDetailBand7.ObjectCount - 1) do
    begin
      if ppDetailBand7.Objects[i].Name = 'ppline100' then
        ppDetailBand7.Objects[i].top := ppDetailBand7.Objects[i].top + 0.1221
      else if ppDetailBand7.Objects[i] is TppLine then
        ppDetailBand7.Objects[i].Height := ppDetailBand7.Objects[i].Height + 0.1221
      else if ppDetailBand7.Objects[i] is TppDBText then
        ppDetailBand7.Objects[i].Top := 0;
    end; // for..
  end;
end;

procedure TfRepSP.ppDBText50GetText(Sender: TObject; var Text: String);
begin
  if tppDBText(sender).FieldValue = -999999 then
  begin
    Text := 'Prep Item';
  end
  else
  begin
    Text := '';
  end;

end;

procedure TfRepSP.ppGroupHeaderBand2BeforePrint(Sender: TObject);
begin
  if adoqLocationCount.RecordCount = 0 then
    ppGroupHeaderBand2.Visible := FALSE;
end;

procedure TfRepSP.ppDetailBand7BeforePrint(Sender: TObject);
begin
  if adoqLocationCount.RecordCount = 0 then
    ppDetailBand7.Visible := FALSE
  else if ppDBTextMustCountLoc.FieldValue = True then
    ppDBText48.Font.Style := [fsBold, fsUnderline]
  else
    ppDBText48.Font.Style := [];
end;

procedure TfRepSP.ppGroupFooterBand2BeforePrint(Sender: TObject);
begin
  if adoqLocationCount.RecordCount = 0 then
    ppGroupFooterBand2.Visible := FALSE;
end;

procedure TfRepSP.ppSummaryBand6BeforePrint(Sender: TObject);
begin
  ppSummaryBand6.Visible := (ppMemoLocNote.Text <> '');
end;

procedure TfRepSP.ppDBText51GetText(Sender: TObject; var Text: String);
begin
  if TppDBText(Sender).FieldValue > 1000000 then
    Text := '+' + inttostr(TppDBText(Sender).FieldValue - 1000000);
end;

procedure TfRepSP.ppLocationsTotGetText(Sender: TObject; var Text: String);
begin
  if tppDBText(sender).DisplayFormat = '#,0.00' then
    Text := data1.fmtRepQtyText(ppdbText49.Text,Text);
end;

procedure TfRepSP.ppDetailBand1BeforePrint(Sender: TObject);
begin
  if ppDBTextMustCount.FieldValue = True then
    ppDBText2.Font.Style := [fsBold, fsUnderline]
  else
    ppDBText2.Font.Style := [];
end;

end.
