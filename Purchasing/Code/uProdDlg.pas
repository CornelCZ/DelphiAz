unit uProdDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask, Grids, Wwdbigrd, Wwdbgrid, DBTables, Wwquery,
  Db, Wwdatsrc, Buttons, DBGrids, ppCtrls, ppClass, ppBands,
  ComCtrls, ppPrnabl, ppCache, ppComm, ppReport, ppDB, ppDBBDE, ppProd,
  ppDBPipe, ppVar, ppRelatv, Variants, ADODB;

type
  TfProddlg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    wwDataSource1: TwwDataSource;
    wwDataSource2: TwwDataSource;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Shape1: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Shape2: TShape;
    wwDBGrid1: TwwDBGrid;
    ppReport1: TppReport;
    ppReport1HeaderBand1: TppHeaderBand;
    ppReport1DetailBand1: TppDetailBand;
    ppReport1FooterBand1: TppFooterBand;
    wwDataSource3: TwwDataSource;
    ppReport1Group1: TppGroup;
    ppReport1GroupFooterBand1: TppGroupFooterBand;
    ppReport1GroupHeaderBand1: TppGroupHeaderBand;
    ppReport1Group2: TppGroup;
    ppReport1GroupFooterBand2: TppGroupFooterBand;
    ppReport1GroupHeaderBand2: TppGroupHeaderBand;
    ppReport1Group3: TppGroup;
    ppReport1GroupFooterBand3: TppGroupFooterBand;
    ppReport1GroupHeaderBand3: TppGroupHeaderBand;
    ppReport1DBText1: TppDBText;
    ppReport1Line1: TppLine;
    ppReport1DBText2: TppDBText;
    ppReport1DBText3: TppDBText;
    ppReport1DBText4: TppDBText;
    ppReport1DBText5: TppDBText;
    ppReport1DBText6: TppDBText;
    ppReport1DBText7: TppDBText;
    ppReport1DBText8: TppDBText;
    ppReport1DBText9: TppDBText;
    ppReport1DBText10: TppDBText;
    ppReport1Line2: TppLine;
    ppReport1Line3: TppLine;
    ppReport1Line4: TppLine;
    ppReport1Line5: TppLine;
    ppReport1Line6: TppLine;
    ppReport1Line7: TppLine;
    ppReport1Line8: TppLine;
    ppReport1Line9: TppLine;
    ppReport1Line10: TppLine;
    ppReport1Line11: TppLine;
    ppReport1Line18: TppLine;
    ppReport1Line20: TppLine;
    ppReport1Line21: TppLine;
    ppReport1Line22: TppLine;
    ppReport1Line23: TppLine;
    ppReport1Label1: TppLabel;
    ppReport1Label2: TppLabel;
    ppReport1Label3: TppLabel;
    ppReport1Label4: TppLabel;
    ppReport1Label5: TppLabel;
    ppReport1Label6: TppLabel;
    ppReport1Label8: TppLabel;
    ppReport1Label9: TppLabel;
    ppReport1Label10: TppLabel;
    ppReport1Label11: TppLabel;
    ppReport1DBCalc1: TppDBCalc;
    ppReport1DBCalc2: TppDBCalc;
    ppReport1DBCalc3: TppDBCalc;
    ppReport1DBCalc4: TppDBCalc;
    ppReport1DBCalc5: TppDBCalc;
    ppReport1DBCalc6: TppDBCalc;
    ppReport1Line12: TppLine;
    ppReport1Line13: TppLine;
    ppReport1Line14: TppLine;
    ppReport1Line15: TppLine;
    ppReport1Line16: TppLine;
    ppReport1Line17: TppLine;
    ppReport1Line24: TppLine;
    ppReport1Label7: TppLabel;
    ppReport1Line25: TppLine;
    ppReport1Line26: TppLine;
    ppReport1Line19: TppLine;
    ppReport1Line27: TppLine;
    ppReport1Line28: TppLine;
    ppReport1Line29: TppLine;
    ppReport1Line30: TppLine;
    ppReport1Line31: TppLine;
    ppReport1TitleBand1: TppTitleBand;
    ppReport1Label14: TppLabel;
    pplabTheTime: TppLabel;
    stPick: TDateTimePicker;
    EndPick: TDateTimePicker;
    prodpipe: TppBDEPipeline;
    ppReport1Calc1: TppSystemVariable;
    wwtProduct2: TADOTable;
    wwtProduct: TADOTable;
    wwqReport: TADOQuery;
    wwqProd1_2: TADOQuery;
    wwqGetAllProd: TADOQuery;
    wwqPutFlavor: TADOQuery;
    wwqProdAllSup: TADOQuery;
    wwqget1Prod: TADOQuery;
    wwqget1Prodsupplier: TStringField;
    wwqget1ProdMinUCost: TBCDField;
    wwqget1ProdAvgUCost: TBCDField;
    wwqget1ProdMaxUCost: TBCDField;
    wwqget1ProdSumQty: TFloatField;
    wwqget1ProdSumICost: TBCDField;
    wwqget1ProdAvgICost: TFloatField;
    wwqProdAllSupitemid: TFloatField;
    wwqProdAllSupMinUCost: TBCDField;
    wwqProdAllSupMaxUCost: TBCDField;
    wwqProdAllSupAvgUcost: TBCDField;
    wwqProdAllSupAvgItemCost: TFloatField;
    wwqProdAllSupSumQty: TFloatField;
    wwqProdAllSupSumItemCost: TBCDField;
    QryRun: TADOQuery;
    wwDBGrid2: TwwDBGrid;
    ppLabel1: TppLabel;
    SiteNameLabel: TppLabel;
    ppReport1Calc2: TppSystemVariable;
    ppReport1Label13: TppLabel;

    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure stPickKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EndPickKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure wwDBGrid2CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure ppReport1PreviewFormCreate(Sender: TObject);
      
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fProddlg: TfProddlg;

implementation

uses
  uADO, uLog, uGlobals;

{$R *.DFM}

procedure TfProddlg.BitBtn3Click(Sender: TObject);
var
  //yrend,usyrend,ukyrend,
  stdate,enddate: string;
  syr,smth,sdy: word;
  eyr,emth,edy: word;
  chunkfile, selectList, whereStr: String;
  Mappings: TStrings;
begin
  log.event('fProddlg; Execute button pressed');
  screen.Cursor := crHourGlass;

  if bitbtn3.Caption = 'Execute' then
  begin
    //replacement code for above - MH 3/10/1999
    // pickdates are y2k compliant and don't need to check for UK system date format
    stdate  := formatdatetime('mm/dd/yyyy',stpick.date);
    enddate := formatdatetime('mm/dd/yyyy',endpick.date);

    //chunk dates
    decodedate(stpick.date,syr,smth,sdy);
    decodedate(endpick.date,eyr,emth,edy);

    selectList := 'p.[entity code], e.[purchase name], p.[unit name],' + #13#10+
                  'p.[flavour], p.[supplier name], CAST (p.[cost per unit] as money) AS [cost per unit],' +#13#10+
                  'e.[Whether Sales Taxable], p.[quantity], p.[total cost]' +#13#10;

    whereStr := 'where (p.[delivery note no.] = h.[delivery note no.])'+#13#10+
                'and (e.[entity code] = p.[entity code])'+#13#10+
                'and (p.[unit name] is not null)'+#13#10+
                'and p.[cost per unit] > 0.0'+#13#10+
                'and p.[quantity] > 0'+#13#10+
                'and h.[date] BETWEEN ''' + stdate + ''' AND ''' + enddate + ''''+#13#10;
                
    if IsSite and not IsMaster then
      whereStr := whereStr +
          'and h.[Supplier Name] IN ' + #13#10 +
          '  (SELECT s2.[Supplier Name] ' + #13#10 +
          '   FROM (select * from ac_SiteSuppliers where SiteId = dbo.fnGetSiteCode()) s1 LEFT OUTER JOIN Supplier s2 ' + #13#10 +
          '      ON s1.SupplierID = s2.[Supplier Code] ' + #13#10 +
          '   WHERE s1.SiteID = '+IntToStr(SiteCode) +') ';

    if sitecode > 0 then
      whereStr := whereStr + 'and h.[Site code] = '+ IntToStr(SiteCode);

    wwtProduct.close;
    dmADO.EmptySQLTable('Product');
    if dmADO.SQLTableExists('#tmpProduct') then dmado.DelSQLTable('#tmpProduct');

    // get current invoice data and make sure the tmp table is created.
    with wwqgetallprod do
    begin
       close;
       sql.Clear;
       // SELECT INTO used to add to the tmp table
       sql.Add('SELECT ' + selectList);
       sql.add('INTO #tmpProduct');
       sql.add('from purchase p, purchhdr h, entity e ');
       sql.add(whereStr);
       sql.Add('and h.[deleted] is null');
       try
         ExecSQL;
       except
         on E: Exception do
         begin
           Log.Event('fProddlg; ERROR - ExecuteButton: getting current invoice data - ' + E.Message + wwqGetAllProd.SQL.Text);
           raise;
         end;
       end;
    end;

    // check for accepted chunk tables between period dates (inclusive)
    while ((smth <= emth) AND (syr <= eyr)) OR ((smth > emth) AND (syr < eyr)) do
    begin
      chunkfile := 'acc'+ Formatdatetime('mmmyy', EncodeDate(syr,smth,sdy));
      try
        try
          with wwqgetallprod do
          begin
            close;
            sql.Clear;
            // INSERT INTO used to add to the tmp table
            sql.Add('INSERT INTO #tmpProduct');
            sql.add('SELECT ' + selectList);
            sql.add('FROM Accpurhd h'+', '+chunkfile+' p, [entity] e');
            sql.add(whereStr);
            ExecSQL;
          end; //with
        except
          //chunk file doesn't exist, ignore and get next one.
        end;
      finally
        //increment the (chunk) month to look for, year change is automatic
        decodedate(incMonth(EncodeDate(syr,smth,sdy),1),syr,smth,sdy);
      end;
    end; // while

    // get invoice data from ACCPURCH
    with wwqgetallprod do
    begin
       close;
       sql.Clear;
       // INSERT INTO used to add to the tmp table
       sql.add('INSERT INTO #tmpProduct');
       sql.Add('SELECT '+selectList );
       sql.add('from Accpurch p, Accpurhd h, entity e ');
       sql.add(whereStr);
       try
         ExecSQL;
       except
         on E: Exception do
         begin
           Log.Event('fProddlg; ERROR - ExecuteButton: getting accepted invoice data - ' + E.Message + wwqGetAllProd.SQL.Text);
           raise;
         end;
       end;
    end;

    // borrow the wwtProduct component for a wee sec.....
    wwtProduct.TableName := '#tmpProduct';
    wwtProduct.Open;
    if wwtProduct.RecordCount = 0 then
    begin
      MessageDlg('There is no product data for this time period', mtInformation, [mbOK], 0);
      wwqgetallprod.Close;
      wwtProduct.Close;
      screen.Cursor := crDefault;
      exit;
    end;
    wwqgetallprod.Close;
    wwtProduct.Close;
    wwtProduct.TableName := 'Product'; // ..... and give it back to Product. cheers mate!

    // format the tmpProduct table so that unit and item cost are null
    // if "view cost prices" is disabled for a particular supplier
    with QryRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE [#tmpProduct]');
      SQL.Add('SET [cost per unit] = NULL, [total cost] = NULL');
      SQL.Add('WHERE ([supplier name] IN ');
      SQL.Add('(SELECT s.[supplier name] FROM vwSupplier s WHERE s.[view cost prices] = ''N''))');
      try
        ExecSQL;
      except
        on E: Exception do
        begin
          Log.Event('fProddlg; ERROR - ExecuteButton: setting costs fields to null - ' + E.Message + qryRun.SQL.Text);
          raise;
        end;
      end;
    end;
    // run the summing qry and batchmove it into product.
    Mappings := TStringList.Create;
    Mappings.Add('entity code=itemid');
    Mappings.Add('unit name=punit');
    Mappings.Add('flavour=flavor');
    Mappings.Add('supplier name=supplier');
    Mappings.Add('purchase name=itemname');
    Mappings.Add('cost per unit=ucost');
    Mappings.Add('whether sales taxable=tax');
    Mappings.Add('quantity=qty');
    Mappings.Add('total cost=itemcost');

    with wwqGetAllProd do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT [entity code], [purchase name], [unit name],'+#13+
              '[flavour], [supplier name], [cost per unit],'+#13+
              '[Whether Sales Taxable], sum([quantity])as Quantity,'+#13+
              'sum([total cost]) as [Total Cost]'+#13);
      sql.Add('FROM #tmpProduct');
      sql.Add('group by  [entity code], [purchase name], [unit name],'+#13+
              '[flavour], [supplier name], [cost per unit],'+#13+
              '[Whether Sales Taxable]'+#13);
      try
        open;
      except
        on E: Exception do
        begin
          Log.Event('fProddlg; ERROR - ExecuteButton: Summing qty and total cost - ' + E.Message + wwqGetAllProd.SQL.Text);
          raise;
        end;
      end;
      if RecordCount > 0 then
        dmADO.BatchMove(wwqGetAllProd, wwtProduct, Mappings);
      close;
    end;

    Mappings.Free;

    try
      wwqputflavor.ExecSQL;
    except
      on E: Exception do
      begin
        Log.Event('fProddlg; ERROR - ExecuteButton: wwqputflavor query - ' + E.Message + wwqputflavor.SQL.Text);
        raise;
      end;
    end;

    try
      wwqprod1_2.open;
    except
      on E: Exception do
      begin
        Log.Event('fProddlg; ERROR - ExecuteButton: wwqProd1_2 query - ' + E.Message + wwqProd1_2.SQL.Text);
        raise;
      end;
    end;
    wwtproduct2.close;
    dmADO.EmptySQLTable('Product2');

    Mappings := TStringList.Create;
    try
      Mappings.Add('itemid=itemid');
      Mappings.Add('punit=punit');
      Mappings.Add('flavor=flavor');
      Mappings.Add('itemname=itemname');
      Mappings.Add('ucost=ucost');
      Mappings.Add('tax=tax');
      Mappings.Add('qty=qty');
      Mappings.Add('itemcost=itemcost');

      dmADO.BatchMove(wwqProd1_2, wwtProduct2, Mappings);
    finally
      Mappings.Free;
    end;

    wwqprod1_2.close;

    try
      wwqprodallsup.Open;
    except
      on E: Exception do
      begin
        Log.Event('fProddlg; ERROR - ExecuteButton: wwqProdAllSup query - ' + E.Message + wwqProdAllSup.SQL.Text);
        raise;
      end;
    end;

    try
      wwqget1prod.Open;
    except
      on E: Exception do
      begin
        Log.Event('fProddlg; ERROR - ExecuteButton: wwqGet1Prod query - ' + E.Message + wwqGet1Prod.SQL.Text);
        raise;
      end;
    end;

    // all supplier grid
    wwqProdAllSupMinUCost.DisplayFormat := '0.0000';
    wwqProdAllSupMaxUCost.DisplayFormat := '0.0000';
    wwqProdAllSupAvgUcost.DisplayFormat := '0.0000';
    wwqProdAllSupAvgItemCost.DisplayFormat := '0.0000';
    wwqProdAllSupSumQty.DisplayFormat := '0.00';
    wwqProdAllSupSumItemCost.DisplayFormat := '0.0000';

    if UKUSmode = 'US' then
      wwqProdAllSup.FieldByName('Flavor').DisplayLabel := 'Flavor'
    else
      wwqProdAllSup.FieldByName('Flavor').DisplayLabel := 'Flavour';

    // 1 supplier grid
    wwqget1ProdMinUCost.DisplayFormat := '0.0000';
    wwqget1ProdAvgUCost.DisplayFormat := '0.0000';
    wwqget1ProdMaxUCost.DisplayFormat := '0.0000';
    wwqget1ProdSumQty.DisplayFormat := '0.00';
    wwqget1ProdSumICost.DisplayFormat := '0.0000';
    wwqget1ProdAvgICost.DisplayFormat := '0.0000';

    stpick.Enabled := false;
    endpick.Enabled := false;
    bitbtn3.Caption := 'New Time Period';
    bitbtn2.Enabled := True;
  end
  else
  begin
    wwqprodallsup.close;
    wwqget1prod.close;
    stpick.Enabled := true;
    endpick.enabled := true;
    bitbtn3.Caption := 'Execute';
    bitbtn2.Enabled := false;
    stpick.SetFocus;
  end;
  screen.Cursor := crDefault;
end;

procedure TfProddlg.FormShow(Sender: TObject);
begin
  self.Caption := 'Product Analysis - '+SiteName;
  stpick.Date := Date;
  endpick.Date := Date;
  stpick.SetFocus;
end;

procedure TfProddlg.BitBtn2Click(Sender: TObject);
begin
  log.event('fProddlg; Print button pressed');
  try
    wwqReport.open;
  except
    on E: Exception do
    begin
      Log.Event('fProddlg; ERROR - PrintButton: wwqReport query - ' + E.Message + wwqReport.SQL.Text);
      raise;
    end;
  end;

  // datetostr changed to formatdatetime - MH 10/12/1999
  pplabthetime.Caption := FormatDateTime('ddddd',stpick.date) + ' - ' +
                                      FormatDateTime('ddddd',endpick.date);
  if UKUSmode = 'UK' then
  begin
    ppReport1Label10.Caption := 'Flavour:';
//    ppReport1.PrinterSetup.PaperName := 'A4';
  end
  else
  begin
    ppReport1Label10.Caption := 'Flavor:';
//    ppReport1.PrinterSetup.PaperName := 'Letter';
  end;
  SiteNameLabel.Caption := SiteName;
  ppReport1.Print;
  wwqReport.Close;
end;

procedure TfProddlg.stPickKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
    endpick.setfocus;
end;

procedure TfProddlg.EndPickKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
    bitbtn3.setfocus;
end;

procedure TfProddlg.FormCreate(Sender: TObject);
begin
  log.event('fProddlg; FormCreate');

  if purchHelpExists then
    setHelpContextID(self, HLP_PRODUCT_ANALYSIS);
end;

procedure TfProddlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  log.event('fProddlg; FormClose');
end;

procedure TfProddlg.wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if (field.Text = '') and
     ((field.FieldName = 'MinUCost') or
      (field.FieldName = 'MaxUCost') or
      (field.FieldName = 'AvgUcost') or
      (field.FieldName = 'AvgItemCost') or
      (field.FieldName = 'SumItemCost')) then
    ABrush.Color := clBtnFace;
end;



procedure TfProddlg.wwDBGrid2CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if (field.Text = '') and
   ((field.FieldName = 'MinUCost') or (field.FieldName = 'MaxUCost') or
    (field.FieldName = 'AvgUCost') or (field.FieldName = 'AvgICost') or
    (field.FieldName = 'SumICost')) then
    Abrush.Color := clBtnFace;

end;

procedure TfProddlg.ppReport1PreviewFormCreate(Sender: TObject);
begin
  dmADO.ReportPreviewFormCreate(Sender);
end;

end.
