unit uRepHold;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppPrnabl, ppClass, ppCtrls, ppBands, ppCache, ppDB, ppDBBDE, ppComm,
  ppProd, ppReport, Db, Wwdatsrc, DBTables, Wwquery, ppVar, ppDBPipe,
  ppRelatv, ADODB, ppStrtch, ppSubRpt;

type
  TfRepHold = class(TDataModule)
    ppHoldRep: TppReport;
    ppHoldPipe1: TppBDEPipeline;
    wwDS1: TwwDataSource;
    ppHoldRepDBText1: TppDBText;
    ppHoldRepDBText2: TppDBText;
    ppHoldRepDBText3: TppDBText;
    ppHoldRepDBText4: TppDBText;
    ppHoldRepDBText5: TppDBText;
    ppHoldRepDBText6: TppDBText;
    ppHoldRepDBText7: TppDBText;
    ppHoldRepDBText8: TppDBText;
    ppHoldRepDBText9: TppDBText;
    ppHoldRepDBText10: TppDBText;
    ppHoldRepDBText11: TppDBText;
    ppHoldRepDBText12: TppDBText;
    ppHoldRepDBText13: TppDBText;
    ppHoldRepDBText14: TppDBText;
    ppHoldRepLabel11: TppLabel;
    ppHoldRepLabel12: TppLabel;
    ppHoldRepLabel13: TppLabel;
    ppHoldRepLabel14: TppLabel;
    ppHoldRepLabel15: TppLabel;
    ppHoldRepLabel16: TppLabel;
    ppHoldRepLabel17: TppLabel;
    ppHoldRepLabel18: TppLabel;
    ppHoldRepLabel19: TppLabel;
    ppHoldRepLabel20: TppLabel;
    ppHoldRepLabel21: TppLabel;
    ppHoldRepLabel22: TppLabel;
    ppHoldRepLabel23: TppLabel;
    ppHoldRepLine1: TppLine;
    ppHoldRepLine2: TppLine;
    ppHoldRepLine3: TppLine;
    ppHoldRepLabel24: TppLabel;
    ppHoldRepDBText15: TppDBText;
    ppHoldRepDBCalc1: TppDBCalc;
    ppHoldRepDBCalc2: TppDBCalc;
    ppHoldRepDBCalc3: TppDBCalc;
    ppHoldRepLabel25: TppLabel;
    ppHoldRepDBCalc4: TppDBCalc;
    ppHoldRepDBCalc5: TppDBCalc;
    ppHoldRepDBCalc6: TppDBCalc;
    ppHoldRepLine8: TppLine;
    ppHoldRepLine9: TppLine;
    ppHoldRepLine10: TppLine;
    ppHoldRepLine11: TppLine;
    ppHoldRepLine12: TppLine;
    ppHoldRepLine13: TppLine;
    ppHoldRepLine14: TppLine;
    ppHoldRepLine15: TppLine;
    ppHoldRepLine16: TppLine;
    ppHoldRepLine17: TppLine;
    ppHoldRepLine18: TppLine;
    ppHoldRepLine19: TppLine;
    ppHoldRepLine20: TppLine;
    ppHoldRepLine21: TppLine;
    ppHoldRepLine22: TppLine;
    ppHoldRepLine23: TppLine;
    ppHoldRepLine24: TppLine;
    ppHoldRepLine25: TppLine;
    ppHoldRepLine26: TppLine;
    ppHoldRepLine27: TppLine;
    ppHoldRepLine28: TppLine;
    ppHoldRepLine29: TppLine;
    ppHoldRepLine30: TppLine;
    ppHoldRepLine31: TppLine;
    ppHoldRepLine32: TppLine;
    ppHoldRepLine33: TppLine;
    ppHoldRepLine34: TppLine;
    ppHoldRepLine35: TppLine;
    ppHoldRepLine36: TppLine;
    ppHoldRepLine37: TppLine;
    ppHoldRepLine38: TppLine;
    ppHoldRepLine4: TppLine;
    ppHoldRepLine5: TppLine;
    ppHoldRepLine6: TppLine;
    ppHoldRepLine7: TppLine;
    ppHoldRepLine39: TppLine;
    ppHoldRepLine40: TppLine;
    ppHoldRepLine41: TppLine;
    ppHoldRepLine42: TppLine;
    ppHoldRepLine43: TppLine;
    ppHoldRepLine44: TppLine;
    ppHoldRepLine45: TppLine;
    ppHoldRepLine46: TppLine;
    ppHoldRepLine47: TppLine;
    ppHoldRepLine50: TppLine;
    ppHoldRepSummaryBand1: TppSummaryBand;
    ppHoldRepLine48: TppLine;
    ppHoldRepLine49: TppLine;
    wwqRun: TADOQuery;
    ppHoldRepBig: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppLine8: TppLine;
    ppLine9: TppLine;
    ppLine10: TppLine;
    ppLine11: TppLine;
    ppLine12: TppLine;
    ppLine13: TppLine;
    ppLine14: TppLine;
    ppLine15: TppLine;
    ppFooterBand1: TppFooterBand;
    ppSummaryBand1: TppSummaryBand;
    ppLabel11: TppLabel;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppDBCalc3: TppDBCalc;
    ppLine16: TppLine;
    ppLine17: TppLine;
    ppLine18: TppLine;
    ppLine19: TppLine;
    ppLine20: TppLine;
    ppLine21: TppLine;
    ppLine22: TppLine;
    ppLine23: TppLine;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppLabel23: TppLabel;
    ppLabel24: TppLabel;
    ppLine25: TppLine;
    ppLine26: TppLine;
    ppLine28: TppLine;
    ppLine29: TppLine;
    ppLine30: TppLine;
    ppLine31: TppLine;
    ppLine32: TppLine;
    ppLine33: TppLine;
    ppLine34: TppLine;
    ppLine35: TppLine;
    ppLine36: TppLine;
    ppLine37: TppLine;
    ppLine38: TppLine;
    ppLine39: TppLine;
    ppLine40: TppLine;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLabel25: TppLabel;
    ppDBText15: TppDBText;
    ppDBCalc4: TppDBCalc;
    ppDBCalc5: TppDBCalc;
    ppDBCalc6: TppDBCalc;
    ppLine41: TppLine;
    ppLine42: TppLine;
    ppLine43: TppLine;
    ppLine44: TppLine;
    ppLine45: TppLine;
    ppLine47: TppLine;
    ppLine49: TppLine;
    ppLine50: TppLine;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppLine46: TppLine;
    ppLine48: TppLine;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppLine51: TppLine;
    ppLine52: TppLine;
    ppLine53: TppLine;
    ppLine54: TppLine;
    ppDBText18: TppDBText;
    ppLine56: TppLine;
    ppLine1: TppLine;
    adoqLG: TADOQuery;
    dsLG: TDataSource;
    pipeLG: TppDBPipeline;
    ppLG: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppDetailBand2: TppDetailBand;
    ppDBText14: TppDBText;
    ppDBText19: TppDBText;
    ppDBText23: TppDBText;
    ppDBText24: TppDBText;
    ppDBText25: TppDBText;
    ppDBText26: TppDBText;
    ppDBText27: TppDBText;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppLine24: TppLine;
    ppLine27: TppLine;
    ppLine55: TppLine;
    ppLine60: TppLine;
    ppLine61: TppLine;
    ppLine62: TppLine;
    ppLine63: TppLine;
    ppLine64: TppLine;
    ppLine65: TppLine;
    ppLine66: TppLine;
    ppLine68: TppLine;
    ppSummaryBand2: TppSummaryBand;
    ppLabel38: TppLabel;
    ppLine74: TppLine;
    ppLine75: TppLine;
    ppLine76: TppLine;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppDBText31: TppDBText;
    ppLabel39: TppLabel;
    ppLabel40: TppLabel;
    ppLabel47: TppLabel;
    ppLine77: TppLine;
    ppLine78: TppLine;
    ppLine79: TppLine;
    ppLine80: TppLine;
    ppLine81: TppLine;
    ppLine85: TppLine;
    ppLine88: TppLine;
    ppLine89: TppLine;
    ppLine93: TppLine;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppLabel52: TppLabel;
    ppDBText32: TppDBText;
    ppLine94: TppLine;
    ppLine95: TppLine;
    ppLine103: TppLine;
    ppLabel44: TppLabel;
    ppLabel45: TppLabel;
    ppLabel46: TppLabel;
    ppLabel53: TppLabel;
    ppLabel48: TppLabel;
    ppLabel49: TppLabel;
    ppLabel50: TppLabel;
    ppLabel54: TppLabel;
    ppShape2: TppShape;
    ppHoldRepLabel1: TppLabel;
    ppHoldRepLabel2: TppLabel;
    ppHoldRepLabel3: TppLabel;
    ppHoldRepLabel4: TppLabel;
    ppltype: TppLabel;
    pplTake: TppLabel;
    pplLen: TppLabel;
    pplAcc: TppLabel;
    ppHoldRepLabel10: TppLabel;
    ppHoldRepCalc1: TppSystemVariable;
    pplDiv: TppLabel;
    pplFrom: TppLabel;
    ppDBText30: TppDBText;
    ppDBText33: TppDBText;
    ppDBText34: TppDBText;
    ppSystemVariable3: TppSystemVariable;
    pplTimes: TppLabel;
    ppLine67: TppLine;
    pplTid: TppLabel;
    ppShape1: TppShape;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLabel10: TppLabel;
    ppLabel59: TppLabel;
    ppDBText35: TppDBText;
    ppDBText36: TppDBText;
    ppDBText37: TppDBText;
    ppSystemVariable4: TppSystemVariable;
    ppLabel60: TppLabel;
    ppLine69: TppLine;
    ppLabel61: TppLabel;
    ppShape3: TppShape;
    ppLabel28: TppLabel;
    ppLabel29: TppLabel;
    ppLabel30: TppLabel;
    ppLabel31: TppLabel;
    ppLabel32: TppLabel;
    ppLabel33: TppLabel;
    ppLabel34: TppLabel;
    ppLabel35: TppLabel;
    ppLabel36: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppLabel37: TppLabel;
    ppLabel62: TppLabel;
    ppDBText38: TppDBText;
    ppDBText39: TppDBText;
    ppDBText40: TppDBText;
    ppSystemVariable5: TppSystemVariable;
    ppLabel63: TppLabel;
    ppLine70: TppLine;
    ppLabel64: TppLabel;
    ppLine71: TppLine;
    ppLine72: TppLine;
    ppLine73: TppLine;
    ppLine83: TppLine;
    ppLine84: TppLine;
    ppLGsmall: TppReport;
    ppHeaderBand3: TppHeaderBand;
    ppShape4: TppShape;
    ppLabel65: TppLabel;
    ppLabel66: TppLabel;
    ppLabel67: TppLabel;
    ppLabel68: TppLabel;
    ppLabel69: TppLabel;
    ppLabel70: TppLabel;
    ppLabel71: TppLabel;
    ppLabel72: TppLabel;
    ppLabel73: TppLabel;
    ppSystemVariable6: TppSystemVariable;
    ppLabel74: TppLabel;
    ppLabel75: TppLabel;
    ppDBText41: TppDBText;
    ppDBText42: TppDBText;
    ppDBText43: TppDBText;
    ppSystemVariable7: TppSystemVariable;
    ppLabel76: TppLabel;
    ppLine86: TppLine;
    ppLabel77: TppLabel;
    ppDetailBand3: TppDetailBand;
    ppDBText44: TppDBText;
    ppDBText45: TppDBText;
    ppDBText46: TppDBText;
    ppDBText47: TppDBText;
    ppDBText49: TppDBText;
    ppDBText50: TppDBText;
    ppDBText52: TppDBText;
    ppDBText53: TppDBText;
    ppDBText54: TppDBText;
    ppDBText55: TppDBText;
    ppLine87: TppLine;
    ppLine90: TppLine;
    ppLine91: TppLine;
    ppLine92: TppLine;
    ppLine96: TppLine;
    ppLine98: TppLine;
    ppLine99: TppLine;
    ppLine101: TppLine;
    ppLine102: TppLine;
    ppLine104: TppLine;
    ppLine105: TppLine;
    ppLine106: TppLine;
    ppFooterBand3: TppFooterBand;
    ppSummaryBand3: TppSummaryBand;
    ppLabel78: TppLabel;
    ppLine107: TppLine;
    ppLine108: TppLine;
    ppLine109: TppLine;
    ppGroup3: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppDBText56: TppDBText;
    ppLabel81: TppLabel;
    ppLabel82: TppLabel;
    ppLabel83: TppLabel;
    ppLabel84: TppLabel;
    ppLabel86: TppLabel;
    ppLine110: TppLine;
    ppLine111: TppLine;
    ppLine112: TppLine;
    ppLine113: TppLine;
    ppLine114: TppLine;
    ppLine115: TppLine;
    ppLine116: TppLine;
    ppLine117: TppLine;
    ppLine118: TppLine;
    ppLine119: TppLine;
    ppLabel87: TppLabel;
    ppLabel88: TppLabel;
    ppLabel90: TppLabel;
    ppLabel91: TppLabel;
    ppLabel92: TppLabel;
    ppLabel93: TppLabel;
    ppLabel94: TppLabel;
    ppLabel95: TppLabel;
    ppGroupFooterBand3: TppGroupFooterBand;
    ppLabel96: TppLabel;
    ppDBText57: TppDBText;
    ppLine120: TppLine;
    ppLine121: TppLine;
    ppLine122: TppLine;
    ppLabel85: TppLabel;
    ppLine97: TppLine;
    ppLine100: TppLine;
    ppLabel99: TppLabel;
    ppLabel100: TppLabel;
    ppLabel101: TppLabel;
    ppLabel102: TppLabel;
    ppDBText48: TppDBText;
    ppLine124: TppLine;
    ppLine125: TppLine;
    ppDBCalc17: TppDBCalc;
    ppDBCalc18: TppDBCalc;
    ppLabel104: TppLabel;
    ppLine127: TppLine;
    ppLine128: TppLine;
    ppDBText51: TppDBText;
    ppLine129: TppLine;
    ppDBCalc19: TppDBCalc;
    ppLine130: TppLine;
    ppDBCalc20: TppDBCalc;
    ppLabel105: TppLabel;
    ppLine131: TppLine;
    ppLine132: TppLine;
    ppDBText58: TppDBText;
    ppLine133: TppLine;
    ppDBCalc21: TppDBCalc;
    ppLine134: TppLine;
    ppDBCalc22: TppDBCalc;
    ppLabel107: TppLabel;
    ppDBText59: TppDBText;
    ppLine135: TppLine;
    ppLine136: TppLine;
    ppLine137: TppLine;
    ppLine138: TppLine;
    ppLine139: TppLine;
    ppLine140: TppLine;
    ppLine141: TppLine;
    ppDBCalc23: TppDBCalc;
    ppDBCalc24: TppDBCalc;
    ppDBCalc25: TppDBCalc;
    ppDBCalc26: TppDBCalc;
    ppLine142: TppLine;
    ppLabel106: TppLabel;
    ppLabel108: TppLabel;
    ppLine147: TppLine;
    ppLine148: TppLine;
    ppLine149: TppLine;
    ppLine150: TppLine;
    ppLine153: TppLine;
    ppLine154: TppLine;
    ppLine155: TppLine;
    ppLine156: TppLine;
    ppDBCalc10: TppDBCalc;
    ppDBCalc11: TppDBCalc;
    ppDBCalc27: TppDBCalc;
    ppDBCalc28: TppDBCalc;
    ppDBCalc31: TppDBCalc;
    ppDBCalc32: TppDBCalc;
    ppDBCalc33: TppDBCalc;
    ppDBCalc34: TppDBCalc;
    ppFooterBand2: TppFooterBand;
    ppLine157: TppLine;
    ppLine158: TppLine;
    ppLine159: TppLine;
    ppLine160: TppLine;
    ppLine161: TppLine;
    ppLine162: TppLine;
    ppLine163: TppLine;
    ppLine165: TppLine;
    ppLine166: TppLine;
    ppLine167: TppLine;
    ppLine168: TppLine;
    ppLine169: TppLine;
    ppLine170: TppLine;
    ppLine171: TppLine;
    ppLine123: TppLine;
    ppDBCalc9: TppDBCalc;
    ppDBCalc12: TppDBCalc;
    ppDBCalc13: TppDBCalc;
    ppDBCalc14: TppDBCalc;
    ppDBCalc15: TppDBCalc;
    ppDBCalc16: TppDBCalc;
    ppDBCalc35: TppDBCalc;
    ppDBCalc36: TppDBCalc;
    ppDBCalc37: TppDBCalc;
    ppDBCalc38: TppDBCalc;
    ppLabel55: TppLabel;
    ppLabel56: TppLabel;
    ppLabel57: TppLabel;
    ppLabel58: TppLabel;
    ppLabel79: TppLabel;
    ppLabel80: TppLabel;
    ppShape7: TppShape;
    ppShape5: TppShape;
    ppShape6: TppShape;
    ppShape8: TppShape;
    ppShape9: TppShape;
    ppShape10: TppShape;
    ppShape11: TppShape;
    ppShape12: TppShape;
    ppLabel97: TppLabel;
    ppLabel98: TppLabel;
    ppLabel103: TppLabel;
    ppLabel109: TppLabel;
    ppLine126: TppLine;
    ppLine164: TppLine;
    ppLine172: TppLine;
    ppLine173: TppLine;
    ppLabel111: TppLabel;
    ppDBText60: TppDBText;
    ppHoldRep2: TppReport;
    ppHeaderBand4: TppHeaderBand;
    ppShape13: TppShape;
    ppLabel110: TppLabel;
    ppLabel112: TppLabel;
    ppLabel113: TppLabel;
    ppLabel114: TppLabel;
    ppLabel115: TppLabel;
    ppLabel116: TppLabel;
    ppLabel117: TppLabel;
    ppLabel118: TppLabel;
    ppLabel119: TppLabel;
    ppSystemVariable8: TppSystemVariable;
    ppLabel120: TppLabel;
    ppLabel121: TppLabel;
    ppDBText61: TppDBText;
    ppDBText62: TppDBText;
    ppDBText63: TppDBText;
    ppSystemVariable9: TppSystemVariable;
    ppLabel122: TppLabel;
    ppLine174: TppLine;
    ppLabel123: TppLabel;
    ppLabel124: TppLabel;
    ppDetailBand4: TppDetailBand;
    ppLabel125: TppLabel;
    ppDBText65: TppDBText;
    ppDBText66: TppDBText;
    ppDBText67: TppDBText;
    ppDBText68: TppDBText;
    ppDBText69: TppDBText;
    ppDBText70: TppDBText;
    ppDBText71: TppDBText;
    ppDBText72: TppDBText;
    ppDBText73: TppDBText;
    ppDBText74: TppDBText;
    ppDBText76: TppDBText;
    ppLine175: TppLine;
    ppLine176: TppLine;
    ppLine177: TppLine;
    ppLine178: TppLine;
    ppLine179: TppLine;
    ppLine180: TppLine;
    ppLine181: TppLine;
    ppLine182: TppLine;
    ppLine184: TppLine;
    ppLine186: TppLine;
    ppLine188: TppLine;
    ppDBText77: TppDBText;
    ppDBText78: TppDBText;
    ppLine189: TppLine;
    ppLine190: TppLine;
    ppLine191: TppLine;
    ppLabel126: TppLabel;
    ppLabel128: TppLabel;
    ppLabel129: TppLabel;
    ppFooterBand4: TppFooterBand;
    ppSummaryBand4: TppSummaryBand;
    ppShape14: TppShape;
    ppLabel130: TppLabel;
    ppDBCalc39: TppDBCalc;
    ppDBCalc40: TppDBCalc;
    ppDBCalc41: TppDBCalc;
    ppLine192: TppLine;
    ppLine193: TppLine;
    ppLine195: TppLine;
    ppLine196: TppLine;
    ppLine197: TppLine;
    ppLine198: TppLine;
    ppLine199: TppLine;
    ppLine200: TppLine;
    ppLabel131: TppLabel;
    ppGroup4: TppGroup;
    ppGroupHeaderBand4: TppGroupHeaderBand;
    ppLabel132: TppLabel;
    ppLabel133: TppLabel;
    ppLabel134: TppLabel;
    ppLabel135: TppLabel;
    ppLabel136: TppLabel;
    ppLabel137: TppLabel;
    ppLabel138: TppLabel;
    ppLabel139: TppLabel;
    ppLabel140: TppLabel;
    ppLabel141: TppLabel;
    ppLabel143: TppLabel;
    ppLine201: TppLine;
    ppLine202: TppLine;
    ppLine203: TppLine;
    ppLine204: TppLine;
    ppLine205: TppLine;
    ppLine206: TppLine;
    ppLine207: TppLine;
    ppLine208: TppLine;
    ppLine209: TppLine;
    ppLine210: TppLine;
    ppLine211: TppLine;
    ppLine213: TppLine;
    ppLine215: TppLine;
    ppLabel145: TppLabel;
    ppLabel146: TppLabel;
    ppLine216: TppLine;
    ppLine217: TppLine;
    ppLine218: TppLine;
    ppDBText79: TppDBText;
    ppLine219: TppLine;
    ppLine220: TppLine;
    ppGroupFooterBand4: TppGroupFooterBand;
    ppShape15: TppShape;
    ppLabel147: TppLabel;
    ppDBText80: TppDBText;
    ppDBCalc42: TppDBCalc;
    ppDBCalc43: TppDBCalc;
    ppDBCalc44: TppDBCalc;
    ppLine221: TppLine;
    ppLine222: TppLine;
    ppLine223: TppLine;
    ppLine224: TppLine;
    ppLine225: TppLine;
    ppLine226: TppLine;
    ppLine228: TppLine;
    ppLine229: TppLine;
    ppLabel149: TppLabel;
    ppLabel150: TppLabel;
    ppLine230: TppLine;
    ppDBText81: TppDBText;
    ppLine183: TppLine;
    ppLine231: TppLine;
    ppDBText64: TppDBText;
    ppLabel144: TppLabel;
    ppLine187: TppLine;
    ppLine214: TppLine;
    ppLine232: TppLine;
    ppLabel151: TppLabel;
    ppLine233: TppLine;
    ppDBText82: TppDBText;
    ppDBCalc45: TppDBCalc;
    ppDBCalc46: TppDBCalc;
    ppLine234: TppLine;
    ppLine235: TppLine;
    ppLine236: TppLine;
    ppDBCalc47: TppDBCalc;
    ppDBCalc48: TppDBCalc;
    ppLine237: TppLine;
    ppLine238: TppLine;
    ppLine239: TppLine;
    adoqInvMas: TADOQuery;
    adoqInvSlv: TADOQuery;
    adoqPurSlv: TADOQuery;
    dsInvMas: TwwDataSource;
    dsInvSlv: TwwDataSource;
    dsPurSlv: TwwDataSource;
    pipeInvMas: TppDBPipeline;
    pipeInvSlv: TppDBPipeline;
    pipePurSlv: TppDBPipeline;
    ppInv: TppReport;
    ppHeaderBand5: TppHeaderBand;
    ppDetailBand5: TppDetailBand;
    ppShape16: TppShape;
    ppLabel148: TppLabel;
    ppLabel152: TppLabel;
    ppLabel153: TppLabel;
    ppLabel154: TppLabel;
    ppLabel155: TppLabel;
    ppLabel156: TppLabel;
    ppLabel157: TppLabel;
    ppLabel158: TppLabel;
    ppLabel159: TppLabel;
    ppSystemVariable10: TppSystemVariable;
    ppLabel160: TppLabel;
    ppLabel161: TppLabel;
    ppDBText83: TppDBText;
    ppDBText84: TppDBText;
    ppDBText85: TppDBText;
    ppSystemVariable11: TppSystemVariable;
    ppLine240: TppLine;
    ppLabel163: TppLabel;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppLabel165: TppLabel;
    ppLabel166: TppLabel;
    ppLabel167: TppLabel;
    ppLabel168: TppLabel;
    ppLabel169: TppLabel;
    ppDBText86: TppDBText;
    ppDBText87: TppDBText;
    ppDBText88: TppDBText;
    ppDBText89: TppDBText;
    ppDBText90: TppDBText;
    ppLabel170: TppLabel;
    ppLine241: TppLine;
    ppLine242: TppLine;
    ppLine243: TppLine;
    ppLine244: TppLine;
    ppLine245: TppLine;
    ppLine246: TppLine;
    ppLine247: TppLine;
    ppLine248: TppLine;
    ppLine249: TppLine;
    ppLine250: TppLine;
    ppLine251: TppLine;
    ppLine252: TppLine;
    ppLine253: TppLine;
    ppLine254: TppLine;
    ppLine255: TppLine;
    ppDetailBand6: TppDetailBand;
    ppSummaryBand5: TppSummaryBand;
    ppSummaryBand6: TppSummaryBand;
    ppShape17: TppShape;
    ppLine256: TppLine;
    ppLine257: TppLine;
    ppLine258: TppLine;
    ppLine259: TppLine;
    ppLabel162: TppLabel;
    ppDBCalc49: TppDBCalc;
    ppLine260: TppLine;
    ppShape18: TppShape;
    ppLabel164: TppLabel;
    ppGroup5: TppGroup;
    ppGroupHeaderBand5: TppGroupHeaderBand;
    ppGroupFooterBand5: TppGroupFooterBand;
    ppDBText91: TppDBText;
    ppDBText92: TppDBText;
    ppDBText93: TppDBText;
    ppDBText94: TppDBText;
    ppDBText95: TppDBText;
    ppDBText96: TppDBText;
    ppDBText97: TppDBText;
    ppLabel171: TppLabel;
    ppLabel172: TppLabel;
    ppLabel173: TppLabel;
    ppLabel174: TppLabel;
    ppLabel175: TppLabel;
    ppLabel176: TppLabel;
    ppLabel177: TppLabel;
    ppLine261: TppLine;
    ppLine262: TppLine;
    ppLine263: TppLine;
    ppLine264: TppLine;
    ppLine265: TppLine;
    ppLine266: TppLine;
    ppLine267: TppLine;
    ppLine268: TppLine;
    ppLine269: TppLine;
    ppLine270: TppLine;
    ppLine271: TppLine;
    ppLine272: TppLine;
    ppLine273: TppLine;
    ppLine274: TppLine;
    ppLine275: TppLine;
    ppLine276: TppLine;
    ppLine277: TppLine;
    ppLine278: TppLine;
    ppLine279: TppLine;
    ppLine280: TppLine;
    ppLine282: TppLine;
    ppLine283: TppLine;
    ppGroup6: TppGroup;
    ppGroupHeaderBand6: TppGroupHeaderBand;
    ppGroupFooterBand6: TppGroupFooterBand;
    ppLine284: TppLine;
    ppLine285: TppLine;
    ppLine287: TppLine;
    ppLine288: TppLine;
    ppLine289: TppLine;
    ppLine290: TppLine;
    ppLabel178: TppLabel;
    ppDBText98: TppDBText;
    ppDBText99: TppDBText;
    ppLabel179: TppLabel;
    ppLabel180: TppLabel;
    ppLabel181: TppLabel;
    ppLabel182: TppLabel;
    ppLabel183: TppLabel;
    ppLabel184: TppLabel;
    ppLine281: TppLine;
    ppLine286: TppLine;
    ppLine291: TppLine;
    ppLine292: TppLine;
    ppLine293: TppLine;
    ppLine294: TppLine;
    ppLine295: TppLine;
    ppSubReport3: TppSubReport;
    ppChildReport3: TppChildReport;
    ppDetailBand8: TppDetailBand;
    ppSummaryBand7: TppSummaryBand;
    ppGroup7: TppGroup;
    ppGroupHeaderBand7: TppGroupHeaderBand;
    ppHoldRepPurGrFoot: TppGroupFooterBand;
    ppGroup8: TppGroup;
    ppGroupHeaderBand8: TppGroupHeaderBand;
    ppGroupFooterBand8: TppGroupFooterBand;
    ppLine312: TppLine;
    ppLabel203: TppLabel;
    ppLabel204: TppLabel;
    ppLabel205: TppLabel;
    ppLabel206: TppLabel;
    ppLabel207: TppLabel;
    ppLabel208: TppLabel;
    ppLabel209: TppLabel;
    ppLine313: TppLine;
    ppLine314: TppLine;
    ppLine315: TppLine;
    ppLine316: TppLine;
    ppLine317: TppLine;
    ppLine318: TppLine;
    ppLine319: TppLine;
    ppLine320: TppLine;
    ppLine321: TppLine;
    ppLine322: TppLine;
    ppLine323: TppLine;
    ppLine324: TppLine;
    ppLine325: TppLine;
    ppLine326: TppLine;
    ppLine327: TppLine;
    ppLine328: TppLine;
    ppLine329: TppLine;
    ppLine330: TppLine;
    ppLine331: TppLine;
    ppLine332: TppLine;
    ppLine333: TppLine;
    ppLine335: TppLine;
    ppLine336: TppLine;
    ppDBText108: TppDBText;
    ppDBText109: TppDBText;
    ppDBText110: TppDBText;
    ppDBText111: TppDBText;
    ppDBText112: TppDBText;
    ppDBText113: TppDBText;
    ppDBText114: TppDBText;
    ppDBText115: TppDBText;
    ppDBText116: TppDBText;
    ppLine340: TppLine;
    ppLine341: TppLine;
    ppDBText118: TppDBText;
    ppLabel210: TppLabel;
    ppLabel211: TppLabel;
    ppDBText117: TppDBText;
    ppLabel212: TppLabel;
    ppLabel213: TppLabel;
    ppDBText119: TppDBText;
    ppShape22: TppShape;
    ppLine342: TppLine;
    ppLine343: TppLine;
    ppLabel214: TppLabel;
    ppDBText120: TppDBText;
    ppLabel185: TppLabel;
    ppLabel186: TppLabel;
    ppLabel187: TppLabel;
    ppShape19: TppShape;
    ppSubReport2: TppSubReport;
    ppChildReport2: TppChildReport;
    ppDetailBand7: TppDetailBand;
    ppLine296: TppLine;
    ppLine297: TppLine;
    ppLine298: TppLine;
    ppLine299: TppLine;
    ppLine300: TppLine;
    ppLine301: TppLine;
    ppLine302: TppLine;
    ppLine304: TppLine;
    ppLine305: TppLine;
    ppLine306: TppLine;
    ppLine307: TppLine;
    ppLine308: TppLine;
    ppSummaryBand8: TppSummaryBand;
    ppLine311: TppLine;
    ppLabel201: TppLabel;
    ppLabel202: TppLabel;
    ppLabel215: TppLabel;
    ppLabel216: TppLabel;
    ppLabel217: TppLabel;
    ppLabel218: TppLabel;
    ppLabel219: TppLabel;
    ppLabel220: TppLabel;
    ppLabel221: TppLabel;
    ppLabel222: TppLabel;
    ppLabel223: TppLabel;
    ppLabel224: TppLabel;
    ppLabel225: TppLabel;
    ppLine360: TppLine;
    ppLine361: TppLine;
    ppLine362: TppLine;
    ppLine363: TppLine;
    ppLine364: TppLine;
    ppLine365: TppLine;
    ppLine366: TppLine;
    ppLine367: TppLine;
    ppLine368: TppLine;
    ppLine369: TppLine;
    ppLine370: TppLine;
    ppLine371: TppLine;
    ppLine372: TppLine;
    ppLine373: TppLine;
    ppLabel226: TppLabel;
    ppLabel227: TppLabel;
    ppLine374: TppLine;
    ppLine375: TppLine;
    ppLine376: TppLine;
    ppShape20: TppShape;
    ppLabel230: TppLabel;
    ppShape21: TppShape;
    ppLabel231: TppLabel;
    ppShape23: TppShape;
    ppLabel245: TppLabel;
    ppLabel246: TppLabel;
    ppLabel247: TppLabel;
    ppSubReport4: TppSubReport;
    ppChildReport4: TppChildReport;
    ppDetailBand9: TppDetailBand;
    ppDBText127: TppDBText;
    ppLabel248: TppLabel;
    ppDBText128: TppDBText;
    ppLabel249: TppLabel;
    ppLine392: TppLine;
    ppLine393: TppLine;
    ppLine394: TppLine;
    ppLine395: TppLine;
    ppLine396: TppLine;
    ppLine397: TppLine;
    ppLine398: TppLine;
    ppLine399: TppLine;
    ppLine400: TppLine;
    ppLine401: TppLine;
    ppLine402: TppLine;
    ppDBText129: TppDBText;
    ppDBText130: TppDBText;
    ppDBText131: TppDBText;
    ppDBText132: TppDBText;
    ppDBText133: TppDBText;
    ppDBText134: TppDBText;
    ppDBText135: TppDBText;
    ppLine403: TppLine;
    ppDBText136: TppDBText;
    ppDBText137: TppDBText;
    ppLine404: TppLine;
    ppDBText138: TppDBText;
    ppSummaryBand9: TppSummaryBand;
    ppLine405: TppLine;
    ppLine406: TppLine;
    ppLine407: TppLine;
    ppGroup9: TppGroup;
    ppGroupHeaderBand9: TppGroupHeaderBand;
    ppLabel265: TppLabel;
    ppLine425: TppLine;
    ppLine426: TppLine;
    ppLabel266: TppLabel;
    ppLabel267: TppLabel;
    ppLabel268: TppLabel;
    ppLabel269: TppLabel;
    ppLabel270: TppLabel;
    ppLabel271: TppLabel;
    ppLabel272: TppLabel;
    ppLine427: TppLine;
    ppLine428: TppLine;
    ppLine429: TppLine;
    ppLine430: TppLine;
    ppLine431: TppLine;
    ppLine432: TppLine;
    ppLine433: TppLine;
    ppLine434: TppLine;
    ppLine435: TppLine;
    ppLine436: TppLine;
    ppLine437: TppLine;
    ppDBText139: TppDBText;
    ppLine438: TppLine;
    ppLabel273: TppLabel;
    ppLine439: TppLine;
    ppLabel274: TppLabel;
    ppGroupFooterBand9: TppGroupFooterBand;
    ppGroup13: TppGroup;
    ppGroupHeaderBand13: TppGroupHeaderBand;
    ppGroupFooterBand13: TppGroupFooterBand;
    ppLine440: TppLine;
    ppGroup14: TppGroup;
    ppGroupHeaderBand14: TppGroupHeaderBand;
    ppGroupFooterBand14: TppGroupFooterBand;
    ppShape24: TppShape;
    ppLabel275: TppLabel;
    ppLabel276: TppLabel;
    ppLabel277: TppLabel;
    ppLabel278: TppLabel;
    ppLabel279: TppLabel;
    ppLabel280: TppLabel;
    ppLabel281: TppLabel;
    ppLabel282: TppLabel;
    ppLabel283: TppLabel;
    ppLabel284: TppLabel;
    ppLabel285: TppLabel;
    ppLabel287: TppLabel;
    ppLine441: TppLine;
    ppLine442: TppLine;
    ppLine443: TppLine;
    ppLine444: TppLine;
    ppLine445: TppLine;
    ppLine446: TppLine;
    ppLine447: TppLine;
    ppLine448: TppLine;
    ppLine449: TppLine;
    ppLine450: TppLine;
    ppLine452: TppLine;
    ppLine453: TppLine;
    ppLabel288: TppLabel;
    ppLabel289: TppLabel;
    ppLine454: TppLine;
    ppLine455: TppLine;
    ppLine456: TppLine;
    ppLabel290: TppLabel;
    ppLabel291: TppLabel;
    ppLine457: TppLine;
    ppLabel292: TppLabel;
    ppLine458: TppLine;
    ppLine459: TppLine;
    ppLabel293: TppLabel;
    adoqMoveSlv: TADOQuery;
    dsMoveSlv: TwwDataSource;
    pipeMoveSlv: TppDBPipeline;
    ppLine337: TppLine;
    ppLine338: TppLine;
    ppLine339: TppLine;
    ppLabel232: TppLabel;
    ppLabel233: TppLabel;
    ppLabel234: TppLabel;
    ppLabel235: TppLabel;
    ppLabel236: TppLabel;
    ppLabel237: TppLabel;
    ppLabel238: TppLabel;
    ppLabel239: TppLabel;
    ppLabel240: TppLabel;
    ppLabel241: TppLabel;
    ppLabel242: TppLabel;
    ppLabel243: TppLabel;
    ppLabel244: TppLabel;
    ppLine377: TppLine;
    ppLine378: TppLine;
    ppLine379: TppLine;
    ppLine380: TppLine;
    ppLine381: TppLine;
    ppLine382: TppLine;
    ppLine383: TppLine;
    ppLine384: TppLine;
    ppLine385: TppLine;
    ppLine386: TppLine;
    ppLine387: TppLine;
    ppLine388: TppLine;
    ppLine389: TppLine;
    ppLine390: TppLine;
    ppLine391: TppLine;
    ppLine500: TppLine;
    ppLine501: TppLine;
    ppSubReport5: TppSubReport;
    ppChildReport5: TppChildReport;
    ppDetailBand10: TppDetailBand;
    ppDBText140: TppDBText;
    ppLine408: TppLine;
    ppLine409: TppLine;
    ppLine410: TppLine;
    ppLine411: TppLine;
    ppLine412: TppLine;
    ppLine415: TppLine;
    ppLine416: TppLine;
    ppLine417: TppLine;
    ppLine418: TppLine;
    ppDBText141: TppDBText;
    ppDBText142: TppDBText;
    ppDBText143: TppDBText;
    ppDBText144: TppDBText;
    ppDBText145: TppDBText;
    ppDBText146: TppDBText;
    ppLine420: TppLine;
    ppSummaryBand10: TppSummaryBand;
    ppLine421: TppLine;
    ppLine422: TppLine;
    ppLine423: TppLine;
    ppLabel253: TppLabel;
    ppLabel254: TppLabel;
    ppLabel255: TppLabel;
    ppLabel256: TppLabel;
    ppLabel257: TppLabel;
    ppLabel258: TppLabel;
    ppLabel259: TppLabel;
    ppLabel260: TppLabel;
    ppLabel261: TppLabel;
    ppLabel262: TppLabel;
    ppLabel263: TppLabel;
    ppLabel264: TppLabel;
    ppLabel294: TppLabel;
    ppLine424: TppLine;
    ppLine460: TppLine;
    ppLine461: TppLine;
    ppLine462: TppLine;
    ppLine463: TppLine;
    ppLine464: TppLine;
    ppLine465: TppLine;
    ppLine466: TppLine;
    ppLine467: TppLine;
    ppLine468: TppLine;
    ppLine469: TppLine;
    ppLine470: TppLine;
    ppLine471: TppLine;
    ppLine472: TppLine;
    ppLine473: TppLine;
    ppGroup15: TppGroup;
    ppGroupHeaderBand15: TppGroupHeaderBand;
    ppLine474: TppLine;
    ppLine475: TppLine;
    ppLabel296: TppLabel;
    ppLabel297: TppLabel;
    ppLabel298: TppLabel;
    ppLabel299: TppLabel;
    ppLabel300: TppLabel;
    ppLabel302: TppLabel;
    ppLine476: TppLine;
    ppLine477: TppLine;
    ppLine478: TppLine;
    ppLine479: TppLine;
    ppLine480: TppLine;
    ppLine483: TppLine;
    ppLine484: TppLine;
    ppLine485: TppLine;
    ppLine487: TppLine;
    ppGroupFooterBand7: TppGroupFooterBand;
    ppGroup16: TppGroup;
    ppGroupHeaderBand16: TppGroupHeaderBand;
    ppGroupFooterBand15: TppGroupFooterBand;
    ppLine489: TppLine;
    ppLine490: TppLine;
    ppLine491: TppLine;
    ppDBText100: TppDBText;
    ppDBText147: TppDBText;
    ppDBText148: TppDBText;
    ppLine414: TppLine;
    ppLabel251: TppLabel;
    ppDBText149: TppDBText;
    ppGroup17: TppGroup;
    ppGroupHeaderBand17: TppGroupHeaderBand;
    ppGroupFooterBand16: TppGroupFooterBand;
    ppLine419: TppLine;
    ppSubReport6: TppSubReport;
    ppChildReport6: TppChildReport;
    ppDetailBand11: TppDetailBand;
    ppSummaryBand11: TppSummaryBand;
    ppGroup18: TppGroup;
    ppGroupHeaderBand18: TppGroupHeaderBand;
    ppLine520: TppLine;
    ppGroupFooterBand17: TppGroupFooterBand;
    ppSubReport7: TppSubReport;
    ppChildReport7: TppChildReport;
    ppDetailBand12: TppDetailBand;
    ppLine503: TppLine;
    ppLine541: TppLine;
    ppLine542: TppLine;
    ppLine543: TppLine;
    ppLine544: TppLine;
    ppLine545: TppLine;
    ppLine546: TppLine;
    ppLine547: TppLine;
    ppLine548: TppLine;
    ppDBText161: TppDBText;
    ppDBText162: TppDBText;
    ppDBText163: TppDBText;
    ppDBText164: TppDBText;
    ppDBText165: TppDBText;
    ppDBText166: TppDBText;
    ppLine549: TppLine;
    ppDBText167: TppDBText;
    ppSummaryBand12: TppSummaryBand;
    ppGroup21: TppGroup;
    ppGroupHeaderBand21: TppGroupHeaderBand;
    ppLine572: TppLine;
    ppGroupFooterBand20: TppGroupFooterBand;
    ppGroup22: TppGroup;
    ppGroupHeaderBand22: TppGroupHeaderBand;
    ppLine573: TppLine;
    ppLine574: TppLine;
    ppLabel338: TppLabel;
    ppLabel339: TppLabel;
    ppLabel340: TppLabel;
    ppLabel341: TppLabel;
    ppLabel342: TppLabel;
    ppLabel343: TppLabel;
    ppLine575: TppLine;
    ppLine576: TppLine;
    ppLine577: TppLine;
    ppLine578: TppLine;
    ppLine579: TppLine;
    ppLine580: TppLine;
    ppLine581: TppLine;
    ppLine582: TppLine;
    ppLine583: TppLine;
    ppDBText168: TppDBText;
    ppDBText169: TppDBText;
    ppDBText170: TppDBText;
    ppLine585: TppLine;
    ppLabel345: TppLabel;
    ppDBText171: TppDBText;
    ppGroupFooterBand21: TppGroupFooterBand;
    ppGroup23: TppGroup;
    ppGroupHeaderBand23: TppGroupHeaderBand;
    ppGroupFooterBand22: TppGroupFooterBand;
    ppLine586: TppLine;
    ppLine587: TppLine;
    ppLine588: TppLine;
    ppLine551: TppLine;
    ppLine552: TppLine;
    ppLabel323: TppLabel;
    ppLabel324: TppLabel;
    ppLabel325: TppLabel;
    ppLabel326: TppLabel;
    ppLabel327: TppLabel;
    ppLabel328: TppLabel;
    ppLabel329: TppLabel;
    ppLabel330: TppLabel;
    ppLabel331: TppLabel;
    ppLabel332: TppLabel;
    ppLabel334: TppLabel;
    ppLine553: TppLine;
    ppLine554: TppLine;
    ppLine555: TppLine;
    ppLine556: TppLine;
    ppLine557: TppLine;
    ppLine558: TppLine;
    ppLine559: TppLine;
    ppLine560: TppLine;
    ppLine561: TppLine;
    ppLine562: TppLine;
    ppLine564: TppLine;
    ppLine565: TppLine;
    ppLabel335: TppLabel;
    ppLabel336: TppLabel;
    ppLine566: TppLine;
    ppLine567: TppLine;
    ppLine568: TppLine;
    ppLabel337: TppLabel;
    ppLabel346: TppLabel;
    ppLine569: TppLine;
    ppLabel347: TppLabel;
    ppLine570: TppLine;
    ppLine571: TppLine;
    ppLabel348: TppLabel;
    ppLine589: TppLine;
    ppLine590: TppLine;
    ppLabel349: TppLabel;
    ppLabel350: TppLabel;
    ppLabel351: TppLabel;
    ppLabel352: TppLabel;
    ppLabel353: TppLabel;
    imgMoveOut1: TppImage;
    imgMoveIn1: TppImage;
    imgPurch1: TppImage;
    imgPurch2: TppImage;
    imgMoveOut2: TppImage;
    imgMoveIn2: TppImage;
    adoqLGhz: TADOQuery;
    dsLGhz: TDataSource;
    pipeLGhz: TppDBPipeline;
    ppLGhz: TppReport;
    ppHeaderBand6: TppHeaderBand;
    lghzShape1: TppShape;
    lghzTitle: TppLabel;
    ppLabel250: TppLabel;
    ppLabel319: TppLabel;
    ppLabel344: TppLabel;
    lghzStockType: TppLabel;
    lgHZstockTaker: TppLabel;
    lghzLength: TppLabel;
    lghzAcc: TppLabel;
    lghzPrinted: TppLabel;
    lghzPage: TppSystemVariable;
    lghzDiv: TppLabel;
    lghzFrom: TppLabel;
    ppDBText172: TppDBText;
    ppDBText173: TppDBText;
    ppDBText174: TppDBText;
    lghzPrTime: TppSystemVariable;
    lghzIncl: TppLabel;
    ppLine413: TppLine;
    lghzThread: TppLabel;
    lghzHeader: TppLabel;
    ppDetailBand13: TppDetailBand;
    ppDBText175: TppDBText;
    ppDBText176: TppDBText;
    ppDBText177: TppDBText;
    ppLine481: TppLine;
    lghzHBotLine: TppLine;
    ppLine532: TppLine;
    ppLine550: TppLine;
    ppLine584: TppLine;
    ppFooterBand5: TppFooterBand;
    ppGroup24: TppGroup;
    ppGroupHeaderBand24: TppGroupHeaderBand;
    ppDBText191: TppDBText;
    ppLabel366: TppLabel;
    ppLabel367: TppLabel;
    ppLabel368: TppLabel;
    lghzLab1: TppLabel;
    lghzHTopLine: TppLine;
    lghzHMidLine: TppLine;
    ppLine623: TppLine;
    ppLine624: TppLine;
    ppLine625: TppLine;
    ppLine626: TppLine;
    ppLine627: TppLine;
    ppGroupFooterBand23: TppGroupFooterBand;
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
    adoqIngredients: TADOQuery;
    dsIngredients: TwwDataSource;
    pipeIngredients: TppDBPipeline;
    adoqParents: TADOQuery;
    dsParents: TwwDataSource;
    pipeParents: TppDBPipeline;
    ppDBText101: TppDBText;
    ppDBText102: TppDBText;
    ppDBText103: TppDBText;
    ppDBText104: TppDBText;
    ppLine303: TppLine;
    ppDBText105: TppDBText;
    ppDBText106: TppDBText;
    ppDBText107: TppDBText;
    ppDBText121: TppDBText;
    ppLine345: TppLine;
    ppLine347: TppLine;
    ppLine348: TppLine;
    ppLine351: TppLine;
    ppLine352: TppLine;
    ppLine353: TppLine;
    ppDBText122: TppDBText;
    ppDBText124: TppDBText;
    ppDBText126: TppDBText;
    ppDBText150: TppDBText;
    ppLine359: TppLine;
    ppLabel89: TppLabel;
    ppLabel189: TppLabel;
    ppLabel190: TppLabel;
    ppLabel191: TppLabel;
    ppLabel192: TppLabel;
    ppLabel193: TppLabel;
    ppLabel194: TppLabel;
    ppLabel195: TppLabel;
    ppLabel196: TppLabel;
    ppLabel197: TppLabel;
    ppLabel198: TppLabel;
    ppLabel199: TppLabel;
    ppLabel200: TppLabel;
    ppLine482: TppLine;
    ppLine486: TppLine;
    ppLine488: TppLine;
    ppLine492: TppLine;
    ppLine493: TppLine;
    ppLine494: TppLine;
    ppLine495: TppLine;
    ppLine496: TppLine;
    ppLine497: TppLine;
    ppLine498: TppLine;
    ppLine499: TppLine;
    ppLine502: TppLine;
    ppLine504: TppLine;
    ppLine505: TppLine;
    ppLabel252: TppLabel;
    ppLabel295: TppLabel;
    ppLine506: TppLine;
    ppLine507: TppLine;
    ppLine508: TppLine;
    ppLine344: TppLine;
    ppLine349: TppLine;
    ppLine354: TppLine;
    ppLabel301: TppLabel;
    ppLabel303: TppLabel;
    ppLine355: TppLine;
    ppLine509: TppLine;
    ppLine510: TppLine;
    ppLine511: TppLine;
    ppLine512: TppLine;
    ppLine513: TppLine;
    ppLabel188: TppLabel;
    ppDBCalc50: TppDBCalc;
    ppDBCalc51: TppDBCalc;
    ppDBCalc52: TppDBCalc;
    ppDBText123: TppDBText;
    ppLine514: TppLine;
    ppLine515: TppLine;
    ppLine516: TppLine;
    ppLabel304: TppLabel;
    ppLabel305: TppLabel;
    ppLabel306: TppLabel;
    ppLine346: TppLine;
    ppLine309: TppLine;
    ppLine350: TppLine;
    ppTitleBand1: TppTitleBand;
    ppLabel307: TppLabel;
    ppShape25: TppShape;
    ppLine357: TppLine;
    ppDBText125: TppDBText;
    ppDBText151: TppDBText;
    ppLabel228: TppLabel;
    ppDBCalc53: TppDBCalc;
    ppLine358: TppLine;
    ppLine517: TppLine;
    ppLine518: TppLine;
    ppLine310: TppLine;
    ppLine185: TppLine;
    ppLine57: TppLine;
    ppDBTextChangeFlag: TppDBText;
    ppLabelChange: TppLabel;
    ppDBTextChangeFlag2: TppDBText;
    ppDBText20: TppDBText;
    ppLabel41: TppLabel;
    ppDBCalc7: TppDBCalc;
    ppLabel42: TppLabel;
    ppLabel51: TppLabel;
    procedure ppHoldRepDBText12GetText(Sender: TObject; var Text: String);
    procedure ppHoldRepBigPreviewFormCreate(Sender: TObject);
    procedure ppHoldRepHeaderBand1BeforePrint(Sender: TObject);
    procedure ppHeaderBand1BeforePrint(Sender: TObject);
    procedure ppHeaderBand2BeforePrint(Sender: TObject);
    procedure ppHoldRepDBText14GetText(Sender: TObject; var Text: String);
    procedure ppHoldRepDBText4GetText(Sender: TObject; var Text: String);
    procedure ppDBText3GetText(Sender: TObject; var Text: String);
    procedure ppDBText20GetText(Sender: TObject; var Text: String);
    procedure ppHeaderBand3BeforePrint(Sender: TObject);
    procedure ppDetailBand3BeforePrint(Sender: TObject);
    procedure ppDBText46GetText(Sender: TObject; var Text: String);
    procedure pplAccPrint(Sender: TObject);
    procedure ppHoldRepDetailBand1BeforePrint(Sender: TObject);
    procedure ppDetailBand1BeforePrint(Sender: TObject);
    procedure ppDBText67GetText(Sender: TObject; var Text: String);
    procedure ppHeaderBand4BeforePrint(Sender: TObject);
    procedure ppDetailBand4BeforePrint(Sender: TObject);
    procedure ppDetailBand8BeforePrint(Sender: TObject);
    procedure ppDBText118GetText(Sender: TObject; var Text: String);
    procedure ppHeaderBand5BeforePrint(Sender: TObject);
    procedure ppDetailBand9BeforePrint(Sender: TObject);
    procedure ppGroupHeaderBand15BeforePrint(Sender: TObject);
    procedure ppDBText145GetText(Sender: TObject; var Text: String);
    procedure ppDBText147GetText(Sender: TObject; var Text: String);
    procedure ppDBText169GetText(Sender: TObject; var Text: String);
    procedure ppDBText165GetText(Sender: TObject; var Text: String);
    procedure ppGroupHeaderBand22BeforePrint(Sender: TObject);
    procedure ppDetailBand10BeforePrint(Sender: TObject);
    procedure ppDetailBand12BeforePrint(Sender: TObject);
    procedure ppHeaderBand6BeforePrint(Sender: TObject);
    procedure ppDBText177GetText(Sender: TObject; var Text: String);
    procedure ppDBText105GetText(Sender: TObject; var Text: String);
    procedure ppDBText126GetText(Sender: TObject; var Text: String);
    procedure ppShape25DrawCommandClick(Sender, aDrawCommand: TObject);
    procedure ppDetailBand11BeforePrint(Sender: TObject);
    procedure ppDBTextChangeFlag2GetText(Sender: TObject;
      var Text: String);
    procedure ppDetailBand7BeforePrint(Sender: TObject);
    procedure ppDetailBand5BeforePrint(Sender: TObject);
    procedure ppSummaryBand6BeforePrint(Sender: TObject);
  private
    { Private declarations }
    procedure setThreadLabelTextAndProperties(var Alabel: TppLabel);
  public
    { Public declarations }
    lgVal, lgCost, doTheo : boolean;
  end;

var
  fRepHold: TfRepHold;

implementation
uses udata1, uADO, uReps1;
{$R *.DFM}

procedure TfRepHold.ppHoldRepDBText12GetText(Sender: TObject;
  var Text: String);
var
	per: Real;
begin
	if text = '' then
  begin
    text := 'EXCESS';
  end
  else
  begin
    if strtoFloat(text) < 0 then
    begin
      text := 'ERROR';
    end
    else
    begin
      per :=  strtoFloat(text) * (data1.Edate - data1.Sdate + 1);
      if (per / 7) > 52 then
        text := 'EXCESS'
      else
        text := IntToStr(trunc(per) div 7)+'/'+ IntToStr(trunc(per) mod 7);
    end;
  end;
end;

procedure TfRepHold.ppHoldRepBigPreviewFormCreate(Sender: TObject);
begin
  dmADO.ALLRepsPreviewFormCreate(Sender, data1.repPaperName);
end;

procedure TfRepHold.ppHoldRepHeaderBand1BeforePrint(Sender: TObject);
var
  s1 :string;
begin
  ppLabel99.Text := 'Header: ' + data1.repHdr;
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

  ppHoldReplabel1.Text := data1.SSbig + ' Holding Report';
  ppHoldReplabel13.Text := 'Opening ' + data1.SSbig;
  if pplabel349.Visible and ( not data1.noTillsOnSite) then
    ppHoldReplabel14.Text := 'Purch or Transf qty'
  else
    ppHoldReplabel14.Text := 'Purchase ' + data1.SSbig;
  ppHoldReplabel15.Text := 'Wastage ' + data1.SSbig;
  ppHoldReplabel16.Text := 'Closing ' + data1.SSbig;
  ppHoldReplabel17.Text := 'Consumed ' + data1.SSbig;
  ppHoldReplabel18.Text := 'Variance ' + data1.SSbig;
  ppHoldReplabel25.Text := uppercase(data1.SSbig) + ' TOTALS:';
  ppHoldReplabel22.Text := data1.SSbig + ' Value';

  pplabel234.Text := ppHoldReplabel13.Text;
  pplabel235.Text := ppHoldReplabel14.Text;
  pplabel236.Text := ppHoldReplabel15.Text;
  pplabel237.Text := ppHoldReplabel16.Text;
  pplabel238.Text := ppHoldReplabel17.Text;
  pplabel239.Text := ppHoldReplabel18.Text;
  pplabel243.Text := ppHoldReplabel22.Text;
  pplabel244.Text := ppHoldReplabel23.Text;

  pplabel255.Text := ppHoldReplabel13.Text;
  pplabel256.Text := ppHoldReplabel14.Text;
  pplabel257.Text := ppHoldReplabel15.Text;
  pplabel258.Text := ppHoldReplabel16.Text;
  pplabel259.Text := ppHoldReplabel17.Text;
  pplabel260.Text := ppHoldReplabel18.Text;
  pplabel264.Text := ppHoldReplabel22.Text;
  pplabel294.Text := ppHoldReplabel23.Text;

  if data1.UKUSmode = 'US' then
  begin
    pplabel205.Text := 'Invoice No.';
  end
  else
  begin
    pplabel205.Text := 'Delivery Note No.';
  end;

  if ppHoldRep.DeviceType = 'Printer' then
  begin
    pplabel230.visible := False;
    ppshape20.visible := False;
  end
  else
  begin
    pplabel230.visible := ppsubreport3.Visible;
    ppshape20.visible := ppsubreport3.Visible;
  end;
end;

procedure TfRepHold.ppHeaderBand1BeforePrint(Sender: TObject);
var
  s1 :string;
begin
  pplabel100.Text := 'Header: ' + data1.repHdr;
  pplabel61.Text := 'Thread Name: ' + data1.curTidName;
  pplabel5.Text := data1.SSbig + ' Type: ' + data1.StkTypeLong;
  pplabel10.Text := 'Division: ' + data1.theDiv;
  pplabel6.Text := data1.SSbig + ' Taker: ' + data1.TheStkTkr;
  pplabel59.Text := 'From: ' + formatDateTime(shortdateformat, data1.SDate) + '   To: ' +
    formatDateTime(shortdateformat, data1.EDate);

  if data1.NeedBeg or data1.NeedEnd then
    s1 := 'Sales included only between ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.SDT) +
       ' and ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.EDT)
    else
      s1 := '';
    
  pplabel60.Text := s1;

  pplabel7.Text := 'Period Length: ' + inttostr(trunc(data1.Edate - data1.SDate + 1)) + ' Days';

  if data1.AccDate <> 0 then
    pplabel8.Text := 'Accepted Date: ' + formatDateTime(shortdateformat, data1.AccDate)
  else
    pplabel8.text := 'Not Accepted';

  pplabel1.Text := data1.SSbig + ' Holding Report';
  pplabel14.Text := 'Opening ' + data1.SSbig;
  if pplabel350.Visible  and ( not data1.noTillsOnSite) then
    pplabel15.Text := 'Purch or Transf qty'
  else
    pplabel15.Text := 'Purchase ' + data1.SSbig;
  pplabel16.Text := 'Wastage ' + data1.SSbig;
  pplabel17.Text := 'Closing ' + data1.SSbig;
  pplabel18.Text := 'Consumed ' + data1.SSbig;
  pplabel19.Text := 'Variance ' + data1.SSbig;
  pplabel11.Text := uppercase(data1.SSbig) + ' TOTALS:';
  pplabel23.Text := data1.SSbig + ' Value';

  pplabel215.Text := pplabel14.Text;
  pplabel216.Text := pplabel15.Text;
  pplabel217.Text := pplabel16.Text;
  pplabel218.Text := pplabel17.Text;
  pplabel219.Text := pplabel18.Text;
  pplabel220.Text := pplabel19.Text;
  pplabel224.Text := pplabel23.Text;
  pplabel225.Text := pplabel24.Text;

  pplabel190.Text := pplabel14.Text;
  pplabel191.Text := pplabel15.Text;
  pplabel192.Text := pplabel16.Text;
  pplabel193.Text := pplabel17.Text;
  pplabel194.Text := pplabel18.Text;
  pplabel195.Text := pplabel19.Text;
  pplabel199.Text := pplabel23.Text;
  pplabel200.Text := pplabel24.Text;


  if ppHoldRepBig.DeviceType = 'Printer' then
    ppshape21.visible := False
  else
    ppshape21.visible := ppsubreport2.Visible;

  ppShape25.visible := ppshape21.visible;
  pplabel231.visible := ppshape21.visible;
  pplabel307.visible := ppshape21.visible;

end;

procedure TfRepHold.ppHeaderBand2BeforePrint(Sender: TObject);
var
  s1 :string;
begin
  pplabel101.Text := 'Header: ' + data1.repHdr;
  pplabel64.Text := 'Thread Name: ' + data1.curTidName;
  pplabel32.Text := data1.SSbig + ' Type: ' + data1.StkTypeLong;
  pplabel37.Text := 'Division: ' + data1.theDiv;
  pplabel33.Text := data1.SSbig + ' Taker: ' + data1.TheStkTkr;
  pplabel62.Text := 'From: ' + formatDateTime(shortdateformat, data1.SDate) + '   To: ' +
    formatDateTime(shortdateformat, data1.EDate);

  if data1.NeedBeg or data1.NeedEnd then
    s1 := 'Sales included only between ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.SDT) +
       ' and ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.EDT)
    else
      s1 := '';

  pplabel63.Text := s1;

  pplabel34.Text := 'Period Length: ' + inttostr(trunc(data1.Edate - data1.SDate + 1)) + ' Days';

  if data1.AccDate <> 0 then
    pplabel35.Text := 'Accepted Date: ' + formatDateTime(shortdateformat, data1.AccDate)
  else
    pplabel35.text := 'Not Accepted';

  pplabel28.Text := data1.SSbig + ' Loss/Gain Report';
  pplabel38.Text := uppercase(data1.SSbig) + ' TOTALS:';

end;

procedure TfRepHold.ppHoldRepDBText14GetText(Sender: TObject;
  var Text: String);
begin
  if Text = '' then
    Text := 'ERROR';
end;

procedure TfRepHold.ppHoldRepDBText4GetText(Sender: TObject;
  var Text: String);
begin
  // format dozens...
  Text := data1.fmtRepQtyText(ppHoldRepdbText3.Text,Text);
end;

procedure TfRepHold.ppDBText3GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText2.Text,Text);
end;

procedure TfRepHold.ppDBText20GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText19.Text,Text);
end;

procedure TfRepHold.ppHeaderBand3BeforePrint(Sender: TObject);
var
  s1 :string;
begin
  pplabel102.Text := 'Header: ' + data1.repHdr;
  pplabel77.Text := 'Thread Name: ' + data1.curTidName;
  pplabel69.Text := data1.SSbig + ' Type: ' + data1.StkTypeLong;
  pplabel74.Text := 'Division: ' + data1.theDiv;
  pplabel70.Text := data1.SSbig + ' Taker: ' + data1.TheStkTkr;
  pplabel75.Text := 'From: ' + formatDateTime(shortdateformat, data1.SDate) + '   To: ' +
    formatDateTime(shortdateformat, data1.EDate);

  if data1.NeedBeg or data1.NeedEnd then
    s1 := 'Sales included only between ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.SDT) +
       ' and ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.EDT)
    else
      s1 := '';

  pplabel76.Text := s1;

  pplabel71.Text := 'Period Length: ' + inttostr(trunc(data1.Edate - data1.SDate + 1)) + ' Days';

  if data1.AccDate <> 0 then
    pplabel72.Text := 'Accepted Date: ' + formatDateTime(shortdateformat, data1.AccDate)
  else
    pplabel72.text := 'Not Accepted';

  //pplabel65.Text := data1.SSbig + ' Loss/Gain Report';
  pplabel78.Text := uppercase(data1.SSbig) + ' TOTALS:';
end;

procedure TfRepHold.ppDetailBand3BeforePrint(Sender: TObject);
begin
  if ppDBText46.FieldValue < 0 then
  begin
    ppDBText46.Visible := False;
    ppDBText49.Visible := True;
  end
  else
  begin
    ppDBText49.Visible := False;
    ppDBText46.Visible := True;
  end;

  ppDBText47.Visible := ppDBText46.Visible;
  ppDBText50.Visible := ppDBText49.Visible;
end;

procedure TfRepHold.ppDBText46GetText(Sender: TObject; var Text: String);
begin
  // format dozens...
  Text := data1.fmtRepQtyText(ppdbText45.Text,Text);
end;

procedure TfRepHold.pplAccPrint(Sender: TObject);
begin
  if doTheo then
  begin
    TppLabel(Sender).text := 'NOT AUDITED';
    TppLabel(Sender).Font.Style := [fsBold, fsUnderline];
  end;
end;

procedure TfRepHold.ppHoldRepDetailBand1BeforePrint(Sender: TObject);
begin
  if wwqRun.FieldByName('key2').AsInteger >= 1000 then // is this a Prep.Item?
  begin
    pplabel106.Visible := True;
  end
  else
  begin
    pplabel106.Visible := False;
  end;

  ppHoldRepDBText5.Visible := not pplabel106.Visible;
  //ppHoldRepDBText6.Visible := not pplabel106.Visible;
  ppHoldRepDBText9.Visible := not pplabel106.Visible;
  //ppHoldRepLine29.Visible := not pplabel106.Visible;
  ppHoldRepDBText12.Visible := not pplabel106.Visible;
  ppHoldRepDBText14.Visible := not pplabel106.Visible;
  ppLabel58.Visible := pplabel106.Visible;
  ppLabel57.Visible := pplabel106.Visible;

  if ppsubreport3.Visible then
  begin
    if ((ppholdrepdbtext5.FieldValue = 0) and
      (wwqRun.FieldByName('purchcost').AsFloat = 0)) or (pplabel106.Visible) then
      ppshape22.Visible := false
    else
    begin
      ppshape22.Visible := True;
      if wwqRun.FieldByName('key2').AsInteger in [1,21] then
      begin
        pplabel185.Visible := True;
        ppHoldRepDBText5.Visible := False;
        ppshape22.Brush.Color := clRed;
        pplabel186.Visible := True;
        pplabel187.Visible := True;
      end
      else
      begin
        pplabel185.Visible := false;
        ppHoldRepDBText5.Visible := true;
        if ppHoldRep.DeviceType = 'Printer' then
          ppshape22.Brush.Color := clWhite
        else
          ppshape22.Brush.Color := clYellow;
      end;
    end;
  end
  else if ppsubreport5.Visible then
  begin
    if ((wwqRun.FieldByName('truepurch').AsFloat = 0) and
      (wwqRun.FieldByName('truemove').AsFloat = 0))  then  //or (pplabel106.Visible)
      ppshape22.Visible := false
    else
    begin
      ppshape22.Visible := True;
{      if wwqRun.FieldByName('key2').AsInteger in [1,21] then
      begin
        pplabel185.Visible := True;
        ppHoldRepDBText5.Visible := False;
        ppshape22.Brush.Color := clRed;
        pplabel186.Visible := True;
        pplabel187.Visible := True;
      end
      else}
      begin
        pplabel185.Visible := false;
        ppHoldRepDBText5.Visible := true;
        if ppHoldRep.DeviceType = 'Printer' then
          ppshape22.Brush.Color := clWhite
        else
          ppshape22.Brush.Color := clYellow;
      end;
    end;
  end
  else
  begin
    ppshape22.Visible := false;
  end;

  case wwqRun.FieldByName('key2').AsInteger of // is this a  NEW Item?
    55, 56, 1055, 1056: begin
                          pplabel80.Visible := True;
                        end;
    else
    begin
      pplabel80.Visible := False;
    end;
  end; // case..

  ppHoldRepDBText4.Visible := not pplabel80.Visible;

  if wwqRun.FieldByName('TheoPrice').AsInteger = -99999 then // is this an orphan?
  begin
    pplabel98.Visible := True;
  end
  else
  begin
    pplabel98.Visible := False;
  end;

  ppHoldRepDBText10.Visible := not pplabel98.Visible;
end;

procedure TfRepHold.ppDetailBand1BeforePrint(Sender: TObject);
begin
  pplabel108.Visible := (wwqRun.FieldByName('key2').AsInteger >= 1000); // is this a Prep.Item?
  ppDBText4.Visible := not pplabel108.Visible;
  //ppDBText5.Visible := not pplabel108.Visible;
  ppDBText8.Visible := not pplabel108.Visible;
  ppDBText16.Visible := not pplabel108.Visible;
  ppDBText17.Visible := not pplabel108.Visible;
  //ppLine6.Visible := not pplabel108.Visible;
  ppLine10.Visible := not pplabel108.Visible;
  ppLine51.Visible := not pplabel108.Visible;
  ppDBText11.Visible := not pplabel108.Visible;
  ppDBText13.Visible := not pplabel108.Visible;
  ppLabel55.Visible := pplabel108.Visible;
  ppLabel56.Visible := pplabel108.Visible;

  if ppsubreport2.Visible then
  begin
    if (pplabel108.Visible) then
    begin
      ppshape19.Visible := false;

      if ppHoldRepBig.DeviceType = 'Printer' then
        pplabel108.Color := clWhite
      else
        pplabel108.Color := clYellow;
    end
    else
    begin
      if ppsubreport6.Visible then
      begin
        if ((wwqRun.FieldByName('OpenPrep').AsFloat <> 0) or
            (wwqRun.FieldByName('PrepRedQty').AsFloat <> 0) or
            (wwqRun.FieldByName('ClosePrep').AsFloat <> 0)) then
        begin
          ppshape19.Visible := True;
          if ppHoldRepBig.DeviceType = 'Printer' then
            ppshape19.Brush.Color := clWhite
          else
            ppshape19.Brush.Color := clYellow;
        end
        else
          ppshape19.Visible := false;
      end
      else
      begin
        ppshape19.Visible := false;
      end; //if.. then.. else..
    end;
  end;  // if.. then..


  case wwqRun.FieldByName('key2').AsInteger of // is this a  NEW Item?
    55, 56, 1055, 1056: begin
                          pplabel79.Visible := True;
                        end;
    else
    begin
      pplabel79.Visible := False;
    end;
  end; // case..

  ppDBText3.Visible := not pplabel79.Visible;

  if wwqRun.FieldByName('TheoPrice').AsInteger = -99999 then // is this an orphan?
  begin
    pplabel97.Visible := True;
  end
  else
  begin
    pplabel97.Visible := False;
  end;

  ppDBText9.Visible := not pplabel97.Visible;
end;

procedure TfRepHold.ppDBText67GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText66.Text,Text);
end;

procedure TfRepHold.ppHeaderBand4BeforePrint(Sender: TObject);
var
  s1 :string;
begin
  pplabel124.Text := 'Header: ' + data1.repHdr;
  pplabel123.Text := 'Thread Name: ' + data1.curTidName;
  pplabel115.Text := data1.SSbig + ' Type: ' + data1.StkTypeLong;
  pplabel120.Text := 'Division: ' + data1.theDiv;
  pplabel116.Text := data1.SSbig + ' Taker: ' + data1.TheStkTkr;
  pplabel121.Text := 'From: ' + formatDateTime(shortdateformat, data1.SDate) + '   To: ' +
    formatDateTime(shortdateformat, data1.EDate);

  if data1.NeedBeg or data1.NeedEnd then
    s1 := 'Sales included only between ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.SDT) +
       ' and ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.EDT)
    else
      s1 := '';

  pplabel122.Text := s1;

  pplabel117.Text := 'Period Length: ' + inttostr(trunc(data1.Edate - data1.SDate + 1)) + ' Days';

  if data1.AccDate <> 0 then
    pplabel118.Text := 'Accepted Date: ' + formatDateTime(shortdateformat, data1.AccDate)
  else
    pplabel118.text := 'Not Accepted';

  pplabel110.Text := data1.SSbig + ' Holding Report';
  pplabel134.Text := 'Opening ' + data1.SSbig;
  if pplabel351.Visible and ( not data1.noTillsOnSite) then
    pplabel135.Text := 'Purch or Transf qty'
  else
    pplabel135.Text := 'Purchase ' + data1.SSbig;
  pplabel136.Text := 'Wastage ' + data1.SSbig;
  pplabel137.Text := 'Closing ' + data1.SSbig;
  pplabel138.Text := 'Consumed ' + data1.SSbig;
  pplabel139.Text := data1.SSbig;
  pplabel130.Text := uppercase(data1.SSbig) + ' TOTALS:';
  pplabel143.Text := data1.SSbig + ' Value';

  pplabel278.Text := pplabel134.Text;
  pplabel279.Text := pplabel135.Text;
  pplabel280.Text := pplabel136.Text;
  pplabel281.Text := pplabel137.Text;
  pplabel282.Text := pplabel138.Text;
  pplabel283.Text := pplabel139.Text;
  pplabel287.Text := pplabel143.Text;
  pplabel292.Text := pplabel144.Text;

  pplabel325.Text := pplabel134.Text;
  pplabel326.Text := pplabel135.Text;
  pplabel327.Text := pplabel136.Text;
  pplabel328.Text := pplabel137.Text;
  pplabel329.Text := pplabel138.Text;
  pplabel330.Text := pplabel139.Text;
  pplabel334.Text := pplabel143.Text;
  pplabel347.Text := pplabel144.Text;

  if data1.UKUSmode = 'US' then
  begin
    pplabel268.Text := 'Invoice No.';
  end
  else
  begin
    pplabel268.Text := 'Delivery Note No.';
  end;

  if ppHoldRep2.DeviceType = 'Printer' then
  begin
    pplabel245.visible := False;
    ppshape23.visible := False;
  end
  else
  begin
    pplabel245.visible := ppsubreport4.Visible;
    ppshape23.visible := ppsubreport4.Visible;
  end;
end;

procedure TfRepHold.ppDetailBand4BeforePrint(Sender: TObject);
begin
  if wwqRun.FieldByName('key2').AsInteger >= 1000 then // is this a Prep.Item?
  begin
    pplabel126.Visible := True;
  end
  else
  begin
    pplabel126.Visible := False;
  end;

  ppDBText68.Visible := not pplabel126.Visible;
  //ppDBText69.Visible := not pplabel126.Visible;
  ppDBText72.Visible := not pplabel126.Visible;
  ppDBText81.Visible := not pplabel126.Visible;
  ppDBText78.Visible := not pplabel126.Visible;
  ppDBText77.Visible := not pplabel126.Visible;
  ppDBText64.Visible := not pplabel126.Visible;
  ppDBText82.Visible := not pplabel126.Visible;

  //ppLine179.Visible := not pplabel126.Visible;
  ppLine183.Visible := not pplabel126.Visible;
  ppLine231.Visible := not pplabel126.Visible;
  ppLine189.Visible := not pplabel126.Visible;
  ppLine233.Visible := not pplabel126.Visible;

  ppLabel125.Visible := pplabel126.Visible;

  if ppsubreport4.Visible then
  begin
    if ((ppdbtext68.FieldValue = 0) and (wwqRun.FieldByName('purchcost').AsFloat = 0)) or (pplabel126.Visible) then
      ppshape24.Visible := false
    else
    begin
      ppshape24.Visible := true;
      if wwqRun.FieldByName('key2').AsInteger in [1,21] then
      begin
        pplabel275.Visible := True;
        ppDBText68.Visible := False;
        ppshape24.Brush.Color := clRed;
        pplabel246.Visible := True;
        pplabel247.Visible := True;
      end
      else
      begin
        pplabel275.Visible := false;
        ppDBText68.Visible := true;
        if ppHoldRep2.DeviceType = 'Printer' then
          ppshape24.Brush.Color := clWhite
        else
          ppshape24.Brush.Color := clYellow;
      end;
    end;
  end  // if.. then..
  else if ppsubreport7.Visible then
  begin
    if ((wwqRun.FieldByName('truepurch').AsFloat = 0) and
      (wwqRun.FieldByName('truemove').AsFloat = 0))  then  //or (pplabel106.Visible)
      ppshape24.Visible := false
    else
    begin
      ppshape24.Visible := True;
      pplabel275.Visible := false;
      ppDBText68.Visible := true;
      if ppHoldRep2.DeviceType = 'Printer' then
        ppshape24.Brush.Color := clWhite
      else
        ppshape24.Brush.Color := clYellow;
    end;
  end
  else
  begin
    ppshape24.Visible := false;
  end; //if.. then.. else.. 

  case wwqRun.FieldByName('key2').AsInteger of // is this a  NEW Item?
    55, 56, 1055, 1056: begin
                          pplabel128.Visible := True;
                        end;
    else
    begin
      pplabel128.Visible := False;
    end;
  end; // case..

  ppDBText67.Visible := not pplabel128.Visible;

  if wwqRun.FieldByName('TheoPrice').AsInteger = -99999 then // is this an orphan?
  begin
    pplabel129.Visible := True;
  end
  else
  begin
    pplabel129.Visible := False;
  end;

  ppDBText73.Visible := not pplabel129.Visible;

end;

procedure TfRepHold.ppDetailBand8BeforePrint(Sender: TObject);
begin
  //purcons := ppdbtext116.FieldValue
  pplabel212.Visible := false;
  pplabel213.Visible := false;

  if ppdbtext116.FieldValue <= 0 then // no purchases were consumed...
  begin
    ppdbtext118.Visible := false; // cons
    ppdbtext113.Visible := true;  // on hand.
  end
  else
  begin  // some purchases were consumed...
    if ppdbtext119.FieldValue <= ppdbtext116.FieldValue then  // all purch in this record were consumed...
    begin
      ppdbtext118.Visible := true;  // cons
      ppdbtext113.Visible := false; // on hand.
    end
    else if ppdbtext119.FieldValue - ppdbtext115.FieldValue >= ppdbtext116.FieldValue then  // all purch in
    begin                                                                   // this record all left on hand...
      ppdbtext118.Visible := false; // cons
      ppdbtext113.Visible := true;  // on hand.
    end
    else // some are consumed, some are left on hand...
    begin
      pplabel212.Text := data1.dozGallFloatToStr(ppdbText111.Text,
        (ppdbtext115.FieldValue - ppdbtext119.FieldValue + ppdbtext116.FieldValue) / ppdbtext117.FieldValue);// consumed stuff
      pplabel213.Text := data1.dozGallFloatToStr(ppdbText111.Text,
        (ppdbtext119.FieldValue - ppdbtext116.FieldValue) / ppdbtext117.FieldValue);// on hand stuff
      pplabel212.Visible := true; // cons
      pplabel213.Visible := true;  // on hand.
      ppdbtext118.Visible := false; // cons
      ppdbtext113.Visible := false;  // on hand.
    end;
  end;
end;

procedure TfRepHold.ppDBText118GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText111.Text,Text);
end;

procedure TfRepHold.ppHeaderBand5BeforePrint(Sender: TObject);
begin
  pplabel171.Text := data1.repHdr;
  pplabel163.Text := 'Thread Name: ' + data1.curTidName;
  pplabel155.Text := data1.SSbig + ' Type: ' + data1.StkTypeLong;
  pplabel160.Text := 'Division: ' + data1.theDiv;
  pplabel156.Text := data1.SSbig + ' Taker: ' + data1.TheStkTkr;
  pplabel161.Text := 'From: ' + formatDateTime(shortdateformat, data1.SDate) + '   To: ' +
    formatDateTime(shortdateformat, data1.EDate);

  pplabel157.Text := 'Period Length: ' + inttostr(trunc(data1.Edate - data1.SDate + 1)) + ' Days';

  if data1.AccDate <> 0 then
    pplabel158.Text := 'Accepted Date: ' + formatDateTime(shortdateformat, data1.AccDate)
  else
    pplabel158.text := 'Not Accepted';

  pplabel148.Text := data1.SSbig + ' Purchases Report';

  if data1.UKUSmode = 'US' then
  begin
    pplabel166.Text := 'Invoice No';
  end
  else
  begin
    pplabel166.Text := 'Delivery Note No.';
  end;
  pplabel179.Text := pplabel166.Text;
  pplabel181.Text := pplabel166.Text;

  pplabel170.Text := 'NOTE: Only "' + data1.theDiv + '" Division Purchases are considered for this report.';

  if ppInv.DeviceType = 'Printer' then
  begin
    pplabel164.visible := False;
    ppshape18.visible := False;
    ppshape17.visible := False;
  end
  else
  begin
    pplabel164.visible := true;
    ppshape18.visible := true;
    ppshape17.visible := true;
  end;
end;

procedure TfRepHold.ppDetailBand9BeforePrint(Sender: TObject);
begin
  //purcons := ppdbtext116.FieldValue
  pplabel249.Visible := false;
  pplabel248.Visible := false;

  if ppdbtext139.FieldValue <= 0 then // no purchases were consumed...
  begin
    ppdbtext128.Visible := false; // cons
    ppdbtext127.Visible := true;  // on hand.
  end
  else
  begin  // some purchases were consumed...
    if ppdbtext137.FieldValue <= ppdbtext139.FieldValue then  // all purch in this record were consumed...
    begin
      ppdbtext128.Visible := true;  // cons
      ppdbtext127.Visible := false; // on hand.
    end
    else if ppdbtext137.FieldValue - ppdbtext135.FieldValue >= ppdbtext139.FieldValue then  // all purch in
    begin                                                                   // this record all left on hand...
      ppdbtext128.Visible := false; // cons
      ppdbtext127.Visible := true;  // on hand.
    end
    else // some are consumed, some are left on hand...
    begin
      pplabel249.Text := data1.dozGallFloatToStr(ppdbText132.Text,
        (ppdbtext135.FieldValue - ppdbtext137.FieldValue + ppdbtext139.FieldValue) / ppdbtext136.FieldValue);// consumed stuff
      pplabel248.Text := data1.dozGallFloatToStr(ppdbText132.Text,
        (ppdbtext137.FieldValue - ppdbtext139.FieldValue) / ppdbtext136.FieldValue);// on hand stuff
      pplabel249.Visible := true; // cons
      pplabel248.Visible := true;  // on hand.
      ppdbtext128.Visible := false; // cons
      ppdbtext127.Visible := false;  // on hand.
    end;
  end;
end;

procedure TfRepHold.ppGroupHeaderBand15BeforePrint(Sender: TObject);
begin
  pplabel302.Visible := not (ppdbtext100.Text = 'Purchases');

  ppline487.Visible := pplabel302.Visible;
  ppline420.Visible := pplabel302.Visible;
  ppDBText146.Visible := pplabel302.Visible;

  if ppdbtext100.Text = 'Purchases' then
  begin
    ppdbText147.DataField := 'truePurch';
    pplabel297.Text := 'Supplier Name';

    if data1.UKUSmode = 'US' then
    begin
      pplabel298.Text := 'Invoice No.';
    end
    else
    begin
      pplabel298.Text := 'Delivery Note No.';
    end;
  end
  else
  begin
    ppdbText147.DataField := 'trueMove';
    pplabel297.Text := 'Transfer To/From';
    pplabel298.Text := 'Transfer ID';
  end;
end;

procedure TfRepHold.ppDBText145GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText144.Text,Text);
end;

procedure TfRepHold.ppDBText147GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText148.Text,Text);
end;

procedure TfRepHold.ppDBText169GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText170.Text,Text);
end;

procedure TfRepHold.ppDBText165GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText164.Text,Text);
end;

procedure TfRepHold.ppGroupHeaderBand22BeforePrint(Sender: TObject);
begin
  pplabel343.Visible := not (ppdbtext168.Text = 'Purchases');

  ppline583.Visible := pplabel343.Visible;
  ppline549.Visible := pplabel343.Visible;
  ppDBText166.Visible := pplabel343.Visible;

  if ppdbtext168.Text = 'Purchases' then
  begin
    ppdbText169.DataField := 'truePurch';
    pplabel339.Text := 'Supplier Name';

    if data1.UKUSmode = 'US' then
    begin
      pplabel340.Text := 'Invoice No.';
    end
    else
    begin
      pplabel340.Text := 'Delivery Note No.';
    end;
  end
  else
  begin
    ppdbText169.DataField := 'trueMove';
    pplabel339.Text := 'Transfer To/From';
    pplabel340.Text := 'Transfer ID';
  end;
end;

procedure TfRepHold.ppDetailBand10BeforePrint(Sender: TObject);
begin
  if ppdbtext140.Text = 'OUT' then
  begin
    imgMoveOut1.Visible := True;
    imgMoveIn1.Visible := False;
    imgPurch1.Visible := False;
    ppdbtext140.Visible := False;
  end
  else if ppdbtext140.Text = 'IN' then
  begin
    imgMoveOut1.Visible := False;
    imgMoveIn1.Visible := True;
    imgPurch1.Visible := False;
    ppdbtext140.Visible := False;
  end
  else if ppdbtext140.Text = 'PURCH' then
  begin
    imgMoveOut1.Visible := False;
    imgMoveIn1.Visible := False;
    imgPurch1.Visible := True;
    ppdbtext140.Visible := False;
  end
  else
  begin
    imgMoveOut1.Visible := False;
    imgMoveIn1.Visible := False;
    imgPurch1.Visible := False;
    ppdbtext140.Visible := True;
  end;
end;

procedure TfRepHold.ppDetailBand12BeforePrint(Sender: TObject);
begin
  if ppdbtext167.Text = 'OUT' then
  begin
    imgMoveOut2.Visible := True;
    imgMoveIn2.Visible := False;
    imgPurch2.Visible := False;
    ppdbtext167.Visible := False;
  end
  else if ppdbtext167.Text = 'IN' then
  begin
    imgMoveOut2.Visible := False;
    imgMoveIn2.Visible := True;
    imgPurch2.Visible := False;
    ppdbtext167.Visible := False;
  end
  else if ppdbtext167.Text = 'PURCH' then
  begin
    imgMoveOut2.Visible := False;
    imgMoveIn2.Visible := False;
    imgPurch2.Visible := True;
    ppdbtext167.Visible := False;
  end
  else
  begin
    imgMoveOut2.Visible := False;
    imgMoveIn2.Visible := False;
    imgPurch2.Visible := False;
    ppdbtext167.Visible := True;
  end;
end;

procedure TfRepHold.ppHeaderBand6BeforePrint(Sender: TObject);
var
  s1 :string;
begin
  lghzHeader.Text := 'Header: ' + data1.repHdr;
  lghzThread.Text := 'Thread Name: ' + data1.curTidName;
  lghzStockType.Text := data1.SSbig + ' Type: ' + data1.StkTypeLong;
  lghzDiv.Text := 'Division: ' + data1.theDiv;
  lghzStockTaker.Text := data1.SSbig + ' Taker: ' + data1.TheStkTkr;
  lghzFrom.Text := 'From: ' + formatDateTime(shortdateformat, data1.SDate) + '   To: ' +
    formatDateTime(shortdateformat, data1.EDate);

  if data1.NeedBeg or data1.NeedEnd then
    s1 := 'Sales included only between ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.SDT) +
       ' and ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.EDT)
    else
      s1 := '';

  lghzIncl.Text := s1;

  lghzLength.Text := 'Period Length: ' + inttostr(trunc(data1.Edate - data1.SDate + 1)) + ' Days';

  if data1.AccDate <> 0 then
    lghzAcc.Text := 'Accepted Date: ' + formatDateTime(shortdateformat, data1.AccDate)
  else
    lghzAcc.text := 'Not Accepted';

end;

procedure TfRepHold.ppDBText177GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText176.Text,Text);
end;

procedure TfRepHold.setThreadLabelTextAndProperties(var Alabel: TppLabel);
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

procedure TfRepHold.ppDBText105GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText102.Text,Text);
end;

procedure TfRepHold.ppDBText126GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText123.Text,Text);
end;

procedure TfRepHold.ppShape25DrawCommandClick(Sender,
  aDrawCommand: TObject);
begin
  PostMessage(fReps1.handle, WM_USER + 3646, 0, 0);
end;

procedure TfRepHold.ppDetailBand11BeforePrint(Sender: TObject);
begin
  ppDBText124.Visible := TRUE;
  ppDBText151.Visible := TRUE;
  ppDBText126.Visible := TRUE;

  if ppDBTextChangeFlag.Text = '-777' then        // prep Item looses an ingredient
  begin
    ppLabelChange.Visible := TRUE;
    ppDBText124.Visible := FALSE;
    ppDBText151.Visible := FALSE;
    ppLabelChange.Caption := 'removed from Prep Item: ';
  end
  else if ppDBTextChangeFlag.Text = '-888' then  // prep Item gains an ingredient
  begin
    ppLabelChange.Visible := TRUE;
    ppDBText126.Visible := FALSE;
    ppLabelChange.Caption := 'added to Prep Item: ';
  end
  else if ppDBTextChangeFlag.Text = '-999' then  // change of ingredeint Qty in Prep Item
  begin
    ppLabelChange.Visible := TRUE;
    ppLabelChange.Caption := 'qty changed in Prep Item: ';
  end
  else
    ppLabelChange.Visible := FALSE;
end;

procedure TfRepHold.ppDBTextChangeFlag2GetText(Sender: TObject;
  var Text: String);
begin
  if Text = '-777' then        // prep Item looses an ingredient
    Text := '- ingredient removed -'
  else if Text = '-888' then  // prep Item gains an ingredient
    Text := '- ingredient added -'
  else if Text = '-999' then  // change of ingredeint Qty in Prep Item
    Text := '- ingredient qty changed -'
  else
    Text := '';
end;

procedure TfRepHold.ppDetailBand7BeforePrint(Sender: TObject);
begin
  ppDBText103.Visible := TRUE;
  ppDBText125.Visible := TRUE;
  ppDBText121.Visible := TRUE;
  ppDBText105.Visible := TRUE;

  if ppDBTextChangeFlag2.Text = '- ingredient removed -' then
  begin
    ppDBText103.Visible := FALSE;
    ppDBText125.Visible := FALSE;
    ppDBText121.Visible := FALSE;
  end
  else if ppDBTextChangeFlag2.Text = '- ingredient added -' then
    ppDBText105.Visible := FALSE;
end;

procedure TfRepHold.ppDetailBand5BeforePrint(Sender: TObject);
begin
  pplabel41.Visible := (ppdbtext20.Text <> '0');
end;

procedure TfRepHold.ppSummaryBand6BeforePrint(Sender: TObject);
begin
  if ppDBCalc7.Value > 0 then
  begin
    ppLabel51.Visible := TRUE;
    if data1.UKUSmode = 'US' then
    begin
      if ppDBCalc7.Value = 1 then
        pplabel51.Text := '-- This Invoice was changed since the Inventory was last calculated; the change may impact the Inventory figures.'
      else
        pplabel51.Text := '-- These ' + ppDBCalc7.Text +
        ' Invoices were changed since the Inventory was last calculated; these changes may impact the Inventory figures.';
    end
    else
    begin
      if ppDBCalc7.Value = 1 then
        pplabel51.Text := '-- This Delivery Note was changed since the Stock was last calculated; the change may impact the Stock figures.'
      else
        pplabel51.Text := '-- These ' + ppDBCalc7.Text +
        ' Delivery Notes were changed since the Stock was last calculated; these changes may impact the Stock figures.';
    end;
  end
  else
  begin
    ppLabel51.Visible := FALSE;
  end;

  pplabel42.Visible := ppLabel51.Visible;
end;

end.
