unit uReps2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ppDB, ppReport, ppStrtch, ppSubRpt, ppCtrls,
  ppBands, ppVar, ppPrnabl, ppClass, ppCache, ppProd, DB, ADODB, ppComm,
  ppRelatv, ppDBPipe, ppDBBDE, Wwdatsrc, ExtCtrls, Printers, ppMemo,
  ppRegion, ComCtrls;

type
  TfReps2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    wwsTrad: TwwDataSource;
    pipeTrad: TppBDEPipeline;
    wwqTrad: TADOQuery;
    dsRet: TwwDataSource;
    pipeRet: TppBDEPipeline;
    wwqRet: TADOQuery;
    ppTrad: TppReport;
    ppReport1HeaderBand1: TppHeaderBand;
    ppShape1: TppShape;
    ppLabel79: TppLabel;
    ppLabel80: TppLabel;
    ppLabel86: TppLabel;
    ppLabel111: TppLabel;
    ppLabel128: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppLabel129: TppLabel;
    ppDBText35: TppDBText;
    ppDBText36: TppDBText;
    ppDBText37: TppDBText;
    ppSystemVariable4: TppSystemVariable;
    ppLine80: TppLine;
    ppLabel132: TppLabel;
    ppReport1DetailBand1: TppDetailBand;
    ppTradSummaryBand1: TppSummaryBand;
    ppTradLabel14: TppLabel;
    ppLine39: TppLine;
    ppLine41: TppLine;
    ppLine42: TppLine;
    ppLine45: TppLine;
    ppRet: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand2: TppDetailBand;
    ppSummaryBand2: TppSummaryBand;
    ppLabel76: TppLabel;
    ppLine114: TppLine;
    ppLine115: TppLine;
    ppLine116: TppLine;
    ppLine117: TppLine;
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
    ppLabel183: TppLabel;
    ppLabel184: TppLabel;
    ppLabel185: TppLabel;
    ppLabel186: TppLabel;
    ppLabel187: TppLabel;
    ppLabel188: TppLabel;
    ppLabel189: TppLabel;
    ppLabel190: TppLabel;
    ppLabel191: TppLabel;
    ppLine170: TppLine;
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
    ppLabel192: TppLabel;
    ppLabel193: TppLabel;
    ppLine183: TppLine;
    ppLabel194: TppLabel;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppDBText19: TppDBText;
    ppDBText20: TppDBText;
    ppDBText21: TppDBText;
    ppDBText22: TppDBText;
    ppDBText23: TppDBText;
    ppDBText24: TppDBText;
    ppDBText25: TppDBText;
    ppDBText26: TppDBText;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppDBCalc5: TppDBCalc;
    ppDBCalc7: TppDBCalc;
    ppDBCalc8: TppDBCalc;
    ppDBCalc10: TppDBCalc;
    ppDBCalc11: TppDBCalc;
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
    ppShape2: TppShape;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLabel8: TppLabel;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppSystemVariable3: TppSystemVariable;
    ppLine17: TppLine;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppLabel17: TppLabel;
    ppLine18: TppLine;
    ppLine19: TppLine;
    ppLine20: TppLine;
    ppLine21: TppLine;
    ppLine22: TppLine;
    ppLine23: TppLine;
    ppLine24: TppLine;
    ppLine25: TppLine;
    ppLine26: TppLine;
    ppLine27: TppLine;
    ppLine29: TppLine;
    ppLine30: TppLine;
    ppLabel19: TppLabel;
    ppLine31: TppLine;
    ppLabel21: TppLabel;
    ppLine32: TppLine;
    ppLine33: TppLine;
    ppLine34: TppLine;
    ppLabel22: TppLabel;
    ppLabel23: TppLabel;
    ppLabel32: TppLabel;
    ppLabel35: TppLabel;
    ppLabel36: TppLabel;
    ppLine53: TppLine;
    ppLine54: TppLine;
    ppLine55: TppLine;
    ppLine56: TppLine;
    ppLine57: TppLine;
    ppLine58: TppLine;
    ppLine59: TppLine;
    ppLine60: TppLine;
    ppLine61: TppLine;
    ppLine62: TppLine;
    ppLine63: TppLine;
    ppLine64: TppLine;
    ppLine65: TppLine;
    ppLine66: TppLine;
    ppLine68: TppLine;
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
    ppDBText27: TppDBText;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppDBText30: TppDBText;
    ppLine49: TppLine;
    ppLine28: TppLine;
    ppLine35: TppLine;
    ppLine36: TppLine;
    ppLine37: TppLine;
    ppLine38: TppLine;
    ppLine40: TppLine;
    ppLine43: TppLine;
    ppLine44: TppLine;
    ppLine46: TppLine;
    ppLine47: TppLine;
    ppLine48: TppLine;
    ppLine50: TppLine;
    ppLine51: TppLine;
    ppLine52: TppLine;
    ppDBCalc3: TppDBCalc;
    ppDBCalc4: TppDBCalc;
    ppDBCalc9: TppDBCalc;
    ppDBCalc15: TppDBCalc;
    ppDBCalc17: TppDBCalc;
    ppDBCalc19: TppDBCalc;
    ppDBText31: TppDBText;
    ppLabel18: TppLabel;
    ppLabel20: TppLabel;
    CloseBtn: TBitBtn;
    RadioButton1: TRadioButton;
    cbSPprof: TRadioButton;
    Bevel1: TBevel;
    ppDBCalc24: TppDBCalc;
    ppDBCalc25: TppDBCalc;
    ppLabel24: TppLabel;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppDBCalc18: TppDBCalc;
    ppDBCalc20: TppDBCalc;
    ppLabel27: TppLabel;
    ppLabel28: TppLabel;
    ppLabel29: TppLabel;
    adoqLG: TADOQuery;
    dsLG: TDataSource;
    pipeLG: TppDBPipeline;
    ppLG: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppShape3: TppShape;
    ppLabel30: TppLabel;
    ppLabel31: TppLabel;
    ppLabel33: TppLabel;
    ppLabel34: TppLabel;
    ppLabel38: TppLabel;
    ppLabel40: TppLabel;
    ppLabel41: TppLabel;
    ppSystemVariable5: TppSystemVariable;
    ppLabel42: TppLabel;
    ppDBText38: TppDBText;
    ppDBText39: TppDBText;
    ppDBText40: TppDBText;
    ppSystemVariable6: TppSystemVariable;
    ppLine70: TppLine;
    ppDetailBand1: TppDetailBand;
    ppDBText32: TppDBText;
    ppDBText33: TppDBText;
    ppDBText34: TppDBText;
    ppDBText41: TppDBText;
    ppDBText42: TppDBText;
    ppDBText43: TppDBText;
    ppDBText44: TppDBText;
    ppDBText45: TppDBText;
    ppDBText46: TppDBText;
    ppDBText47: TppDBText;
    ppDBText48: TppDBText;
    ppDBText49: TppDBText;
    ppLine67: TppLine;
    ppLine69: TppLine;
    ppLine71: TppLine;
    ppLine72: TppLine;
    ppDBText51: TppDBText;
    ppLine132: TppLine;
    ppDBText58: TppDBText;
    ppDBText59: TppDBText;
    ppFooterBand2: TppFooterBand;
    ppSummaryBand1: TppSummaryBand;
    ppLabel43: TppLabel;
    ppLine84: TppLine;
    ppLine85: TppLine;
    ppLine86: TppLine;
    ppLine130: TppLine;
    ppDBCalc12: TppDBCalc;
    ppLine134: TppLine;
    ppDBCalc22: TppDBCalc;
    ppLine139: TppLine;
    ppLine140: TppLine;
    ppLine141: TppLine;
    ppDBCalc13: TppDBCalc;
    ppDBCalc26: TppDBCalc;
    ppLine142: TppLine;
    ppLine146: TppLine;
    ppLine151: TppLine;
    ppLine152: TppLine;
    ppLine153: TppLine;
    ppLine154: TppLine;
    ppLine155: TppLine;
    ppLine156: TppLine;
    ppDBCalc29: TppDBCalc;
    ppDBCalc30: TppDBCalc;
    ppDBCalc31: TppDBCalc;
    ppDBCalc32: TppDBCalc;
    ppDBCalc33: TppDBCalc;
    ppDBCalc34: TppDBCalc;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppLabel59: TppLabel;
    ppDBText52: TppDBText;
    ppLine97: TppLine;
    ppLine98: TppLine;
    ppLine103: TppLine;
    ppLine129: TppLine;
    ppDBCalc16: TppDBCalc;
    ppLine99: TppLine;
    ppDBCalc27: TppDBCalc;
    ppLine136: TppLine;
    ppLine137: TppLine;
    ppLine138: TppLine;
    ppDBCalc28: TppDBCalc;
    ppDBCalc35: TppDBCalc;
    ppLine143: TppLine;
    ppLine144: TppLine;
    ppLine145: TppLine;
    ppLine147: TppLine;
    ppLine148: TppLine;
    ppLine149: TppLine;
    ppLine150: TppLine;
    ppDBCalc36: TppDBCalc;
    ppDBCalc37: TppDBCalc;
    ppDBCalc38: TppDBCalc;
    ppDBCalc39: TppDBCalc;
    ppDBCalc40: TppDBCalc;
    ppDBCalc41: TppDBCalc;
    ppLGsmall: TppReport;
    ppHeaderBand3: TppHeaderBand;
    ppShape4: TppShape;
    ppLabel65: TppLabel;
    ppLabel66: TppLabel;
    ppLabel67: TppLabel;
    ppLabel68: TppLabel;
    ppLabel70: TppLabel;
    ppLabel74: TppLabel;
    ppDBText53: TppDBText;
    ppDBText54: TppDBText;
    ppDBText55: TppDBText;
    ppDetailBand3: TppDetailBand;
    ppDBText56: TppDBText;
    ppDBText57: TppDBText;
    ppDBText60: TppDBText;
    ppDBText61: TppDBText;
    ppDBText62: TppDBText;
    ppDBText63: TppDBText;
    ppDBText64: TppDBText;
    ppDBText65: TppDBText;
    ppDBText66: TppDBText;
    ppDBText67: TppDBText;
    ppLine101: TppLine;
    ppLine102: TppLine;
    ppLine104: TppLine;
    ppLine105: TppLine;
    ppLine106: TppLine;
    ppLine107: TppLine;
    ppLine108: TppLine;
    ppLine109: TppLine;
    ppLine110: TppLine;
    ppLine111: TppLine;
    ppLine112: TppLine;
    ppLine113: TppLine;
    ppLine118: TppLine;
    ppDBText68: TppDBText;
    ppFooterBand3: TppFooterBand;
    ppSummaryBand3: TppSummaryBand;
    ppLabel78: TppLabel;
    ppLine119: TppLine;
    ppLine120: TppLine;
    ppLine121: TppLine;
    ppLine125: TppLine;
    ppDBCalc42: TppDBCalc;
    ppLine122: TppLine;
    ppLine123: TppLine;
    ppLine124: TppLine;
    ppLine126: TppLine;
    ppLine157: TppLine;
    ppLine184: TppLine;
    ppLine185: TppLine;
    ppLine186: TppLine;
    ppDBCalc43: TppDBCalc;
    ppDBCalc44: TppDBCalc;
    ppDBCalc45: TppDBCalc;
    ppDBCalc46: TppDBCalc;
    ppDBCalc47: TppDBCalc;
    ppGroup3: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppDBText69: TppDBText;
    ppLabel81: TppLabel;
    ppLabel82: TppLabel;
    ppLabel83: TppLabel;
    ppLabel84: TppLabel;
    ppLabel61: TppLabel;
    ppLine187: TppLine;
    ppLine188: TppLine;
    ppLine189: TppLine;
    ppLine190: TppLine;
    ppLine191: TppLine;
    ppLine192: TppLine;
    ppLine193: TppLine;
    ppLine194: TppLine;
    ppLine195: TppLine;
    ppLine196: TppLine;
    ppLabel87: TppLabel;
    ppLabel88: TppLabel;
    ppLabel90: TppLabel;
    ppLabel91: TppLabel;
    ppLabel92: TppLabel;
    ppLabel93: TppLabel;
    ppLabel94: TppLabel;
    ppLabel95: TppLabel;
    ppLabel85: TppLabel;
    ppLine197: TppLine;
    ppGroupFooterBand3: TppGroupFooterBand;
    ppLabel96: TppLabel;
    ppDBText70: TppDBText;
    ppLine198: TppLine;
    ppLine199: TppLine;
    ppLine200: TppLine;
    ppLine201: TppLine;
    ppDBCalc48: TppDBCalc;
    ppLine202: TppLine;
    ppLine203: TppLine;
    ppLine204: TppLine;
    ppLine205: TppLine;
    ppLine206: TppLine;
    ppLine207: TppLine;
    ppLine208: TppLine;
    ppDBCalc49: TppDBCalc;
    ppDBCalc50: TppDBCalc;
    ppDBCalc51: TppDBCalc;
    ppDBCalc52: TppDBCalc;
    ppDBCalc53: TppDBCalc;
    GroupBox1: TGroupBox;
    rbCost: TRadioButton;
    rbPrice: TRadioButton;
    rbBoth: TRadioButton;
    btnLossGain: TBitBtn;
    ppMemo1: TppMemo;
    ppLabel37: TppLabel;
    ppLabel39: TppLabel;
    ppLabel62: TppLabel;
    ppLabel60: TppLabel;
    ppLabel63: TppLabel;
    ppSystemVariable7: TppSystemVariable;
    ppSystemVariable8: TppSystemVariable;
    ppLabel64: TppLabel;
    ppLine100: TppLine;
    ppMemo2: TppMemo;
    ppLabel69: TppLabel;
    ppLabel71: TppLabel;
    ppShape5: TppShape;
    ppShape6: TppShape;
    ppShape7: TppShape;
    ppShape8: TppShape;
    ppDBText71: TppDBText;
    ppLabel72: TppLabel;
    ppDBText72: TppDBText;
    ppLabel73: TppLabel;
    ppLabel75: TppLabel;
    ppLabel77: TppLabel;
    ppLabel89: TppLabel;
    ppLabel97: TppLabel;
    ppLabel98: TppLabel;
    ppLine209: TppLine;
    ppLine210: TppLine;
    ppLine211: TppLine;
    ppLine212: TppLine;
    ppLine213: TppLine;
    ppLine214: TppLine;
    ppLine215: TppLine;
    ppLine216: TppLine;
    ppLine217: TppLine;
    ppLine218: TppLine;
    ppLabel99: TppLabel;
    ppLabel100: TppLabel;
    ppLabel101: TppLabel;
    ppLabel102: TppLabel;
    ppLabel103: TppLabel;
    ppLabel106: TppLabel;
    ppLabel108: TppLabel;
    ppLabel109: TppLabel;
    ppLabel110: TppLabel;
    ppLabel112: TppLabel;
    ppLine219: TppLine;
    ppLabel113: TppLabel;
    ppLine220: TppLine;
    ppLabel114: TppLabel;
    ppLine221: TppLine;
    ppLabel115: TppLabel;
    ppLine87: TppLine;
    ppLine88: TppLine;
    ppLine89: TppLine;
    ppLine90: TppLine;
    ppLine91: TppLine;
    ppLine92: TppLine;
    ppLine93: TppLine;
    ppLine94: TppLine;
    ppLine95: TppLine;
    ppLine96: TppLine;
    ppLine127: TppLine;
    ppLine131: TppLine;
    ppLine222: TppLine;
    ppDBText50: TppDBText;
    ppLine73: TppLine;
    ppLine74: TppLine;
    adoqLGdetail: TADOQuery;
    dsLGdetail: TDataSource;
    pipeLGdetail: TppDBPipeline;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppTitleBand1: TppTitleBand;
    ppDetailBand4: TppDetailBand;
    ppSummaryBand4: TppSummaryBand;
    ppDBText73: TppDBText;
    ppDBText74: TppDBText;
    ppDBText75: TppDBText;
    ppDBText76: TppDBText;
    ppDBText77: TppDBText;
    ppDBText78: TppDBText;
    ppDBText79: TppDBText;
    ppDBText80: TppDBText;
    ppDBText81: TppDBText;
    ppDBText82: TppDBText;
    ppLine75: TppLine;
    ppLine76: TppLine;
    ppDBText83: TppDBText;
    ppLine77: TppLine;
    ppDBText84: TppDBText;
    ppDBText85: TppDBText;
    ppLine78: TppLine;
    ppLine79: TppLine;
    ppLine81: TppLine;
    ppLine82: TppLine;
    ppLine83: TppLine;
    ppLine128: TppLine;
    ppLine135: TppLine;
    ppLine223: TppLine;
    ppLine224: TppLine;
    ppLine225: TppLine;
    ppLine226: TppLine;
    ppLine227: TppLine;
    ppLine228: TppLine;
    ppDBText86: TppDBText;
    ppDBText87: TppDBText;
    ppDBText88: TppDBText;
    ppLabel44: TppLabel;
    ppLabel45: TppLabel;
    ppLine229: TppLine;
    ppRegion1: TppRegion;
    ppLine230: TppLine;
    ppLine231: TppLine;
    hzTabs: TPageControl;
    hzTab0: TTabSheet;
    Panel1: TPanel;
    ppLabel352: TppLabel;
    ppLabel46: TppLabel;
    ppLabel47: TppLabel;
    ppLabel48: TppLabel;
    ppLabel49: TppLabel;
    ppLabel50: TppLabel;
    pplabNoTillsTrad: TppLabel;
    pplabNoTillsLGsmall: TppLabel;
    pplabNoTillsLG: TppLabel;
    ppShape9: TppShape;
    ppShape10: TppShape;
    ppDBCalc6: TppDBCalc;
    procedure BitBtn1Click(Sender: TObject);
    procedure ppDBText16GetText(Sender: TObject; var Text: String);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ppDBText7Print(Sender: TObject);
    procedure ppSummaryBand2BeforePrint(Sender: TObject);
    procedure ppTradPreviewFormCreate(Sender: TObject);
    procedure ppDBText26GetText(Sender: TObject; var Text: String);
    procedure ppDBText9GetText(Sender: TObject; var Text: String);
    procedure FormCreate(Sender: TObject);
    procedure ppTradSummaryBand1BeforePrint(Sender: TObject);
    procedure btnLossGainClick(Sender: TObject);
    procedure ppDetailBand1BeforePrint(Sender: TObject);
    procedure ppDBText34GetText(Sender: TObject; var Text: String);
    procedure ppDetailBand3BeforePrint(Sender: TObject);
    procedure ppDBText60GetText(Sender: TObject; var Text: String);
    procedure ppDetailBand4BeforePrint(Sender: TObject);
    procedure ppRegion1Print(Sender: TObject);
    procedure hzTabsChange(Sender: TObject);
    procedure ppGroupHeaderBand3AfterPrint(Sender: TObject);
    procedure ppDetailBand2BeforePrint(Sender: TObject);
  private
    { Private declarations }
    lastPName : string;
    isGP : boolean;
  public
    { Public declarations }
    curTid : integer;
    stocks : array of integer;
    stkCodes, Division, TidName : string;
    err : boolean;
    repHZid, repHZPurch : smallint;
    repHZidStr, repHZName : string;
  end;

var
  fReps2: TfReps2;

implementation

uses uADO, udata1, ulog;

{$R *.dfm}

procedure TfReps2.BitBtn1Click(Sender: TObject);
begin
  try
    data1.ERRSTR1 := 'Gather Multi-Trad Report Data';
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select tname, division, isGP from threads where tid = ' + inttostr(curTid));
      open;

      TidName := FieldByName('tname').asstring;
      Division := FieldByName('division').asstring;
      isGP := (FieldByName('isGP').asstring = 'Y');
      close;
    end;

    with wwqTrad do
    begin
      data1.ERRSTR1 := 'Open Multi-Trad Report Query';
      close;
      sql.Clear;
      sql.Add('select a.[tid], a.[stockcode], a.[SDate], a.[Stime], a.[EDate], a.[ETime], a.[stkkind],');

      sql.Add('(CASE ');
      sql.Add('     WHEN b.[totinc] = 0 THEN b.[banked]');
      sql.Add('     ELSE (b.[totnetinc] * b.[banked] / b.[totinc])');
      sql.Add(' END) as NetTake,');

      sql.Add('(CASE ');
      sql.Add('     WHEN b.[totinc] = 0 THEN (7 * b.[banked] / b.[per])');
      sql.Add('     ELSE (7 * (b.[totnetinc] * b.[banked] / b.[totinc]) / b.[per])');
      sql.Add(' END) as wkTake,');

      sql.Add('(b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]) as totActCost,');

      sql.Add('(CASE ');
      sql.Add('     WHEN (b.[totConsVal] + b.[totRcpVar]) = 0 THEN NULL');
      sql.Add('     ELSE (100 * b.[banked] / (b.[totConsVal] + b.[extraInc]  + b.[totRcpVar]))');
      sql.Add(' END) as Yield,');

      sql.Add('(b.[totLGW] + b.[banked] - b.[totInc] + b.[miscBal1] + ');
      sql.Add('      b.[miscBal2] + b.[miscBal3] + b.[totawvalue]) as SResult,');

      sql.Add('(CASE ');
      sql.Add('     WHEN (b.[totConsVal] + b.[totRcpVar]) = 0 THEN NULL');
      sql.Add('     ELSE (100 * (b.[totLGW] + b.[banked] - b.[totInc] + b.[miscBal1] + b.[miscBal2] + b.[miscBal3]) / ');
      sql.Add('                   (b.[totConsVal] + b.[extraInc] + b.[totRcpVar]))');
      sql.Add(' END) as SRPerc,');

      sql.Add('(CASE ');
      sql.Add('     WHEN b.[totinc] = 0 THEN (b.[banked] - ');
      sql.Add('              (b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]))');
      sql.Add('     ELSE ((b.[totnetinc] * b.[banked] / b.[totinc]) - ');
      sql.Add('              (b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]))');
      sql.Add(' END) as GP,');

      if isGP then
      begin
        pplabel193.Caption := 'Actual GP%';
        sql.Add('(CASE ');
        sql.Add('  WHEN b.[banked] = 0 THEN NULL');
        sql.Add('  ELSE ');
        sql.Add('    (CASE ');
        sql.Add('      WHEN b.[totinc] = 0 THEN (100 - (100 * ');
        sql.Add('          ((b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]) / b.[banked])))');
        sql.Add('      ELSE (100 - (100 * ((b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]) ');
        sql.Add('                   / (b.[totnetinc] * b.[banked] / b.[totinc]))))');
        sql.Add('    END)');
        sql.Add(' END) as GPPerc,');
      end
      else
      begin
        pplabel193.Caption := 'Actual COS%';
        sql.Add('(CASE ');
        sql.Add('  WHEN b.[banked] = 0 THEN NULL');
        sql.Add('  ELSE ');
        sql.Add('    (CASE ');
        sql.Add('      WHEN b.[totinc] = 0 THEN (100 * ');
        sql.Add('           ((b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]) / b.[banked]))');
        sql.Add('      ELSE (100 * ((b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]) ');
        sql.Add('                    / (b.[totnetinc] * b.[banked] / b.[totinc])))');
        sql.Add('    END)');
        sql.Add(' END) as GPPerc,');
      end;

      sql.Add('(b.[totmovecost] + b.[totpurch]) as totPurchMove, b.*');
      sql.Add('from [stocks] a, [stkmisc] b');
      sql.Add('where a.[sitecode] = b.[sitecode]');
      sql.Add('and a.SiteCode = '+IntToStr(data1.repSite));
      sql.Add('and a.[tid] = b.[tid]');
      sql.Add('and a.[stockcode] = b.[stockcode]');
      sql.Add('and a.[tid] = ' + inttostr(curTid));
      sql.Add('and a.[stockcode] IN (' + stkCodes + ')');
      sql.Add('and b.hzid = ' + repHZidStr);
      sql.Add('order by SDate');
      open;

      pplabel129.Text := 'Division: ' + division;
      pplabel132.Text := 'Thread Name: ' + tidName;

      data1.ERRSTR1 := 'View/Print Multi-Trad Report';
      ppTrad.Print;

      close;
    end;
  except
    on E: exception do
    begin
      ShowMessage('ERROR trying to Print a Multi-Trad Report!' + #13 + 'Error Location: ' + data1.ERRSTR1 +
        #13 + 'Error Message: ' + E.Message);
      log.event('ERROR Printing Multi-Trad Rep - Err Loc: ' + data1.ERRSTR1 + ' Msg: ' + E.Message);
    end;
  end;
end;

procedure TfReps2.ppDBText16GetText(Sender: TObject; var Text: String);
var
  per2 : integer;
begin
  per2 := strtoint(text);
  Text := IntToStr(trunc(per2) div 7)+'/'+ IntToStr(trunc(per2) mod 7);// period
end;

procedure TfReps2.FormShow(Sender: TObject);
var
  i : integer;
  h1 : smallint;
  NewTab : TTabSheet;
begin
  self.Caption := 'Multiple ' + data1.SSplural + ' Reports';

  pplabel3.Caption := data1.SSbig + ' Results Report (Retail)';
  pplabel79.Caption := data1.SSbig + ' Results Report (Traditional)';

  pplabel16.Caption := data1.SSbig + ' Result';
  pplabel189.Caption := data1.SSbig + ' Result';

  pplabel35.Caption := 'Opening ' + data1.SS6 + ' Cost';
  pplabel36.Caption := data1.SSBig + ' On Hand Cost';

  if data1.UKUSmode = 'US' then
  begin
    pplabel11.Text := 'inc. Tax';
    pplabel19.Text := 'exc. Tax';
    pplabel184.Text := 'inc. Tax';
    pplabel192.Text := 'exc. Tax';
  end
  else
  begin
    pplabel11.Text := 'inc. VAT';
    pplabel19.Text := 'exc. VAT';
    pplabel184.Text := 'inc. VAT';
    pplabel192.Text := 'exc. VAT';
  end;  

  stkCodes := inttostr(Stocks[0]);
  for i := 1 to (High(Stocks)) do
  begin
    stkCodes := stkCodes + ',' + inttostr(Stocks[i]);
  end; // for..

  with dmADO.adoqRun do
  begin
    // are these stocks by HZ? If yes are they all "compatible" (i.e. same HZs)?
    // do a group by hzid and count the records. ALL hzid's that result should have the same count
    // as the number of stocks. If one of them has less (it cannot be more) then the stocks are
    // not compatible and the multi reports are only availalble in Full Site mode...
    close;
    sql.Clear;
    sql.Add('select hzid, count(stockcode) as thecount from stkmisc');
    sql.Add('where SiteCode = '+IntToStr(data1.repSite));
    sql.Add('and [tid] = ' + inttostr(curTid));
    sql.Add('and [stockcode] IN (' + stkCodes + ')');
    sql.Add('group by hzid');
    sql.Add('having count(stockcode) <> ' + inttostr(High(Stocks) + 1));
    open;

    if (recordcount = 0) or ((recordcount = 1) and (FieldByName('hzid').AsString = '')) then
    begin
      // all OK
      // BUT are there any HZ's at all? Above query could simply have been all stocks only having HZid = 0
      // so select all present HZids and see how many they are...
      close;
      sql.Clear;
      sql.Add('select hzid from stkmisc');
      sql.Add('where SiteCode = '+IntToStr(data1.repSite));
      sql.Add('and [tid] = ' + inttostr(curTid));
      sql.Add('and [stockcode] IN (' + stkCodes + ')');
      sql.Add('and hzid > 0 ');
      sql.Add('group by hzid');
      open;

      h1 := recordcount; // unique hzids

      if h1 = 0 then // all of them are by site, DO NOT showMessage....
      begin
        // DO NOT show the HZtabs...
        hzTabs.ActivePageIndex := 0;
        hzTabs.Visible := False;

        self.ClientHeight := 153;
      end
      else    // by HZid
      begin
        // but do all stocks involved have the same properties for the hzids (name, purch, sales)?

        close;
        sql.Clear;
        sql.Add('select distinct hzid, hzname, hzpurch, hzsales from stkmisc');
        sql.Add('where SiteCode = '+IntToStr(data1.repSite));
        sql.Add('and [tid] = ' + inttostr(curTid));
        sql.Add('and [stockcode] IN (' + stkCodes + ')');
        sql.Add('and hzid > 0 ');
        open;

        // if even one record is different on one attribute then this query will have more
        // records than the one above in which case only show by Site Wide...
        if recordcount = h1 then
        begin
          // show by HZ
          // use the HZtabs but first make them up...

          // use the query just opened above...
          h1 := 1;
          while not eof do
          begin
            NewTab := TTabSheet.Create(hzTabs);
            NewTab.PageControl := hzTabs;
            newTab.Tag := FieldByName('hzid').asinteger;
            newTab.PageIndex := h1;
            newTab.Caption := FieldByName('hzname').asstring;
            newTab.ImageIndex := -1;

            if FieldByName('hzsales').asboolean then
            begin
              if FieldByName('hzpurch').asboolean then
                newTab.ImageIndex := 2
              else
                newTab.ImageIndex := 0
            end
            else
            begin
              if FieldByName('hzpurch').asboolean then
                newTab.ImageIndex := 1;
            end;

            if FieldByName('hzpurch').asboolean then
              rephzPurch := FieldByName('hzid').asinteger;

            next;
            inc(h1);
          end;

          close;

          hzTabs.Visible := True;
          hzTabs.ActivePageIndex := 0;
        end
        else
        begin // show site only...
          // DO NOT show the HZtabs...
          showMessage('The selected ' + data1.SSplural + ' were all done by Holding Zone.'#13 +
            'But at least one Holding Zone changed properties (Name or Accept Purchases or Accept Sales)'#13 +
            'from one ' + data1.SSlow + ' to another.'#13#13 +
            'The only Multi-Reports that can be shown are for the Complete Site.');

          hzTabs.ActivePageIndex := 0;
          hzTabs.Visible := False;

          self.ClientHeight := 153;
        end;

      end;
    end
    else   // discrepancy in the number of hzids, only show site wide but tell the user...
    begin
      // DO NOT show the HZtabs...
      showMessage('Some of the selected ' + data1.SSplural + ' were done by Holding Zone.'#13 +
        'But at least one of them does not have the same Holding Zones as the others.'#13#13 +
        'The only Multi-Reports that can be shown are for the Complete Site.');

      hzTabs.ActivePageIndex := 0;
      hzTabs.Visible := False;

      self.ClientHeight := 153;
    end;

    close;
    repHZid := 0;
    repHZidStr := '0';
  end;
end;

procedure TfReps2.BitBtn2Click(Sender: TObject);
begin
  try
    with wwqRet do
    begin
      data1.ERRSTR1 := 'Gather Multi-Retail Report Data';
      close;
      sql.Clear;
      sql.Add('select tname, division, isGP from threads where tid = ' + inttostr(curTid));
      open;

      TidName := FieldByName('tname').asstring;
      Division := FieldByName('division').asstring;
      isGP := (FieldByName('isGP').asstring = 'Y');
      close;

      data1.ERRSTR1 := 'Open Multi-Retail Report Query';
      close;
      sql.Clear;
      sql.Add('select a.[tid], a.[stockcode], a.[SDate], a.[Stime], a.[EDate], a.[ETime], a.[stkkind],');

      sql.Add('(CASE ');
      sql.Add('     WHEN b.[totinc] = 0 THEN b.[banked]');
      sql.Add('     ELSE (b.[totnetinc] * b.[banked] / b.[totinc])');
      sql.Add(' END) as NetTake,');

      sql.Add('(CASE ');
      sql.Add('     WHEN b.[totinc] = 0 THEN (7 * b.[banked] / b.[per])');
      sql.Add('     ELSE (7 * (b.[totnetinc] * b.[banked] / b.[totinc]) / b.[per])');
      sql.Add(' END) as wkTake,');

      sql.Add('(b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]) as totActCost,');


      if cbSPprof.Checked then
      begin
        pplabel20.Text := 'Profit Variance used for ' + data1.SSbig + ' Result';

        // The lines below mean Profit Variance even if field says Cost Variance, fields named wrongly in StkMisk...
         // Yield % ProfVar formula summary: (Stock Result/Net Sales*100)+100
        sql.Add('(CASE  WHEN totnetinc = 0 THEN NULL');
        sql.Add('   ELSE ((b.[totCostVar] + b.[banked] - b.[totInc] + ');
        sql.Add('            b.[miscBal1] + b.[miscBal2] + b.[miscBal3]) / totnetinc * 100) + 100');
        sql.Add(' END) as Yield,');

        sql.Add('(b.[totCostVar] + b.[banked] - b.[totInc] + b.[miscBal1] + b.[miscBal2] + b.[miscBal3]) as SResult,');

        sql.Add('(CASE WHEN b.[totnetinc] = 0 THEN NULL');
        sql.Add('     ELSE (100 * (b.[totCostVar] + b.[banked] - b.[totInc] + ');
        sql.Add('                  b.[miscBal1] + b.[miscBal2] + b.[miscBal3]) / b.[totnetinc])');
        sql.Add(' END) as SRPerc,');
      end
      else
      begin
        pplabel20.Text := 'Cost Variance used for ' + data1.SSbig + ' Result';

        // The lines below mean Cost Variance - the fields are named wrongly in StkMisk...
         // Yield % CostVar formula summary: (Stock Result/Cost of Sales*100)+100
        sql.Add('(CASE  WHEN (b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]) = 0 THEN NULL');
        sql.Add('  ELSE ((b.[totProfVar] + b.[banked] - b.[totInc] + b.[miscBal1] + b.[miscBal2] + b.[miscBal3]) /');
        sql.Add('              (b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]) * 100) + 100');
        sql.Add(' END) as Yield,');

        sql.Add('(b.[totProfVar] + b.[banked] - b.[totInc] + b.[miscBal1] + b.[miscBal2] + b.[miscBal3]) as SResult,');

        sql.Add('(CASE WHEN b.[totnetinc] = 0 THEN NULL');
        sql.Add('     ELSE (100 * (b.[totProfVar] + b.[banked] - b.[totInc] + ');
        sql.Add('                  b.[miscBal1] + b.[miscBal2] + b.[miscBal3]) / b.[totnetinc])');
        sql.Add(' END) as SRPerc,');
      end;

      if isGP then
      begin
        pplabel32.Caption := 'Actual GP%';
        sql.Add('(CASE ');
        sql.Add('  WHEN b.[banked] = 0 THEN NULL');
        sql.Add('  ELSE ');
        sql.Add('    (CASE ');
        sql.Add('      WHEN b.[totinc] = 0 THEN (100 - (100 * ');
        sql.Add('          ((b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]) / b.[banked])))');
        sql.Add('      ELSE (100 - (100 * ((b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]) / ');
        sql.Add('           (b.[totnetinc] * b.[banked] / b.[totinc]))))');
        sql.Add('    END)');
        sql.Add(' END) as GPPerc,');
      end
      else
      begin
        pplabel32.Caption := 'Actual COS%';
        sql.Add('(CASE ');
        sql.Add('  WHEN b.[banked] = 0 THEN NULL');
        sql.Add('  ELSE ');
        sql.Add('    (CASE ');
        sql.Add('      WHEN b.[totinc] = 0 THEN (100 * ');
        sql.Add('          ((b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]) / b.[banked]))');
        sql.Add('      ELSE (100 * ((b.[totopcost] + b.[totpurch] + b.[totMoveCost] - b.[totclosecost]) / ');
        sql.Add('            (b.[totnetinc] * b.[banked] / b.[totinc])))');
        sql.Add('    END)');
        sql.Add(' END) as GPPerc,');
      end;


      sql.Add('(b.[totmovecost] + b.[totpurch]) as totPurchMove, b.*');
      sql.Add('from [stocks] a, [stkmisc] b');
      sql.Add('where a.[sitecode] = b.[sitecode]');
      sql.Add('and a.SiteCode = '+IntToStr(data1.repSite));
      sql.Add('and a.[tid] = b.[tid]');
      sql.Add('and a.[stockcode] = b.[stockcode]');
      sql.Add('and a.[tid] = ' + inttostr(curTid));
      sql.Add('and a.[stockcode] IN (' + stkCodes + ')');
      sql.Add('and b.hzid = ' + repHZidStr);
      sql.Add('order by SDate');
      open;

      pplabel8.Text := 'Division: ' + division;
      pplabel9.Text := 'Thread Name: ' + tidName;

      err := False;

      data1.ERRSTR1 := 'View/Print Multi-Retail Report';
      ppRet.Print;

      close;
    end;
  except
    on E: exception do
    begin
      ShowMessage('ERROR trying to Print a Multi-Retail Report!' + #13 + 'Error Location: ' + data1.ERRSTR1 +
        #13 + 'Error Message: ' + E.Message);
      log.event('ERROR Printing Multi-Retail Rep - Err Loc: ' + data1.ERRSTR1 + ' Msg: ' + E.Message);
    end;
  end;
end;


procedure TfReps2.ppDetailBand2BeforePrint(Sender: TObject);
begin
  ppshape9.Brush.Color := $c0ffff;
end;


procedure TfReps2.ppDBText7Print(Sender: TObject);
begin
  if abs(ppdbtext7.FieldValue - ppdbtext31.FieldValue) >= 5 then
  begin
    ppdbtext7.Font.Style := [fsUnderline];
    err := True;
  end
  else
  begin
    ppdbtext7.Font.Style := [];
  end;
end;

procedure TfReps2.ppSummaryBand2BeforePrint(Sender: TObject);
begin
  pplabel18.Caption := '';
  if (err) then
  begin
    pplabel18.Caption := 'NOTE: Underlined "Cost of Sales" figures mean that the Cost of Sales calculated as the sum of COS for all retail items ' +
      'is different from the ' + data1.SSbig + ' Opening Cost + Purchases Cost - ' + data1.SSbig + ' Closing Cost! (Cumulative Error:' +
      formatfloat(currencyString + '#,0.00', ppDBCalc24.Value - ppDBCalc15.Value) + ')';
  end;

  // fill the Yield, Stock Result % and GP% labels

  if cbSPprof.Checked then
  begin
    if ppDBCalc6.Value = 0 then
      ppLabel24.caption := '-----'
    else                                            // Stock Result     NetInc
      ppLabel24.Caption := formatfloat('0.00', (ppDBCalc19.Value / ppDBCalc6.Value * 100) + 100); // profVar Yield %.
  end
  else
  begin
    if ppDBCalc15.Value = 0 then
      ppLabel24.caption := '-----'
    else                                            //   Stock Result    ActCOS
      ppLabel24.Caption := formatfloat('0.00', (ppDBCalc19.Value / ppDBCalc15.Value * 100) + 100); // costVar Yield %.
  end;

  if ppDBCalc6.Value = 0 then
  begin
    ppLabel25.caption := '-----';
  end
  else
  begin
    ppLabel25.Caption := formatfloat('0.00', 100 * ppDBCalc19.Value / ppDBCalc6.Value); // StkRes%
  end;

  if ppDBCalc9.Value = 0 then
    ppLabel26.caption := '-----'
  else
    if isGP then
      ppLabel26.Caption := formatfloat('0.00', 100 - (100 * ppDBCalc15.Value / ppDBCalc9.Value)) // GP%
    else
      ppLabel26.Caption := formatfloat('0.00', (100 * ppDBCalc15.Value / ppDBCalc9.Value)); // COS%

  // calcualte opening cost for summary
  pplabel72.Caption := formatfloat(currencyString + '#,0.00', ppDBCalc15.Value - ppDBCalc17.Value + ppdbtext71.FieldValue);

  if ppDBCalc3.Value = 0 then
    ppLabel50.caption := '-----'
  else
    ppLabel50.Caption := formatfloat(currencyString + '#,0.00', (7 * ppDBCalc9.Value / ppDBCalc3.Value)); // weekly takings

  ppshape10.Brush.Color := $c0FFFF;

end;

procedure TfReps2.ppTradPreviewFormCreate(Sender: TObject);
begin
  dmADO.ALLRepsPreviewFormCreate(Sender, data1.repPaperName);
end;

procedure TfReps2.ppDBText26GetText(Sender: TObject; var Text: String);
begin
  if Text = '' then
    Text := '----';
end;

procedure TfReps2.ppDBText9GetText(Sender: TObject; var Text: String);
begin
  if Text = '' then
    Text := '----';
end;

procedure TfReps2.FormCreate(Sender: TObject);
begin
  ppTrad.PrinterSetup.PaperName := data1.repPaperName;
  ppRet.PrinterSetup.PaperName := data1.repPaperName;
  ppLG.PrinterSetup.PaperName := data1.repPaperName;
  ppLGsmall.PrinterSetup.PaperName := data1.repPaperName;

  if data1.noTillsOnSite then
  begin
    rbCost.Checked := TRUE;
    bitBtn2.Visible := FALSE;
    radiobutton1.Visible := FALSE;
    cbSPprof.Visible := FALSE;
    bevel1.Visible := FALSE;
    rbCost.Visible := FALSE;
    rbPrice.Visible := FALSE;
    rbBoth.Visible := FALSE;

    pplabNoTillsTrad.Visible := TRUE;
    pplabNoTillsLG.Visible := TRUE;
    pplabNoTillsLGsmall.Visible := TRUE;
  end;
end;

procedure TfReps2.ppTradSummaryBand1BeforePrint(Sender: TObject);
begin
  // fill the Yield, Stock Result % and GP% labels

  if (ppDBCalc18.Value + ppDBCalc20.Value) = 0 then
  begin
    ppLabel27.caption := '-----';
    ppLabel28.caption := '-----';
  end
  else
  begin
    ppLabel27.Caption := formatfloat('0.00', 100 * ppDBCalc2.Value / (ppDBCalc18.Value + ppDBCalc20.Value)); // Yield.
    ppLabel28.Caption := formatfloat('0.00', 100 * ppDBCalc10.Value / (ppDBCalc18.Value + ppDBCalc20.Value)); // StkRes%
  end;

  if ppDBCalc5.Value = 0 then
    ppLabel29.caption := '-----'
  else
    if isGP then
      ppLabel29.Caption := formatfloat('0.00', 100 - (100 * ppDBCalc7.Value / ppDBCalc5.Value)) // GP%
    else
      ppLabel29.Caption := formatfloat('0.00', (100 * ppDBCalc7.Value / ppDBCalc5.Value)); // COS%

  if ppDBCalc1.Value = 0 then
    ppLabel49.caption := '-----'
  else
    ppLabel49.Caption := formatfloat(currencyString + '#,0.00', (7 * ppDBCalc5.Value / ppDBCalc1.Value)); // weekly takings

end;

procedure TfReps2.btnLossGainClick(Sender: TObject);
var
  sstocks, noOfStocks : string;
begin
  try
    lastPName := '';
    // prepare dataset for report
    with dmADO.adoqRun do
    begin
      data1.ERRSTR1 := 'Gather Multi-LG Report Data';
      close;
      sql.Clear;
      sql.Add('select tname, division from threads where tid = ' + inttostr(curTid));
      open;

      TidName := FieldByName('tname').asstring;
      Division := FieldByName('division').asstring;
      close;

      // prepare string with the stocks involved...
      data1.ERRSTR1 := 'Gather Multi-LG Report Data 2';
      close;
      sql.Clear;
      sql.Add('select "sdate", "edate", [StkKind],');
      sql.Add('(CAST(((FLOOR(CAST(([edate] - [sdate] + 1) AS int))) / 7) AS VARCHAR) + ''/'' +');
      sql.Add('  CAST(((FLOOR(CAST(([edate] - [sdate] + 1) AS int))) % 7) AS VARCHAR)) as period');
      sql.Add('from [stocks]');
      sql.Add('where SiteCode = '+IntToStr(data1.repSite));
      sql.Add('and [tid] = ' + inttostr(curTid));
      sql.Add('and [stockcode] IN (' + stkCodes + ')');
      open;

      noOfStocks := inttostr(recordcount);
      sstocks := '';
      while not eof do
      begin
        sstocks := sstocks + inttostr(recno) + ')' +
          '  From: ' + formatDateTime('ddddd', FieldByName('sdate').asdatetime) +
          '  --  To: ' + formatDateTime('ddddd', FieldByName('edate').asdatetime) +
          '      Period: ' + FieldByName('period').asstring +
          '      Kind: ' + FieldByName('stkkind').asstring + #13;
        next;
      end;

      close;

      // "release" #ghost if used...
      data1.ERRSTR1 := 'Gather Multi-LG Report Data 3';
      dmADO.DelSQLTable('#LGghost');

      // get all the required numbers for all the stocks involved and dump them in ghost
      // to be summed up later...

      close;
      sql.Clear;
      sql.Add('select b."tid", b."stkcode", b."entitycode", b."PurchUnit",');
      sql.Add('(CASE');
      sql.Add('  WHEN (b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) < 0 THEN 0');
      sql.Add('  ELSE ((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) / b."PurchBaseU")');
      sql.Add(' END) as sq,');

      sql.Add('(CASE');
      sql.Add('  WHEN (b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) >= 0 THEN 0');
      sql.Add(' ELSE (-1 * (b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) / b."PurchBaseU")');
      sql.Add(' END) as dq,');

      sql.Add('((((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) + ');
      sql.Add(' Abs(b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty)) / 2) * b.NomPrice) as sv,');

      sql.Add('((((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) + ');
      sql.Add(' Abs(b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty)) / 2) * b.ActRedCost) as sc,');

      sql.Add('((((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) - ');
      sql.Add(' Abs(b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty)) / -2) * b.NomPrice) as dv,');

      sql.Add('((((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) - ');
      sql.Add(' Abs(b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty)) / -2) * b.ActRedCost) as dc,');

      sql.Add('b.ActRedQty, (b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) as lgPurchU,');

      sql.Add('(b."wastage" / b."PurchBaseU") as Wq,');
      sql.Add('(b."wastage" * b."ActRedCost") as Wc,');
      sql.Add('(b."wastage" * b."NomPrice") as Wv,');
      sql.Add('b."wastage",');

      sql.Add('((b.SoldQty - b.ActRedQty - b.PrepRedQty) * b.NomPrice) as totv,');
      sql.Add('((b.SoldQty - b.ActRedQty - b.PrepRedQty) * b.ActRedCost) as totc,');

      sql.Add('(CASE');
      sql.Add('  WHEN ((b.ActRedQty + b.PrepRedQty) = 0) THEN 100');
      sql.Add('  ELSE (b.SoldQty / (b.ActRedQty + b.PrepRedQty) * 100)');
      sql.Add('END) as Yield, b.SiteCode');

      sql.Add('INTO [#LGghost]');

      sql.Add('from [stkMain] b');
      sql.Add('where b.SiteCode = '+IntToStr(data1.repSite));
      sql.Add('and b.[tid] = ' + inttostr(curTid));
      sql.Add('and b.[stkcode] IN (' + stkCodes + ')');
      sql.Add('and ((ABS((b.SoldQty + b.Wastage - b.ActRedQty - b.PrepRedQty) / b."PurchBaseU") >= 0.001)');
      sql.Add('        or (ABS(b."wastage") >= 0.001))');
      sql.Add('and b.hzid = ' + repHZidStr);
      sql.Add('and b."key2" < 1000');

      execSQL;
    end;

    // now do the report query itself..
    with adoqLG do
    begin
      data1.ERRSTR1 := 'Open Multi-LG Report Query';
      close;
      sql.Clear;
      if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
        sql.Add('SELECT (a."SCat") as SubCatName,')
      else
        sql.Add('SELECT (a."Cat") as SubCatName,');

      sql.Add('b."entitycode", a.PurchaseName, b."PurchUnit",');
      sql.Add('sum(b."sq") as sq, sum(b."dq") as dq, sum(b."sv") as sv, sum(b."sc") as sc,');
      sql.Add('sum(b."dv") as dv, sum(b."dc") as dc,');

      sql.Add('(CASE');
      sql.Add('  WHEN (sum(b.ActRedQty) = 0) THEN NULL');
      sql.Add('  ELSE (sum(b.lgpurchU) / sum(b.ActRedQty) * 100)');
      sql.Add('END) as spc,');

      sql.Add('sum(b."wq") as wq, sum(b."wc") as wc, sum(b."wv") as wv,');

      sql.Add('(CASE');
      sql.Add('  WHEN (sum(b.ActRedQty) = 0) THEN NULL');
      sql.Add('  ELSE (sum(b.wastage) / sum(b.ActRedQty) * 100)');
      sql.Add('END) as wpc,');

      sql.Add('sum(b."totv") as totv, sum(b."totc") as totc, avg(b.Yield) as Yield');
      sql.Add('FROM "stkEntity" a, "#LGghost" b');
      sql.Add('WHERE a."entitycode" = b."entitycode"');

      if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
      begin
        sql.Add('group By a."SCat", b."entitycode", a."PurchaseName", b."PurchUnit"');
        sql.Add('Order By a."SCat", a."PurchaseName", b."PurchUnit"');
      end
      else
      begin
        sql.Add('group By a."Cat", b."entitycode", a."PurchaseName", b."PurchUnit"');
        sql.Add('Order By a."Cat", a."PurchaseName", b."PurchUnit"');
      end;

      open;

    end;

    // datasets ready

    // now decide which report to show and set data fields and labels...
    if adoqLG.RecordCount = 0 then
    begin
      showmessage('There are no Losses or Gains to report.');
    end
    else
    begin
      if rbBoth.Checked then
      begin
        ppLabel40.Caption := data1.SSplural + ' involved: ' + noOfStocks;
        ppMemo1.Text := sstocks;
        pplabel39.Text := 'Header: ' + data1.repHdr;
        pplabel38.Text := 'Thread Name: ' + TidName;
        pplabel42.Text := 'Division: ' + division;
        pplabel30.Text := 'Summed ' + data1.SSplural + ' Loss/Gain Report';
        pplabel37.Text := 'List of ' + data1.SSplural + ' involved in this report:';

        // now do the detail query
        data1.ERRSTR1 := 'Open Multi-LG Report Detail Query';
        adoqLGDetail.open;

        data1.ERRSTR1 := 'View/Print Multi-LG Report';
        ppLG.Print;
        adoqLGDetail.close;
      end
      else
      begin
        ppLabel60.Caption := data1.SSplural + ' involved: ' + noOfStocks;
        ppMemo2.Text := sstocks;
        pplabel64.Text := 'Header: ' + data1.repHdr;
        pplabel70.Text := 'Thread Name: ' + TidName;
        pplabel74.Text := 'Division: ' + division;
        pplabel69.Text := 'List of ' + data1.SSplural + ' involved in this report:';
        if rbPrice.Checked then
        begin
          data1.ERRSTR1 := ' (Val)';
          pplabel84.Text := 'Value';
          ppdbtext61.DataField := 'sv';
          ppdbtext63.DataField := 'dv';
          ppdbtext66.DataField := 'Wv';
          ppdbtext68.DataField := 'totv';
          pplabel65.Text := 'Summed ' + data1.SSplural + ' Loss/Gain Value Report';
        end
        else
        begin
          data1.ERRSTR1 := ' (Cost)';
          pplabel84.Text := 'Cost';
          ppdbtext61.DataField := 'sc';
          ppdbtext63.DataField := 'dc';
          ppdbtext66.DataField := 'Wc';
          ppdbtext68.DataField := 'totc';
          pplabel65.Text := 'Summed ' + data1.SSplural  + ' Loss/Gain Cost Report';
        end;

        ppDBCalc49.DataField  := ppdbtext61.DataField; // Surplus Summs
        ppDBCalc43.DataField := ppdbtext61.DataField;

        ppDBCalc50.DataField := ppdbtext63.DataField; // Deficit Summs
        ppDBCalc44.DataField := ppdbtext63.DataField;

        ppDBCalc51.DataField := ppdbtext66.DataField; // Wastage Summs
        ppDBCalc46.DataField := ppdbtext66.DataField;

        ppDBCalc48.DataField := ppdbtext68.DataField; // Total Summs
        ppDBCalc42.DataField := ppdbtext68.DataField;

        pplabel93.Text := pplabel84.Text;
        pplabel88.Text := pplabel84.Text;
        pplabel85.Text := 'Total ' + pplabel84.Text;

        data1.ERRSTR1 := 'View/Print Multi-LG Report' + data1.ERRSTR1;
        ppLGsmall.Print;
      end;
    end;
    adoqLG.Close;
  except
    on E: exception do
    begin
      ShowMessage('ERROR trying to Print a Multi-Loss Gain Report!' + #13 + 'Error Location: ' + data1.ERRSTR1 +
        #13 + 'Error Message: ' + E.Message);
      log.event('ERROR Printing Multi-LG Rep - Err Loc: ' + data1.ERRSTR1 + ' Msg: ' + E.Message);
    end;
  end;
end;

procedure TfReps2.ppDetailBand1BeforePrint(Sender: TObject);
begin
  if ppdbText32.Text = lastPName then
  begin
    pplabel62.Visible := True;
  end
  else
  begin
    pplabel62.Visible := False;
    lastPName := ppdbText32.Text;
  end;

  ppDBText43.Visible := (ppDBText43.FieldValue > 0);
  ppDBText34.Visible := (ppDBText34.FieldValue > 0);

  ppDBText41.Visible := ppDBText34.Visible;
  ppDBText42.Visible := ppDBText34.Visible;
  ppDBText44.Visible := ppDBText43.Visible;
  ppDBText45.Visible := ppDBText43.Visible;
end;

procedure TfReps2.ppDBText34GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText33.Text,Text);
end;

procedure TfReps2.ppDetailBand3BeforePrint(Sender: TObject);
begin
  if ppdbText56.Text = lastPName then
  begin
    pplabel71.Visible := True;
  end
  else
  begin
    pplabel71.Visible := False;
    lastPName := ppdbText56.Text;
  end;

  ppDBText60.Visible := (ppDBText60.FieldValue > 0);
  ppDBText62.Visible := (ppDBText62.FieldValue > 0);

  ppDBText61.Visible := ppDBText60.Visible;
  ppDBText63.Visible := ppDBText62.Visible;
end;

procedure TfReps2.ppDBText60GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText57.Text,Text);
end;

procedure TfReps2.ppDetailBand4BeforePrint(Sender: TObject);
begin
  ppDBText73.Visible := (ppDBText73.FieldValue > 0);
  ppDBText76.Visible := (ppDBText76.FieldValue > 0);

  ppDBText74.Visible := ppDBText73.Visible;
  ppDBText75.Visible := ppDBText73.Visible;
  ppDBText77.Visible := ppDBText76.Visible;
  ppDBText78.Visible := ppDBText76.Visible;

end;

procedure TfReps2.ppRegion1Print(Sender: TObject);
begin
  if pplg.DeviceType = 'Printer' then
  begin
    ppregion1.Brush.Color := $00FFFFFF; // this is white clWhite;
  end
  else
  begin
    ppregion1.Brush.Color := $0000FFFF; //  clYellow;
  end;
end;

procedure TfReps2.hzTabsChange(Sender: TObject);
begin
  repHZid := hzTabs.ActivePage.Tag;
  repHZidStr := inttostr(repHZid);
  repHZName := hzTabs.ActivePage.Caption;

  bitBtn2.Enabled := ((hzTabs.ActivePage.ImageIndex = 0) or (hzTabs.ActivePage.ImageIndex = 2) or (repHzid = 0));
  radiobutton1.Enabled := bitBtn2.Enabled;
  cbSPprof.Enabled := bitBtn2.Enabled;

  if repHZid = 0 then
  begin
    ppLabel352.Visible := False;
    pplabel187.Caption := 'Purchases   Cost';
  end
  else
  begin
    ppLabel352.Visible := True;
    ppLabel352.Caption := 'For Holding Zone: ' + repHZname;
    if repHZid = repHZpurch then
      pplabel187.Caption := 'Purchases & Transfers Cost'
    else
      pplabel187.Caption := ' Transfers   Cost';
  end;

  ppLabel46.Visible := ppLabel352.Visible;
  ppLabel47.Visible := ppLabel352.Visible;
  ppLabel48.Visible := ppLabel352.Visible;
  ppLabel46.Caption := ppLabel352.Caption;
  ppLabel47.Caption := ppLabel352.Caption;
  ppLabel48.Caption := ppLabel352.Caption;
  ppLabel14.Caption := ppLabel187.Caption;
end;

procedure TfReps2.ppGroupHeaderBand3AfterPrint(Sender: TObject);
begin
  lastPName := '';
end;

end.
