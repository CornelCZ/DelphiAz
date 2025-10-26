unit uLC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, ADODB, Grids, Wwdbigrd,
  Wwdbgrid, RxCalc, wwDialog, Wwlocate, DB, Wwdatsrc, Wwkeycb, DateUtil,
  ppComm, ppRelatv, ppProd, ppClass, ppReport, ppDB, ppBands, ppCtrls,
  ppVar, ppPrnabl, ppCache, ppDBPipe, ppDBBDE, DBCtrls, DateUtils, wwdblook,
  ppSubRpt, ppStrtch, ppRegion, ppDevice, ppMemo, uGlobals;

type
  TfLC = class(TForm)
    pnlThread: TPanel;
    pnlProds: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    wwFind: TwwLocateDialog;
    Label9: TLabel;
    wwIncrementalSearch2: TwwIncrementalSearch;
    wwDBGrid1: TwwDBGrid;
    Bevel3: TBevel;
    Label11: TLabel;
    Label13: TLabel;
    lookCat: TComboBox;
    Label14: TLabel;
    lookSCat: TComboBox;
    cbAWonly: TCheckBox;
    adoqRun: TADOQuery;
    dsProds: TwwDataSource;
    adotProds: TADOTable;
    adoqThreads: TADOQuery;
    dsThreads: TwwDataSource;
    wwDBGrid2: TwwDBGrid;
    BitBtn11: TBitBtn;
    btnNext: TBitBtn;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn19: TBitBtn;
    BitBtn20: TBitBtn;
    BitBtn21: TBitBtn;
    lblSelectStatus1: TLabel;
    adoqCount: TADOQuery;
    dsCount: TwwDataSource;
    pipeCount: TppBDEPipeline;
    ppCount: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppShape3: TppShape;
    ppLabel3: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel12: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText12: TppDBText;
    ppSystemVariable3: TppSystemVariable;
    ppLine24: TppLine;
    ppDetailBand1: TppDetailBand;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText5: TppDBText;
    ppDBText11: TppDBText;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppLine8: TppLine;
    ppLine10: TppLine;
    ppLine16: TppLine;
    ppLine17: TppLine;
    ppLine18: TppLine;
    ppLine85: TppLine;
    ppSummaryBand1: TppSummaryBand;
    ppShape1: TppShape;
    ppLabel13: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppDBText20: TppDBText;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppLabel28: TppLabel;
    ppLabel29: TppLabel;
    ppLine62: TppLine;
    ppLine63: TppLine;
    ppLine64: TppLine;
    ppLine65: TppLine;
    ppLine66: TppLine;
    ppLine72: TppLine;
    ppLine74: TppLine;
    ppLine75: TppLine;
    ppLine76: TppLine;
    ppLine77: TppLine;
    ppLabel35: TppLabel;
    ppLine78: TppLine;
    ppLine84: TppLine;
    ppLabel24: TppLabel;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLine11: TppLine;
    ppLine12: TppLine;
    ppLine13: TppLine;
    ppLine15: TppLine;
    ppLine19: TppLine;
    ppLine20: TppLine;
    ppLine21: TppLine;
    ppLine22: TppLine;
    ppLine31: TppLine;
    BitBtn3: TBitBtn;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    pnlHZ: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    pnlHZprods: TPanel;
    lblHZname: TLabel;
    Image1: TImage;
    comboHZ: TComboBox;
    Panel1: TPanel;
    BitBtn14: TBitBtn;
    BitBtn10: TBitBtn;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    adoqLG: TADOQuery;
    dsLG: TDataSource;
    pipeLG: TppDBPipeline;
    ppLGsmall: TppReport;
    ppHeaderBand3: TppHeaderBand;
    ppShape4: TppShape;
    ppLabel65: TppLabel;
    ppLabel66: TppLabel;
    ppLabel67: TppLabel;
    ppLabel68: TppLabel;
    ppLabel73: TppLabel;
    ppSystemVariable6: TppSystemVariable;
    ppDBText41: TppDBText;
    ppDBText42: TppDBText;
    ppDBText43: TppDBText;
    ppSystemVariable7: TppSystemVariable;
    ppLine86: TppLine;
    ppDetailBand3: TppDetailBand;
    ppDBText44: TppDBText;
    ppDBText45: TppDBText;
    ppDBText46: TppDBText;
    ppDBText55: TppDBText;
    ppLine87: TppLine;
    ppLine90: TppLine;
    ppLine91: TppLine;
    ppLine92: TppLine;
    ppLine101: TppLine;
    ppLine105: TppLine;
    ppLine106: TppLine;
    ppLine3: TppLine;
    ppDBText1: TppDBText;
    ppDBText4: TppDBText;
    ppFooterBand3: TppFooterBand;
    ppSummaryBand3: TppSummaryBand;
    ppShape12: TppShape;
    ppLabel78: TppLabel;
    ppLine171: TppLine;
    ppDBCalc38: TppDBCalc;
    ppLabel4: TppLabel;
    ppLine5: TppLine;
    ppMemo1: TppMemo;
    ppGroup3: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppDBText56: TppDBText;
    ppLabel81: TppLabel;
    ppLabel82: TppLabel;
    ppLabel86: TppLabel;
    ppLine110: TppLine;
    ppLine111: TppLine;
    ppLine112: TppLine;
    ppLine113: TppLine;
    ppLine115: TppLine;
    ppLine117: TppLine;
    ppLine119: TppLine;
    ppLabel90: TppLabel;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppLabel15: TppLabel;
    ppLine4: TppLine;
    ppLabel2: TppLabel;
    ppLabel19: TppLabel;
    ppLabel21: TppLabel;
    ppGroupFooterBand3: TppGroupFooterBand;
    ppShape11: TppShape;
    ppLabel96: TppLabel;
    ppDBText57: TppDBText;
    ppLine163: TppLine;
    ppDBCalc15: TppDBCalc;
    ppLine9: TppLine;
    ppLmid1: TppLabel;
    ppLmid2: TppLabel;
    pplDiv: TppLabel;
    pplRight2: TppLabel;
    pplHeader: TppLabel;
    ppLabel1: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    LCconn: TADOConnection;
    adoqLock: TADOQuery;
    lblNoHZs: TLabel;
    adoqThreadstid: TSmallintField;
    adoqThreadstname: TStringField;
    adoqThreadsdivision: TStringField;
    adoqThreadsbyHZ: TIntegerField;
    adoqThreadsbaseDT: TDateTimeField;
    adoqThreadsbaseBsDate: TDateTimeField;
    adoqThreadsdozForm: TStringField;
    adoqThreadsgallForm: TStringField;
    lblSelectStatus2: TLabel;
    ppLabelPrepItem: TppLabel;
    ppDBText6: TppDBText;
    ppLine14: TppLine;
    ppLine23: TppLine;
    ppLabel16: TppLabel;
    ppLabel14: TppLabel;
    ppLine25: TppLine;
    ppLine26: TppLine;
    ppLine27: TppLine;
    pipeLocationCount: TppBDEPipeline;
    ppLocationCount: TppReport;
    ppHeaderBand4: TppHeaderBand;
    ppLine99: TppLine;
    ppDetailBand7: TppDetailBand;
    ppDBText48: TppDBText;
    ppDBText49: TppDBText;
    ppDBText51: TppDBText;
    ppLine100: TppLine;
    ppLine28: TppLine;
    ppLine29: TppLine;
    ppLine107: TppLine;
    ppLine108: TppLine;
    ppLine30: TppLine;
    ppLocationsTot: TppDBText;
    ppLine118: TppLine;
    ppDBText50: TppDBText;
    ppFooterBand2: TppFooterBand;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppLabel69: TppLabel;
    ppLabel70: TppLabel;
    ppLabel71: TppLabel;
    ppLine34: TppLine;
    ppLine35: TppLine;
    ppLine120: TppLine;
    ppLine122: TppLine;
    ppLine123: TppLine;
    ppLine125: TppLine;
    ppLabel34: TppLabel;
    ppLine126: TppLine;
    ppLabel74: TppLabel;
    ppLine116: TppLine;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppLine129: TppLine;
    adoqLocationCount: TADOQuery;
    dsLocationCount: TwwDataSource;
    ppGroup4: TppGroup;
    ppGroupHeaderBand4: TppGroupHeaderBand;
    ppGroupFooterBand4: TppGroupFooterBand;
    ppLine36: TppLine;
    ppLine37: TppLine;
    ppLine38: TppLine;
    ppDBText13: TppDBText;
    ppShape2: TppShape;
    ppDBText14: TppDBText;
    ppShape5: TppShape;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel20: TppLabel;
    ppLabel22: TppLabel;
    ppLabel23: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText15: TppDBText;
    ppSystemVariable4: TppSystemVariable;
    ppLabel27: TppLabel;
    ppLabel30: TppLabel;
    ppLabel31: TppLabel;
    ppLabel32: TppLabel;
    ppLine40: TppLine;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure adoqThreadsAfterScroll(DataSet: TDataSet);
    procedure BitBtn10Click(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure wwDBGrid1CalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure wwDBGrid1TitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure lookCatCloseUp(Sender: TObject);
    procedure lookSCatCloseUp(Sender: TObject);
    procedure cbAWonlyClick(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure ppCountPreviewFormCreate(Sender: TObject);
    procedure ppHeaderBand1BeforePrint(Sender: TObject);
    procedure ppDBText11GetText(Sender: TObject; var Text: String);
    procedure wwDBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn18Click(Sender: TObject);
    procedure wwDBGrid1Exit(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure adotProdsAfterPost(DataSet: TDataSet);
    procedure BitBtn3Click(Sender: TObject);
    procedure wwDBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure ppDetailBand3BeforePrint(Sender: TObject);
    procedure ppDBText46GetText(Sender: TObject; var Text: String);
    procedure ppLGsmallPreviewFormCreate(Sender: TObject);
    procedure ppDBText5GetText(Sender: TObject; var Text: String);
    procedure adoqThreadsbyHZGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure adotProdsBeforePost(DataSet: TDataSet);
    procedure adotProdsAfterOpen(DataSet: TDataSet);
    procedure ppGroupHeaderBand4BeforePrint(Sender: TObject);
    procedure ppDBText50GetText(Sender: TObject; var Text: String);
    procedure ppHeaderBand4BeforePrint(Sender: TObject);
    procedure ppDetailBand7BeforePrint(Sender: TObject);
    procedure ppGroupHeaderBand2BeforePrint(Sender: TObject);
  private
    { Private declarations }
    dt1 : tdatetime;

    baseDT, LCDT : TDateTime;
    theDiv, curTidName : string;

    curTid, lastLCID,
    availTempl, curTempl, selectedProds : integer;

    wasECLinvalid : boolean;

    // filters
      fillCat, fillSCat, awGridFilt, awOnlyFilt : string;  // ---- choose products

      procedure SetGridFilt;
    // end of filters

    procedure ViewPanel(thePanel: TPanel);
    function getLockTableName: String;
  public
    { Public declarations }

    curLCblind, curLChasYieldTemplate : boolean;
    curLCYieldTemplate : integer;

    curLCtext : string;
    curHZid : integer;
    theHZs : array[0..15] of integer;
    theHZimg : array[0..15] of integer;
    curHZName : string;
    curHZeSales, curHZePur : boolean;

    procedure PostAuditCalc;
    procedure PrintRep;
    procedure StoreLC;
  end;

var
  fLC: TfLC;

implementation

uses udata1, uADO, ulog, uAudit, uLCTempl, dRunSP, uNewAudit, uLineCheckComment, uAztecDatabaseUtils, Math,
  uAuditLocations;

{$R *.dfm}

const
  // base name for the table used to ensure mutex - this should be accessed via the getLockTableName function, which
  // appends the database's unique DB_ID
  LOCK_TABLE : String = '##stkLock_LC';

procedure TfLC.ViewPanel(thePanel: TPanel);
begin
  pnlThread.Visible := false;
  pnlProds.Visible := false;

  // make this panel visible
  thePanel.Visible := True;
  thePanel.Top := 0;
  thePanel.Left := 0;
  self.HelpContext := thePanel.HelpContext;

  // resize form
  self.ClientHeight := thepanel.Height;
  self.ClientWidth := thepanel.Width;
  self.Left := (screen.WorkAreaWidth div 2) - (self.Width div 2);
  self.Top := (screen.WorkAreaHeight div 2) - (self.Height div 2);

  Application.ProcessMessages;
end; // procedure..

procedure TfLC.FormCreate(Sender: TObject);
begin
  pnlThread.Visible := false;
  pnlProds.Visible := false;

  curTempl := -1;

  SetUpAztecADOConnection(lcConn);

  ppLabelPrepItem.Width := 3.0521;
end;

procedure TfLC.btnCancelClick(Sender: TObject);
begin // go away...
  self.ModalResult := mrCancel;
end;

procedure TfLC.adoqThreadsAfterScroll(DataSet: TDataSet);
begin
  baseDT := adoqThreads.FieldByName('baseDT').asdatetime;
  lblNoHZs.Visible := False;

  if pnlHZ.Visible then
  begin
    if (adoqThreads.FieldByName('byHZ').asinteger = 1) then
    begin
      if data1.siteUsesHZs then // all OK with HZs, allow user to choose the HZ
      begin
        if wasECLinvalid then  // no LC allowed, show RED label...
        begin
          lblNoHZs.Caption := 'Line Checks cannot be done for Division "' +
            adoqThreads.FieldByName('division').asstring +
            '" because of recent invalidated Holding Zone setup (the next Accept ' +
            data1.SSbig + ' for this Div. will re-initialise).';
          lblNoHZs.Visible := True;
        end
        else
        begin
          if not comboHZ.Enabled then
          begin
            comboHZ.Enabled := true;
            label8.Enabled := true;
            label7.Caption := 'Select a Holding Zone for this Line Check';
            // flash to get attention
            label8.Visible := false;
            Application.ProcessMessages;
            sleep(100);
            label8.Visible := true;
            Application.ProcessMessages;
            sleep(100);
            label8.Visible := false;
            Application.ProcessMessages;
            sleep(100);
            label8.Visible := true;
            Application.ProcessMessages;
          end;
          lblNoHZs.Visible := False;
        end;
      end
      else if wasECLinvalid then // show the RED label
      begin
        lblNoHZs.Caption := 'Line Checks cannot be done for Division "' +
          adoqThreads.FieldByName('division').asstring +
          '" because the Last Accepted ' + data1.SSbig +
          ' was by Holding Zone and this Site does not have a VALID Holding Zone setup at present';
        lblNoHZs.Visible := True;
      end;
    end
    else
    begin
      comboHZ.Enabled := false;
      label8.Enabled := false;
      label7.Caption := 'This Division does not use Holding Zones';
    end;

    comboHZ.Visible := not lblNoHZs.Visible;
  end;

  bitBtn10.Enabled := not lblNoHZs.Visible;
end;

// Next >> (start a LC)
procedure TfLC.BitBtn10Click(Sender: TObject);
var
  imgIx : smallint;
  baseStk : integer;
begin
  data1.curdozForm := adoqThreads.FieldByName('dozForm').asstring = 'Y';
  data1.curGallForm := adoqThreads.FieldByName('gallForm').asstring = 'Y';
  theDiv := adoqThreads.FieldByName('division').asstring;
  baseDT := adoqThreads.FieldByName('baseDT').asdatetime;
  curTid := adoqThreads.FieldByName('tid').AsInteger;
  curTidName := adoqThreads.FieldByName('tname').Asstring;

  if (data1.siteUsesHZs) and (adoqThreads.FieldByName('byHZ').asinteger = 1) then
  begin
    curHZid := theHZs[comboHZ.ItemIndex];
    curHZName := comboHZ.Items[comboHZ.ItemIndex];
    imgIx := theHZimg[comboHZ.ItemIndex];
    curHZeSales := (imgIx = 0) or (imgIx = 2);
    curHZePur := (imgIx = 1) or (imgIx = 2);
    pnlHZprods.Visible := True;
    lblHZname.Caption := 'For Holding Zone: ' + curHZname;
    data1.hzTabsImgList.GetBitmap(imgIx,Image1.Picture.Bitmap);
    image1.Left := lblHZName.Left + lblHZName.Width + 5;
  end
  else
  begin
    curHZid := 0;
    curHZname := '';
    pnlHZprods.Visible := False;
  end;

  // is this LC blind?
  if data1.UserAllowed(curTid, 29) then  // NOT Blind...
    curLCblind := false
  else
    curLCblind := true;

  // put in the selection grid all products from stkMain from the Base Stock
  adotProds.close;
  dmADO.DelSQLTable('stkLCProds');
  with adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('CREATE TABLE dbo.[stkLCProds] ([EntityCode] [float] NULL, [PurN] [varchar] (40) NULL,');
    sql.Add(' [PurchaseUnit] [varchar] (10) NULL, [PurchBaseU] [float] NULL, [doLC] [bit] NULL,');
    sql.Add('	[Sub] [varchar] (20) NULL, [Cat] [varchar] (20) NULL, [Norm] [bit] NULL,[ForSC] [bit] NULL,');
    sql.Add(' [BaseQ] [float] NULL , [Purch] [float] NULL , [Transf] [float] NULL ,[TheoRed] [float] NULL,');
    sql.Add(' ECL [float] NULL, TrueECL [float] NULL, lcc [float] NULL, lcVar [float] NULL,');
    sql.Add(' PreSelected [bit] NULL DEFAULT (0), IsPreparedItem bit NOT NULL DEFAULT(0), FromPrep [float] NULL )');
    execSQL;

    close;
    sql.Clear;
    sql.Add('insert stkLCProds ([EntityCode], [PurN], [PurchaseUnit], [PurchBaseU], [doLC], ');
    sql.Add('  [Sub], [Cat], [Norm], [ForSC], [IsPreparedItem])');
    sql.Add('SELECT [EntityCode], [PurchaseName],[PurchaseUnit], [PurchBaseU], 0,[SCat] as Sub, [Cat], 1,');
    sql.Add('  (CASE [ETcode] WHEN ''S'' THEN 1 ELSE 0 END),');
    sql.Add('  (CASE [ETcode] WHEN ''P'' THEN 1 ELSE 0 END)');
    sql.Add('FROM stkEntity WHERE etcode in (''G'', ''S'', ''P'')');
    sql.Add('and entitycode in (select distinct a.entitycode from stkECLevel a');
    sql.Add('   where a.division = ' + quotedStr(theDiv) + ' and a.hzid = ' + inttostr(curHZid) + ' and a.SiteCode = ' + inttostr(data1.TheSiteCode) + ')');
    sql.Add('order by [Cat], [SCat], [PurchaseName]');
    execSQL;

    // read the ID of the last LC for this thread for this base (HZid is irrelevant)...
    close;
    sql.Clear;
    sql.Add('select max(LCID) as lcid from LineCheck');
    sql.Add('where division = ' + quotedStr(theDiv) + ' and SiteCode = ' + inttostr(data1.TheSiteCode));
    open;

    lastLCID := FieldByName('lcid').asinteger;
    bitbtn17.Enabled := (lastLCID <> 0); // if no prior LC for this div disable the button...


    // Mandatory Template for this Division?
    close;
    sql.Clear;
    sql.Add('SELECT IncludeInMandatoryLineCheck FROM ac_ProductDivision WHERE [name] = ' + quotedStr(theDiv));
    open;
    curLChasYieldTemplate := (FieldByName('IncludeInMandatoryLineCheck').asboolean);
    close;

    if curLChasYieldTemplate then
    begin
      // Verify if the Mandatory Template needs a change...
      dmRunSP := TdmRunSP.Create(self);
      with dmRunSP do
      begin
        spConn.Open;

        with adoqRunSP do
        begin
          close;
          sql.Clear;
          sql.Add('exec spCalculateMandatoryLineCheckTemplate');
          dt1 := Now;

          try
            execSQL;
            log.event('SP EXECUTED - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' +
               sql[0] + '"');
          except
            on E:Exception do
            begin
              log.event('SP ERROR - "' + sql[0] + '"' +
              ' ERR MSG: ' + E.Message);
              showMessage('ERROR Creating Mandatory Line Check Template!' + #13 +
                'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.');
              exit;
            end;
          end;
        end;
        spConn.Close;
      end;
      dmRunSP.Free;

      // check all is OK and we have a Mandatory Template
      close;
      sql.Clear;
      sql.Add('Select TemplateId from LineCheckTemplate');
      sql.Add('where TemplateId < 0 and div = ' + quotedStr(theDiv) + ' and SiteCode = ' + inttostr(data1.TheSiteCode));
      open;
      curLCYieldTemplate := FieldByName('TemplateID').asinteger;
      close;

      // load the mandatory template if any...
      if curLChasYieldTemplate and (curLCYieldTemplate < 0) then
      begin
        close;
        sql.Clear;
        sql.Add('update stkLCProds set doLC = 0');
        sql.Add('');
        sql.Add('update stkLCProds set doLC = 1, PreSelected = 1');
        sql.Add('from (select EntityCode from LineCheckTemplateDetail');
        sql.Add('      where TemplateID = ' + inttostr(curLCYieldTemplate) + ' and SiteCode = ' + inttostr(data1.TheSiteCode) + ') sq');
        sql.Add('where stkLCProds.entitycode = sq.entitycode');
        execSQL;
      end;
    end;

    // Now delete from stkLCProds any products that are not supposed to be available for Line Check.
    // These are prods with no existing stock Level, no sales, purch, etc. in the last stock
    // or since the last stock and NOT in mandatory templates.

    close;
    sql.Clear;
    sql.Add('if EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID(''tempdb..#stkViewForLC''))');
    sql.Add('   DROP TABLE [#stkViewForLC]');
    execSQL;

    Close;
    sql.Clear;
    sql.Add('select top 1 [BaseStk] from stkECLevel');
    sql.Add('where division = ' + quotedStr(theDiv) + ' and BaseTid = ' + inttostr(curTid) + ' and SiteCode = ' + inttostr(data1.TheSiteCode));
    open;
    baseStk := FieldByName('BaseStk').AsInteger;
    close;

    Close;
    sql.Clear;
    sql.Add('select distinct [entitycode] INTO [#stkViewForLC] from stkECLevel');
    sql.Add('where division = ' + quotedStr(theDiv) + ' and BaseTid = ' + inttostr(curTid) + ' and SiteCode = ' + IntToStr(data1.TheSiteCode));
    sql.Add('and (([PurQty] <> 0) or ([Transfers] <> 0) or ([TheoRed] <> 0) or ([TrueECL] <> 0) or');
    sql.Add('  ([ECL] <> 0) or ([SCVar] <> 0))');
    execSQL;

    Close;
    sql.Clear;
    sql.Add('INSERT [#stkViewForLC] (entitycode)');
    sql.Add('SELECT distinct entitycode from stkMain');
    sql.Add('where Tid = ' + inttostr(curTid) + ' and stkCode = ' + inttostr(baseStk) + ' and SiteCode = ' + IntToStr(data1.TheSiteCode));
    sql.Add('and (([OpStk] <> 0) or ([PurchStk] <> 0) or ([actCloseStk] <> 0) or ([ThCloseStk] <> 0) or');
    sql.Add('  (([soldQty] <> 0) and ([key2] < 1000)) or ([Wastage] <> 0) or ([WasteTill] <> 0) or');
    sql.Add('  ([PrepRedQty] <> 0) or (purchcost <> 0) or ([MoveQty] <> 0))');
    execSQL;

    // now delete
    Close;
    sql.Clear;
    sql.Add('delete stklcprods');
    sql.Add('from stklcprods a left outer join [#stkViewForLC] b on a.entitycode = b.entitycode');
    sql.Add('where b.entitycode is NULL and a.doLC = 0');
    execSQL;

    // any templates for this thread?
    close;
    sql.Clear;
    sql.Add('select templateID from LineCheckTemplate where TemplateId >= 0 and div = ' + quotedStr(theDiv) + ' and SiteCode = ' + inttostr(data1.TheSiteCode));
    open;
    availTempl := recordcount;
    close;

    if availTempl = 0 then
    begin
      bitbtn19.Enabled := false;
      bitbtn19.Caption := 'No Template Set';
    end
    else
    begin
      bitbtn19.Enabled := true;
      bitbtn19.Caption := 'Copy from Template (' + inttostr(availTempl) + ' Set)';
    end;
  end;

  // filters etc...
  with adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct cat from stklcprods');
    sql.Add('union select ('' - SHOW ALL - '') as divname');
    open;
    first;

    lookCat.Items.Clear;
    while not eof do
    begin
      lookCat.Items.Add(FieldByName('cat').asstring);
      next;
    end;

    close;
    sql.Clear;
    sql.Add('select distinct sub from stklcprods');
    sql.Add('union select ('' - SHOW ALL - '') as divname');
    open;
    first;

    looksCat.Items.Clear;
    while not eof do
    begin
      looksCat.Items.Add(FieldByName('sub').asstring);
      next;
    end;
    close;
  end;

  fillCat := '';
  fillSCat := '';
  awGridFilt := '';
  awOnlyFilt := '';
  lookcat.ItemIndex := 0;
  lookscat.ItemIndex := 0;
  SetGridFilt;
  selectedProds := 0;
  adotProds.Open;

  // now go and choose the products for the LC...
  ViewPanel(pnlProds);
end;

procedure TfLC.btnNextClick(Sender: TObject);
begin
  if selectedProds = 0 then
  begin
    showMessage('No items selected. Nothing to check.');
    exit;
  end;

  with adoqRun do
  begin
    close;     // is there a SC being done right now?
    sql.Clear;
    sql.Add('SELECT VarBit, vardt, varstring from stkVarLocal where VarName = ''SConLck''');
    open;

    if FieldByName('varbit').AsBoolean then
    begin
      showmessage('There is a Spot Check operation on going!' + #13 + #13 +
        'The Spot Check date/time is: ' + FieldByName('vardt').AsString + #13 + #13 +
        'A Line Check cannot be done until the Spot Check is finished.' + #13 +
        'Either wait a few minutes and click "Next" again or Cancel the Line Check and come back later.');

      log.event('CANNOT do LC as SC is ongoing scdt,scid(' +
        FieldByName('vardt').AsString + ', ' + FieldByName('varstring').AsString +')');

      close;
      exit;
    end;
    close;

    // all OK, proceed....
    // get rid of items NOT selected...
    close;
    sql.Clear;
    sql.Add('delete stkLCProds where doLC = 0');
    execSQL;

    // make the lock table; this will self destroy if Stocks crashes...
    if not lcConn.Connected then
      lcConn.Connected := TRUE;

    with adoqLock do
    begin
      close;
      sql.Clear;
      sql.Add('CREATE TABLE [' + getLockTableName + '] ([LineCheckIsOn] [smallint] NULL)');
      execSQL;
    end;


    // START the Line Check!!!!
    dmRunSP := TdmRunSP.Create(self);
    with dmRunSP do
    begin
      spConn.Open;

      with adoqRunSP do
      begin
        close;
        sql.Clear;
        sql.Add('exec stkSP_ECLstartLC ' + inttostr(curhzid));
        dt1 := Now;

        try
          execSQL;
          log.event('SP EXECUTED - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' +
             sql[0] + '"');
        except
          on E:Exception do
          begin
            log.event('SP ERROR - "' + sql[0] + '"' +
            ' ERR MSG: ' + E.Message);
            showMessage('ERROR starting Line Check!' + #13 +
              'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.');
            exit;
          end;
        end;
      end;
      spConn.Close;
    end;
    dmRunSP.Free;

    LCDT := Now;


    if data1.siteUsesLocations and data1.siteLCbyLocation then
    begin
      dmAdo.EmptySQLTable('auditLocationscur');

      // first load the Complete Site...
      close;
      sql.Clear;
      sql.Add('insert into auditLocationscur ([LocationID], [RecID], entitycode, [name], subcat,');
      sql.Add('            OpStk, PurchStk, ThRedQty, ThCloseStk, [wastage], ');
      sql.Add('            unit, purchbaseU, isPurchUnit, ShouldBe)');
      if data1.RepHdr = 'Sub-Category' then
        sql.Add('SELECT 0, 0, entitycode, [PurN],[Sub],')
      else
        sql.Add('SELECT 0, 0, entitycode, [PurN],[Cat],');
      sql.Add('  [BaseQ] / purchbaseU, CASE WHEN isPreparedItem = 1 THEN -999999 ELSE [Purch] / purchbaseU END, ');
      sql.Add('  [TheoRed] / purchbaseU, ([ECL] - [TrueECL]) / purchbaseU, [ECL] / purchbaseU,');
      sql.Add('  [PurchaseUnit], [PurchBaseU], 0, CASE Norm WHEN 0 THEN 1 ELSE 0 END');
      sql.Add('FROM stkLCProds');
      execSQL;


      //now load the Location Lists...
      // the Prep Item indicator switches from the PurchStk column to the Wastage Adj. column
      close;
      sql.Clear;
      sql.Add('insert into auditLocationscur ([LocationID], [RecID], entitycode, [name], subcat,');
      sql.Add('            OpStk, PurchStk, ThRedQty, ThCloseStk, [wastage],');
      sql.Add('            unit, purchbaseU, isPurchUnit, ShouldBe)');
      if data1.RepHdr = 'Sub-Category' then
        sql.Add('SELECT ll.LocationID, ll.RecID, a.entitycode, a.[PurN],a.[Sub],')
      else
        sql.Add('SELECT ll.LocationID, ll.RecID, a.entitycode, a.[PurN],a.[Cat],');
      sql.Add('  a.[BaseQ], CASE WHEN a.isPreparedItem = 1 THEN -999999 ELSE a.[Purch] END, ');
      sql.Add('  a.[TheoRed], (a.[ECL] - a.[TrueECL]), a.[ECL],');
      sql.Add('  ll.Unit, NULL, (CASE WHEN (ll.Unit = a.PurchaseUnit) THEN 1 ELSE 0 END) as IsPurchUnit,');
      sql.Add('  CASE a.Norm WHEN 0 THEN 1 ELSE 0 END');
      sql.Add('FROM stkLocationLists ll, stkLCProds a');
      sql.Add('WHERE ll.entitycode = a.entitycode and ll.Deleted = 0');
      execSQL;

      // get the Base Units for the Units...
      close;
      sql.Clear;
      sql.Add('update auditLocationsCur set purchbaseu = sq.[base units]');
      sql.Add('from (select b.[unit name], b.[base units] from Units b) sq');
      sql.Add('where unit = sq.[unit name] and LocationID > 0');
      execSQL;

      // now for any product NOT in at least one Location add it to the <No Location> list
      close;
      sql.Clear;
      sql.Add('insert into auditLocationscur ([LocationID], [RecID], entitycode, [name], subcat,');
      sql.Add('            OpStk, PurchStk, ThRedQty, ThCloseStk, [wastage],');
      sql.Add('            unit, purchbaseU, isPurchUnit, ShouldBe)');
      sql.Add('SELECT 999, 0, a.entitycode, a.name, a.SubCat, ');
      sql.Add('   OpStk, PurchStk, ThRedQty, ThCloseStk, [wastage],');
      sql.Add('   unit, purchbaseU, isPurchUnit, ShouldBe');
      sql.Add('FROM (select * from auditLocationscur where LocationID = 0) a');
      sql.Add('LEFT OUTER JOIN ');
      sql.Add('  (select distinct entitycode from auditLocationscur where LocationID > 0) ll ');
      sql.Add('ON a.entitycode = ll.entitycode ');
      sql.Add('WHERE ll.entitycode is NULL');
      execSQL;

      close;     // prepared item rows do not show any Theo Reduction, Theo Close or Prev. Variance
      sql.Clear;
      sql.Add('update auditcur SET ThRedQty = NULL, ThCloseStk = NULL, wastage = NULL');
      sql.Add('where PurchStk = -999999');
      execSQL;

      // fill Wastage with -999999 if PrepItem for Locations only...
      close;
      sql.Clear;
      sql.Add('update auditLocationscur set Wastage = -999999 where PurchStk = -999999');
      sql.Add('  and LocationID > 0 and LocationID < 999');
      execSQL;

      // if later required to suppress Print Count Shet dialog for LC as well, uncomment 2 lines below and corresponding end;
      //if not data1.noCountSheetDlg then // if not configured to suppress the Count Sheet printing prompt
      //begin

        // ask to print Audit Count Sheets
        if MessageDlg('In the next step the actual closing ' + data1.SSlow +
            ' levels will be required to complete the Line Check.' +
            #13 + #13 + 'Do you want to print the Count Sheets for the current Line Check now?',
            mtConfirmation, [mbYes,mbNo], 0) = mrYes then
        begin
          with adoqLocationCount do
          begin
            Close;
            sql.Clear;

            SQL.Add('SELECT locs.[LocationName], locs.[Active], alc.* from ');
            SQL.Add('  (SELECT loc.[LocationID], loc.[LocationName], loc.[Active] from stkLocations loc');
            SQL.Add('    WHERE loc.Deleted = 0 and loc.SiteCode = ' + IntToStr(data1.TheSiteCode));
            SQL.Add('   UNION  ');
            SQL.Add('   SELECT 999, ''<No Location>'', 0) locs');
            SQL.Add('JOIN  ');
            sql.Add('  (select * from AuditLocationsCur');
            sql.Add('   WHERE LocationID > 0');
            sql.Add('   AND ((shouldbe = 0) or ("ActCloseStk" <> 0) or ("WasteTill" <> 0) or ("WastePC" <> 0))) alc');
            sql.Add('ON locs.LocationID = alc.LocationID');
            SQL.Add('ORDER BY [Active], locationName, RecID, SubCat, [Name]');
          end;

          adoqLocationCount.Open;
          ppLocationCount.Print;
          adoqLocationCount.Close;
        end;

      //end; // end if not data1.noCountSheetDlg


      // show Audit screen
      fAuditLocations := TfAuditLocations.Create(Self);
      fAuditLocations.isLC := true;

      if curLCblind then
      begin
        // if returning with mrCancel kill the whole LC process
        if fAuditLocations.ShowModal = mrCancel then
        begin
          fAuditLocations.Free;
          self.ModalResult := mrCancel; // go away...
          exit;
        end;

        fAuditLocations.Free;
        PostAuditCalc;
        StoreLC;       // save to perm table
        PrintRep;      // print report, get out..
        self.ModalResult := mrCancel; // go away...
      end
      else
      begin
        fAuditLocations.ShowModal;
        fAuditLocations.Free;
        self.ModalResult := mrCancel; // go away...
      end;
    end
    else  // else of: if data1.siteUsesLocations and data1.siteLCbyLocation
    begin
      dmAdo.EmptySQLTable('auditcur');

      close;
      sql.Clear;
      sql.Add('insert into auditcur (hzid, entitycode, name, subcat,');
      sql.Add('        OpStk, PurchStk, ThRedQty, ThCloseStk, wastage, moveqty,');
      sql.Add('        purchunit, purchbaseU, ShouldBe)');

      if data1.RepHdr = 'Sub-Category' then
        sql.Add('SELECT ' + inttostr(curhzid) + ', entitycode, [PurN],[Sub],')
      else
        sql.Add('SELECT ' + inttostr(curhzid) + ', entitycode, [PurN],[Cat],');

      sql.Add('[BaseQ] / purchbaseU, CASE WHEN isPreparedItem = 1 THEN -999999 ELSE [Purch] / purchbaseU END, ');
      sql.Add('[TheoRed] / purchbaseU,([ECL] - [TrueECL]) / purchbaseU, [ECL] / purchbaseU, [Transf] / purchbaseU,');
      sql.Add('[PurchaseUnit], [PurchBaseU],');
      sql.Add('CASE Norm WHEN 0 THEN 1 ELSE 0 END');

      sql.Add('FROM stkLCProds');
      execSQL;

      close;     // prepared item rows do not show any Theo Reduction, Theo Close or Prev. Variance
      sql.Clear;
      sql.Add('update auditcur SET ThRedQty = NULL, ThCloseStk = NULL, wastage = NULL');
      sql.Add('where PurchStk = -999999');
      execSQL;

      // if later required to suppress Print Count Shet dialog for LC as well, uncomment 2 lines below and corresponding end;
      //if not data1.noCountSheetDlg then // if not configured to suppress the Count Sheet printing prompt
      //begin

        // ask to print Audit Count Sheets
        if MessageDlg('In the next step the actual closing ' + data1.SSlow + ' levels will be required to complete the Line Check.' +
            #13 + #13 + 'Do you want to print the Count Sheets for the current Line Check now?',
            mtConfirmation, [mbYes,mbNo], 0) = mrYes then
        begin
          adoqCount.Open;
          ppCount.Print;
          adoqCount.Close;
        end;

      //end;

      // show Audit screen
      fAudit := TfAudit.Create(Self);
      fAudit.isLC := true;
      fAudit.curhzname := curHZname;

      if curLCblind then
      begin
        // if returning with mrCancel kill the whole LC process
        if fAudit.ShowModal = mrCancel then
        begin
          fAudit.Free;
          self.ModalResult := mrCancel; // go away...
          exit;
        end;

        fAudit.Free;
        PostAuditCalc;
        StoreLC;       // save to perm table
        PrintRep;      // print report, get out..
        self.ModalResult := mrCancel; // go away...
      end
      else
      begin
        fAudit.ShowModal;
        fAudit.Free;
        self.ModalResult := mrCancel; // go away...
      end;
    end;
  end;
end;

procedure TfLC.BitBtn17Click(Sender: TObject);
begin
  adotProds.DisableControls;

  with adoqRun do
  begin
    // set selected products from storage...
    close;
    sql.Clear;
    sql.Add('update stkLCProds set doLC = 1');
    sql.Add('from (select entitycode from LineCheckDetail');
    sql.Add('      where lcid = ' + inttostr(lastLCID) + ') sq');
    sql.Add('where stkLCProds.entitycode = sq.entitycode');
    execSQL;
  end;

  adotProds.close;
  adotProds.open;
  adotProds.EnableControls;
  wwdbGrid1.Invalidate;
  wwDBGrid1.RedrawGrid;
end;

procedure TfLC.wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if adotProds.FieldByName('doLC').asboolean then
  begin
    if not Highlight then
    begin
      if (Field.fieldname = 'Cat') and (not adotProds.FieldByName('norm').asboolean) then
      begin
        aFont.Style := [];
        aFont.Color := clWhite;
        aBrush.Color := clGreen;
      end
      else if (Field.fieldname = 'PurN') and adotProds.FieldByName('isPreparedItem').asboolean then
      begin
        aFont.Style := [fsBold];
        aFont.Color := clYellow;
        aBrush.Color := clBlack;
      end
      else
      begin
        if adotProds.FieldByName('PreSelected').asboolean then
        begin
          aFont.Style := [];
          AFont.Color := clWhite;
          ABrush.Color := clRed;
        end
        else
        begin
          aFont.Style := [];
          AFont.Color := clWhite;
          ABrush.Color := clBlue;
        end;
      end;
    end
    else
    begin                               // if Highlight
      if (Field.fieldname = 'PurN') and adotProds.FieldByName('isPreparedItem').asboolean then
      begin
        aFont.Style := [fsBold];
        aFont.Color := clYellow;
        aBrush.Color := clBlue;
      end
      else
      begin
        aFont.Style := [];
        aFont.Color := clHighlightText;
        aBrush.Color := clHighlight;
      end;
    end;
  end
  else
  begin       // ------------------ NOT Selected for Line Check
    if not Highlight then
    begin
      if (Field.fieldname = 'Cat') and (not adotProds.FieldByName('norm').asboolean) then
      begin
        aFont.Style := [];
        aFont.Color := clWhite;
        aBrush.Color := clGreen;
      end
      else if (Field.fieldname = 'PurN') and adotProds.FieldByName('isPreparedItem').asboolean then
      begin
        aFont.Style := [fsBold];
        aFont.Color := clYellow;
        aBrush.Color := clBlack;
      end
      else
      begin
        aFont.Style := [];
        aFont.Color := clBlack;
        aBrush.Color := clWhite;
      end;
    end
    else
    begin                               // if Highlight
      if (Field.fieldname = 'PurN') and adotProds.FieldByName('isPreparedItem').asboolean then
      begin
        aFont.Style := [fsBold];
        aFont.Color := clYellow;
        aBrush.Color := clBlue;
      end
      else
      begin
        aFont.Style := [];
        aFont.Color := clHighlightText;
        aBrush.Color := clHighlight;
      end;
    end;
  end;
end;

procedure TfLC.wwDBGrid1CalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  if afieldname = adotProds.IndexFieldNames then
  begin
    aBrush.Color := clYellow;
    aFont.Color := clBlack;
  end;
end;

procedure TfLC.wwDBGrid1TitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  with adotProds do
  begin
    DisableControls;

    if AFieldName = IndexFieldNames then // already Yellow, go back to default...
      IndexFieldNames := 'Cat;Sub;PurN'
    else
      IndexFieldNames := AFieldName;

    EnableControls;
  end;
end;

procedure TfLC.SetGridFilt;
begin
  if awGridFilt <> '' then
  begin
    if awOnlyFilt <> '' then
      adotProds.Filter := awGridFilt + ' AND ' + awOnlyFilt
    else
    begin
      adotProds.Filter := awGridFilt;
    end;
  end
  else
  begin
    if awOnlyFilt <> '' then
      adotProds.Filter := awOnlyFilt
    else
      adotProds.Filter := '';
  end;
end;

procedure TfLC.lookCatCloseUp(Sender: TObject);
var
  f1, f2 : string;
begin
  if lookCat.Text <> ' - SHOW ALL - ' then
  begin // apply filters
    fillCat := lookCat.Text;
    fillSCat := '';
  end
  else
  begin
    fillCat := '';
    fillSCat := '';
  end;

  f1 := '';
    if fillCat <> '' then
    begin
      f1 := 'Cat = ' + quotedStr(fillCat);      // for lookSCat

      f2 := f1;
      if fillSCat <> '' then
        f2 := f1 + ' AND Sub = ' + quotedStr(fillSCat); // for grid
    end
    else
    begin
      f1 := '';
      f2 := '';
      if fillSCat <> '' then
        f2 := 'Sub = ' + quotedStr(fillSCat);
    end;

  // 2. "filter" the adoqSCat
  with adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct sub from stkLCprods');
    if f1 <> '' then
       sql.add('where ' + f1);

    sql.Add('union select ('' - SHOW ALL - '') as divname');
    open;
    first;

    looksCat.Items.Clear;
    while not eof do
    begin
      looksCat.Items.Add(FieldByName('sub').asstring);
      next;
    end;
    close;
    lookSCat.Refresh;
    lookSCat.ItemIndex := 0;
  end;

  // 3. filter the grid
  awGridFilt := f2;
  SetGridFilt;
end;

procedure TfLC.lookSCatCloseUp(Sender: TObject);
var
  f1, f2 : string;
begin
  if lookSCat.Text <> ' - SHOW ALL - ' then
  begin // apply filters
    fillSCat := lookSCat.Text;
  end
  else
  begin
    fillSCat := '';
  end;

  f1 := '';
    if fillCat <> '' then
    begin
      f1 := 'Cat = ' + quotedStr(fillCat);      // for lookSCat

      f2 := f1;
      if fillSCat <> '' then
        f2 := f1 + ' AND Sub = ' + quotedStr(fillSCat); // for grid
    end
    else
    begin
      f1 := '';
      f2 := '';
      if fillSCat <> '' then
        f2 := 'Sub = ' + quotedStr(fillSCat);
    end;

  // 3. filter the grid
  awGridFilt := f2;
  SetGridFilt;

end;

procedure TfLC.cbAWonlyClick(Sender: TObject);
begin
  if cbAWonly.Checked then
    awOnlyFilt := 'doLC = 1'
  else
    awOnlyFilt := '';

  SetGridFilt;
end;

procedure TfLC.BitBtn20Click(Sender: TObject);
begin
  // fill all (but only for what's filtered)
  with adotProds do
  begin
    disablecontrols;
    requery;
    first;
    while not eof do
    begin
      edit;
      FieldByName('doLC').asboolean := True;
      post;
      next;
    end;
    requery;
    first;
    enablecontrols;
  end;
end;

procedure TfLC.BitBtn21Click(Sender: TObject);
begin
  // empty all (but only for what's filtered)
  with adotProds do
  begin
    disablecontrols;
    requery;
    first;
    while not eof do
    begin
      if FieldByName('PreSelected').asboolean then
      begin
        next;
        continue;
      end;

      edit;
      FieldByName('doLC').asboolean := False;
      post;

      if awOnlyFilt = '' then
        next;
    end;
    requery;
    first;
    enablecontrols;
  end;
end;

procedure TfLC.PostAuditCalc;
begin
  with data1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('UPDATE stkLCprods SET lcc = sq.ActCloseStk');                                                     /////////////
    sql.Add('from');
    sql.Add(' (SELECT entitycode, (ActCloseStk * PurchBaseU) as ActCloseStk');
    if data1.siteUsesLocations and data1.siteLCbyLocation then
      sql.Add('   FROM AuditLocationscur where Locationid = 0) as sq')
    else
      sql.Add('   FROM Auditcur) as sq');

    sql.Add('where stkLCprods.entitycode = sq.entitycode');
    sql.Add('');
    sql.Add('UPDATE stkLCprods SET lcc = ecl'); // smooth out false variance due to rounding errors
    sql.Add('WHERE (ABS(ecl - lcc) < 0.00001)');
    ExecSQL;


    // if there are any PrepItems then split their LC counts to their ingredients in a temp table
      // Group By to ensure that if a Prep Item has the same ingredient more than once then it is
      // only 1 record per ingredient that gets wasted, with the tot waste qty...
    close;
    sql.Clear;
    SQL.Add('IF object_id(''tempdb..#LCprepItemIngr'') IS NOT NULL DROP TABLE #LCprepItemIngr');

    sql.Add('select l.entitycode, r.Child, SUM(r.RcpQty * l.lcc) as iQty ');
    sql.Add('INTO #LCprepItemIngr');
    sql.Add('   from  stkLCprods l join stk121Rcp r on r.Parent = l.EntityCode');
    sql.Add('   where l.isPreparedItem = 1');
    sql.Add('   group by l.entitycode, r.Child');
    sql.Add('');
    ExecSQL;

    // now sum up the LC count splits for each ingredient and add to stkLCprods to be part of
    // the "final" count and the Variance calculation
    close;
    sql.Clear;
    sql.Add('UPDATE stkLCprods SET FromPrep = sq.iQty, lcc = lcc + isNULL(sq.iQty, 0)');                                                     /////////////
    sql.Add('from');
    sql.Add(' (SELECT child, SUM(iQty) as iQty');
    sql.Add('   FROM  #LCprepItemIngr group by child) as sq');
    sql.Add('where stkLCprods.entitycode = sq.child');
    sql.Add('');
    sql.Add('UPDATE stkLCprods SET lcc = ecl'); // smooth out false variance due to rounding errors again
    sql.Add('WHERE (ABS(ecl - lcc) < 0.00001)');
    sql.Add('');
    ExecSQL;

    close;
    sql.Clear;
    sql.Add('UPDATE stkLCprods SET ');
    sql.Add('lcVar = lcc - ecl');
    ExecSQL;

    if data1.ssDebug then
      with dmADO.adoqRun2 do
      begin
        Close;
        sql.Clear;
        sql.Add('IF EXISTS (SELECT * FROM sysobjects WHERE id=OBJECT_ID(''stkZZ_LCprepItemIngr'')) DROP TABLE [stkZZ_LCprepItemIngr]');
        sql.Add('SELECT * INTO dbo.[stkZZ_LCprepItemIngr] FROM [#LCprepItemIngr]');
        execSQL;
      end;


  end;//THAT'S IT, ready to print report....
end; // procedure..


procedure TfLC.ppCountPreviewFormCreate(Sender: TObject);
begin
  dmADO.ALLRepsPreviewFormCreate(Sender, data1.repPaperName);
end;

procedure TfLC.ppHeaderBand1BeforePrint(Sender: TObject);
begin
  pplabel3.Text := 'Line Check Count Sheet';

  pplabel8.Caption := 'Line Check Date Time: ' + formatDateTime('ddddd hh:nn:ss', lcdt);
  pplabel10.Text := 'Header: ' + data1.repHdr;
  pplabel1.Text := 'Division: ' + theDiv;
  pplabel11.Caption := 'For Holding Zone: ' + curHZname;
  pplabel11.Visible := (curHZid > 0);
  pplabel9.Caption := 'Base Date Time: ' + formatDateTime('ddddd hh:nn:ss', baseDT);
end;

procedure TfLC.ppDBText11GetText(Sender: TObject; var Text: String);
begin
  if Text = '' then
  begin
    Text := 'New Item';
    ppDBText11.Font.Style := [fsBold];
    exit;
  end
  else
  begin
    ppDBText11.Font.Style := [];
  end;

  Text := data1.fmtRepQtyText(ppdbText3.Text,Text);
end;

procedure TfLC.PrintRep;
var
  hasPrepQty : boolean;
begin
  hasPrepQty := FALSE;

  with adoqLG do
  begin
    close;
    sql.Clear;
    if data1.RepHdr = 'Sub-Category' then
     sql.Add('SELECT [sub] as SubCatName, entitycode, PurN as PurchaseName, PurchaseUnit as PurchUnit,')
    else
     sql.Add('SELECT [cat] as SubCatName, entitycode, PurN as PurchaseName, PurchaseUnit as PurchUnit,');
    sql.Add('(lcVar / PurchBaseU) as q,');
    sql.Add('((lcc - TrueECL) / PurchBaseU) as bq,');
    sql.Add('(CASE  WHEN (TheoRed = 0) THEN null');
    sql.Add('       ELSE (((lcc - TrueECL) / TheoRed) * 100) END) as spc,');
    sql.Add('((lcc - ISNULL(FromPrep, 0)) / PurchBaseU) as CheckCount,');
    sql.Add('IsPreparedItem, (FromPrep / PurchBaseU) as FromPrep');
    sql.Add('FROM stkLCProds');
    sql.Add('WHERE lcc is NOT NULL');
    if not data1.lcZeroLG then
      sql.Add('and ((ABS(lcVar) > 0.001) or (IsPReparedItem = 1))');
    if data1.RepHdr = 'Sub-Category' then
     sql.Add('Order By  [sub], PurN')
    else
     sql.Add('Order By  [cat], PurN');
  end;

  adoqLG.Open;

  with dmADO.adoqRun2 do
  begin
    Close;
    sql.Clear;
    sql.Add('select * from stkLCProds where FromPrep is NOT NULL');
    open;
    if recordcount > 0 then hasPrepQty := TRUE;

    close;
  end;

  if hasPrepQty then
  begin
    ppline4.Width := 5.4271;
    ppline111.Width := 7.6354;
    pplabel16.Visible := TRUE;
  end
  else
  begin
    ppline4.Width := 4.7708;
    ppline111.Width := 6.9583;
    pplabel16.Visible := FALSE;
  end;

  ppline90.Width := ppline111.Width;
  ppShape11.width := ppline111.Width;
  ppShape12.Width := ppline111.Width;
  ppline119.Visible := pplabel16.Visible;
  ppline106.Visible := pplabel16.Visible;
  ppDBText12.Visible := pplabel1.Visible;
  pplabel14.Visible := pplabel1.Visible;

  pplabel65.Text := 'Line Check Loss/Gain Report';
  ppmemo1.Visible := false;
  pplabel4.Visible := false;

  pplmid1.Caption := 'Line Check Date Time: ' + formatDateTime('ddddd hh:nn:ss', lcdt);
  pplHeader.Text := 'Header: ' + data1.repHdr;
  pplDiv.Text := 'Division: ' + theDiv;
  ppLright2.Visible := (curHzid > 0);
  ppLright2.Caption := 'For Holding Zone: ' + curhzName;
  pplmid2.Caption := 'Base Date Time: ' + formatDateTime('ddddd hh:nn:ss', baseDT);
  pplabel21.Text := 'Since Last Accepted ' + data1.SSbig;

  if adoqLG.RecordCount = 0 then
    showmessage('There are no Losses or Gains to report.')
  else
    ppLGsmall.Print;

  adoqLG.Close;
end;

procedure TfLC.StoreLC;
begin
  curLCText := GetLineCheckComment;

  // save the data to the [stkECLevel], [stkLCs] and [stkLCmain] tables
  dmRunSP := TdmRunSP.Create(self);
  with dmRunSP do
  begin
    spConn.Open;

    with adoqRunSP do
    begin
      close;
      sql.Clear;
      sql.Add('exec stkSP_ECLcountLC ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss:zzz', LCDT)) +
           ', ' + inttoStr(curHZid) + ', ' + quotedStr(TheDiv) +
           ', ' + inttoStr(data1.TheSiteCode) + ', ' + quotedStr(curHZname) +
           ', ' + quotedstr(CurrentUser.UserName) + ', ' + quotedstr(curLCText));
      dt1 := Now;

      try
        execSQL;
        log.event('SP EXECUTED - ' + formatDateTime('hh:nn:ss:zzz', Now - dt1) + ' - "' +
           sql[0] + '"');
      except
        on E:Exception do
        begin
          log.event('SP ERROR - "' + sql[0] + '"' +
          ' ERR MSG: ' + E.Message);
          showMessage('ERROR Commiting the Line Check!' + #13 +
            'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.');
          exit;
        end;
      end;
    end;
    spConn.Close;
  end;
  dmRunSP.Free;

  // now see if at least 1 Line Check has been done for each Mandatory product
  if curLChasYieldTemplate then
  begin
    with adoqRun do
    begin
     close;
     sql.Clear;
     sql.Add('select * from [fnMandatoryProductsStillToLineCheck](' +
              QuotedStr(formatDateTime('yyyymmdd hh:nn:ss:zzz', Now)) + ')');
     open;

     if recordcount = 0 then  // no more products still to Linke Check, set the DATE...
     begin
       Close;
       sql.Clear;
       sql.Add('DECLARE @Value datetime');
       sql.Add('SET @Value = GetDate()');
       sql.Add('EXECUTE [spSetLocalDateVariable] ''DateMandatoryLineCheckDone'' , @Value');
       execSQL;
     end;

     close;
    end;
  end;
end;

procedure TfLC.wwDBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    //if adotProds.State = dsEdit then
      adotProds.Next;
end;

procedure TfLC.BitBtn18Click(Sender: TObject);
var
  newtemplID : integer;
  tname, ttext : string;
begin
  if selectedProds = 0 then
  begin
    showMessage('No items selected. A Selection Template with no items does not make sense.');
    exit;
  end;

  fLCTempl := TFLCTempl.Create(self);

  flctempl.Label1.Caption := 'Existing Selection Templates:';
  flctempl.Caption := 'Save New Line Check Selection Template - Division: ' + theDiv;

  flctempl.ADOQuery1.Parameters.ParamByName('thediv').Value := theDiv;
  flctempl.ADOQuery1.Open;
  flctempl.ADOQuery2.Open;

  flctempl.Panel1.Visible := true;

  if flctempl.ShowModal = mrOK then
  begin // save new template...
    // get next available TemplateID
    with adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select max(templateid) as maxid from LineCheckTemplate');
      open;

      //Bug 351175: Ensure that the minimum Id is 1. If only mandatory line check templates exist simply taking the current max Id
      // and adding 1 would yield a negative Id.
      newtemplID := Max(1, 1 + FieldByName('maxid').asinteger);
      close;

      tname := flctempl.Edit1.Text;
      ttext := flctempl.Memo1.Text;

      // now insert in stklctempls
      close;
      sql.Clear;
      sql.Add('insert LineChecktemplate (SiteCode, TemplateID, TName, TText, Div, LMDT, LMBy)');
      sql.Add('Values ('+IntToStr(data1.TheSiteCode)+', '+ inttostr(newtemplID) + ', ' + quotedStr(tname) + ', ' + quotedStr(ttext) +
         ', ' + quotedStr(TheDiv) + ', ' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now))  +
         ', ' + quotedStr(CurrentUser.UserName) + ')');
      execSQL;

      // now save the products...
      close;
      sql.Clear;
      sql.Add('insert LineCheckTemplateDetail (SiteCode, TemplateID, EntityCode, LMDT)');
      sql.Add('select '+IntToStr(data1.TheSiteCode)+', '+ inttostr(newtemplID) + ', Entitycode, '+
                       QuotedStr(FormatDateTime('mm/dd/yyyy hh:nn:ss.zzz', now))+
                       'from stkLCProds where doLC = 1');
      execSQL;

      // now reflect change on the "Copy From Template" btn
      // any templates for this thread? there should now be at least 1 so bitbtn19 WILL BE enabled.
      close;
      sql.Clear;
      sql.Add('select templateID from LineCheckTemplate where div = ' + quotedStr(TheDiv));
      open;

      bitbtn19.Enabled := true;
      bitbtn19.Caption := 'Copy from Template (' + inttostr(recordcount) + ' Set)';

      close;
    end;
  end;

  flcTempl.Free;

end;

procedure TfLC.wwDBGrid1Exit(Sender: TObject);
begin
  if adotProds.State = dsEdit then
    adotProds.Post;
end;

procedure TfLC.BitBtn19Click(Sender: TObject);
begin
  fLCTempl := TFLCTempl.Create(self);

  flctempl.Label1.Caption := 'Choose a Template to copy from:';
  flctempl.Caption := 'Line Check Selection Templates - Division: ' + theDiv;

  flctempl.ADOQuery1.Parameters.ParamByName('thediv').Value := theDiv;
  flctempl.ADOQuery1.Open;
  flctempl.ADOQuery2.Open;

  flctempl.Panel1.Visible := false;

  if flctempl.ShowModal = mrOK then
  begin // load from template...
    adotProds.disablecontrols;
    adotProds.close;

    // get TemplateID
    curTempl := flctempl.ADOQuery1.FieldByName('templateid').asinteger;

    with adoqRun do
    begin
      // first, insert any items that are in the template but not in the LC selection list
      // (this can happen if items have had no stock movememnt and no base stk)
      close;
      sql.Clear;
      sql.Add('SELECT sq.entitycode ');
      sql.Add('         from (select EntityCode from LineCheckTemplateDetail where TemplateID = ' +
                                                       inttostr(curTempl) + ') sq');
      sql.Add('         LEFT OUTER JOIN stkLCProds p ON p.entitycode = sq.entitycode');
      sql.Add('         where p.entitycode is NULL');
      open;

      if recordcount > 0 then
      begin
        close;
        sql.Clear;
        sql.Add('insert stkLCProds ([EntityCode], [PurN], [PurchaseUnit], [PurchBaseU], [doLC], ');
        sql.Add('  [Sub], [Cat], [Norm], [ForSC], [IsPreparedItem])');

        sql.Add('SELECT entitycode,[PurchaseName],[PurchaseUnit], [PurchBaseU], 0,[SCat], [Cat],  0,');
        sql.Add('  (CASE [ETcode] WHEN ''S'' THEN 1 ELSE 0 END) as ForSC,');
        sql.Add('  (CASE [ETcode] WHEN ''P'' THEN 1 ELSE 0 END) as IsPreparedItem');
        sql.Add('FROM stkEntity WHERE etcode in (''G'', ''S'', ''P'')');
        sql.Add('and entitycode in (SELECT sq.entitycode ');
        sql.Add('         from (select EntityCode from LineCheckTemplateDetail where TemplateID = ' +
                                                         inttostr(curTempl) + ') sq');
        sql.Add('         LEFT OUTER JOIN stkLCProds p ON p.entitycode = sq.entitycode');
        sql.Add('         where p.entitycode is NULL)');
        sql.Add('and div = ' + quotedStr(theDiv));
        sql.Add('order by [Cat], [SCat], [PurchaseName]');
        execSQL;
      end;


      // now do selection
      close;
      sql.Clear;
      sql.Add('update stkLCProds set doLC = 0 where PreSelected = 0');
      sql.Add('');
      sql.Add('update stkLCProds set doLC = 1');
      sql.Add('from (select EntityCode from LineCheckTemplateDetail where TemplateID = ' +
                                                       inttostr(curTempl) + ') sq');
      sql.Add('where stkLCProds.entitycode = sq.entitycode');
      execSQL;
    end;

    adotProds.open;
    adotProds.first;
    adotProds.enablecontrols;
    lookCat.ItemIndex := 0;
    lookCatCloseUp(self);

    bitbtn3.Visible := True;
    bitbtn3.Enabled := False;
    label4.Visible := True;
    label5.Visible := True;
    bevel1.Visible := True;
    label5.Caption := flctempl.ADOQuery1.FieldByName('tName').asstring;
  end;

  flcTempl.Free;
end;

procedure TfLC.adotProdsAfterPost(DataSet: TDataSet);
begin
  if bitbtn3.Visible then
    bitbtn3.Enabled := True;

  with adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select count(entitycode) as thec from stklcprods where doLC = 1');
    open;

    selectedProds := FieldByName('thec').asinteger;
    lblSelectStatus1.Caption := FieldByName('thec').asstring + ' items selected';

    close;
    sql.Clear;
    sql.Add('select count(entitycode) as thec from stklcprods where doLC = 1 and PreSelected = 1');
    open;

    if FieldByName('thec').asinteger > 0 then
    begin
      lblSelectStatus1.Height := 21;
      lblSelectStatus2.Caption := '(including ' + FieldByName('thec').asstring + ' mandatory)';
      lblSelectStatus2.Visible := TRUE;
    end
    else
    begin
      lblSelectStatus1.Height := 35;
      lblSelectStatus2.Visible := FALSE;
    end;

    close;
  end;
end;

procedure TfLC.BitBtn3Click(Sender: TObject);
begin
  if selectedProds = 0 then
  begin
    showMessage('No items selected. A Selection Template with no items does not make sense.');
    exit;
  end;

  // just replace the "old" entity codes with the new ones...
  with adoqRun do
  begin
    // delete old products...
    close;
    sql.Clear;
    sql.Add('delete LineCheckTemplateDetail where templateID = ' + inttostr(curTempl));
    execSQL;

    // now save the products...
    close;
    sql.Clear;
    sql.Add('insert LineCheckTemplateDetail (SiteCode, TemplateID, EntityCode, LMDT)');
    sql.Add('select '+IntToStr(data1.TheSiteCode)+', '+ inttostr(curTempl) + ', Entitycode, '+
                    QuotedStr(FormatDateTime('mm/dd/yyyy hh:nn:ss.zzz', now))+' from stkLCProds where doLC = 1');
    execSQL;
  end;

  bitbtn3.Enabled := False;
end;

procedure TfLC.wwDBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if adotProds.State = dsEdit then
    adotProds.Post;
end;

procedure TfLC.FormShow(Sender: TObject);
var
  imgIx, theIx : smallint;
begin
  if pnlHZ.Visible then
  begin
    adoqThreadsbyHZ.Visible := True;
    pnlThread.Width := 385;
  end
  else
  begin
    adoqThreadsbyHZ.Visible := False;
    pnlThread.Width := 355;
  end;

  ViewPanel(pnlThread);

  // rules for LC byHZ or bySite:
  // 1. If the last Acc Stk of any Thread/Div is LCbase AND byHZ then panel pnlHZ is visible
  //    (this is detected by seeing if stkECLevel has any HZs <> 0 as the Stk last accepted will
  //     set the levels byHZ when stkSP_ECLbase is executed)
  // 2. If the site has VALID HZs then it is up to the grid/dataset (on scroll) to enable/disable
  //    the comboHZ depending on what division is chosen. Also prepare the Selection panel to
  //    display the HZs page control.
  // 3. If the site has INVALID HZs then the on scroll will disable the comboHZ for divisions that
  //    are currently bySite (in stkECLevel).
  //    For divisions that are byHZ the panel pnlHZ will be covered by a RED label that says the
  //    levels are byHZ (as is the Last Acc Stk) for this division but the HZs are not VALID.
  //    A LC will not be available for this div until either the HZs are made VALID again or a new
  //    Stk BY SITE is accepted for that division (that will set stkECLevel bySite for the division)
  // 4. If no HZ <> 0 are in stkECLevel then the panel pnlHZ is simply not shown and LCs can only
  //    be done bySite. NOTE: it is irrelevant if the HZs are VALID or not.


  with dmADO.adoqRun do
  begin     // any div has levels by HZ in stkECLevel?
    close;
    sql.Clear;
    sql.Add('select max(hzid) as byHZ from stkECLevel');
    open;
    pnlHZ.Visible := (fields[0].AsInteger > 0);
    close;

    close;  // was stkECLevel invalidated (HZid = -1) and not re-initialised yet?
    sql.Clear;
    sql.Add('select min(hzid) as byHZ from stkECLevel');
    open;
    wasECLinvalid := (fields[0].AsInteger < 0);
    close;
  end;

  if pnlHZ.Visible then
  begin
    if data1.siteUsesHZs and (not wasECLinvalid) then
    begin
      // use the HZtabs but first make them up...
      with dmADO.adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('select hzid, hzname, epur, eSales from stkHZs where Active = 1 order by hzid');
        open;

        comboHZ.Items.Clear;
        while not eof do
        begin
          imgIx := -1;
          theIx := comboHZ.Items.Add(FieldByName('hzname').asstring);

          theHZs[theIx] := FieldByName('hzid').asinteger;

          if FieldByName('esales').asboolean then
          begin
            if FieldByName('epur').asboolean then
              imgIx := 2
            else
              imgIx := 0
          end
          else
          begin
            if FieldByName('epur').asboolean then
              imgIx := 1;
          end;

          theHZimg[theIx] := imgIx;

          next;
        end;

        comboHZ.ItemIndex := 0;
        close;
      end;
    end;
  end;


  with dmADO.adoqRun do
  begin
    close;
    SQL.Clear;
    SQL.Add('select * from stkHOConf');
    SQL.Add('where SiteCode = 0');
    Open;

    // should I Show Line Checks on Reports even if Variance = 0?
    // Default is NO (cbit = 0)
    if locate('cname', 'LCzeroLG', []) then
    begin
      data1.lcZeroLG := FieldByName('cbit').asboolean;
    end
    else
    begin
      insert;
      FieldByName('sitecode').asinteger := 0;
      FieldByName('cname').asstring := 'LCzeroLG';
      FieldByName('cbit').asboolean := False;
      FieldByName('lmdt').AsDateTime := Now;
      FieldByName('lmBy').asstring := CurrentUser.UserName;
      post;
      data1.lcZeroLG := False;
    end;

    close;
  end;

  adoqThreads.open; // 326419 (the line was moved from top of proc down here)
end;

procedure TfLC.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with adoqLock do
  begin
    close;
    sql.Clear;
    sql.Add('if EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID(''tempdb..' + getLockTableName + '''))');
    sql.Add('   DROP TABLE [' + getLockTableName + ']');
    execSQL;
  end;
  lcConn.Close;

  // kill the LC "lock" in case it wasn't killed by commiting the LC...
  with data1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('IF (SELECT VarBit from stkVarLocal where VarName = ''LConLck'') = 1');
    sql.Add('BEGIN');
    sql.Add('  DELETE stkVarLocal where VarName = ''LConLck''');
    sql.Add('  INSERT stkVarLocal ([SiteCode], [VarName], [VarBit], [LMDT])');
    sql.Add('     VALUES('+IntToStr(data1.TheSiteCode)+', ''LConLck'', 0, GetDate())');
    sql.Add('END');
    execSQL;
  end;
end;

procedure TfLC.BitBtn1Click(Sender: TObject);
var
  i : integer;
begin
  fNewAudit := TfNewAudit.Create(self);

  dmADO.DelSQLTable('#NewAudit');
  with data1.adoqRun do
  begin
    close;
    sql.Clear;
    if data1.RepHdr = 'Sub-Category' then
      sql.Add('SELECT entitycode,[Scat] as subcat,')
    else
      sql.Add('SELECT entitycode,[Cat] as subcat,');

    sql.Add('[PurchaseName],[PurchaseUnit], [PurchBaseU], [SCat] as Sub, [Cat], EntityType, ');
    sql.Add('(''N'') as Sel, (CASE [ETcode] WHEN ''S'' THEN 1 ELSE 0 END) as ForSC,');
    sql.Add('(CASE [ETcode] WHEN ''P'' THEN 1 ELSE 0 END) as IsPreparedItem');
    sql.Add('into [#newAudit]');
    sql.Add('FROM stkEntity WHERE etcode in (''G'', ''S'', ''P'')');
    sql.Add('and entitycode NOT in (select entitycode from stkLCProds)');
    sql.Add('and div = ' + quotedStr(theDiv));
    if data1.RepHdr = 'Sub-Category' then
      sql.Add('order by [Scat],[PurchaseName]')
    else
      sql.Add('order by [Cat],[PurchaseName]');
    execSQL;
  end;

  if fNewAudit.ShowModal = mrOK then
  begin
    adotProds.DisableControls;
    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('insert stkLCProds ([EntityCode], [PurN], [PurchaseUnit], [PurchBaseU], [doLC], ');
      sql.Add('  [Sub], [Cat], [Norm], [ForSC], [IsPreparedItem])');
      sql.Add('SELECT [EntityCode], [PurchaseName],[PurchaseUnit], [PurchBaseU], 0,[Sub], [Cat], 0, ForSC, [IsPreparedItem]');
      sql.Add('FROM "#NewAudit" where Sel = ''Y''');
      sql.Add('order by [Cat], [Sub], [PurchaseName]');
      i := execSQL;
    end;

    if i > 0 then
    begin
      adotProds.close;
      adotProds.open;
      showMessage(inttostr(i) + ' items added.');
    end;
    adotProds.EnableControls;
  end;

  fNewAudit.Free;

end;

procedure TfLC.ppDetailBand3BeforePrint(Sender: TObject);
begin
  ppLabelPrepItem.Visible := adoqLG.FieldByName('IsPreparedItem').AsBoolean;
  ppline101.Visible := not ppLabelPrepItem.Visible;
  ppline105.Visible := not ppLabelPrepItem.Visible;

  ppDBText46.Visible := ppDBText46.FieldValue <> 0;

  ppDBText4.Visible := ppDBText4.FieldValue <> 0;
end;

procedure TfLC.ppDBText46GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText45.Text,Text);
end;

procedure TfLC.ppLGsmallPreviewFormCreate(Sender: TObject);
begin
  dmADO.ALLRepsPreviewFormCreate(Sender, data1.repPaperName);
end;

procedure TfLC.ppDBText5GetText(Sender: TObject; var Text: String);
begin
  if adoqCount.FieldByName('IsPreparedItem').AsBoolean then
    Text := 'Prep.Item'
  else
    Text := data1.fmtRepQtyText(ppdbText3.Text,Text);
end;

procedure TfLC.adoqThreadsbyHZGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if Sender.AsInteger = 1 then
    Text := 'Yes'
  else
    Text := 'No';
end;


procedure TfLC.adotProdsBeforePost(DataSet: TDataSet);
begin
  if adotProds.FieldByName('PreSelected').asboolean then
    if data1.UserAllowed(-1, 30) then
    begin
      if not adotProds.FieldByName('doLC').asboolean then
        if (MessageDlg('This Product is Pre-Selected to be Line Checked based on the Yield % Template.'+
                  #13+#10+ 'Are you sure you want to de-select this Product?',
                  mtWarning, [mbYes, mbNo], 0) = mrNo) then
          adotProds.FieldByName('doLC').asboolean := TRUE;
    end
    else
    begin
      if not adotProds.FieldByName('doLC').asboolean then
      begin
        MessageDlg('This Product is Pre-Selected to be Line Checked based on the Yield % Template.'+
          #13+#10+ 'Your security permissions do not allow you to de-select this Product.', mtError, [mbOK], 0);
        adotProds.FieldByName('doLC').asboolean := TRUE;
      end;
    end;
end;

// returns a name for the lock table appended with DB's unique ID number
function TfLC.getLockTableName: String;
begin
  result := LOCK_TABLE + '_' + dmADO.getDBID;
end;

procedure TfLC.adotProdsAfterOpen(DataSet: TDataSet);
begin
  with adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select count(entitycode) as thec from stklcprods where doLC = 1');
    open;

    selectedProds := FieldByName('thec').asinteger;
    lblSelectStatus1.Caption := FieldByName('thec').asstring + ' items selected';

    close;
    sql.Clear;
    sql.Add('select count(entitycode) as thec from stklcprods where doLC = 1 and PreSelected = 1');
    open;

    if FieldByName('thec').asinteger > 0 then
    begin
      lblSelectStatus1.Height := 21;
      lblSelectStatus2.Caption := '(including ' + FieldByName('thec').asstring + ' mandatory)';
      lblSelectStatus2.Visible := TRUE;
    end
    else
    begin
      lblSelectStatus1.Height := 35;
      lblSelectStatus2.Visible := FALSE;
    end;

    close;
  end;
end;

procedure TfLC.ppGroupHeaderBand4BeforePrint(Sender: TObject);
begin
  ppGroupHeaderBand4.Visible := (adoqLocationCount.FieldByName('LocationID').AsInteger = 999);
end;

procedure TfLC.ppDBText50GetText(Sender: TObject; var Text: String);
begin
  if Text = '-999999' then
    Text := 'Prep.Item'
  else
    Text := '';
end;

procedure TfLC.ppHeaderBand4BeforePrint(Sender: TObject);
begin
  pplabel17.Text := 'Line Check Count Sheet';

  pplabel30.Caption := 'Line Check Date Time: ' + formatDateTime('ddddd hh:nn:ss', lcdt);
  pplabel32.Text := '<No Location> Sub-Header: ' + data1.repHdr;
  pplabel27.Text := 'Division: ' + theDiv;
  pplabel31.Caption := 'Base Date Time: ' + formatDateTime('ddddd hh:nn:ss', baseDT);
end;

procedure TfLC.ppDetailBand7BeforePrint(Sender: TObject);
begin
  if adoqLocationCount.FieldByName('LocationID').AsInteger = 999 then
  begin
    ppDBText51.Visible := FALSE;
    ppLine118.Visible := FALSE;
    ppDBText48.Left := 0.3958;
  end
  else
  begin
    ppDBText51.Visible := TRUE;
    ppLine118.Visible := TRUE;
    ppDBText48.Left := 0.6875;
  end;
end;

procedure TfLC.ppGroupHeaderBand2BeforePrint(Sender: TObject);
begin
  if adoqLocationCount.FieldByName('LocationID').AsInteger = 999 then
  begin
    ppLabel71.Visible := FALSE;
    ppLine116.Visible := FALSE;
    ppLabel69.Left := 0.3125;
    ppShape2.Left := 0.3125;
    ppDBText13.Left := 0.3325;
  end
  else
  begin
    ppLabel71.Visible := TRUE;
    ppLine116.Visible := TRUE;
    ppLabel69.Left := 0.6875;
    ppShape2.Left := 0.7083;
    ppDBText13.Left := 0.7383;
  end;
end;

end.

