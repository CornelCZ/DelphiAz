unit uLCRep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwdblook, Grids, Wwdbigrd, Wwdbgrid, Buttons, DBCtrls,
  ExtCtrls, DB, Wwdatsrc, ADODB, ppBands, ppClass, ppStrtch, ppMemo,
  ppCtrls, ppVar, ppPrnabl, ppCache, ppProd, ppReport, ppDB, ppComm,
  ppRelatv, ppDBPipe, ppSubRpt;

type
  TfLCRep = class(TForm)
    gridLCReps: TwwDBGrid;
    adotLCReps: TADOTable;
    dsLCReps: TwwDataSource;
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
    pplDiv: TppLabel;
    ppLmid1: TppLabel;
    ppDBText41: TppDBText;
    ppDBText42: TppDBText;
    ppDBText43: TppDBText;
    ppSystemVariable7: TppSystemVariable;
    ppLine86: TppLine;
    pplHeader: TppLabel;
    ppLmid3: TppLabel;
    ppLmid2: TppLabel;
    pplRight2: TppLabel;
    ppDetailBand3: TppDetailBand;
    ppDBText44: TppDBText;
    ppDBText45: TppDBText;
    ppDBText46: TppDBText;
    ppDBText55: TppDBText;
    ppLine87: TppLine;
    ppLine90: TppLine;
    ppLine92: TppLine;
    ppLine101: TppLine;
    ppLine105: TppLine;
    ppLine106: TppLine;
    ppLine3: TppLine;
    ppDBText1: TppDBText;
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
    ppGroupFooterBand3: TppGroupFooterBand;
    ppShape11: TppShape;
    ppLabel96: TppLabel;
    ppDBText57: TppDBText;
    ppLine163: TppLine;
    ppDBCalc15: TppDBCalc;
    ppLine4: TppLine;
    ppDBText2: TppDBText;
    ppLine6: TppLine;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel6: TppLabel;
    adoqSlave: TADOQuery;
    dsSlave: TDataSource;
    pipeSlave: TppDBPipeline;
    ppSlave: TppSubReport;
    ppChildReport1: TppChildReport;
    ppDetailBand1: TppDetailBand;
    ppSummaryBand1: TppSummaryBand;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText8: TppDBText;
    ppLine7: TppLine;
    ppLine8: TppLine;
    ppLine10: TppLine;
    ppLine12: TppLine;
    ppLine14: TppLine;
    ppLine15: TppLine;
    ppLine16: TppLine;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppLine9: TppLine;
    ppLabel7: TppLabel;
    ppLine17: TppLine;
    ppLine18: TppLine;
    ppLabel9: TppLabel;
    ppDBText11: TppDBText;
    ppShape1: TppShape;
    ppShape20: TppShape;
    ppLabel230: TppLabel;
    PanelRight: TPanel;
    Bevel4: TBevel;
    Label27: TLabel;
    Label26: TLabel;
    Label25: TLabel;
    Label24: TLabel;
    Label23: TLabel;
    Label22: TLabel;
    Label21: TLabel;
    Label16: TLabel;
    DBText4: TDBText;
    DBText3: TDBText;
    DBText2: TDBText;
    DBText1: TDBText;
    Label6: TLabel;
    lookRepDiv: TComboBox;
    cbCurrLC: TCheckBox;
    BitBtn15: TBitBtn;
    BitBtn16: TBitBtn;
    ppLabelPrepItem: TppLabel;
    ppLabelPrepItem2: TppLabel;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppLine19: TppLine;
    ppLine20: TppLine;
    ppLabel1: TppLabel;
    ppLine21: TppLine;
    ppLabel8: TppLabel;
    ppLine22: TppLine;
    ppLine23: TppLine;
    procedure BitBtn15Click(Sender: TObject);
    procedure lookRepDivCloseUp(Sender: TObject);
    procedure cbCurrLCClick(Sender: TObject);
    procedure gridLCRepsTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure gridLCRepsCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure gridLCRepsMultiSelectRecord(Grid: TwwDBGrid;
      Selecting: Boolean; var Accept: Boolean);
    procedure adotLCRepsAfterScroll(DataSet: TDataSet);
    procedure ppDetailBand3BeforePrint(Sender: TObject);
    procedure ppDBText46GetText(Sender: TObject; var Text: String);
    procedure ppLGsmallPreviewFormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gridLCRepsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure ppDetailBand1BeforePrint(Sender: TObject);
    procedure ppHeaderBand3BeforePrint(Sender: TObject);
  private
    { Private declarations }
    fillRepDiv, fillRepTh, repGridFilt, repOnlyFilt : string; // -- lc reports
    selDiv : string;
    isSC, hasPrepQty: boolean;
    procedure SetRepGridFilt;
  public
    { Public declarations }

    procedure ExpandCollapse(var Msg: TMsg);
  end;

var
  fLCRep: TfLCRep;

implementation

uses uADO, udata1, uLCmultiDM, uGlobals;

{$R *.dfm}


procedure TfLCRep.BitBtn15Click(Sender: TObject);
begin
  if adotlcreps.RecordCount = 0 then
  begin
    showmessage('No Line Checks exist yet, nothing to report.');
    exit;
  end;
  hasPrepQty := FALSE;

  // show single report...
  with adoqLG do
  begin
    isSC := adotLCReps.FieldByName('LCID').IsNull and (not adotLCReps.FieldByName('SCID').IsNull);

    dmADO.DelSQLTable('#lcrep');
    dmADO.DelSQLTable('#lcSlaverep');

    if isSC then
    begin
      close;
      sql.Clear;
      if data1.RepHdr = 'Sub-Category' then
       sql.Add('SELECT a.scat as SubCatName, b.entitycode, a.PurchaseName, a.PurchaseUnit as PurchUnit,')
      else
       sql.Add('SELECT a.cat as SubCatName, b.entitycode, a.PurchaseName, a.PurchaseUnit as PurchUnit,');
      sql.Add('(b.scVar / a.PurchBaseU) as q,');
      sql.Add('((b.ECL - b.TrueECL) / a.PurchBaseU) as bq,');
      sql.Add('(CASE');
      sql.Add('  WHEN (b.TheoRed = 0) THEN NULL');
      sql.Add('  ELSE ((b.ECL - b.TrueECL) / b.TheoRed * 100)');
      sql.Add('END) as spc,');
      sql.Add('(b.ECL / a.PurchBaseU) as CheckCount, 0 as PrevC,');
      sql.Add(' 0 as IsPreparedItem, (b.ECL * 0) as FromPrep');
      sql.Add('INTO [#lcRep]');
      sql.Add('FROM stkEntity a, stkSCMain b');
      sql.Add('WHERE a.entitycode = b.entitycode and b.SCID = ' + adotLCReps.FieldByName('SCID').asstring);
      sql.Add('and b.division = ' + quotedStr(adotLCReps.FieldByName('division').asstring));
      if not data1.lcZeroLG then
        sql.Add('and (ABS(b.scVar) > 0.001)');
      sql.Add('and b.SiteCode = '+IntToStr(data1.repSite));
      execSQL;
    end
    else
    begin
      close;
      sql.Clear;
      if data1.RepHdr = 'Sub-Category' then
       sql.Add('SELECT a.scat as SubCatName, b.entitycode, a.PurchaseName, a.PurchaseUnit as PurchUnit,')
      else
       sql.Add('SELECT a.cat as SubCatName, b.entitycode, a.PurchaseName, a.PurchaseUnit as PurchUnit,');
      sql.Add('(b.Var / a.PurchBaseU) as q,');
      sql.Add('((b.ECL - b.TrueECL) / a.PurchBaseU) as bq,');
      sql.Add('(CASE');
      sql.Add('  WHEN ((b.TheoRed = 0) or (b.TheoRed = -999999)) THEN null');
      sql.Add('  ELSE ((b.ECL - b.TrueECL) / b.TheoRed * 100)');
      sql.Add('END) as spc,');
      sql.Add('((b.ECL - ISNULL(FromPrep, 0)) / a.PurchBaseU) as CheckCount, 0 as PrevC, ');
      sql.Add('CASE b.TheoRed WHEN -999999 THEN 1 ELSE 0 END as IsPreparedItem, (FromPrep / a.PurchBaseU) as FromPrep');
      sql.Add('INTO [#lcRep]');
      sql.Add('FROM stkEntity a, LineCheckDetail b');
      sql.Add('WHERE a.entitycode = b.entitycode and b.LCID = ' + adotLCReps.FieldByName('LCID').asstring);
      if not data1.lcZeroLG then
        sql.Add('and ((ABS(b.Var) > 0.001)  or (b.TheoRed = -999999))');
      sql.Add('and b.SiteCode = '+IntToStr(data1.repSite));
      execSQL;
    end;

    close;
    sql.Clear;
    sql.Add('SELECT s.SCDT as theDT, b.entitycode, a.PurchaseUnit as PurchUnit,');
    sql.Add('(b.scVar / a.PurchBaseU) as q,');
    sql.Add('((b.ECL - b.TrueECL) / a.PurchBaseU) as bq,');
    sql.Add('(CASE');
    sql.Add('  WHEN (b.TheoRed = 0) THEN null');
    sql.Add('  ELSE ((b.ECL - b.TrueECL) / b.TheoRed * 100)');
    sql.Add('END) as spc,');
    sql.Add('(b.ECL / a.PurchBaseU) as CheckCount, 1 as isSC,');
    sql.Add(' 0 as IsPreparedItem, b.ECL * 0 as FromPrep');
    sql.Add('INTO [#lcSlaveRep]');
    sql.Add('FROM stkEntity a, stkSCMain b, stkSC s');
    sql.Add('WHERE a.entitycode = b.entitycode and b.SCID = s.SCID');
    sql.Add('and b.division = ' + quotedStr(adotLCReps.FieldByName('division').asstring));
    sql.Add('and b.BaseDT = ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss.zzz',
                adotLCReps.FieldByName('BaseDT').asdatetime)));
    sql.Add('and s.SCDT < ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss.zzz',
                adotLCReps.FieldByName('LCSCDT').asdatetime)));
    sql.Add('and b.SiteCode = '+IntToStr(data1.repSite));
    sql.Add('and s.SiteCode = '+IntToStr(data1.repSite));
    sql.Add('');
    sql.Add('UNION');
    sql.Add('');
    sql.Add('SELECT s.LCDT as theDT, b.entitycode, a.PurchaseUnit as PurchUnit,');
    sql.Add('(b.Var / a.PurchBaseU) as q,');
    sql.Add('((b.ECL - b.TrueECL) / a.PurchBaseU) as bq,');
    sql.Add('(CASE');
    sql.Add('  WHEN (b.TheoRed = 0) THEN null');
    sql.Add('  ELSE ((b.ECL - b.TrueECL) / b.TheoRed * 100)');
    sql.Add('END) as spc,');
    sql.Add('((b.ECL - ISNULL(FromPrep, 0)) / a.PurchBaseU) as CheckCount, 0 as isSC,');
      sql.Add('CASE b.TheoRed WHEN -999999 THEN 1 ELSE 0 END as IsPreparedItem, (FromPrep / a.PurchBaseU) as FromPrep');
    sql.Add('FROM stkEntity a, LineCheckDetail b, LineCheck s');
    sql.Add('WHERE a.entitycode = b.entitycode and b.LCID = s.LCID');
    sql.Add('and s.BaseDT = ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss.zzz',
                adotLCReps.FieldByName('BaseDT').asdatetime)));
    sql.Add('and s.LCDT < ' + quotedStr(formatDateTime('yyyymmdd hh:nn:ss.zzz',
                adotLCReps.FieldByName('LCSCDT').asdatetime)));
    sql.Add('and b.SiteCode = '+IntToStr(data1.repSite));
    sql.Add('and s.SiteCode = '+IntToStr(data1.repSite));
    execSQL;

    close;
    sql.Clear;
    sql.Add('delete [#lcSlaverep] ');
    sql.Add('where entitycode not in (select entitycode from #lcrep)');
    execSQL;


    close;
    sql.Clear;
    sql.Add('update [#lcSlaverep] set FromPrep = NULL');
    sql.Add('where [#lcSlaverep].isSC = 1');
    execSQL;

    close;
    sql.Clear;
    sql.Add('update [#lcrep] set prevc = sq.thecount');
    sql.Add('from (select entitycode, count(*) as thecount from [#lcSlaveRep] group by entitycode) sq');
    sql.Add('where [#lcrep].entitycode = sq.entitycode');
    execSQL;

    // now do the report queries...
    close;
    sql.Clear;
    sql.Add('SELECT * from [#lcrep] order by SubCatName, PurchaseName');
    open;
  end;

  adoqSlave.close;
//    adoqSlave.sql.Clear;
//    adoqSlave.sql.Add('SELECT * from [#lcSlaveRep] where entitycode = :entitycode order by theDT');
  adoqSlave.sql[1] := 'from [#lcSlaveRep]';
  adoqSlave.open;


    if data1.ssDebug then
      with dmADO.adoqRun2 do
      begin
        Close;
        sql.Clear;
        sql.Add('IF EXISTS (SELECT * FROM sysobjects WHERE id=OBJECT_ID(''stkZZ_lcrep'')) DROP TABLE [stkZZ_lcrep]');
        sql.Add('SELECT * INTO dbo.[stkZZ_lcrep] FROM [#lcrep]');
        sql.Add('');
        sql.Add('IF EXISTS (SELECT * FROM sysobjects WHERE id=OBJECT_ID(''stkZZ_lcSlaverep'')) DROP TABLE [stkZZ_lcSlaverep]');
        sql.Add('SELECT * INTO dbo.[stkZZ_lcSlaverep] FROM [#lcSlaverep]');

        execSQL;
      end;



  with dmADO.adoqRun2 do
  begin
    Close;
    sql.Clear;
    sql.Add('select * from #lcrep where FromPrep is NOT NULL');
    open;
    if recordcount > 0 then hasPrepQty := TRUE;

    Close;
    sql.Clear;
    sql.Add('select * from #lcSlaverep where FromPrep is NOT NULL');
    open;
    if recordcount > 0 then hasPrepQty := TRUE;

    close;
  end;


  if isSC then
  begin
    pplabel65.Text := 'Spot Check Report';
    pplmid1.Caption := 'Spot Check Date Time: ' + formatDateTime('ddddd hh:nn:ss',
      adotLCReps.FieldByName('lcscdt').asdatetime);
    pplmid3.Caption := 'Saved on: ' + formatDateTime('ddddd hh:nn:ss',
      adotLCReps.FieldByName('lmdt').asdatetime);
    ppmemo1.Visible := false;
    pplabel4.Visible := false;
  end
  else
  begin
    pplabel65.Text := 'Committed Line Check Report';
    pplmid1.Caption := 'Line Check Date Time: ' + formatDateTime('ddddd hh:nn:ss',
      adotLCReps.FieldByName('lcscdt').asdatetime);
    pplmid3.Caption := 'Committed on: ' + formatDateTime('ddddd hh:nn:ss',
      adotLCReps.FieldByName('lmdt').asdatetime);
    ppmemo1.Text := DBText3.Field.AsString;
    ppmemo1.Visible := true;
    pplabel4.Visible := (ppmemo1.Text <> '');
  end;

  if hasPrepQty then
  begin
    ppline6.Width := 5.6354;
    ppline111.Width := 7.8229;
    ppline8.Width := 7.2709;
    pplabel1.Visible := TRUE;
  end
  else
  begin
    ppline6.Width := 5.0521;
    ppline111.Width := 7.2396;
    ppline8.Width := 6.6875;
    pplabel1.Visible := FALSE;
  end;

  ppline90.Width := ppline111.Width;
  ppline9.Width := ppline111.Width;
  ppShape11.width := ppline111.Width;
  ppShape12.Width := ppline111.Width;
  ppline119.Visible := pplabel1.Visible;
  ppline106.Visible := pplabel1.Visible;
  ppline15.Visible := pplabel1.Visible;
  ppDBText12.Visible := pplabel1.Visible;
  ppDBText13.Visible := pplabel1.Visible;
  pplabel8.Visible := pplabel1.Visible;

  pplHeader.Text := 'Header: ' + data1.repHdr;
  pplDiv.Text := 'Division: ' + adotLCReps.FieldByName('division').asstring;
  ppLright2.Caption := 'For Holding Zone: ' + adotlcreps.FieldByName('hzName').asstring;
  ppLright2.Visible := (adotlcreps.FieldByName('hzid').asinteger > 0);
  pplmid2.Caption := 'Base Date Time: ' + formatDateTime('ddddd hh:nn:ss',
    adotLCReps.FieldByName('baseDT').asdatetime);
  pplabel6.Text := 'Since Last Accepted ' + data1.SSbig;

  data1.curDozForm := (adotlcreps.FieldByName('dozform').asboolean);      // 326550
  data1.curGallForm := (adotlcreps.FieldByName('gallform').asboolean);    // 326550

  if adoqLG.RecordCount = 0 then
    showmessage('There are no Losses or Gains to report.')
  else
    ppLGsmall.Print;

  adoqSlave.Close;
  adoqLG.Close;
end;

procedure TfLCRep.SetRepGridFilt;
begin
  if repGridFilt <> '' then
  begin
    if repOnlyFilt <> '' then
      adotLCreps.Filter := repGridFilt + ' AND ' + repOnlyFilt
    else
      adotLCreps.Filter := repGridFilt;
  end
  else
  begin
    if repOnlyFilt <> '' then
      adotLCreps.Filter := repOnlyFilt
    else
      adotLCreps.Filter := '';
  end;

end;

procedure TfLCRep.lookRepDivCloseUp(Sender: TObject);
var
  f1, f2 : string;
begin
  if lookrepDiv.Text <> ' - SHOW ALL - ' then
  begin // apply filters
    fillrepDiv := lookrepDiv.Text;
    fillrepTh := '';
  end
  else
  begin
    fillrepDiv := '';
    fillrepTh := '';
  end;

  f1 := '';
    if fillrepDiv <> '' then
    begin
      f1 := 'division = ' + quotedStr(fillrepDiv);      // for lookrepTh

      f2 := f1;
      if fillrepTh <> '' then
        f2 := f1 + ' AND Tid = ' + quotedStr(fillrepTh); // for grid
    end
    else
    begin
      f1 := '';
      f2 := '';
      if fillrepTh <> '' then
        f2 := 'Tid = ' + quotedStr(fillrepTh);
    end;


  // 3. filter the grid
  repGridFilt := f2;
  SetrepGridFilt;
end;

procedure TfLCRep.cbCurrLCClick(Sender: TObject);
begin
  if cbCurrLC.Checked then
    repOnlyFilt := 'cur = 1'
  else
    repOnlyFilt := '';

  SetrepGridFilt;
end;

procedure TfLCRep.gridLCRepsTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  with adotLCreps do
  begin
    DisableControls;

    if (AFieldName + ' DESC') = IndexFieldNames then // already Yellow, go to red...
    begin
      IndexFieldNames := AFieldName;
    end
    else if (AFieldName + ' DESC') = IndexFieldNames then // already Red, go to nothing...
    begin
      IndexFieldNames := 'Division;BaseDT DESC;LCSCDT DESC';
    end
    else
    begin
      if AFieldName = 'Division' then
      begin
        IndexFieldNames := 'Division;BaseDT DESC;LCSCDT DESC';
      end
      else
      begin
        IndexFieldNames := AFieldName + ' DESC';
      end;
    end;

    EnableControls;
  end;
end;

procedure TfLCRep.gridLCRepsCalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  if (afieldname + ' DESC') = adotLCreps.IndexFieldNames then
  begin
    aBrush.Color := clYellow;
    aFont.Color := clBlack;
  end
  else if afieldname = adotLCreps.IndexFieldNames then
  begin
    aBrush.Color := clRed;
    aFont.Color := clWhite;
  end;
end;

procedure TfLCRep.gridLCRepsMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  if Selecting then
  begin
    if Grid.SelectedList.Count = 0 then // first selection
    begin
      selDiv := adotLCReps.FieldByName('Division').asstring;
    end
    else
    begin
      if selDiv <> adotLCReps.FieldByName('division').asstring then // diff div, refuse selection
      begin
        showMessage('You can select more than one Line Check only if they are in the same Division!' + #13 +
          'Currently selectable Division is: ' + selDiv + #13 + #13 +
          'Selection Denied!');
        Accept := False;
        exit;
      end;
    end;
  end
  else if Grid.SelectedList.Count = 1 then   // if unselect the last one
  begin
    selDiv := '';
  end;

  if Grid.SelectedList.Count >= 1 then
  begin
    label6.Visible := True;

    if Selecting then
    begin
      label6.Caption := inttostr(Grid.SelectedList.Count + 1);
    end
    else // if unselecting
    begin
      if Grid.SelectedList.Count <= 2 then
      begin  // once unselection is done there will not be multi select anymore
        label6.Visible := False;
      end
      else
      begin
        label6.Caption := inttostr(Grid.SelectedList.Count - 1);
      end;
    end;
    label6.Caption := label6.Caption + ' Checks selected' + #13 + '(Division: ' + selDiv +  ')' +
      #13 + #13 + 'Report shown will be:' +
      #13 + #13 + '"Cumulative ' + #13 + 'Check Variance"';
  end
  else
  begin
    label6.Visible := False;
  end;

end;

procedure TfLCRep.ExpandCollapse(var Msg: TMsg);
begin
  if LCMultiDM.Expanded then
  begin
    LCMultiDM.repMLC.CollapseDrillDowns;
    LCMultiDM.Expanded := False;
  end
  else
  begin
    LCMultiDM.repMLC.ExpandDrillDowns;
    LCMultiDM.Expanded := True;
  end;

  LCMultiDM.repMLC.PrintToDevices;
end;


procedure TfLCRep.adotLCRepsAfterScroll(DataSet: TDataSet);
begin
  if adotLCReps.FieldByName('LCID').IsNull and (not adotLCReps.FieldByName('SCID').IsNull) then
  begin
    label24.Caption := 'Spot Check saved on:';
    label25.Caption := 'Spot Check done from:';
    label26.Visible := False;
    dbtext1.Color := clBtnFace;
  end
  else
  begin
    label24.Caption := 'Line Check commited on:';
    label25.Caption := 'Line Check done by:';
    label26.Visible := True;
    dbtext1.Color := clWhite;
  end;

  dbText3.Visible := label26.Visible;
  dbtext2.Color := dbtext1.Color;
  dbtext4.Color := dbtext1.Color;
end;

procedure TfLCRep.ppDetailBand3BeforePrint(Sender: TObject);
begin
  ppLabelPrepItem.Visible := (adoqLG.FieldByName('IsPreparedItem').AsInteger = 1);
  ppline101.Visible := not ppLabelPrepItem.Visible;
  ppline105.Visible := not ppLabelPrepItem.Visible;

  ppDBText46.Visible := (ppDBText46.FieldValue <> 0);
 
  ppDBText2.Visible := (ppDBText2.FieldValue <> 0);

  ppShape1.Visible := (ppdbText11.FieldValue > 0) and (pplgsmall.DeviceType <> 'Printer');
end;

procedure TfLCRep.ppDBText46GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText45.Text,Text);
end;

procedure TfLCRep.ppLGsmallPreviewFormCreate(Sender: TObject);
begin
  dmADO.ALLRepsPreviewFormCreate(Sender, data1.repPaperName);
end;

procedure TfLCRep.FormShow(Sender: TObject);
begin
  data1.sitetab.close;
  data1.sitetab.Parameters.ParamByName('repSite').Value := data1.repSite;
  data1.sitetab.Open;

  data1.areatab.close;
  data1.areatab.Parameters.ParamByName('repSite').Value := data1.repSite;
  data1.areatab.Open;

  ADOTlcreps.Close;

  ppLabelPrepItem.Width := 2.8854;
  ppLabelPrepItem2.Width := 3.3333;


  // make up a temp table to view the LCs AND SCs
  dmADO.DelSQLTable('stkLCreps');
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('CREATE TABLE dbo.[stkLCReps] ([SiteCode] [smallint] NULL, [Division] [varchar] (20) NULL,');
    sql.Add('	[LCID] [int] NULL, [SCID] [bigint] NULL, [LCSCDT] [datetime] NULL,');
    sql.Add(' [HzID] [int] NULL, [HzName] [varchar] (30) NULL, [CommitBy] [varchar] (20) NULL,');
    sql.Add('	[LCText] [varchar] (255) NULL, [cur] [bit] NULL, [dozForm] [bit] NULL,');
    sql.Add(' [gallForm] [bit] NULL, [BaseDT] [datetime] NULL, LMDT [datetime] NULL)');

    sql.Add('');

    sql.Add('insert stkLCreps ([SiteCode], [Division], [LCID], [SCID], [LCSCDT], [HzID],');
    sql.Add('    [HzName], [CommitBy], [LCText], [cur], [dozForm], [gallForm], [BaseDT], LMDT)');
    sql.Add('select [SiteCode], [Division], [LCID], NULL, [LCDT], [HzID],');
    sql.Add('         [HzName], [CommitBy], [LCText], 0, 0, 0, [BaseDT], LMDT');
    sql.Add('from LineCheck');
    sql.Add('where SiteCode = '+IntToStr(data1.repSite));

    sql.Add('');

    sql.Add('insert stkLCreps ([SiteCode], [Division], [LCID], [SCID], [LCSCDT], [HzID],');
    sql.Add('     [HzName],[CommitBy], [LCText], [cur], [dozForm], [gallForm], [BaseDT], LMDT)');
    sql.Add('select a.[SiteCode], sq.[Division], a.TermID, a.[SCID], a.[SCDT], sq.[HzID], NULL,');
    sql.Add('      NULL, NULL, 0, 0, 0, sq.[BDT], a.LMDT');
    sql.Add('from stkSC a, (select [SiteCode], [SCID], [Division], max([HZID]) as HZid,');
    sql.Add('     max([BaseDT]) as BDT from stkSCmain where SiteCode = '+IntToStr(data1.repSite));
    sql.Add('     group by [SiteCode], [SCID], [Division]) sq');
    sql.Add('where a.SiteCode = sq.SiteCode and a.SCID = sq.SCID');
    sql.Add('and a.SiteCode = '+IntToStr(data1.repSite));

    sql.Add('');

    sql.Add('update stkLCreps set CommitBy = sq.[POS Name], lcid = NULL');
    sql.Add('from ');
    sql.Add('(select t.EPOSDeviceID, b.[POS Name]');
    sql.Add('   from ThemeEPOSDevice t, config b where t.POSCode = b.[pos code]');
    sql.Add('   and b.[Site Code] = '+IntToStr(data1.repSite)+ ' ) sq');
    sql.Add('where stkLCreps.lcid = sq.EPOSDeviceID and stkLCreps.scid is NOT NULL');
    sql.Add('');

    sql.Add('update stkLCreps set dozForm = (CASE sq.doz WHEN ''Y'' THEN 1 ELSE 0 END),');
    sql.Add('                    gallform = (CASE sq.gall WHEN ''Y'' THEN 1 ELSE 0 END)');
    sql.Add('from ');
    sql.Add('(select division, max(dozform) as doz, max(gallform) as gall');
    sql.Add('   from threads where active = ''Y'' and lcbase = 1 group by division) sq');
    sql.Add('where stkLCreps.division = sq.division');
    sql.Add('');

    sql.Add('update stklcReps set hzname = sq.hzname');
    sql.Add('from (select hzid, hzname from stkHZs where active = 1 and SiteCode = '+ IntToStr(data1.repSite));
    sql.Add('        union');
    sql.Add('      select 0, ''Complete Site'') sq');
    sql.Add('where stklcReps.hzid = sq.hzid');
    sql.Add('');

    if uGlobals.isSite then
    begin
      sql.Add('update stklcReps set cur = 1');
      sql.Add('from (select division, max(basedt) as themax from stkECLevel group by division) sq');
      sql.Add('where stklcReps.division = sq.division and stklcReps.basedt = sq.themax');
    end
    else
    begin
      cbcurrLC.Visible := False;
      label22.Visible := False;
    end;

    execSQL;

    close;
    sql.Clear;
    sql.Add('select distinct division from stklcreps');
    sql.Add('union select ('' - SHOW ALL - '') as divname');
    open;
    first;

    lookrepDiv.Items.Clear;
    while not eof do
    begin
      lookrepDiv.Items.Add(FieldByName('division').asstring);
      next;
    end;
  end;


  fillRepDiv := '';
  repGridFilt := '';
  repOnlyFilt := '';
  lookrepDiv.ItemIndex := 0;
  adotLCreps.Filter := '';
  ADOTlcreps.open;
  ADOTlcreps.IndexFieldNames := 'Division;BaseDT DESC;LCSCDT DESC';
  gridLCReps.Options := [dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,
                         dgRowSelect,dgAlwaysShowSelection,dgConfirmDelete,dgCancelOnExit,
                         dgWordWrap]; // ,dgMultiSelect];
  label23.caption :=
 'Click on a Field Title to order grid by that field with newest at top (Title will turn Yellow)' +
  #13 + '  ' + #13 +
 'Click a Yellow Title to order with oldest at top (Title will turn Red)' +
  #13 + '  ' + #13 +
 'Click "Division" to go back to Default order' + #13 +
 '(Div > Base DT > LC/SC DT) newest at top.';

//
//        'Click on a Field Title to order grid by that field (Title will turn Yellow)' +
//        'Click "Division" or a Yellow Title' + #13 +
//        ' to go back to Default order' + #13 + '(Div > Base DT > LC/SC DT)';// + #13 + '  ' + #13 +
//        //'Use Shift-Left Click for Range Select, Left Click to Un-Select';
end;

procedure TfLCRep.gridLCRepsCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if not Highlight then
  begin
    if adotLCReps.FieldByName('LCID').IsNull and
      (not adotLCReps.FieldByName('SCID').IsNull) then
      aBrush.Color := clBtnFace
    else
      aBrush.Color := clWhite;
  end;


  if adotLCReps.FieldByName('cur').AsBoolean then
    AFont.Style := [fsBold]
  else
    AFont.Style := [];
end;

procedure TfLCRep.ppDetailBand1BeforePrint(Sender: TObject);
begin
  ppLabelPrepItem2.Visible := (adoqSlave.FieldByName('IsPreparedItem').AsInteger = 1);
  ppline12.Visible := not ppLabelPrepItem2.Visible;
  ppline14.Visible := not ppLabelPrepItem2.Visible;

  if ppDBText4.Text = '1' then
    pplabel7.Caption := 'SC'
  else
    pplabel7.Caption := 'LC';

  ppDBText5.Visible := (ppDBText5.FieldValue <> 0);

  ppDBText10.Visible := (ppDBText10.FieldValue <> 0);
end;

procedure TfLCRep.ppHeaderBand3BeforePrint(Sender: TObject);
begin
  if pplgsmall.DeviceType = 'Printer' then
  begin
    pplabel230.visible := False;
    ppshape20.visible := False;
  end
  else
  begin
    pplabel230.visible := true;
    ppshape20.visible := true;
  end;

end;

end.
