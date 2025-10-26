unit uRepTrad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppProd, ppClass, ppReport, ppComm, ppCache, ppDB, ppDBBDE, Db, Wwdatsrc,
  DBTables, Wwquery, Wwtable, ppBands, ppCtrls, ppPrnabl, ppVar, ppRelatv,
  ppDBPipe, Variants, ADODB, ppStrtch, ppSubRpt, ppMemo, ppRegion;

type
  TfRepTrad = class(TDataModule)
    wwsTrad: TwwDataSource;
    pipeTrad: TppBDEPipeline;
    ppTrad: TppReport;
    ppTradSummaryBand1: TppSummaryBand;
    ppTradLabel1: TppLabel;
    ppTradLabel2: TppLabel;
    ppTradLabel4: TppLabel;
    ppTradLabel5: TppLabel;
    ppTradLabel6: TppLabel;
    ppTradLabel7: TppLabel;
    ppTradLabel8: TppLabel;
    ppTradLabel9: TppLabel;
    ppTradLabel10: TppLabel;
    ppTradLabel11: TppLabel;
    ppTradLabel12: TppLabel;
    ppTradLabel13: TppLabel;
    ppTradDBText1: TppDBText;
    ppTradDBText2: TppDBText;
    ppTradDBText3: TppDBText;
    ppTradDBText4: TppDBText;
    ppTradDBText5: TppDBText;
    ppTradDBText6: TppDBText;
    ppTradDBText7: TppDBText;
    ppTradDBText8: TppDBText;
    ppTradDBText9: TppDBText;
    ppTradDBText10: TppDBText;
    ppTradDBText11: TppDBText;
    ppTradDBText12: TppDBText;
    ppTradDBText13: TppDBText;
    ppTradLabel14: TppLabel;
    wwqTrad: TADOQuery;
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
    ppLine40: TppLine;
    ppLine46: TppLine;
    ppLine48: TppLine;
    ppLine54: TppLine;
    ppLine56: TppLine;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLine1: TppLine;
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
    ppLine16: TppLine;
    ppLine17: TppLine;
    ppLine18: TppLine;
    ppLine19: TppLine;
    ppLine20: TppLine;
    ppLine21: TppLine;
    ppLine22: TppLine;
    ppLine23: TppLine;
    ppLine24: TppLine;
    ppLine27: TppLine;
    ppLine38: TppLine;
    ppLine39: TppLine;
    ppLine41: TppLine;
    ppLine42: TppLine;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppDBCalc5: TppDBCalc;
    ppDBCalc6: TppDBCalc;
    ppDBCalc7: TppDBCalc;
    ppDBCalc8: TppDBCalc;
    ppDBCalc10: TppDBCalc;
    ppDBCalc12: TppDBCalc;
    ppLabel1: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLine43: TppLine;
    ppLine44: TppLine;
    ppLine45: TppLine;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppDetailBand1: TppDetailBand;
    ppSummaryBand1: TppSummaryBand;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel17: TppLabel;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppLabel23: TppLabel;
    ppLabel24: TppLabel;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppLabel28: TppLabel;
    ppLabel29: TppLabel;
    ppLabel30: TppLabel;
    ppLabel31: TppLabel;
    ppLabel32: TppLabel;
    ppLabel33: TppLabel;
    ppLabel34: TppLabel;
    ppLabel36: TppLabel;
    ppLabel37: TppLabel;
    ppLine47: TppLine;
    ppLine49: TppLine;
    ppLine50: TppLine;
    ppLine51: TppLine;
    ppLine52: TppLine;
    ppLine53: TppLine;
    ppLine55: TppLine;
    ppLine57: TppLine;
    ppLine58: TppLine;
    ppLine59: TppLine;
    ppLine62: TppLine;
    ppLine63: TppLine;
    ppLine64: TppLine;
    ppLine65: TppLine;
    ppLabel40: TppLabel;
    ppLabel41: TppLabel;
    ppLine66: TppLine;
    ppLine68: TppLine;
    ppLabel38: TppLabel;
    ppLabel39: TppLabel;
    ppLabel42: TppLabel;
    ppLabel43: TppLabel;
    ppLabel44: TppLabel;
    ppLabel45: TppLabel;
    ppLabel46: TppLabel;
    ppLabel47: TppLabel;
    ppLabel48: TppLabel;
    ppLabel49: TppLabel;
    ppLabel50: TppLabel;
    ppLabel35: TppLabel;
    ppLine60: TppLine;
    ppLine61: TppLine;
    dsRet: TwwDataSource;
    pipeRet: TppBDEPipeline;
    ppRet: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppLabel61: TppLabel;
    ppLabel62: TppLabel;
    ppLabel63: TppLabel;
    ppLabel64: TppLabel;
    ppLabel65: TppLabel;
    ppLabel66: TppLabel;
    ppLabel67: TppLabel;
    ppLabel68: TppLabel;
    ppLabel69: TppLabel;
    ppLine69: TppLine;
    ppLine70: TppLine;
    ppLine71: TppLine;
    ppLine72: TppLine;
    ppLine73: TppLine;
    ppLine74: TppLine;
    ppLine75: TppLine;
    ppLine76: TppLine;
    ppLine77: TppLine;
    ppLine78: TppLine;
    ppLine81: TppLine;
    ppLine82: TppLine;
    ppLine84: TppLine;
    ppLabel73: TppLabel;
    ppDetailBand2: TppDetailBand;
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
    ppLine87: TppLine;
    ppLine88: TppLine;
    ppLine89: TppLine;
    ppLine90: TppLine;
    ppLine91: TppLine;
    ppLine92: TppLine;
    ppLine93: TppLine;
    ppLine94: TppLine;
    ppLine97: TppLine;
    ppLine99: TppLine;
    ppLine100: TppLine;
    ppLine101: TppLine;
    ppSummaryBand2: TppSummaryBand;
    ppLabel76: TppLabel;
    ppLine102: TppLine;
    ppLine103: TppLine;
    ppLine104: TppLine;
    ppLine105: TppLine;
    ppLine106: TppLine;
    ppLine107: TppLine;
    ppLine108: TppLine;
    ppLine109: TppLine;
    ppLine112: TppLine;
    ppLine114: TppLine;
    ppLine115: TppLine;
    ppLine116: TppLine;
    ppDBCalc3: TppDBCalc;
    ppDBCalc4: TppDBCalc;
    ppDBCalc9: TppDBCalc;
    ppDBCalc14: TppDBCalc;
    ppLabel77: TppLabel;
    ppLine117: TppLine;
    ppSubReport2: TppSubReport;
    ppChildReport2: TppChildReport;
    ppDetailBand3: TppDetailBand;
    ppSummaryBand3: TppSummaryBand;
    ppLabel82: TppLabel;
    ppLabel83: TppLabel;
    ppLabel85: TppLabel;
    ppLabel87: TppLabel;
    ppLabel88: TppLabel;
    ppLabel89: TppLabel;
    ppLabel90: TppLabel;
    ppLabel91: TppLabel;
    ppLabel92: TppLabel;
    ppLabel93: TppLabel;
    ppLabel94: TppLabel;
    ppLabel95: TppLabel;
    ppLabel96: TppLabel;
    ppLabel97: TppLabel;
    ppLabel98: TppLabel;
    ppLabel99: TppLabel;
    ppLabel100: TppLabel;
    ppLabel101: TppLabel;
    ppLabel102: TppLabel;
    ppLabel103: TppLabel;
    ppLabel104: TppLabel;
    ppLabel105: TppLabel;
    ppLabel106: TppLabel;
    ppLabel107: TppLabel;
    ppLabel108: TppLabel;
    ppLabel109: TppLabel;
    ppLine118: TppLine;
    ppLine119: TppLine;
    ppLine120: TppLine;
    ppLine121: TppLine;
    ppLine122: TppLine;
    ppLine123: TppLine;
    ppLine124: TppLine;
    ppLine125: TppLine;
    ppLine126: TppLine;
    ppLine127: TppLine;
    ppLine128: TppLine;
    ppLine129: TppLine;
    ppLine130: TppLine;
    ppLine131: TppLine;
    ppLabel110: TppLabel;
    ppLine132: TppLine;
    ppLine134: TppLine;
    ppLabel112: TppLabel;
    ppLabel113: TppLabel;
    ppLabel114: TppLabel;
    ppLabel115: TppLabel;
    ppLabel116: TppLabel;
    ppLabel117: TppLabel;
    ppLabel118: TppLabel;
    ppLabel119: TppLabel;
    ppLabel120: TppLabel;
    ppLabel121: TppLabel;
    ppLabel122: TppLabel;
    ppLabel123: TppLabel;
    ppLine135: TppLine;
    wwqRet: TADOQuery;
    ppDBCalc15: TppDBCalc;
    ppLabel70: TppLabel;
    ppLabel71: TppLabel;
    ppLabel72: TppLabel;
    ppLabel74: TppLabel;
    ppLine79: TppLine;
    ppLabel75: TppLabel;
    ppLabel78: TppLabel;
    ppShape1: TppShape;
    ppLabel79: TppLabel;
    ppLabel80: TppLabel;
    ppLabel86: TppLabel;
    ppLabel111: TppLabel;
    ppLabel124: TppLabel;
    ppLabel125: TppLabel;
    ppLabel126: TppLabel;
    ppLabel127: TppLabel;
    ppLabel128: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppLabel129: TppLabel;
    ppLabel130: TppLabel;
    ppDBText35: TppDBText;
    ppDBText36: TppDBText;
    ppDBText37: TppDBText;
    ppSystemVariable4: TppSystemVariable;
    ppLabel131: TppLabel;
    ppLine80: TppLine;
    ppLabel132: TppLabel;
    ppShape2: TppShape;
    ppLabel51: TppLabel;
    ppLabel52: TppLabel;
    ppLabel53: TppLabel;
    ppLabel54: TppLabel;
    ppLabel55: TppLabel;
    ppLabel56: TppLabel;
    ppLabel57: TppLabel;
    ppLabel58: TppLabel;
    ppLabel59: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLabel60: TppLabel;
    ppLabel133: TppLabel;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppSystemVariable3: TppSystemVariable;
    ppLabel134: TppLabel;
    ppLine83: TppLine;
    ppLabel135: TppLabel;
    ppLabel136: TppLabel;
    ppLabel81: TppLabel;
    ppLabel84: TppLabel;
    ppLabel137: TppLabel;
    ppLine85: TppLine;
    ppLabel138: TppLabel;
    ppLabel139: TppLabel;
    ppLabel140: TppLabel;
    ppLabel141: TppLabel;
    ppLabel16: TppLabel;
    ppLabel18: TppLabel;
    ppLine86: TppLine;
    ppLabel142: TppLabel;
    ppLabel143: TppLabel;
    ppLabel144: TppLabel;
    ppLabel145: TppLabel;
    ppLine95: TppLine;
    ppLine96: TppLine;
    ppLine98: TppLine;
    ppLine110: TppLine;
    ppLine111: TppLine;
    ppLine113: TppLine;
    ppLine136: TppLine;
    ppLine137: TppLine;
    ppLine138: TppLine;
    ppLine139: TppLine;
    ppLine140: TppLine;
    ppLine141: TppLine;
    ppLine142: TppLine;
    ppLabel146: TppLabel;
    ppLabel147: TppLabel;
    ppLabel148: TppLabel;
    ppLabel149: TppLabel;
    ppLabel150: TppLabel;
    ppLabel151: TppLabel;
    ppLabel152: TppLabel;
    ppLabel153: TppLabel;
    ppLabel154: TppLabel;
    ppLabel155: TppLabel;
    ppLabel156: TppLabel;
    ppLine143: TppLine;
    ppLabel157: TppLabel;
    ppLine67: TppLine;
    ppLine144: TppLine;
    ppLine145: TppLine;
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
    ppLabel158: TppLabel;
    ppLabel159: TppLabel;
    ppLabel160: TppLabel;
    ppLabel161: TppLabel;
    ppLabel162: TppLabel;
    ppLabel163: TppLabel;
    ppLabel164: TppLabel;
    ppLabel165: TppLabel;
    ppLabel166: TppLabel;
    ppLabel167: TppLabel;
    ppLabel168: TppLabel;
    ppLine156: TppLine;
    ppLabel169: TppLabel;
    ppLine157: TppLine;
    ppLabel170: TppLabel;
    ppLabel171: TppLabel;
    ppLabel172: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLine133: TppLine;
    ppLine158: TppLine;
    ppLine159: TppLine;
    ppLine160: TppLine;
    ppLine161: TppLine;
    ppLine162: TppLine;
    ppLine163: TppLine;
    ppLine164: TppLine;
    ppLine165: TppLine;
    ppLine166: TppLine;
    ppLine167: TppLine;
    ppLine168: TppLine;
    ppLine169: TppLine;
    ppLabel173: TppLabel;
    ppLabel174: TppLabel;
    ppLabel175: TppLabel;
    ppLabel176: TppLabel;
    ppLabel177: TppLabel;
    ppLabel178: TppLabel;
    ppLabel179: TppLabel;
    ppLabel180: TppLabel;
    ppLabel181: TppLabel;
    ppLabel182: TppLabel;
    ppLabel183: TppLabel;
    ppLine170: TppLine;
    ppLabel184: TppLabel;
    ppLabel185: TppLabel;
    ppLine171: TppLine;
    ppLine172: TppLine;
    ppLine173: TppLine;
    ppLine174: TppLine;
    ppLine175: TppLine;
    ppLine176: TppLine;
    ppLine177: TppLine;
    ppLine178: TppLine;
    ppLine179: TppLine;
    ppLine180: TppLine;
    ppLine181: TppLine;
    ppLine182: TppLine;
    ppLine183: TppLine;
    ppLabel186: TppLabel;
    ppLabel187: TppLabel;
    ppLabel188: TppLabel;
    ppLabel189: TppLabel;
    ppLabel190: TppLabel;
    ppLabel191: TppLabel;
    ppLabel192: TppLabel;
    ppLabel193: TppLabel;
    ppLabel194: TppLabel;
    ppLabel195: TppLabel;
    ppLabel196: TppLabel;
    ppLine184: TppLine;
    ppLabel197: TppLabel;
    ppLine185: TppLine;
    ppLabel198: TppLabel;
    ppLabel199: TppLabel;
    ppLabel200: TppLabel;
    ppLabel201: TppLabel;
    ppLabel202: TppLabel;
    ppLabel203: TppLabel;
    ppLabel204: TppLabel;
    ppLabel205: TppLabel;
    ppLabel206: TppLabel;
    ppLabel207: TppLabel;
    ppLabel208: TppLabel;
    ppLabel209: TppLabel;
    ppMemo1: TppMemo;
    ppMemo2: TppMemo;
    ppRegion1: TppRegion;
    ppRegion2: TppRegion;
    ppRegion3: TppRegion;
    ppRegion4: TppRegion;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppRegion5: TppRegion;
    ppRegion6: TppRegion;
    ppDBText14: TppDBText;
    ppLine186: TppLine;
    ppLine187: TppLine;
    ppLine188: TppLine;
    ppDBCalc11: TppDBCalc;
    ppLabel211: TppLabel;
    ppLabel349: TppLabel;
    ppLabel210: TppLabel;
    ppLabel212: TppLabel;
    ppLGhz: TppReport;
    ppHeaderBand6: TppHeaderBand;
    lghzShape1: TppShape;
    lghzTitle: TppLabel;
    ppLabel250: TppLabel;
    ppLabel319: TppLabel;
    ppLabel344: TppLabel;
    lghzAcc: TppLabel;
    lghzPrinted: TppLabel;
    lghzPage: TppSystemVariable;
    ppDBText172: TppDBText;
    ppDBText173: TppDBText;
    ppDBText174: TppDBText;
    lghzPrTime: TppSystemVariable;
    ppLine413: TppLine;
    ppDetailBand13: TppDetailBand;
    ppDBText175: TppDBText;
    ppDBText176: TppDBText;
    ppDBText177: TppDBText;
    ppLine481: TppLine;
    lghzHBotLine: TppLine;
    ppLine532: TppLine;
    ppLine550: TppLine;
    ppLine584: TppLine;
    lghzText1: TppDBText;
    lghzline1: TppLine;
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
    ppFooterBand5: TppFooterBand;
    ppGroup24: TppGroup;
    ppGroupHeaderBand24: TppGroupHeaderBand;
    ppDBText15: TppDBText;
    ppLabel213: TppLabel;
    ppLine189: TppLine;
    ppLine190: TppLine;
    ppGroupFooterBand23: TppGroupFooterBand;
    ppLine191: TppLine;
    ppGroup4: TppGroup;
    ppGroupHeaderBand4: TppGroupHeaderBand;
    ppDBText191: TppDBText;
    ppLabel366: TppLabel;
    ppLabel367: TppLabel;
    lghzlab0: TppLabel;
    lghzLab1: TppLabel;
    lghzHTopLine: TppLine;
    lghzHMidLine: TppLine;
    ppLine623: TppLine;
    ppLine624: TppLine;
    ppLine625: TppLine;
    ppLine626: TppLine;
    ppLine627: TppLine;
    ppLine650: TppLine;
    lgHzTline1: TppLine;
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
    ppGroupFooterBand4: TppGroupFooterBand;
    adoqLGhz: TADOQuery;
    dsLGhz: TDataSource;
    pipeLGhz: TppDBPipeline;
    ppTradSig: TppLabel;
    ppRetSig: TppLabel;
    ppRegion7: TppRegion;
    ppRegion8: TppRegion;
    ppRegion9: TppRegion;
    ppLabel214: TppLabel;
    ppRegion10: TppRegion;
    ppLabel215: TppLabel;
    ppShape22: TppShape;
    ppShape3: TppShape;
    ppShape4: TppShape;
    function MakeRep:boolean;
    procedure ppTradPreviewFormCreate(Sender: TObject);
    procedure ppTradSummaryBand1BeforePrint(Sender: TObject);
    procedure ppTradDBText12GetText(Sender: TObject; var Text: String);

    function MakeRetRep:boolean;
    procedure ppSummaryBand2BeforePrint(Sender: TObject);
    procedure ppReport1HeaderBand1BeforePrint(Sender: TObject);
    procedure ppHeaderBand1BeforePrint(Sender: TObject);
    procedure ppLabel127Print(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure ppDetailBand2BeforePrint(Sender: TObject);
  private
    { Private declarations }
    totgcons, totNcons, totcost, rcpVar, extraInc, totInc, totVAT, totNetInc : real;
    totProfVar, opCost, purCost, closeCost, totTcost, totSalesQty, totMoveCost : real;

    totgcons2, totcost2, rcpVar2, extraInc2, totInc2, totNetInc2 : real;
    totProfVar2, opCost2, closeCost2, totLGW2, totCloseVal2, totMoveCost2 : real;
    reph : string;
  public
    { Public declarations }
    prof, audited : boolean;
    bgCPS, repHZid : integer;
    bgCPStext, repHZidStr : string;
  end;

var
  fRepTrad: TfRepTrad;

implementation

uses uADO, udata1;

{$R *.DFM}

function TfRepTrad.MakeRep:boolean;
var
  i : integer;
begin
  Result := False;
  with dmADO.adoqRun do
  begin
    dmADO.DelSQLTable('TradRep');

    // get the main figures by sub-category

    data1.ERRSTR1 := 'Get Trad Data 1';
    close;
    sql.Clear;
    sql.Add('SELECT (a.[' + reph + ']) as SubCatName, (sum(b."opstk" - b."opstk")) as gains,');
    sql.Add('(sum(b."opstk" - b."opstk")) as loss, (sum(b."opstk" - b."opstk")) as mix,');
    sql.Add('(sum (b."ActRedQty" * b."NomPrice")) as grossCons,');
    sql.Add('(sum ((opStk * opCost) + (PurchStk * purchCost) - ' +
                   '(ActCloseStk * ActCloseCost) + (moveQty * moveCost))) as costSales,');
    sql.Add('(sum (b."ActCloseStk" * b."ActCloseCost")) as closeVal,');
    sql.Add('(sum (b."OpStk" * b."OpCost")) as opVal,');
    sql.Add('(sum (b."wastage" * b."NomPrice")) as faultVal,');
    sql.Add('(CASE');
    sql.Add('    WHEN (sum (b."ActRedQty" * b."ActRedCost")) = 0 THEN NULL');
    sql.Add('    ELSE ((sum (b."ActCloseStk" * b."ActCloseCost")) /' +
                        ' (sum (b."ActRedQty" * b."ActRedCost")))');
    sql.Add(' END) as hand,');
    sql.Add('sum((NomPrice - VATRate) * ActRedQty) as netCons,');
    sql.Add('(sum (b."PurchStk" * b."purchCost")) as purchCost,');
    sql.Add('(sum (moveQty * moveCost)) as moveCost');

    sql.Add('INTO dbo.TradRep');

    sql.Add('FROM stkEntity a, "StkCrDiv" b');
    sql.Add('WHERE a."entitycode" = b."entitycode"');
    sql.Add('and b.hzid = ' + repHZidStr);

    sql.Add('Group By a.[' + reph + ']');
    sql.Add('Order By a.[' + reph + ']');


    i := execSQL;

    if i = 0 then
      exit;

    // get the gains  -- modified 17779
    data1.ERRSTR1 := 'Get Trad Data 2';
    close;
    sql.Clear;
    sql.Add('update TradRep set gains = sq.gains');
    sql.Add('FROM (SELECT (a.[' + reph + ']) as SubCatName,');
    sql.Add('       (sum ((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) * b.NomPrice)) as gains');
    sql.Add('       FROM stkEntity a, "StkCrDiv" b');
    sql.Add('       WHERE a."entitycode" = b."entitycode"');
    sql.Add('       and ((b.SoldQty + b.Wastage) > (b.ActRedQty + b.PrepRedQty))');
    sql.Add('       and b.key2 < 1000');
    sql.Add('       and b.hzid = ' + repHZidStr);
    sql.Add('     Group By a.[' + reph + ']');
    sql.Add('      ) as sq');
    sql.Add('where [TradRep].subcatname = sq.subcatname');
    execSQL;

    // get the losses  -- modified 17779
    data1.ERRSTR1 := 'Get Trad Data 3';
    close;
    sql.Clear;
    sql.Add('update TradRep set loss = sq.loss');
    sql.Add('FROM (SELECT (a.[' + reph + ']) as SubCatName,');
    sql.Add('      (sum (-1 * (b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) * b.NomPrice)) as loss');
    sql.Add('      FROM stkEntity a, "StkCrDiv" b');
    sql.Add('      WHERE a."entitycode" = b."entitycode"');
    sql.Add('      and ((b.SoldQty + b.Wastage) < (b.ActRedQty + b.PrepRedQty))');
    sql.Add('       and b.key2 < 1000');
    sql.Add('       and b.hzid = ' + repHZidStr);
    sql.Add('      Group By a.[' + reph + ']');
    sql.Add('      ) as sq');
    sql.Add('where [TradRep].subcatname = sq.subcatname');
    execSQL;

    // get the totals from ghost
    data1.ERRSTR1 := 'Get Trad Data 4';
    close;
    sql.Clear;
    sql.Add('select (sum(a."grosscons")) as totgcons, (sum(a."costsales")) as totcost,');
    sql.add('(sum(a.movecost)) as totMoveCost, (sum(a."netcons")) as totNcons from "TradRep" a');
    open;

    totgcons := FieldByName('totgcons').asfloat;
    totcost := FieldByName('totcost').asfloat;
    totNcons := FieldByName('totNcons').asfloat;
    totMoveCost := FieldByName('totMoveCost').asfloat;

    close;

    //calculate mix% and insert in the ghost table
    data1.ERRSTR1 := 'Get Trad Data 5';
    if totgcons <> 0 then
    begin
      close;
      sql.Clear;
      sql.Add('update TradRep set mix = 100 * grosscons / ' + floattostr(totgcons));
      execSQL;
    end;

    // get recipe variance (and tot income and VAT) from StkCrSld.
    data1.ERRSTR1 := 'Get Trad Data 6';
    close;
    sql.Clear;
    sql.Add('select (sum(a."income")) as income,');
    sql.Add('(sum((CASE ');
    sql.Add('               WHEN a.[ProductType] like ''R%''  THEN a.[income]');
    sql.Add('               ELSE 0');
    sql.Add('END))) as rcpVar,');
    sql.Add('(sum((CASE ');
    sql.Add('               WHEN a.[ProductType] like ''X%''  THEN a.[income]');
    sql.Add('               ELSE 0');
    sql.Add('END))) as extraInc,');
    sql.Add('(sum(a."Income" - a."vatRate")) as totNetInc');
    sql.Add('from "stkCrSld" a');
    sql.Add('where a.hzid = ' + repHZidStr);
    open;

    rcpVar := FieldByName('rcpvar').asfloat;
    extraInc := FieldByName('extraInc').asfloat;
    totInc := FieldByName('income').asfloat;
    totNetInc := FieldByName('totNetInc').asfloat;
    totVAT := totInc - totNetInc;

    close;
  end;

  // prepare query for report
  with wwqTrad do
  begin
    data1.ERRSTR1 := 'Prepare Query';
    close;
    sql.Clear;
    sql.Add('select (1) as grp, a."subcatname", a."grosscons", a."costsales", a."closeval",');
    sql.Add('a."opVal", a."hand", a."gains", a."loss", a."mix", (purchCost + movecost) as purchCost,');

    if data1.curIsGP then
    begin
      sql.Add('(CASE ');
      sql.Add('   WHEN a."netcons" = 0 THEN 0');
      sql.Add('   ELSE (100 - (a."costsales" / a."netcons" * 100)) ');
      sql.Add(' END) as gpPct,');
    end
    else
    begin
      sql.Add('(CASE ');
      sql.Add('   WHEN (a."netcons" = 0 AND a."costsales" = 0) THEN 0');
      sql.Add('   WHEN (a."netcons" = 0 AND a."costsales" <> 0) THEN 100');
      sql.Add('   ELSE (a."costsales" / a."netcons" * 100) ');
      sql.Add(' END) as gpPct,');
    end;


    sql.Add('a."faultVal", (a."gains" - a."loss" - a."faultVal") as TotLG,'); // 17779

    sql.Add('(CASE ');
    sql.Add('   WHEN (a."grosscons" = 0) THEN NULL');
    sql.Add('   ELSE (100 * (a."gains" - a."loss" - a."faultVal") / a."grosscons")');
    sql.Add(' END) as LGper');

    sql.Add('from "TradRep" a');

    //18541 - only show sub cats with some figures other than zero...
    sql.Add('where ((a."grosscons" <> 0) OR (a."costsales" <> 0) OR (a."closeval" <> 0) OR (a."opVal" <> 0)');
    sql.Add('        OR (a."hand" <> 0) OR (a."gains" <> 0) OR (a."loss" <> 0) OR (a."faultVal" <> 0))');

    sql.Add('order by a."subcatname"');

    open;

    if recordcount = 0 then
      exit;
  end;

  if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
    ppTradlabel1.Text := 'Sub-Category'
  else
    ppTradlabel1.Text := 'Category';


  /////////////////////////

  // previous stock....

  if data1.StkCode >= 3 then
  begin
    with dmADO.adoqRun do
    begin
      data1.ERRSTR1 := 'Get Previous figures';
      // get the main figures from StkMain (saved stkCrDiv)
      close;
      sql.Clear;
      sql.Add('SELECT count(entitycode) as theitems,');
      sql.Add('(sum ');
      sql.Add('  (CASE');
      sql.Add('   WHEN b.key2 >= 1000 THEN 0');
      sql.Add('   ELSE ((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) * b.NomPrice)');
      sql.Add('  END)');
      sql.Add(' ) as gains,');
      sql.Add('(sum (b."ActRedQty" * b."NomPrice")) as grossCons,');
      sql.Add('(sum ((opStk * opCost) + (PurchStk * purchCost) - ' +                      // 330357
                   '(ActCloseStk * ActCloseCost) + (moveQty * moveCost))) as costSales,');
      sql.Add('(sum (b."ActCloseStk" * b."ActCloseCost")) as closeVal,');
      sql.Add('(sum (b."OpStk" * b."OpCost")) as opVal,');
      sql.Add('(sum (b."wastage" * b."NomPrice")) as faultVal,'); // 18541 sql.Add('(avg (b."COS%")) as cosPct,');
      sql.Add('sum((NomPrice - VATRate) * ActRedQty) as netCons,');
      sql.Add('(sum (moveQty * moveCost)) as moveCost');
      sql.Add('FROM "StkMain" b');
      sql.Add('WHERE b."tid" = ' + inttostr(data1.CurTid));
      sql.Add('and b."stkcode" = ' + inttostr(data1.StkCode - 1));
      sql.Add('and b.SiteCode = '+IntToStr(data1.repSite));
      sql.Add('and b.hzid = ' + repHZidStr);
      //sql.Add('and ((b."OpStk" <> 0) or (b."PurchStk" <> 0) or (b."actCloseStk" <> 0))');

      open;

      data1.ERRSTR1 := 'Get Previous figures 2';
      if (FieldByName('theitems').AsInteger <> 0) and (FieldByName('costsales').value <> NULL) then
      begin
        totgcons2 := FieldByName('grosscons').asfloat;
        totcost2 := FieldByName('costsales').asfloat;
        totLGW2 := FieldByName('gains').asfloat - FieldByName('faultval').asfloat;
        totCloseVal2 := FieldByName('closeVal').asfloat;
        totMoveCost2 := FieldByName('moveCost').asfloat;

        close;

        // get recipe variance (and tot income and VAT) from StkCrSld.
        data1.ERRSTR1 := 'Get Previous figures 3';
        close;
        sql.Clear;
        sql.Add('select (sum(a."income")) as income,');
        sql.Add('(sum((CASE ');
        sql.Add('               WHEN a.[ProductType] like ''R%''  THEN a.[income]');
        sql.Add('               ELSE 0');
        sql.Add('END))) as rcpVar,');
        sql.Add('(sum((CASE ');
        sql.Add('               WHEN a.[ProductType] like ''X%''  THEN a.[income]');
        sql.Add('               ELSE 0');
        sql.Add('END))) as extraInc,');
        sql.Add('(sum(a."Income" - a."vatRate")) as totNetInc');
        sql.Add('FROM "StkSold" a');
        sql.Add('WHERE a."tid" = ' + inttostr(data1.CurTid));
        sql.Add('and a."stkcode" = ' + inttostr(data1.StkCode - 1));
        sql.Add('and a.SiteCode = '+IntToStr(data1.repSite));
        sql.Add('and a.hzid = ' + repHZidStr);
        open;

        rcpVar2 := FieldByName('rcpvar').asfloat;
        extraInc2 := FieldByName('extraInc').asfloat;
        totInc2 := FieldByName('income').asfloat;
        totNetInc2 := FieldByName('totNetInc').asfloat;
        pplabel147.Visible := True;
      end
      else
      begin
        pplabel147.Visible := False; // last stock has no data for this HZ, nothing to show...
      end;
      close;
    end;
  end
  else
  begin // no last stock available...
    //make relevant labels and lines invisible...
    pplabel147.Visible := False;
  end;

/////////////////////////////////////////////////
  // do CPS

  pplabel185.Visible := False;
  if data1.curCPS then  // if this stock is bgCPS then this is the 1st in the CP, don't show anything
  begin
    // if no last stock then obviously no cumulative stock. On site this means this is the 1st stock,
    // but on a HZ this could mean the last stock was not by HZ or did not have this HZ so this stock
    // is then the start of a new cumulative period. This Cum Per issue should be covered already
    // in uMainMenu where any change detected in HZ status when starting a new stock makes the new stock
    // a Begin for Cum Period (i.e. curBgCP = True just below) but still, better safe...
    if (pplabel147.Visible) and (not data1.curBgCP) and (data1.StkCode > 2) then
    begin
      data1.ERRSTR1 := 'Get Cumulative figures 1';
      pplabel184.Visible := True;
      with dmADO.adoqRun do
      begin
        // find the 1st stock in the current Cumulative Period, if none the first one is IT.
        close;
        sql.Clear;
        sql.Add('select * from stocks where tid = ' + inttostr(data1.CurTid));
        sql.Add('and "stockcode" <= ' + inttostr(data1.StkCode - 1));
        sql.Add('and SiteCode = '+IntToStr(data1.repSite));
        sql.Add('and [type] = ''B''');
        sql.Add('order by stockcode DESC');
        open;

        if recordcount = 0 then // no BgCPS designated, take the first ever stock (got to be stkcode = 2)
        begin
          bgCPS := 2;
        end
        else
        begin
          bgCPS := FieldByName('stockcode').asinteger;
        end;

        // get some text about bgCPS to put in pplabel184
        data1.ERRSTR1 := 'Get Cumulative figures 2';
        close;
        sql.Clear;
        sql.Add('select sdate, edate, accdate from stocks where tid = ' + inttostr(data1.CurTid));
        sql.Add('and "stockcode" = ' + inttostr(bgCPS));
        sql.Add('and SiteCode = '+IntToStr(data1.repSite));
        open;

        bgCPStext := 'Start: ' + datetostr(FieldByName('sdate').AsDateTime) +
          ' -- End: ' + datetostr(FieldByName('edate').AsDateTime) + ' -- Accepted on: ' +
          datetostr(FieldByName('accdate').AsDateTime);


        // now get the data
        data1.ERRSTR1 := 'Get Cumulative figures 3';
        close;
        sql.Clear;
        sql.Add('select');

        sql.Add('sum(CASE ');
        sql.Add('     WHEN b.[totinc] = 0 THEN b.[banked]');
        sql.Add('     ELSE (b.[totnetinc] * b.[banked] / b.[totinc])');
        sql.Add(' END) as NetTake,');

        sql.Add('sum(CASE ');
        sql.Add('     WHEN b.[totinc] = 0 THEN b.[banked]');
        sql.Add('     ELSE (b.[totnetinc] * b.[banked] / b.[totinc])');
        sql.Add(' END) as wkTake,');

        sql.Add('sum(b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]) as totActCost,');

        sql.Add('sum(b.[totConsVal]) as totConsVal, sum(b.[totRcpVar]) as totRcpVar,');
        sql.Add('sum(b.[banked]) as banked, sum(b.[extrainc]) as extrainc,');

        sql.Add('sum(b.[totLGW] + b.[banked] - b.[totInc] + b.[miscBal1] + ');
        sql.Add('      b.[miscBal2] + b.[miscBal3] + b.[totawvalue]) as SResult,');

        sql.Add('sum(b.[totpurch]) as totpurch, sum(b.[totMoveCost]) as totMovecost, sum(b.per) as per');
        sql.Add('from [stkmisc] b');
        sql.Add('where b.SiteCode = '+IntToStr(data1.repSite));
        sql.Add('and b.[tid] = ' + inttostr(data1.curTid));
        sql.Add('and b.[stockcode] >= ' + inttostr(bgCPS));
        sql.Add('and b.[stockcode] <= ' + inttostr(data1.StkCode));
        sql.Add('and b.hzid = ' + repHZidStr);
        open;

        // labels can be filled in here as we have all the info we need...

        data1.ERRSTR1 := 'Get Cumulative figures 4';
        pplabel174.Caption := IntToStr(FieldByName('per').AsInteger div 7) +
          '/' + IntToStr(FieldByName('per').AsInteger mod 7);// period
        pplabel173.Caption := formatfloat(currencyString + '#,0.00', FieldByName('banked').AsFloat); // takings inc VAT
        pplabel175.Caption := formatfloat(currencyString + '#,0.00', FieldByName('nettake').AsFloat); // takings exc VAT
        pplabel176.Caption := formatfloat(currencyString + '#,0.00',
          7 * FieldByName('wktake').AsFloat / FieldByName('per').AsInteger); // Net Takings / week
        pplabel177.Caption := formatfloat(currencyString + '#,0.00', FieldByName('totActCost').AsFloat);// Cost of Sales
        pplabel178.Caption := formatfloat(currencyString + '#,0.00',
          FieldByName('totpurch').AsFloat + FieldByName('totMoveCost').AsFloat);// purchase cost

        pplabel180.Caption := formatfloat(currencyString + '#,0.00', FieldByName('SResult').AsFloat);// Stock Result
        pplabel182.Caption := formatfloat(currencyString + '#,0.00',
                       FieldByName('nettake').AsFloat - FieldByName('totActCost').AsFloat); // actual GP


        // fill the Yield, Stock Result % and GP% labels

        data1.ERRSTR1 := 'Get Cumulative figures 5';
        if (FieldByName('totConsVal').AsFloat + FieldByName('totRcpVar').AsFloat) = 0 then
        begin
          ppLabel179.caption := '-----';
          ppLabel181.caption := '-----';
        end
        else
        begin
          ppLabel179.Caption := formatfloat('0.000', 100 * FieldByName('banked').AsFloat /
            (FieldByName('totConsVal').AsFloat + FieldByName('extrainc').AsFloat + FieldByName('totRcpVar').AsFloat)); // Yield.
          ppLabel181.Caption := formatfloat('0.000', 100 * FieldByName('sresult').AsFloat /
            (FieldByName('totConsVal').AsFloat + FieldByName('extrainc').AsFloat + FieldByName('totRcpVar').AsFloat)); // StkRes%
        end;

        if FieldByName('nettake').AsFloat = 0 then
          ppLabel183.caption := '-----'
        else
          if data1.curIsGP then
            ppLabel183.Caption := formatfloat('0.000', 100 - (100 *
              FieldByName('totActCost').AsFloat / FieldByName('nettake').AsFloat)) // GP%
          else
            ppLabel183.Caption := formatfloat('0.000', (100 *
              FieldByName('totActCost').AsFloat / FieldByName('nettake').AsFloat)); // COS%

        pplabel184.Caption := 'Cumulative Period Summary (Period 1st ' + data1.SSbig + ' ' + bgCPStext +
          ') -- No. of ' + data1.SSplural + ' involved: ' + inttostr(data1.StkCode - bgCPS + 1);
      end;
    end
    else
    begin
      pplabel184.Visible := False;
      pplabel185.Visible := True;
    end;
  end
  else
  begin
    pplabel184.Visible := False;
  end;

  data1.ERRSTR1 := 'Set Labels and Lines';
  // now set ALL labels and lines for the prev stock visible or not...
  pplabel146.Visible := pplabel147.Visible;
  pplabel148.Visible := pplabel147.Visible;
  pplabel149.Visible := pplabel147.Visible;
  pplabel150.Visible := pplabel147.Visible;
  pplabel151.Visible := pplabel147.Visible;
  pplabel152.Visible := pplabel147.Visible;
  pplabel153.Visible := pplabel147.Visible;
  pplabel154.Visible := pplabel147.Visible;
  pplabel155.Visible := pplabel147.Visible;
  pplabel156.Visible := pplabel147.Visible;
  pplabel157.Visible := pplabel147.Visible;

  ppline143.Visible := pplabel147.Visible;
  ppline142.Visible := pplabel147.Visible;
  ppline95.Visible := pplabel147.Visible;
  ppline96.Visible := pplabel147.Visible;
  ppline98.Visible := pplabel147.Visible;
  ppline110.Visible := pplabel147.Visible;
  ppline111.Visible := pplabel147.Visible;
  ppline113.Visible := pplabel147.Visible;
  ppline136.Visible := pplabel147.Visible;
  ppline137.Visible := pplabel147.Visible;
  ppline138.Visible := pplabel147.Visible;
  ppline140.Visible := pplabel147.Visible;
  ppline141.Visible := pplabel147.Visible;
  ppline139.Visible := pplabel147.Visible;

  // now set ALL labels and lines for the CPS visible or not...
  pplabel180.Visible := pplabel184.Visible;
  pplabel181.Visible := pplabel184.Visible;
  pplabel182.Visible := pplabel184.Visible;
  pplabel183.Visible := pplabel184.Visible;
  pplabel174.Visible := pplabel184.Visible;
  pplabel175.Visible := pplabel184.Visible;
  pplabel176.Visible := pplabel184.Visible;
  pplabel177.Visible := pplabel184.Visible;
  pplabel178.Visible := pplabel184.Visible;
  pplabel179.Visible := pplabel184.Visible;
  pplabel173.Visible := pplabel184.Visible;

  ppline133.Visible := pplabel184.Visible;
  ppline158.Visible := pplabel184.Visible;
  ppline159.Visible := pplabel184.Visible;
  ppline160.Visible := pplabel184.Visible;
  ppline161.Visible := pplabel184.Visible;
  ppline162.Visible := pplabel184.Visible;
  ppline163.Visible := pplabel184.Visible;
  ppline164.Visible := pplabel184.Visible;
  ppline165.Visible := pplabel184.Visible;
  ppline166.Visible := pplabel184.Visible;
  ppline167.Visible := pplabel184.Visible;
  ppline168.Visible := pplabel184.Visible;
  ppline169.Visible := pplabel184.Visible;
  ppline170.Visible := pplabel184.Visible;

  if not pplabel147.Visible then
  begin
    if pplabel185.Visible then
      pplabel185.Top := pplabel157.Top;
  end;

  Result := True;
  data1.ERRSTR1 := 'Ready to Print...';
end; // procedure..



procedure TfRepTrad.ppTradPreviewFormCreate(Sender: TObject);
begin
  dmADO.ALLRepsPreviewFormCreate(Sender, data1.repPaperName);
end;

procedure TfRepTrad.ppTradSummaryBand1BeforePrint(Sender: TObject);
var
	per, takings, totMiscAll, totpurch, SResult, netTake: Real;
	per2, takings2, totMiscAll2, totpurch2, SResult2, netTake2: Real;
begin
  data1.ERRSTR1 := 'Printing Summary Band 1';
  ppTradSig.Text := '';
  if data1.curMngSig then
    ppTradSig.Text := 'Manager Signature: ________________________________________________       ';
  if data1.curAudSig then
    ppTradSig.Text := ppTradSig.Text +
      'Auditor Signature: ________________________________________________';
  ppRegion8.Visible := (ppTradSig.Text <> '');

  // do the grid bottom labels
  pplabel20.Text := data1.SSbig + ' Variance';
  pplabel34.Text := data1.SSbig + ' Result';

  if data1.UKUSmode = 'US' then
  begin
    pplabel29.Text := 'inc. Tax';
    pplabel40.Text := 'exc. Tax';
  end
  else
  begin
    pplabel29.Text := 'inc. VAT';
    pplabel40.Text := 'exc. VAT';
  end;

  // Loss/Gain % label
  data1.ERRSTR1 := 'Printing Summary Band 2';
  if totgcons = 0 then
    ppLabel6.Caption := '----'
  else
    ppLabel6.Caption := formatfloat('0.00', (ppDBCalc8.Value / totgcons * 100));

  // total in hand Days label
  if totcost = 0 then
  begin
    ppLabel7.Caption := '----';
  end
  else
  begin
    per := ppDBCalc12.Value / totcost;
    if per < 0 then
    begin
      ppLabel7.Caption := 'ERR.';
    end
    else
    begin
      per :=  per * (data1.Edate - data1.Sdate + 1);

      if (per / 7) > 52 then
        ppLabel7.Caption := '> 52/0'
      else
        ppLabel7.Caption := IntToStr(trunc(per) div 7)+'/'+ IntToStr(trunc(per) mod 7);
    end;
  end;

  // do the summary figures
  data1.ERRSTR1 := 'Printing Summary Band 3';
  per :=  (data1.Edate - data1.Sdate + 1);

  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT *');
    sql.Add('FROM [stkmisc] a');
    sql.Add('WHERE a."StockCode" = '+IntToStr(data1.StkCode));
    sql.Add('and a.tid = '+IntToStr(data1.curtid));
    sql.Add('and a.SiteCode = '+IntToStr(data1.repSite));
    sql.Add('and a.hzid = ' + repHZidStr);
    open;

    takings := FieldByName('banked').asfloat;
    totMiscAll := FieldByName('miscbal1').AsFloat + FieldByName('miscbal2').AsFloat +
      FieldByName('miscbal3').AsFloat + FieldByName('totawvalue').AsFloat;
    totpurch := FieldByName('totpurch').asfloat;

    data1.ERRSTR1 := 'Printing Summary Band 4';
    if FieldByName('totawvalue').AsFloat <> 0 then
    begin
      pplabel200.Visible := true;
      pplabel201.Visible := true;
      pplabel201.Caption := formatfloat(currencyString + '#,0.00', FieldByName('totawvalue').AsFloat);
    end
    else
    begin
      pplabel200.Visible := false;
      pplabel201.Visible := false;
    end;

    pplabel16.Caption := FieldByName('miscbalreason1').asstring;
    pplabel18.Caption := formatfloat(currencyString + '#,0.00', FieldByName('miscbal1').AsFloat);
    pplabel142.Caption := FieldByName('miscbalreason2').asstring;
    pplabel143.Caption := formatfloat(currencyString + '#,0.00', FieldByName('miscbal2').AsFloat);
    pplabel144.Caption := FieldByName('miscbalreason3').asstring;
    pplabel145.Caption := formatfloat(currencyString + '#,0.00', FieldByName('miscbal3').AsFloat);

    if FieldByName('stocknote').AsString <> '' then
    begin
      ppMemo2.Text := FieldByName('stocknote').AsString;
      pplabel208.Visible := True;
      ppregion2.Visible := True;
    end
    else
    begin
      pplabel208.Visible := False;
      ppregion2.Visible := False;
    end;

    close;
  end;

  data1.ERRSTR1 := 'Printing Summary Band 5';
  if not audited then
  begin
    takings := totInc;
    totMiscAll := 0;
  end;

  if totInc <> 0 then
    netTake := totNetInc * takings / totInc // 16948 - takings exc VAT
  else
    netTake := takings;

  SResult := ppDBCalc8.Value + takings - totInc + totMiscAll;

  if rcpVar <> 0 then
  begin
    pplabel8.Visible := true;
    pplabel11.Visible := true;
    pplabel11.Caption := formatfloat(currencyString + '#,0.00', rcpVar);           // Rcp Variance
  end
  else
  begin
    pplabel8.Visible := false;
    pplabel11.Visible := false;
  end;

  if extraInc <> 0 then
  begin
    pplabel206.Visible := true;
    pplabel207.Visible := true;
    pplabel207.Caption := formatfloat(currencyString + '#,0.00', extraInc);
  end
  else
  begin
    pplabel206.Visible := false;
    pplabel207.Visible := false;
  end;

  data1.ERRSTR1 := 'Printing Summary Band 6';
  pplabel205.Caption := formatfloat(currencyString + '#,0.00', totInc);          // Expected Takings
  pplabel12.Caption := formatfloat(currencyString + '#,0.00', totGCons);         // Gross Cons
  pplabel13.Caption := formatfloat(currencyString + '#,0.00', rcpVar + extraInc + totGCons);// Expected Sales
  pplabel15.Caption := formatfloat(currencyString + '#,0.00', takings);          // Takings
  //pplabel18.Caption := formatfloat(currencyString + '#,0.00', ppDBCalc7.Value);  // wastage
  pplabel19.Caption := formatfloat(currencyString + '#,0.00', totMiscAll);       // Misc Allowance
  pplabel24.Caption := formatfloat(currencyString + '#,0.00', ppDBCalc8.Value);  // Stock Variance (total Loss/Gain)
  pplabel25.Caption := formatfloat(currencyString + '#,0.00', takings - totInc); // Cash Variance
  pplabel26.Caption := formatfloat(currencyString + '#,0.00', totMiscAll);       // Misc Allowance
  pplabel27.Caption := formatfloat(currencyString + '#,0.00', SResult);          // Result

  pplabel39.Caption := IntToStr(trunc(per) div 7)+'/'+ IntToStr(trunc(per) mod 7);// period
  pplabel38.Caption := formatfloat(currencyString + '#,0.00', takings);           // takings inc VAT
  pplabel42.Caption := formatfloat(currencyString + '#,0.00', netTake);   // 16948 - takings exc VAT
  pplabel43.Caption := formatfloat(currencyString + '#,0.00', (netTake / per) * 7);// Net Takings / week
  pplabel44.Caption := formatfloat(currencyString + '#,0.00', totCost);           // Cost of Sales
  pplabel45.Caption := formatfloat(currencyString + '#,0.00', totPurch + totMoveCost); // purchase cost

  data1.ERRSTR1 := 'Printing Summary Band 7';
  if (rcpVar + extraInc + totGCons) = 0 then
    pplabel46.Caption := '----'
  else
    pplabel46.Caption := formatfloat('0.000', (takings / (rcpVar + extraInc + totGCons)) * 100); // overall Yield %

  pplabel47.Caption := formatfloat(currencyString + '#,0.00', SResult);               // Stock Result
  if (rcpVar + extraInc + totGCons) = 0 then
    pplabel48.Caption := '----'
  else
    pplabel48.Caption := formatfloat('0.000', (SResult / (rcpVar + extraInc + totGCons)) * 100); // Stock Result %

  pplabel49.Caption := formatfloat(currencyString + '#,0.00', netTake - totCost); // actual GP

  // GP mode or COS mode
  data1.ERRSTR1 := 'Printing Summary Band 8';
  if data1.curIsGP then
  begin
    // GP% grid totals label
    if totncons = 0 then
      pplabel5.Caption := '0.00'
    else
      pplabel5.Caption := formatfloat('0.00', (100 - (totcost / totncons * 100)));

    ppTradLabel4.Caption := 'GP%';
    ppLabel41.Caption := 'Actual GP%';

    // GP% summary section label
    if netTake <> 0 then
      pplabel50.Caption := formatfloat('0.000', 100 - ((totCost / netTake) * 100))   // actual GP%
    else
      pplabel50.Caption := '----';
  end
  else
  begin
    // GP% grid totals label
    if totncons = 0 then
      if totcost = 0 then
        pplabel5.Caption := '0.00'
      else
        pplabel5.Caption := '100.00'
    else
      pplabel5.Caption := formatfloat('0.00', (totcost / totncons * 100));

    ppTradLabel4.Caption := 'COS%';
    ppLabel41.Caption := 'Actual COS%';

    // GP% summary section label
    if netTake <> 0 then
      pplabel50.Caption := formatfloat('0.000', ((totCost / netTake) * 100))   // actual COS%
    else
      pplabel50.Caption := '----';
  end;

  data1.ERRSTR1 := 'Printing Summary Band 9';
  if data1.StkCode >= 3 then
  begin
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT *');
      sql.Add('FROM [stocks] a');
      sql.Add('WHERE a."StockCode" = '+IntToStr(data1.StkCode - 1));
      sql.Add('and a.tid = '+IntToStr(data1.curtid));
      sql.Add('and a.SiteCode = '+IntToStr(data1.repSite));
      open;

      data1.ERRSTR1 := 'Printing Summary Band 10';
      per2 := (FieldByName('Edate').asdatetime - FieldByName('Sdate').asdatetime + 1);

      pplabel157.Caption := 'Previous ' + data1.SSbig + ' Summary (Start: ' + datetostr(FieldByName('Sdate').asdatetime) +
        ' ' + FieldByName('Stime').asstring + ', End: ' + datetostr(FieldByName('Edate').asdatetime) +
        ' ' + FieldByName('Etime').asstring + ', Accepted: ' + datetostr(FieldByName('accdate').asdatetime) +
        ' ' + FieldByName('acctime').asstring + ', Type: ' + FieldByName('stkkind').asstring;

      close;
      sql.Clear;
      sql.Add('SELECT *');
      sql.Add('FROM [stkmisc] a');
      sql.Add('WHERE a."StockCode" = '+IntToStr(data1.StkCode - 1));
      sql.Add('and a.tid = '+IntToStr(data1.curtid));
      sql.Add('and a.SiteCode = '+IntToStr(data1.repSite));
      sql.Add('and a.hzid = ' + repHZidStr);
      open;

      data1.ERRSTR1 := 'Printing Summary Band 11';
      takings2 := FieldByName('banked').asfloat;
      totMiscAll2 := FieldByName('miscbal1').AsFloat + FieldByName('miscbal2').AsFloat +
        FieldByName('miscbal3').AsFloat + FieldByName('totawvalue').AsFloat;
      totpurch2 := FieldByName('totpurch').asfloat;

      pplabel157.Caption := pplabel157.Caption + ', Done By: ' +
        FieldByName('stocktaker').asstring + ')';

      close;
    end;

    if totInc2 <> 0 then
      netTake2 := totNetInc2 * takings2 / totInc2 // 16948 - takings exc VAT
    else
      netTake2 := takings2;

    SResult2 := totLGW2 + takings2 - totInc2 + totMiscAll2;


    data1.ERRSTR1 := 'Printing Summary Band 12';
    pplabel147.Caption := IntToStr(trunc(per2) div 7)+'/'+ IntToStr(trunc(per2) mod 7);// period
    pplabel146.Caption := formatfloat(currencyString + '#,0.00', takings2); // takings inc VAT
    pplabel148.Caption := formatfloat(currencyString + '#,0.00', netTake2);// 16948 - takings exc VAT
    pplabel149.Caption := formatfloat(currencyString + '#,0.00', (netTake2 / per2) * 7);    // Net Takings / week
    pplabel150.Caption := formatfloat(currencyString + '#,0.00', totCost2 + totMoveCost2); // Cost of Sales
    pplabel151.Caption := formatfloat(currencyString + '#,0.00', totPurch2);// purchase cost
    if (rcpVar2 + totGCons2 + extraInc2) = 0 then
      pplabel152.Caption := '----'
    else
      pplabel152.Caption := formatfloat('0.000', (takings2 / (rcpVar2 + totGCons2 + extraInc2)) * 100); // overall Yield %
    pplabel153.Caption := formatfloat(currencyString + '#,0.00', SResult2);                           // Stock Result
    if (rcpVar2 + totGCons2 + extraInc2) = 0 then
      pplabel154.Caption := '----'
    else
      pplabel154.Caption := formatfloat('0.000', (SResult2 / (rcpVar2 + totGCons2 + extraInc2)) * 100); // Stock Result %
    pplabel155.Caption := formatfloat(currencyString + '#,0.00', netTake2 - totCost2); // actual GP

    data1.ERRSTR1 := 'Printing Summary Band 13';
    if data1.curIsGP then
    begin
      if nettake2 <> 0 then
        pplabel156.Caption := formatfloat('0.000', 100 - ((totCost2 / netTake2) * 100))   // actual GP%
      else
        pplabel156.Caption := '----';
    end
    else
    begin
      if nettake2 <> 0 then
        pplabel156.Caption := formatfloat('0.000', ((totCost2 / netTake2) * 100))   // actual COS%
      else
        pplabel156.Caption := '----';
    end;
  end
  else
  begin
    // what?
  end;
end;

procedure TfRepTrad.ppTradDBText12GetText(Sender: TObject; var Text: String);
var
	per: Real;
begin
	if text = '' then
  begin
    text := '----';
  end
  else
  begin
    if strtoFloat(text) < 0 then
    begin
      text := 'ERR.';
    end
    else
    begin
      per :=  strtoFloat(text) * (data1.Edate - data1.Sdate + 1);
      if (per / 7) > 52 then
        text := '> 52/0'
      else
        text := IntToStr(trunc(per) div 7)+'/'+ IntToStr(trunc(per) mod 7);
    end;
  end;
end;

function TfRepTrad.MakeRetRep:boolean;
begin
  Result := False;
  with dmADO.adoqRun do
  begin
    data1.ERRSTR1 := 'Get Retail Data 1';
    dmADO.DelSQLTable('RetRep');

    // get the main figures by sub-category
    close;
    sql.Clear;
  	sql.Add('SELECT (a.[' + reph + ']) as SubCatName, (0 * min(b."income")) as AvSpend, (0 * min(b."income")) as AvTake,');
    sql.Add('(sum (b."salesqty")) as salesQty,');
    sql.Add('(sum (b."Income")) as Income,');
    sql.Add('(sum (b."Income" - b."vatRate")) as NetIncome,');
    sql.Add('(sum (b."ActCost" * b."salesQty")) as totActCost,');
    if prof then
    begin
      sql.Add('(sum (b."cos%")) as profVar,');
    end
    else
    begin
      sql.Add('(sum ((b."TheoCost" * b."salesQty") - (b."ActCost" * b."salesQty"))) as profVar,');
    end;

    sql.Add('(sum (b."TheoCost" * b."salesQty")) as totTheoCost');

    sql.Add('INTO dbo.RetRep');

    sql.Add('FROM stkEntity a, "StkCrSld" b');
    sql.Add('WHERE a."entitycode" = b."entitycode"');
    sql.Add('and (b."producttype" not like ''Z'' or b."producttype" is NULL)');
    sql.Add('and b.hzid = ' + repHZidStr);

    sql.Add('Group By a.[' + reph + ']');
    sql.Add('Order By a.[' + reph + ']');
    execSQL;

    // now add the orphans if any...
    data1.ERRSTR1 := 'Get Retail Data 2';
    close;
    sql.Clear;
    sql.Add('SELECT b."ActCost"');
    sql.Add('FROM "StkCrSld" b');
    sql.Add('WHERE b."producttype" = ''Z''');
    sql.Add('and b.hzid = ' + repHZidStr);
    open;

    if recordcount > 0 then
    begin
      data1.ERRSTR1 := 'Get Retail Data 3';
      close;
      sql.Clear;
      sql.Add('insert RetRep (SubCatName, totActCost, Income, NetIncome, profVar)');
      sql.Add('SELECT (''zzzzzzzzzz'') as SubCatName, (sum (b."ActCost" * b."salesQty")) as totActCost, ');
      sql.Add('0, 0, (sum (b."ActCost" * b."salesQty") * -1)');
      sql.Add('FROM "StkCrSld" b');
      sql.Add('WHERE b."producttype" = ''Z''');
      sql.Add('and b.hzid = ' + repHZidStr);
      execSQL;
    end;

    // get the totals
    data1.ERRSTR1 := 'Get Retail Data 4';
    close;
    sql.Clear;
    sql.Add('select (sum(a."totActCost")) as totcost, (sum(a."profVar")) as totProfVar,');
    sql.add('(sum(a."tottheocost")) as totTcost, (sum (a."Income")) as Income, (sum(a."salesqty")) as salesqty');
    sql.Add('from "RetRep" a');
    open;

    totInc := FieldByName('income').asfloat;
    totProfVar := FieldByName('totprofvar').asfloat;
    totcost := FieldByName('totcost').asfloat;
    totTcost := FieldByName('totTcost').asfloat;
    totSalesQty := FieldByName('salesqty').asfloat;

    close;

    if (totInc = 0) and (totcost = 0) then
      exit;

    // get recipe variance (and tot income and VAT) from StkCrSld.
    data1.ERRSTR1 := 'Get Retail Data 5';
    close;
    sql.Clear;
    sql.Add('select (sum(a."income")) as income,');
    sql.Add('(sum((CASE');
    sql.Add('   WHEN (a."TheoCost" = 0) AND (a."ActCost" = 0) THEN (a."income")');
    sql.Add('   ELSE 0');
    sql.Add('END))) as rcpVar,');
    sql.Add('(sum(a."Income" - a."vatRate")) as totNetInc');
    sql.Add('from "stkCrSld" a');
    sql.Add('where a.hzid = ' + repHZidStr);
    open;

    rcpVar := FieldByName('rcpvar').asfloat;
    totInc := FieldByName('income').asfloat;
    totNetInc := FieldByName('totNetInc').asfloat;
    totVAT := totInc - totNetInc;

    // set the avg spend and avg take up
    data1.ERRSTR1 := 'Get Retail Data 6';
    if totSalesQty <> 0 then
    begin
      close;
      sql.Clear;
      sql.Add('update RetRep set avSpend = (CASE');
    sql.Add('   WHEN (salesqty = 0) THEN NULL');
    sql.Add('   ELSE (income / salesqty)');
    sql.Add('END),');
      sql.Add('avTake = 100 * salesqty / ' + floattostr(totSalesQty));
      execSQL;
    end;

    // get open cost, purch cost and close cost AND MOVE COST
    data1.ERRSTR1 := 'Get Retail Data 7';
    close;
    sql.Clear;
    sql.Add('select sum(b."ActCloseStk" * b."ActCloseCost") as closeCost,');
    sql.Add('sum(b."opStk" * b."opCost") as opCost, ');
    sql.Add('sum(moveQty * moveCost) as moveCost, ');
    sql.Add('sum(b."purchStk" * b."purchCost") as purCost');
    sql.Add('from stkCrDiv b where b.hzid = ' + repHZidStr);
    open;
    opCost := FieldByName('opCost').asfloat;
    closeCost:= FieldByName('closeCost').asfloat;
    purCost := FieldByName('purCost').asfloat;
    totMoveCost := FieldByName('moveCost').asfloat;

    close;
  end;

  // prepare query for report
  with wwqRet do
  begin
    data1.ERRSTR1 := 'Get Retail Data 8';
    close;
    sql.Clear;
    sql.Add('select (1) as grp, a."subcatname", a."salesqty", a."income", a."totActCost",');
    sql.Add('(a."netincome" - a."totActCost") as GP, a."avSpend", a."avTake",');

    if data1.curIsGP then
    begin
      sql.Add('(CASE ');
      sql.Add('   WHEN a."netincome" = 0 THEN 0.0');
      sql.Add('   ELSE (100 - (a."totActCost" / a."netincome" * 100)) ');
      sql.Add(' END) as gppPact,');

      sql.Add('(CASE ');
      sql.Add('   WHEN a."netincome" = 0 THEN 0.0');
      sql.Add('   ELSE (100 - (a."totTheoCost" / a."netincome" * 100)) ');
      sql.Add(' END) as gppTact,');

    end
    else
    begin
      sql.Add('(CASE ');
      sql.Add('   WHEN (a."netincome" = 0 AND a."totActCost" = 0) THEN 0.0');
      sql.Add('   WHEN (a."netincome" = 0 AND a."totActCost" <> 0) THEN 100.0');
      sql.Add('   ELSE (a."totActCost" / a."netincome" * 100) ');
      sql.Add(' END) as gppPact,');

      sql.Add('(CASE ');
      sql.Add('   WHEN (a."netincome" = 0 AND a."totTheoCost" = 0) THEN 0.0');
      sql.Add('   WHEN (a."netincome" = 0 AND a."totTheoCost" <> 0) THEN 100.0');
      sql.Add('   ELSE (a."totTheoCost" / a."netincome" * 100) ');
      sql.Add(' END) as gppTact,');

    end;


    sql.Add('a."profVar" from "RetRep" a order by grp, a."subcatname"');
    open;

    if recordcount = 0 then
      exit;
  end;

  if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
    pplabel61.Text := 'Sub-Category'
  else
    pplabel61.Text := 'Category';

  /////////////////////////

  // previous stock....

  if data1.StkCode >= 3 then
  begin
    with dmADO.adoqRun do
    begin
      data1.ERRSTR1 := 'Get Retail Data 9';
      // get the main figures from StkMain (saved stkCrDiv)
      close;
      sql.Clear;
      sql.Add('SELECT count(entitycode) as theitems, sum(b."ActCloseStk" * b."ActCloseCost") as closeCost,');
      sql.Add('sum(moveQty * moveCost) as moveCost, sum(b."opStk" * b."opCost") as opCost');
      sql.Add('FROM "StkMain" b');
      sql.Add('WHERE b."tid" = ' + inttostr(data1.CurTid));
      sql.Add('and b."stkcode" = ' + inttostr(data1.StkCode - 1));
      sql.Add('and b.SiteCode = '+IntToStr(data1.repSite));
      sql.Add('and ((b."OpStk" <> 0) or (b."PurchStk" <> 0) or (b."actCloseStk" <> 0))');
      sql.Add('and b.hzid = ' + repHZidStr);

      open;

      if (FieldByName('theitems').AsInteger <> 0) and (FieldByName('opcost').value <> NULL) then
      begin
        opCost2 := FieldByName('opCost').asfloat;
        closeCost2 := FieldByName('closeCost').asfloat;
        totMoveCost2 := FieldByName('moveCost').asfloat;

        // get recipe variance (and tot income and VAT) from StkCrSld.
        data1.ERRSTR1 := 'Get Retail Data 10';
        close;
        sql.Clear;
        sql.Add('select (sum(a."income")) as income,');
        sql.Add('(sum (a."ActCost" * a."salesQty")) as totActCost,');
        if prof then
        begin
          sql.Add('(sum (a."cos%")) as totProfVar,');
        end
        else
        begin
          sql.Add('(sum ((a."TheoCost" * a."salesQty") - (a."ActCost" * a."salesQty"))) as totProfVar,');
        end;
        sql.Add('(sum(a."Income" - a."vatRate")) as totNetInc');
        sql.Add('FROM "StkSold" a');
        sql.Add('WHERE a."tid" = ' + inttostr(data1.CurTid));
        sql.Add('and a."stkcode" = ' + inttostr(data1.StkCode - 1));
        sql.Add('and a.SiteCode = '+IntToStr(data1.repSite));
        sql.Add('and a.hzid = ' + repHZidStr);
        open;

        totInc2 := FieldByName('income').asfloat;
        totNetInc2 := FieldByName('totNetInc').asfloat;
        totProfVar2 := FieldByName('totprofvar').asfloat;
        totcost2 := FieldByName('totActcost').asfloat;
        pplabel159.Visible := True;
      end
      else
      begin
        pplabel159.Visible := False; // last stock has no data for this HZ, nothing to show...
      end;
      close;
    end;

  end
  else
  begin // no last stock available...
    //make relevant labels and lines invisible...
    pplabel159.Visible := False;
  end;

/////////////////////////////////////////////////
  // do CPS

  pplabel199.Visible := False;
  if data1.curCPS then
  begin
    // if no last stock then obviously no cumulative stock. On site this means this is the 1st stock,
    // but on a HZ this could mean the last stock was not by HZ or did not have this HZ so this stock
    // is then the start of a new cumulative period. This Cum Per issue should be covered already
    // in uMainMenu where any change detected in HZ status when starting a new stock makes the new stock
    // a Begin for Cum Period (i.e. curBgCP = True just below) but still, better safe...
    if (pplabel147.Visible) and (not data1.curBgCP) and (data1.StkCode > 2) then
    begin
      pplabel197.Visible := True;
      with dmADO.adoqRun do
      begin
        // find the 1st stock in the current Cumulative Period, if none the first one is IT.
        data1.ERRSTR1 := 'Get Retail Data 11';
        close;
        sql.Clear;
        sql.Add('select * from stocks where tid = ' + inttostr(data1.CurTid));
        sql.Add('and "stockcode" <= ' + inttostr(data1.StkCode - 1));
        sql.Add('and SiteCode = '+IntToStr(data1.repSite));
        sql.Add('and [type] = ''B''');
        sql.Add('order by stockcode DESC');
        open;

        if recordcount = 0 then // no BgCPS designated, take the first ever stock (got to be stkcode = 2)
        begin
          bgCPS := 2;
        end
        else
        begin
          bgCPS := FieldByName('stockcode').asinteger;
        end;

        // get some text about bgCPS to put in pplabel184
        data1.ERRSTR1 := 'Get Retail Data 12';
        close;
        sql.Clear;
        sql.Add('select sdate, edate, accdate from stocks where tid = ' + inttostr(data1.CurTid));
        sql.Add('and "stockcode" = ' + inttostr(bgCPS));
        sql.Add('and SiteCode = '+IntToStr(data1.repSite));
        open;

        bgCPStext := 'Start: ' + datetostr(FieldByName('sdate').AsDateTime) +
          ' -- End: ' + datetostr(FieldByName('edate').AsDateTime) + ' -- Accepted on: ' +
          datetostr(FieldByName('accdate').AsDateTime);


        // now get the data
        data1.ERRSTR1 := 'Get Retail Data 13';
        close;
        sql.Clear;
        sql.Add('select');

        sql.Add('sum(b.[banked]) as banked,');
        sql.Add('sum(CASE ');
        sql.Add('     WHEN b.[totinc] = 0 THEN b.[banked]');
        sql.Add('     ELSE (b.[totnetinc] * b.[banked] / b.[totinc])');
        sql.Add(' END) as NetTake,');
        sql.Add('sum(CASE ');
        sql.Add('     WHEN b.[totinc] = 0 THEN b.[banked]');
        sql.Add('     ELSE (b.[totnetinc] * b.[banked] / b.[totinc])');
        sql.Add(' END) as wkTake,');

        sql.Add('sum(b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]) as totActCost,');
        sql.Add('sum(b.[totopcost]) as totopcost, sum(b.[totpurch]) as totpurch,');
        sql.Add('sum(b.[totmovecost]) as totMovecost, sum(b.[totclosecost]) as totclosecost,');

        if prof then
        begin // The lines below mean Profit Variance even if the field says Cost Variance
          sql.Add('sum(b.[totCostVar] + b.[banked] - b.[totInc] + b.[miscBal1] + ');
          sql.Add('    b.[miscBal2] + b.[miscBal3] + b.[totawvalue]) as SResult,');
        end
        else
        begin // The lines below mean Cost Variance - the fields are named wrongly in StkMisk...
          sql.Add('sum(b.[totProfVar] + b.[banked] - b.[totInc] + b.[miscBal1] + ');
          sql.Add('    b.[miscBal2] + b.[miscBal3] + b.[totawvalue]) as SResult,');
        end;

        sql.Add('sum(b.[totinc]) as totinc, sum(b.[totNetinc]) as totNetinc, sum(b.per) as per');
        sql.Add('from [stkmisc] b');
        sql.Add('where b.SiteCode = '+IntToStr(data1.repSite));
        sql.Add('and b.[tid] = ' + inttostr(data1.curTid));
        sql.Add('and b.[stockcode] >= ' + inttostr(bgCPS));
        sql.Add('and b.[stockcode] <= ' + inttostr(data1.StkCode));
        sql.Add('and b.hzid = ' + repHZidStr);
        open;

        // labels can be filled in here as we have all the info we need...

        data1.ERRSTR1 := 'Get Retail Data 14';
        pplabel187.Caption := IntToStr(FieldByName('per').AsInteger div 7) +'/'+
                                                       IntToStr(FieldByName('per').AsInteger mod 7);// period
        pplabel186.Caption := formatfloat(currencyString + '#,0.00', FieldByName('banked').AsFloat); // takings inc VAT
        pplabel188.Caption := formatfloat(currencyString + '#,0.00', FieldByName('nettake').AsFloat); // takings exc VAT
        pplabel189.Caption := formatfloat(currencyString + '#,0.00',
                                     7 * FieldByName('wktake').AsFloat / FieldByName('per').AsInteger); // Net Takings / week
        pplabel190.Caption := formatfloat(currencyString + '#,0.00', FieldByName('totActCost').AsFloat);// Cost of Sales
        pplabel192.Caption := formatfloat(currencyString + '#,0.00',
                                  FieldByName('totpurch').AsFloat + FieldByName('totmoveCost').AsFloat);// purchase cost

        // the closing cost is the closing cost of THIS stock...
        pplabel193.Caption := formatfloat(currencyString + '#,0.00', closeCost);                        // Close cost
        // the opening cost is the opening of the BgCPS - calcualte it using THIS stocks closing cost
        pplabel191.Caption := formatfloat(currencyString + '#,0.00', FieldByName('totActCost').AsFloat -
                               FieldByName('totpurch').AsFloat - FieldByName('totmoveCost').AsFloat + closeCost);// Open cost
        pplabel195.Caption := formatfloat(currencyString + '#,0.00', FieldByName('SResult').AsFloat);// Stock Result

        // fill the Yield, Stock Result % and GP% labels


        if prof then // Yield % ProfVar: (Stock Result/Net Sales*100)+100, CostVar: (Stock Result/Cost of Sales*100)+100
        begin
          if FieldByName('TotNetInc').AsFloat <> 0 then
            pplabel194.Caption := formatfloat('0.000',
                      (FieldByName('SResult').AsFloat / FieldByName('TotNetInc').AsFloat * 100) + 100) // profVar Yield %
          else
            pplabel194.Caption := '----';
        end
        else
        begin
          if FieldByName('totActCost').AsFloat <> 0 then
            pplabel194.Caption := formatfloat('0.000',
                      (FieldByName('SResult').AsFloat / FieldByName('totActCost').AsFloat * 100) + 100) // costVar Yield %
          else
            pplabel194.Caption := '----';
        end;

        data1.ERRSTR1 := 'Get Retail Data 15';
        if FieldByName('TotNetInc').AsFloat = 0 then
          pplabel196.Caption := '----'
        else
          pplabel196.Caption := formatfloat('0.000', (FieldByName('SResult').AsFloat /
                                                          FieldByName('TotNetInc').AsFloat) * 100);  // Stock Result %

        if FieldByName('nettake').AsFloat = 0 then
          ppLabel198.caption := '-----'
        else
          if data1.curIsGP then
            ppLabel198.Caption := formatfloat('0.000', 100 - (100 *
              FieldByName('totActCost').AsFloat / FieldByName('nettake').AsFloat)) // GP%
          else
            ppLabel198.Caption := formatfloat('0.000', (100 *
              FieldByName('totActCost').AsFloat / FieldByName('nettake').AsFloat)); // COS%

        pplabel197.Caption := 'Cumulative Period Summary (Period 1st ' + data1.SSbig + ' ' + bgCPStext +
          ') -- No. of ' + data1.SSplural + ' involved: ' + inttostr(data1.StkCode - bgCPS + 1);

        close;
      end;
    end
    else
    begin
      // if this stock is bgCPS then this is the 1st in the CP, don't show anything
      // if it has no2 then this is the same thing...
      pplabel197.Visible := False;
      pplabel199.Visible := True;
    end;
  end
  else
  begin
    pplabel197.Visible := False;
  end;

  // prev stock labels / lines
  data1.ERRSTR1 := 'Get Retail Data 16';
  pplabel158.Visible := pplabel159.Visible;
  pplabel160.Visible := pplabel159.Visible;
  pplabel161.Visible := pplabel159.Visible;
  pplabel162.Visible := pplabel159.Visible;
  pplabel163.Visible := pplabel159.Visible;
  pplabel164.Visible := pplabel159.Visible;
  pplabel165.Visible := pplabel159.Visible;
  pplabel166.Visible := pplabel159.Visible;
  pplabel167.Visible := pplabel159.Visible;
  pplabel168.Visible := pplabel159.Visible;
  pplabel170.Visible := pplabel159.Visible;
  pplabel169.Visible := pplabel159.Visible;
  pplabel171.Visible := pplabel159.Visible;
  ppshape3.Visible := pplabel159.Visible;

  ppline67.Visible := pplabel159.Visible;
  ppline144.Visible := pplabel159.Visible;
  ppline145.Visible := pplabel159.Visible;
  ppline146.Visible := pplabel159.Visible;
  ppline147.Visible := pplabel159.Visible;
  ppline148.Visible := pplabel159.Visible;
  ppline149.Visible := pplabel159.Visible;
  ppline150.Visible := pplabel159.Visible;
  ppline151.Visible := pplabel159.Visible;
  ppline152.Visible := pplabel159.Visible;
  ppline153.Visible := pplabel159.Visible;
  ppline154.Visible := pplabel159.Visible;
  ppline155.Visible := pplabel159.Visible;
  ppline156.Visible := pplabel159.Visible;
  ppline157.Visible := pplabel159.Visible;

  // CPS labels / lines
  pplabel190.Visible := pplabel197.Visible;
  pplabel191.Visible := pplabel197.Visible;
  pplabel192.Visible := pplabel197.Visible;
  pplabel193.Visible := pplabel197.Visible;
  pplabel194.Visible := pplabel197.Visible;
  pplabel195.Visible := pplabel197.Visible;
  pplabel196.Visible := pplabel197.Visible;
  pplabel198.Visible := pplabel197.Visible;
  pplabel186.Visible := pplabel197.Visible;
  pplabel187.Visible := pplabel197.Visible;
  pplabel188.Visible := pplabel197.Visible;
  pplabel189.Visible := pplabel197.Visible;
  ppshape4.Visible := pplabel197.Visible;

  ppline171.Visible := pplabel197.Visible;
  ppline172.Visible := pplabel197.Visible;
  ppline173.Visible := pplabel197.Visible;
  ppline174.Visible := pplabel197.Visible;
  ppline175.Visible := pplabel197.Visible;
  ppline176.Visible := pplabel197.Visible;
  ppline177.Visible := pplabel197.Visible;
  ppline178.Visible := pplabel197.Visible;
  ppline179.Visible := pplabel197.Visible;
  ppline180.Visible := pplabel197.Visible;
  ppline181.Visible := pplabel197.Visible;
  ppline182.Visible := pplabel197.Visible;
  ppline183.Visible := pplabel197.Visible;
  ppline184.Visible := pplabel197.Visible;
  ppline185.Visible := pplabel197.Visible;

  if not pplabel159.Visible then
  begin
    if pplabel199.Visible then
      pplabel199.Top := pplabel169.Top;
  end;

  Result := True;
  data1.ERRSTR1 := 'Ready to Print Retail Rep';
end; // procedure..

// RETAIL summary report
procedure TfRepTrad.ppSummaryBand2BeforePrint(Sender: TObject);
var
  per, takings, totMiscAll, totpurch, SResult, netTake: Real;
  per2, takings2, totMiscAll2, totpurch2, SResult2, netTake2: Real;
  tradCOS, tradCOS2 : Real;
begin
  data1.ERRSTR1 := 'Print Retail Summary Band 1';
  ppRetSig.Text := '';
  if data1.curMngSig then
    ppRetSig.Text := 'Manager Signature: _______________________________________________      ';
  if data1.curAudSig then
    ppRetSig.Text := ppRetSig.Text + 'Auditor Signature: _______________________________________________';
  ppRegion7.Visible := (ppRetSig.Text <> '');

  // do the grid bottom labels
  pplabel93.Text := data1.SSbig + ' Variance';
  pplabel107.Text := data1.SSbig + ' Result';
  pplabel75.Text := 'Opening ' + data1.SS6 + ' Cost';
  pplabel78.Text := data1.SS6 + ' On Hand Cost';

  if data1.UKUSmode = 'US' then
  begin
    pplabel102.Text := 'inc. Tax';
    pplabel110.Text := 'exc. Tax';
  end
  else
  begin
    pplabel102.Text := 'inc. VAT';
    pplabel110.Text := 'exc. VAT';
  end;

  // avg spend label
  data1.ERRSTR1 := 'Print Retail Summary Band 2';
  if totSalesQty = 0 then
    pplabel77.Caption := '----'
  else
    pplabel77.Caption := formatfloat(currencyString + '#,0.00', (totinc/totSalesQty));

  // do the summary figures
  per :=  (data1.Edate - data1.Sdate + 1);

  with dmADO.adoqRun do
  begin
    data1.ERRSTR1 := 'Print Retail Summary Band 3';
    close;
    sql.Clear;
    sql.Add('SELECT *');
    sql.Add('FROM [stkmisc] a');
    sql.Add('WHERE a."StockCode" = '+IntToStr(data1.StkCode));
    sql.Add('and a.tid = '+IntToStr(data1.curtid));
    sql.Add('and a.SiteCode = '+IntToStr(data1.repSite));
    sql.Add('and a.hzid = ' + repHZidStr);
    open;

    takings := FieldByName('banked').asfloat;
    totMiscAll := FieldByName('miscbal1').AsFloat +
      FieldByName('miscbal2').AsFloat + FieldByName('miscbal3').AsFloat + FieldByName('totawvalue').AsFloat;
    totpurch := FieldByName('totpurch').asfloat;

    if FieldByName('totawvalue').AsFloat <> 0 then
    begin
      pplabel202.Visible := true;
      pplabel203.Visible := true;
      pplabel203.Caption := formatfloat(currencyString + '#,0.00', FieldByName('totawvalue').AsFloat);
    end
    else
    begin
      pplabel202.Visible := false;
      pplabel203.Visible := false;
    end;

    pplabel89.Caption := FieldByName('miscbalreason1').asstring;
    pplabel91.Caption := formatfloat(currencyString + '#,0.00', FieldByName('miscbal1').AsFloat);
    pplabel138.Caption := FieldByName('miscbalreason2').asstring;
    pplabel139.Caption := formatfloat(currencyString + '#,0.00', FieldByName('miscbal2').AsFloat);
    pplabel140.Caption := FieldByName('miscbalreason3').asstring;
    pplabel141.Caption := formatfloat(currencyString + '#,0.00', FieldByName('miscbal3').AsFloat);

    if FieldByName('stocknote').AsString <> '' then
    begin
      ppMemo1.Text := FieldByName('stocknote').AsString;
      pplabel209.Visible := True;
      ppregion1.Visible := True;
    end
    else
    begin
      pplabel209.Visible := False;
      ppregion1.Visible := False;
    end;

    close;
  end;

  data1.ERRSTR1 := 'Print Retail Summary Band 4';
  if not audited then
  begin
    takings := totInc;
    totMiscAll := 0;
  end;

  if totInc <> 0 then
    netTake := totNetInc * takings / totInc // 16948 - takings exc VAT
  else
    netTake := takings;

  SResult := totProfVar + takings - totInc + totMiscAll;
  tradCOS := opCost + totPurch + totMoveCost - closeCost;

  data1.ERRSTR1 := 'Print Retail Summary Band 5';
  pplabel85.Caption := formatfloat(currencyString + '#,0.00', totInc);         // Gross Sales
  pplabel88.Caption := formatfloat(currencyString + '#,0.00', takings);        // Takings
  pplabel92.Caption := formatfloat(currencyString + '#,0.00', totMiscAll);     // Misc Allowance

  if prof then
    pplabel93.Caption := 'Profit Variance'
  else
    pplabel93.Caption := 'Cost Variance';
  pplabel97.Caption := formatfloat(currencyString + '#,0.00', totProfVar);       // Stock Variance (tot profit var)
  pplabel98.Caption := formatfloat(currencyString + '#,0.00', takings - totInc); // Cash Variance
  pplabel99.Caption := formatfloat(currencyString + '#,0.00', totMiscAll);       // Misc Allowance
  pplabel100.Caption := formatfloat(currencyString + '#,0.00', SResult);         // Stock Result (between grids)

  pplabel113.Caption := IntToStr(trunc(per) div 7)+'/'+ IntToStr(trunc(per) mod 7);   // period
  pplabel112.Caption := formatfloat(currencyString + '#,0.00', takings);              // takings inc VAT
  pplabel114.Caption := formatfloat(currencyString + '#,0.00', netTake);              // takings exc VAT
  pplabel115.Caption := formatfloat(currencyString + '#,0.00', (netTake / per) * 7);  // Net Takings / week
  pplabel116.Caption := formatfloat(currencyString + '#,0.00', tradCOS);              // CostOfSales = Open+Purch-Close

  pplabel117.Caption := formatfloat(currencyString + '#,0.00', opCost);                // open cost
  pplabel121.Caption := formatfloat(currencyString + '#,0.00', totPurch + totMoveCost);// purchase cost
  pplabel74.Caption := formatfloat(currencyString + '#,0.00', closeCost);              // close cost
  pplabel119.Caption := formatfloat(currencyString + '#,0.00', SResult);               // Stock Result (bottom grid)

  data1.ERRSTR1 := 'Print Retail Summary Band 6';

  if prof then // Yield % ProfVar: (Stock Result/Net Sales*100)+100, CostVar: (Stock Result/Cost of Sales*100)+100
  begin
    if totNetinc <> 0 then
      pplabel118.Caption := formatfloat('0.000', (Sresult / totNetInc * 100) + 100)     // profVar Yield %
    else
      pplabel118.Caption := '----';
  end
  else
  begin
    if tradCOS <> 0 then
      pplabel118.Caption := formatfloat('0.000', (Sresult / tradCOS * 100) + 100)      // costVar Yield %
    else
      pplabel118.Caption := '----';
  end;

  if totNetinc = 0 then
    pplabel120.Caption := '----'
  else
    pplabel120.Caption := formatfloat('0.000', (SResult / totNetInc) * 100);            // Stock Result %


  // GP mode or COS mode
  data1.ERRSTR1 := 'Print Retail Summary Band 7';
  if data1.curIsGP then
  begin
    pplabel66.Caption := 'Actual GP%';
    pplabel67.Caption := 'Target GP%';
    pplabel83.Caption := 'Actual GP %';
    pplabel109.Caption := 'Actual GP%';
    // act and Targ GP % label
    if totNetInc = 0 then
    begin
      ppLabel70.Caption := '----';
      ppLabel71.Caption := '----';
    end
    else
    begin
      ppLabel70.Caption := formatfloat('0.00', ((1 - (totcost / totNetInc )) * 100));
      ppLabel71.Caption := formatfloat('0.00', ((1 - (totTcost / totNetInc )) * 100));
    end;

    if netTake <> 0 then
      pplabel72.Caption := formatfloat('0.000', 100 - ((totCost / netTake) * 100)) // actual GP% - uses Retail COS
    else
      pplabel72.Caption := '----';


    if netTake <> 0 then
      pplabel122.Caption := formatfloat('0.000', 100 - ((tradCOS / netTake) * 100))// actual GP% - uses trad COS
    else
      pplabel122.Caption := '----';
  end
  else
  begin
    pplabel66.Caption := 'Actual COS%';
    pplabel67.Caption := 'Target COS%';
    pplabel83.Caption := 'Actual COS %';
    pplabel109.Caption := 'Actual COS%';
    // act and Targ COS % label
    if totNetInc = 0 then
    begin
      ppLabel70.Caption := '----';
      ppLabel71.Caption := '----';
    end
    else
    begin
      ppLabel70.Caption := formatfloat('0.00', ((totcost / totNetInc) * 100));
      ppLabel71.Caption := formatfloat('0.00', ((totTcost / totNetInc) * 100));
    end;

    if netTake <> 0 then
      pplabel72.Caption := formatfloat('0.000', (totCost / netTake) * 100) // actual GP% - uses Retail COS
    else
      pplabel72.Caption := '----';

    if netTake <> 0 then
      pplabel122.Caption := formatfloat('0.000', (tradCOS / netTake) * 100)// actual GP% - uses trad COS
    else
      pplabel122.Caption := '----';
  end;


  data1.ERRSTR1 := 'Print Retail Summary Band 8';
  pplabel136.Caption := '';
  if abs(opcost + totpurch + totMoveCost - closecost - totcost) >= 5 then
  begin
    pplabel136.Caption := 'WARNING: The Cost of Sales calculated as the sum of COS for all items ' +
      'is different from the Opening Cost + Purchases Cost - Closing Cost! ' +
      '(error: ' + formatfloat(currencyString + '#,0.00', (totcost - opcost - totpurch - totMoveCost + closecost)) + ')';
  end;

///////////////////////////////////////// PREVIOUS STOCK row
  if data1.StkCode >= 3 then
  begin
    data1.ERRSTR1 := 'Print Retail Summary Band 9';
    if pplabel136.Caption <> '' then
    begin
      pplabel136.Caption := 'CURRENT ' + uppercase(data1.SSbig) + ' ' + pplabel136.Caption;
    end;

    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT *');
      sql.Add('FROM [stocks] a');
      sql.Add('WHERE a."StockCode" = '+IntToStr(data1.StkCode - 1));
      sql.Add('and a.tid = '+IntToStr(data1.curtid));
      sql.Add('and a.SiteCode = '+IntToStr(data1.repSite));
      open;

      per2 := (FieldByName('Edate').asdatetime - FieldByName('Sdate').asdatetime + 1);

      pplabel169.Caption := 'Previous ' + data1.SSbig + ' Summary (Start: ' + datetostr(FieldByName('Sdate').asdatetime) +
        ' ' + FieldByName('Stime').asstring + ', End: ' + datetostr(FieldByName('Edate').asdatetime) +
        ' ' + FieldByName('Etime').asstring + ', Accepted: ' + datetostr(FieldByName('accdate').asdatetime) +
        ' ' + FieldByName('acctime').asstring + ', Type: ' + FieldByName('stkkind').asstring;

      data1.ERRSTR1 := 'Print Retail Summary Band 10';
      close;
      sql.Clear;
      sql.Add('SELECT *');
      sql.Add('FROM [stkmisc] a');
      sql.Add('WHERE a."StockCode" = '+IntToStr(data1.StkCode - 1));
      sql.Add('and a.tid = '+IntToStr(data1.curtid));
      sql.Add('and a.SiteCode = '+IntToStr(data1.repSite));
      sql.Add('and a.hzid = ' + repHZidStr);
      open;

      takings2 := FieldByName('banked').asfloat;
      totMiscAll2 := FieldByName('miscbal1').AsFloat +
        FieldByName('miscbal2').AsFloat + FieldByName('miscbal3').AsFloat + FieldByName('totawvalue').AsFloat;
      totpurch2 := FieldByName('totpurch').asfloat;

      pplabel169.Caption := pplabel169.Caption + ', Done By: ' +
        FieldByName('stocktaker').asstring + ')';

      close;
    end;

    if totInc2 <> 0 then
      netTake2 := totNetInc2 * takings2 / totInc2 // takings exc VAT
    else
      netTake2 := takings2;

    data1.ERRSTR1 := 'Print Retail Summary Band 11';
    SResult2 := totProfVar2 + takings2 - totInc2 + totMiscAll2;
    tradCOS2 := opCost2 + totPurch2 + totMoveCost2 - closeCost2;


    pplabel159.Caption := IntToStr(trunc(per2) div 7)+'/'+ IntToStr(trunc(per2) mod 7); // period
    pplabel158.Caption := formatfloat(currencyString + '#,0.00', takings2);             // takings inc VAT
    pplabel160.Caption := formatfloat(currencyString + '#,0.00', netTake2);             // takings exc VAT
    pplabel161.Caption := formatfloat(currencyString + '#,0.00', (netTake2 / per2) * 7);// Net Takings / week
    pplabel162.Caption := formatfloat(currencyString + '#,0.00', tradCOS2);             // Cost of Sales

    pplabel163.Caption := formatfloat(currencyString + '#,0.00', opCost2);                 // open cost
    pplabel164.Caption := formatfloat(currencyString + '#,0.00', totPurch2 + totMoveCost2);// purchase cost
    pplabel165.Caption := formatfloat(currencyString + '#,0.00', closeCost2);              // close cost
    pplabel167.Caption := formatfloat(currencyString + '#,0.00', SResult2);                // Stock Result
    
    data1.ERRSTR1 := 'Print Retail Summary Band 12';

    if prof then  // Yield % ProfVar: (Stock Result/Net Sales*100)+100, CostVar: (Stock Result/Cost of Sales*100)+100
    begin
      if totNetinc2 <> 0 then
        pplabel166.Caption := formatfloat('0.000', (Sresult2 / totNetInc2 * 100) + 100)     // profVar Yield %
      else
        pplabel166.Caption := '----';
    end
    else
    begin
      if tradCOS2 <> 0 then
        pplabel166.Caption := formatfloat('0.000', (Sresult2 / tradCOS2 * 100) + 100)       // costVar Yield %
      else
        pplabel166.Caption := '----';
    end;

    if totNetinc2 = 0 then
      pplabel168.Caption := '----'
    else
      pplabel168.Caption := formatfloat('0.000', (SResult2 / totNetInc2) * 100);            // Stock Result %


    if data1.curIsGP then
    begin
      if netTake2 <> 0 then
        pplabel170.Caption := formatfloat('0.000', 100 - ((tradCOS2 / netTake2) * 100))   // actual GP%
      else
        pplabel170.Caption := '----';
    end
    else
    begin
      if netTake2 <> 0 then
        pplabel170.Caption := formatfloat('0.000', (tradCOS2 / netTake2) * 100)   // actual COS%
      else
        pplabel170.Caption := '----';
    end;


    data1.ERRSTR1 := 'Print Retail Summary Band 13';
    pplabel171.Caption := '';
    if abs(opcost2 + totpurch2 + totMoveCost2 - closecost2 - totcost2) >= 5 then
    begin
      pplabel171.Caption := 'Previous ' + data1.SSbig + ' Warning: The Cost of Sales calculated as the sum of COS for all items ' +
        'is different from the Opening Cost + Purchases Cost - Closing Cost! ' +
        '(error: ' + formatfloat(currencyString + '#,0.00', (totcost2 - opcost2 - totpurch2 - totMoveCost2 + closecost2)) + ')';
    end;
  end;

  pplabel136.Visible := (pplabel136.Caption <> '');
  pplabel171.Visible := (pplabel171.Caption <> '') and pplabel159.Visible;

  ppshape22.Brush.Color := $c0FFFF;
  ppshape3.Brush.Color := $c0ffff;
  ppshape4.Brush.Color := $c0FFFF;
end;

procedure TfRepTrad.ppReport1HeaderBand1BeforePrint(Sender: TObject);
var
  s1 :string;
begin
  pplabel84.Text := 'Header: ' + data1.repHdr;
  pplabel132.Text := 'Thread Name: ' + data1.curTidName;
  pplabel124.Text := data1.SSbig + ' Type: ' + data1.StkTypeLong;
  pplabel129.Text := 'Division: ' + data1.theDiv;
  pplabel125.Text := data1.SSbig + ' Taker: ' + data1.TheStkTkr;
  pplabel130.Text := 'From: ' + formatDateTime(shortdateformat, data1.SDate) + '   To: ' +
    formatDateTime(shortdateformat, data1.EDate);

  if data1.NeedBeg or data1.NeedEnd then
    s1 := 'Sales included only between ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.SDT) +
       ' and ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.EDT)
    else
      s1 := '';

  pplabel131.Text := s1;

  pplabel126.Text := 'Period Length: ' + inttostr(trunc(data1.Edate - data1.SDate + 1)) + ' Days';

  if data1.AccDate <> 0 then
    pplabel127.Text := 'Accepted Date: ' + formatDateTime(shortdateformat, data1.AccDate)
  else
    pplabel127.text := 'Not Accepted';

  pplabel79.Text := data1.SSbig + ' Summary Report (Traditional)';
  pptradlabel11.Text := 'Opening ' + data1.SSbig + ' Valuation';
  pplabel3.Text := data1.SSbig + ' on Hand';
end;

procedure TfRepTrad.ppHeaderBand1BeforePrint(Sender: TObject);
var
  s1 :string;
begin
  pplabel137.Text := 'Header: ' + data1.repHdr;
  pplabel135.Text := 'Thread Name: ' + data1.curTidName;
  pplabel55.Text := data1.SSbig + ' Type: ' + data1.StkTypeLong;
  pplabel60.Text := 'Division: ' + data1.theDiv;
  pplabel56.Text := data1.SSbig + ' Taker: ' + data1.TheStkTkr;
  pplabel133.Text := 'From: ' + formatDateTime(shortdateformat, data1.SDate) + '   To: ' +
    formatDateTime(shortdateformat, data1.EDate);

  if data1.NeedBeg or data1.NeedEnd then
    s1 := 'Sales included only between ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.SDT) +
       ' and ' + formatDateTime(shortdateformat + ' hh:nn:ss', data1.EDT)
    else
      s1 := '';

  pplabel134.Text := s1;

  pplabel57.Text := 'Period Length: ' + inttostr(trunc(data1.Edate - data1.SDate + 1)) + ' Days';

  if data1.AccDate <> 0 then
    pplabel58.Text := 'Accepted Date: ' + formatDateTime(shortdateformat, data1.AccDate)
  else
    pplabel58.text := 'Not Accepted';

  if prof then
    pplabel68.Caption := 'Profit Variance'
  else
    pplabel68.Caption := 'Cost Variance';
  pplabel51.Text := data1.SSbig + ' Summary Report (Retail)';
end;

procedure TfRepTrad.ppLabel127Print(Sender: TObject);
begin
  if not audited then
  begin
    TppLabel(Sender).text := 'NOT AUDITED';
    TppLabel(Sender).Font.Style := [fsBold, fsUnderline];
  end;
end;

procedure TfRepTrad.DataModuleCreate(Sender: TObject);
begin
  if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
    reph := 'SCat'
  else
    reph := 'Cat';

  ppTrad.PrinterSetup.PaperName := data1.repPaperName;
  ppRet.PrinterSetup.PaperName := data1.repPaperName;

  pplabel208.Caption := data1.SSbig + ' Note:';
  pplabel209.Caption := data1.SSbig + ' Note:';
end;

procedure TfRepTrad.ppDetailBand2BeforePrint(Sender: TObject);
begin
  if ppdbtext1.Text = 'zzzzzzzzzz' then
  begin
    ppline87.Visible := False;
    ppline97.Visible := False;
  end
  else
  begin
    ppline87.Visible := True;
    ppline97.Visible := True;
  end;

  pplabel172.Visible := not ppline87.Visible;
  ppdbtext1.Visible := ppline87.Visible;
  ppdbtext10.Visible := ppline87.Visible;
  ppdbtext2.Visible := ppline87.Visible;

end;

end.
