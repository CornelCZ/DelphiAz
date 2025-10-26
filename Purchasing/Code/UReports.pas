unit UReports;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  wwdbedit, Wwdotdot, Wwdbcomb, StdCtrls, Mask, ExtCtrls, Grids, Wwdbigrd,
  Wwdbgrid, Db, DBTables, Wwtable, Buttons, Wwdatsrc, Wwquery, Wwkeycb,
  ppBands, ppClass, ppCtrls, ComCtrls, ppDB, ppDBBDE, ppPrnabl, ppCache,
  ppComm, ppReport, ppProd, ppVar, ppDBPipe, ppRelatv, ppTypes,
  Variants, ADODB, Math, DateUtils;

type
  TfReports = class(TForm)
    GridVendors: TwwDBGrid;
    Panel2: TPanel;
    BitBtnClose: TBitBtn;
    DatesDS: TwwDataSource;
    GridTotals: TwwDBGrid;
    totalsDS: TwwDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RadioButtonVendor: TRadioButton;
    RadioButtonItem: TRadioButton;
    Combo1: TwwDBComboBox;
    BitBtnView: TBitBtn;
    Panel3: TPanel;
    GridItems: TwwDBGrid;
    Label5: TLabel;
    Search1: TwwIncrementalSearch;
    Panel4: TPanel;
    SpeedButtonSubcateg: TSpeedButton;
    SpeedButtonItem: TSpeedButton;
    Search2: TwwIncrementalSearch;
    Label6: TLabel;
    SpeedButtonVendor: TSpeedButton;
    SpeedButtonInvoiceNo: TSpeedButton;
    SpeedButtonDate: TSpeedButton;
    BitBtnPrint: TBitBtn;
    VendReport: TppReport;
    VendReportHeaderBand1: TppHeaderBand;
    VendReportDetailBand1: TppDetailBand;
    VendReportFooterBand1: TppFooterBand;
    ItemReport: TppReport;
    VendReportGroup1: TppGroup;
    VendReportGroupFooterBand1: TppGroupFooterBand;
    VendReportGroupHeaderBand1: TppGroupHeaderBand;
    VendReportShape1: TppShape;
    VendReportShape2: TppShape;
    VendReportLabel1: TppLabel;
    VendReportLabel2: TppLabel;
    VendReportShape3: TppShape;
    VendReportDBText1: TppDBText;
    VendReportShape4: TppShape;
    VendReportShape5: TppShape;
    VendReportLabel4: TppLabel;
    VendReportLabel5: TppLabel;
    rptDivnLabel1: TppLabel;
    rptDivnLabel2: TppLabel;
    rptDivnLabel3: TppLabel;
    rptDivnLabel4: TppLabel;
    rptDivnLabel5: TppLabel;
    rptDivnLabelTotal: TppLabel;
    VendReportDBText2: TppDBText;
    VendReportDBText3: TppDBText;
    rptVendDBText1: TppDBText;
    rptVendDBText2: TppDBText;
    rptVendDBText3: TppDBText;
    rptVendDBText4: TppDBText;
    rptVendDBText5: TppDBText;
    VendReportDBText9: TppDBText;
    VendReportLine1: TppLine;
    VendReportLine2: TppLine;
    VendReportLine3: TppLine;
    VendReportLine4: TppLine;
    VendReportLine5: TppLine;
    VendReportLine6: TppLine;
    VendReportLine7: TppLine;
    VendReportLine8: TppLine;
    VendReportLine9: TppLine;
    VendReportLine10: TppLine;
    VendReportLine11: TppLine;
    VendReportLine12: TppLine;
    VendReportLine13: TppLine;
    VendReportLine14: TppLine;
    VendReportSummaryBand1: TppSummaryBand;
    VendReportShape6: TppShape;
    VendReportLine15: TppLine;
    VendReportLine16: TppLine;
    VendReportLine17: TppLine;
    VendReportLine18: TppLine;
    VendReportLine19: TppLine;
    rptTotalsSumDBText1: TppDBCalc;
    rptTotalsSumDBText2: TppDBCalc;
    rptTotalsSumDBText3: TppDBCalc;
    rptTotalsSumDBText4: TppDBCalc;
    rptTotalsSumDBText5: TppDBCalc;
    VendReportDBCalc6: TppDBCalc;
    VendReportLabel12: TppLabel;
    ItemReportHeaderBand1: TppHeaderBand;
    ItemReportDetailBand1: TppDetailBand;
    ItemReportFooterBand1: TppFooterBand;
    ItemReportShape1: TppShape;
    ItemReportShape2: TppShape;
    ItemReportLabel1: TppLabel;
    ItemReportLabel2: TppLabel;
    ItemReportGroup1: TppGroup;
    ItemReportGroupFooterBand1: TppGroupFooterBand;
    ItemReportGroupHeaderBand1: TppGroupHeaderBand;
    ItemReportShape3: TppShape;
    ItemReportDBText1: TppDBText;
    ItemReportShape4: TppShape;
    ItemReportLabel4: TppLabel;
    ItemReportLabel5: TppLabel;
    ItemReportLabel6: TppLabel;
    ItemReportLabel7: TppLabel;
    ItemReportLabel8: TppLabel;
    ItemReportLabel9: TppLabel;
    ItemReportLabel10: TppLabel;
    ItemReportLine1: TppLine;
    ItemReportLine2: TppLine;
    ItemReportLine3: TppLine;
    ItemReportLine4: TppLine;
    ItemReportLine5: TppLine;
    ItemReportLine6: TppLine;
    ItemReportShape5: TppShape;
    ItemReportLine7: TppLine;
    ItemReportLine8: TppLine;
    ItemReportLine9: TppLine;
    ItemReportLine10: TppLine;
    ItemReportLine11: TppLine;
    ItemReportLine12: TppLine;
    ItemReportDBText2: TppDBText;
    ItemReportDBText3: TppDBText;
    ItemReportDBText4: TppDBText;
    ItemReportDBText5: TppDBText;
    ItemReportDBText6: TppDBText;
    ItemReportDBText7: TppDBText;
    ItemReportDBText8: TppDBText;
    ItemReportLabel11: TppLabel;
    VendRepDS: TwwDataSource;
    ItemRepDS: TwwDataSource;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    StPick: TDateTimePicker;
    EndPick: TDateTimePicker;
    vendpipe: TppBDEPipeline;
    itempipe: TppBDEPipeline;
    combo2: TwwDBComboBox;
    Label10: TLabel;
    ItemReportLabel12: TppLabel;
    divlabel: TppLabel;
    VendReportLabel3: TppLabel;
    vendlab: TppLabel;
    VendReportShape7: TppShape;
    VendReportLine20: TppLine;
    VendReportLine21: TppLine;
    VendReportLine22: TppLine;
    VendReportLine23: TppLine;
    VendReportLine24: TppLine;
    rptVendSumDBText1: TppDBCalc;
    rptVendSumDBText2: TppDBCalc;
    rptVendSumDBText3: TppDBCalc;
    rptVendSumDBText4: TppDBCalc;
    rptVendSumDBText5: TppDBCalc;
    VendReportDBCalc12: TppDBCalc;
    VendReportLabel13: TppLabel;
    VendReportLine25: TppLine;
    Label11: TLabel;
    Label12: TLabel;
    VendReportLabel14: TppLabel;
    VendReportCalc1: TppSystemVariable;
    ItemReportCalc1: TppSystemVariable;
    ItemReportCalc2: TppSystemVariable;
    DatesQuery: TADOQuery;
    Ptab1: TADOTable;
    wwqRun: TADOQuery;
    Distinctqry: TADOQuery;
    Ptab2: TADOTable;
    SumQry: TADOQuery;
    wwqGetTax: TADOQuery;
    Totalsqry: TADOQuery;
    ITab1: TADOTable;
    Ptab3: TADOTable;
    ITab2: TADOTable;
    Items1qry: TADOQuery;
    VendTabOrdqry: TADOQuery;
    ItemTabOrdqry: TADOQuery;
    Items2qry: TADOQuery;
    invnoqry: TADOQuery;
    vendqry: TADOQuery;
    invdateqry: TADOQuery;
    subcatqry: TADOQuery;
    itemordqry: TADOQuery;
    qryPZrun: TADOQuery;
    itemsds: TwwDataSource;
    ppDBText1: TppDBText;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppShape1: TppShape;
    qryItemsforDisplay: TADOQuery;
    qryItemsforDisplaySiteCode: TSmallintField;
    qryItemsforDisplaySubCat: TStringField;
    qryItemsforDisplayEntityName: TStringField;
    qryItemsforDisplayInvoiceNo: TStringField;
    qryItemsforDisplayInvoiceDate: TDateTimeField;
    qryItemsforDisplayQuantity: TFloatField;
    qryItemsforDisplayCost: TBCDField;
    qryItemsforDisplayTotalQty: TFloatField;
    qryItemsforDisplayTotalCost: TFloatField;
    ppDBText2: TppDBText;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppLabel1: TppLabel;
    SpeedButtonSite: TSpeedButton;
    qryRun2: TADOQuery;
    rptDivnLabel6: TppLabel;
    rptDivnLabel7: TppLabel;
    rptDivnLabel8: TppLabel;
    rptDivnLabel9: TppLabel;
    rptDivnLabel10: TppLabel;
    rptDivnLabel11: TppLabel;
    rptVendDBText8: TppDBText;
    rptVendDBText6: TppDBText;
    rptVendDBText7: TppDBText;
    rptVendDBText9: TppDBText;
    rptVendDBText10: TppDBText;
    rptVendDBText11: TppDBText;
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
    rptDivnLabel12: TppLabel;
    rptVendDBText12: TppDBText;
    ppLine25: TppLine;
    ppLine26: TppLine;
    ppLine27: TppLine;
    ppLine28: TppLine;
    rptVendSumDBText6: TppDBCalc;
    rptVendSumDBText7: TppDBCalc;
    rptVendSumDBText8: TppDBCalc;
    rptVendSumDBText9: TppDBCalc;
    rptVendSumDBText10: TppDBCalc;
    rptTotalsSumDBText6: TppDBCalc;
    rptTotalsSumDBText7: TppDBCalc;
    rptTotalsSumDBText8: TppDBCalc;
    rptTotalsSumDBText9: TppDBCalc;
    rptTotalsSumDBText10: TppDBCalc;
    rptTotalsSumDBText11: TppDBCalc;
    rptTotalsSumDBText12: TppDBCalc;
    rptVendSumDBText11: TppDBCalc;
    rptVendSumDBText12: TppDBCalc;
    VendReportCalc2: TppSystemVariable;
    ppLabel2: TppLabel;
    PeriodLabel: TppLabel;
    ppLabel3: TppLabel;
    ItemRptPeriodLabel: TppLabel;
    qryItemsforDisplaySiteName: TStringField;
    ADOStoredProc: TADOStoredProc;
    minMaxDatesQry: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure BitBtnCloseClick(Sender: TObject);
    procedure RadioButtonItemClick(Sender: TObject);
    procedure RadioButtonVendorClick(Sender: TObject);
    procedure BitBtnViewClick(Sender: TObject);
    procedure CalculateTax;
    procedure buildTable;
    procedure FillTable;
    procedure SpeedButtonSubcategClick(Sender: TObject);
    procedure FormatTable;
    procedure DoReportsClose;
    procedure SpeedButtonItemClick(Sender: TObject);
    procedure SpeedButtonVendorClick(Sender: TObject);
    procedure SpeedButtonInvoiceNoClick(Sender: TObject);
    procedure SpeedButtonDateClick(Sender: TObject);
    procedure EndMaskKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtnPrintClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ItemReportDBText8GetText(Sender: TObject; var Text: String);
    procedure StPickKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EndPickKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure combo2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Combo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButtonSiteClick(Sender: TObject);
    procedure VendReportPreviewFormCreate(Sender: TObject);
    procedure ItemReportPreviewFormCreate(Sender: TObject);
  private
    errflag: boolean;
    procedure buildVendorReport;
    procedure setVendReportFields(fieldIndex: integer);
    procedure formatGridForVendRep;
    procedure formatGridForItemRep;
    procedure FormatCurrencyFields;
    procedure FormatItemsCurrencyFields;
    procedure GetMinAndMaxAccDates(var stAccDate: String; var endAccDate: String; var DataExists: boolean);
    procedure GetMinAndMaxPurDates(var stPurDate: String; var endPurDate: String; var DataExists: boolean);
    function GetChunkFiles: TStringList;
    function datesValid: boolean;
    procedure UpdateUKTax;
  public
    thetax: real;
    rep: integer;
    { Public declarations }
  end;

var
  fReports: TfReports;

const
  CurrencyFormat = '0.00';

implementation

uses
  uMainMenu, uDMWklyPrchRep, uADO, uGlobals, uLog;


{$R *.DFM}

procedure TfReports.FormShow(Sender: TObject);
begin
  fReports.Caption := GetLocalisedName(lsInvoice) + ' Reports - '+SiteName;
  RadioButtonVendor.Caption := 'Vendor ' + GetLocalisedName(lsInvoice);
  RadioButtonItem.Caption := 'Item ' + GetLocalisedName(lsInvoice);
  SpeedButtonInvoiceNo.Caption := GetLocalisedName(lsInvoice) + ' No. (F6)';

  ItemReportLabel5.Caption := GetLocalisedName(lsInvoice) + ' No.';
  ItemReportLabel11.Caption := '* Total for item on ' + GetLocalisedName(lsInvoice);
  VendReportLabel4.Caption := GetLocalisedName(lsInvoice) + ' Number';
  VendReportLabel14.Caption := '^ = Accepted ' + GetLocalisedName(lsInvoice);

  label9.visible := true;
  //panel3.visible := true;
  SpeedButtonVendor.Enabled := true;
  SpeedButtonDate.Enabled := true;
  SpeedButtonInvoiceNo.Enabled := true;
  label5.caption := 'Vendor Name';
  label6.caption := 'Sub-Category';
  GridVendors.Visible := true;
  thetax := fmainmenu.thetax;
  rep := fmainmenu.rep;

  // fill the lookup list 1 with all the available divisions
  with wwqRun do
  begin
    sql.Clear;
    sql.Add('select [division name] from division');
    sql.Add('order by [division name]');
    log.event('Reports; FormShow: wwqRun opened: ' + wwqRUn.SQL.Text);
    open;
    first;
    combo1.items.clear;
    while not eof do
    begin
      combo1.items.add(FieldByName('division name').asstring);
      next;
    end;
    combo1.ItemIndex := 0;
    close;
  end;

  // fill the lookup list 2 with all the available vendors
  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select [Supplier Name] from supplier');
    if IsSite and not IsMaster then
    begin
      SQL.Add('WHERE [Supplier Name] IN ');
      SQL.Add('  (SELECT s2.[Supplier Name] ');
      SQL.Add('   FROM (select * from ac_SiteSuppliers where SiteId = dbo.fnGetSiteCode()) s1 LEFT OUTER JOIN Supplier s2 ');
      SQL.Add('      ON s1.SupplierID = s2.[Supplier Code] ');
      SQL.Add('   WHERE s1.SiteID = '+IntToStr(SiteCode) +') ');
    end;
    sql.Add('order by [Supplier Name]');
    log.event('Reports; FormShow: wwqRun opened: ' + wwqRun.SQL.Text);
    open;
    first;
    combo2.items.clear;
    combo2.items.add('All Vendors');
    while not eof do
    begin
      combo2.items.add(FieldByName('Supplier Name').asstring);
      next;
    end;
    combo2.ItemIndex := 0;
    close;
  end;
  stpick.Date := Date;
  endpick.Date := Date;
  stpick.SetFocus;
end;

procedure TFreports.DoReportsClose;
begin
  ptab1.close;
  ptab2.close;
  ptab3.close;
  itab1.close;
  itab2.close;
  datesquery.close;
  distinctqry.close;
  sumqry.close;
  totalsqry.close;
  items1qry.close;
  items2qry.close;
  subcatqry.close;
  wwqRun.close;
end;

procedure TfReports.BitBtnCloseClick(Sender: TObject);
begin
  log.event('Reports; Close button pressed');
  DoReportsClose;
  GridVendors.datasource := nil;
  GridItems.datasource := nil;
  GridTotals.datasource := nil;
  close;
end;

procedure TfReports.RadioButtonItemClick(Sender: TObject);
begin
  if RadioButtonItem.checked = true then
  begin
    SpeedButtonSite.Visible := not isSite;
    GridItems.visible := true;
    label9.visible := false;
    GridTotals.visible := false;
    GridVendors.visible := false;
    combo1.visible := true;
    combo2.Visible := false;
    label10.Visible := false;
    label4.visible := true;
    stpick.setfocus;
  end;
end;

procedure TfReports.RadioButtonVendorClick(Sender: TObject);
begin
  GridVendors.visible := true;
  label9.visible := true;
  GridTotals.visible := true;
  GridItems.visible := false;
  combo1.visible := false;
  combo2.Visible := true;
  label10.Visible := true;
  label4.visible := false;
  stpick.setfocus;
end;

// runs through each record in the table and calculates the tax payable
// if applicable. This is added to the existing total cost to give a total
// for each item.

procedure Tfreports.CalculateTax;
begin
  with PTab3 do
  begin
    log.event('Reports; CalculateTax: PTab3 opened: ' + PTab3.TableName);
    Open;
    First;

    while not eof do
    begin
      Edit;

      if FieldByName('taxable').asstring = 'Y' then
      begin
        FieldByName('totalcost').asfloat :=
                   FieldByName('sumcost').asfloat + GetLocalisedItemTax(FieldByName('sumcost').asfloat,
                   theTax, False);
        fieldByName('TaxCost').asFloat := GetLocalisedItemTax(FieldByName('sumcost').asfloat, theTax, False);
      end
      else
      begin
        FieldByName('totalcost').asfloat := FieldByName('sumcost').asfloat;
        fieldByName('TaxCost').asFloat := 0.0;
      end;

      Next;
    end;
  end;

  if UKUSMode = 'UK' then
    UpdateUKTax;
end;

// build the report table based on division names
procedure Tfreports.buildTable;
var
  DivStr: String;
  divFieldList: TStringList;
  i: integer;
begin
  with wwqRun do
  begin
    try
      close;
      SQL.Clear;
      SQL.Add('DROP TABLE #tmpVendTab2');
      ExecSQL;
    except
    end;

    close;
    SQL.Clear;
    SQL.Add('SELECT a.[Site Code], b.[Site Name], a.[Vendor], a.[InvoiceNo], a.[InvoiceDate], a.[Tax], a.[Cost] as TotalCost, a.[Cost]');
    SQL.Add('INTO #tmpVendTab2');
    SQL.Add('FROM VendTab2 a, Site b');
    SQL.Add('WHERE a.[Site Code] = b.[Site Code]');
    SQL.Add('ORDER BY a.[Vendor], b.[Site Name], a.[InvoiceDate]');
    ExecSQL;
  end;

  divFieldList := TStringList.Create;
  with wwqRun do
  begin
    close;
    SQL.Clear;

    if UKUSMode = 'UK' then
    begin
      SQL.Add('SELECT DISTINCT [DivisionName] as [Division Name] FROM VendTab3');
      SQL.Add('ORDER BY [DivisionName]');
    end
    else
    begin
      SQL.Add('SELECT DISTINCT [division name] FROM Division');
      SQL.Add('ORDER BY [division name]');
    end;

    open;
    While not EOF do
    begin
      DivStr := '['+wwqRun.FieldByName('Division Name').AsString+']' + ' money';
      divFieldList.Add(wwqRun.FieldByName('Division Name').AsString);

      with qryRun2 do
      begin
        Close;
        SQL.Clear;
        SQL.Add('Alter Table #tmpvendTab2 ADD');
        SQL.Add(DivStr);
        log.event('Reports; BuildTable: qryRun2 executed: ' + qryRun2.SQL.Text);
        ExecSQL;
        wwqRun.next;
      end; //With QAlter
    end; //While
    qryRun2.Close;
  end; //with wwqRun

  // set all null fields to 0.0
  divFieldList.Add('tax');
  divFieldList.Add('Cost');
  for i := 0 to divFieldList.Count - 1 do
  begin
    with wwqRun do
    begin
      close;
      sql.Clear;
      sql.Add('update [#tmpvendtab2] SET ['+divFieldList[i]+ '] = 0.0');
      ExecSQL;
    end;
  end;
  divFieldList.Free;
end;


// Ptab 1 contains all the details of each invoice during the period. Each
// invoive is broken down into individual items/costs.
// Ptab2 initially contains the invoice date,number and vendor name only.
// these are selected from Ptab1.
// Ptab3 contains a breakdown of the items in each invoice in Ptab2. The items
// are broken down by invoice into different divisions, the cost for the items
// in that division and within each division there can also be some items which
// are taxable and some which are not. The totals for these are also shown
// individually.
// Scanning down Ptab3, each record has a matching invoice in Ptab2. The total
// for each division is added to anything already against that invoice/division
// and the total tax and total cost figures are applied.

procedure Tfreports.FillTable;
var
  divn, divnStr, totalsStr: String;
begin
  log.event('Reports; FillTable: FillTable ');
  with wwqrun do
  begin
    close;
    SQL.Clear;

    if UKUSMode = 'UK' then
    begin
      SQL.Add('SELECT DISTINCT DivisionName as [Division Name] FROM VendTab3');
      SQL.Add('ORDER BY [DivisionName]');
    end
    else
    begin
      SQL.Add('SELECT DISTINCT [division name] FROM Division');
      SQL.Add('ORDER BY [division name]');
    end;
    open;

    // these will be used l8r to update the cost field & totals grid later.
    divnStr := '';
    totalsStr := '';
    while not eof do
    begin
     divnStr := divnStr + '[' + fieldByName('division name').AsString + '] +';
     totalsStr := totalsStr +'SUM(['+ fieldByName('division name').AsString + ']) AS "'+fieldByName('division name').AsString+'",';
     next;
    end;
    //cut off the last '+' and ',' from the strings
    divnStr := copy(divnStr, 0, length(divnStr)-1);
    totalsStr := copy(totalsStr, 0, length(totalsStr)-1);
  end;

  wwqrun.first;
  While not wwqRun.EOF do
  begin
    divn := wwqrun.fieldbyname('division name').AsString;
    with qryrun2 do
    begin
      close;
      sql.Clear;
      sql.Add('UPDATE [#tmpvendtab2]');
      sql.Add('SET [' + divn + '] = vt3.SumDiv,');
      sql.Add('    [tax] = [Tax] + vt3.SumTax');
      sql.Add('from  (select [Vendor],');
      sql.Add('              [InvoiceNo],');
      sql.Add('              [InvoiceDate],');
      sql.Add('              [Site Code],');
      sql.Add('              sum([SumCost]) as SumDiv,');
      sql.Add('              sum([TaxCost]) as SumTax');
      sql.Add('       from vendtab3');
      sql.Add('       where [DivisionName] = ' + QuotedStr(divn));
      sql.Add('       group by [Vendor],[InvoiceNo],[InvoiceDate],[Site Code]) vt3,');
      sql.Add('     [#tmpvendtab2] vt2');
      sql.Add('WHERE vt2. vendor = vt3. vendor');
      sql.Add('AND vt2.invoiceno = vt3.invoiceno');
      sql.Add('AND vt2.invoicedate = vt3.invoicedate');
      sql.Add('AND vt2.[site code] = vt3.[site code]');
      ExecSQL
    end;
    wwqRun.Next;
  end;
  with qryrun2 do
  begin
    close;
    sql.Clear;
    sql.Add('UPDATE [#tmpvendtab2]');
    sql.Add('SET [cost] = '+divnStr);
    ExecSQL;

    SQL.Clear;
    sql.Add('UPDATE [#tmpvendtab2]');
    SQL.Add('set [TotalCost] = [Cost] + [Tax]');
    ExecSQL;
  end;

  with Totalsqry do
  begin
    close;
    sql.Clear;
    sql.Add('select sum(a."tax") as Tax, sum(a."cost") as Cost, '+totalsStr);

    if UKUSMode = 'UK' then
      SQL.Add(', sum(Tax) as VAT, sum(TotalCost) as [Total Cost]');

    sql.Add('from "#tmpvendtab2" a');
  end;

  qryRun2.Close;
  wwqRun.Close;
end;

// Itab1 contains the details of each item purchased during the period and
// its cost,sub-category, invoice no. etc.
// Itab2 is then filled with each distinct sub-category and item along with
// the total spent on it and the latest date it was purchased.
// Scanning down Itab2 each record has a match in Itab1 and to this is appended
// the details from Itab2.
// For each record in Itab2 there could be several matches (sub-cat & item) in
// Itab1 but the total values are only applied to the latest purchase. This is
// denoted by placing a * after the item name on the report.

procedure Tfreports.FormatTable;
begin
  log.event('Reports; FormatTable: summarising ItemTab1 totals into #GhostSums');
  if dmADO.SQLTableExists('#GhostSums') then dmAdo.DelSQLTable('#GhostSums');
  with wwqrun do
  begin
    close;
    SQL.Clear;
    SQL.Add('SELECT [SubCat], [EntityCode], [EntityName], [InvoiceNo], [InvoiceDate],');
    SQL.Add('       sum([Quantity]) as Quantity, sum([Cost]) as Cost, sum([TotalQty]) as TotalQty,');
    SQL.Add('       sum([TotalCost]) as TotalCost, [Site Code]');
    SQL.Add('INTO #GhostSums');
    SQL.Add('FROM [ItemTab1]');
    SQL.Add('GROUP BY [SubCat], [EntityCode], [EntityName], [InvoiceNo], [InvoiceDate], [Site Code]');
    ExecSQL;
    close;
  end;
  if dmADO.SQLTableExists('ItemTab1') then dmADO.DelSQLTable('ItemTab1');
  log.event('Reports; FormatTable: Overwriting ItemTab1 from #GhostSums');
  with wwqrun do
  begin
    close;
    SQL.Clear;
    SQL.Add('SELECT [SubCat], [EntityCode], [EntityName], [InvoiceNo], [InvoiceDate],');
    SQL.Add('       [Quantity], [Cost], [TotalQty], [TotalCost], [Site Code]');
    SQL.Add('INTO ItemTab1');
    SQL.Add('FROM [#GhostSums]');
    ExecSQL;
    close;
  end;

  log.event('Reports; FormatTable: iTab1 opened: ' + iTab1.TableName);
  itab1.open;
  with itab2 do
  begin
    log.event('Reports; FormatTable: iTab2 opened: ' + iTab2.TableName);
    open;
    first;
    while not eof do
    begin
      if itab1.locate('subcat;entitycode;entityname;InvoiceDate',
                   VarArrayOf([FieldByName('subcat').asstring,
                                FieldByName('entitycode').AsVariant,
                               FieldByName('entityname').asstring,
                             FieldByName('Invoicedate').asdatetime]),[]) then
      begin
        itab1.edit;
        itab1.FieldByName('entitycode').AsFloat := ITab2.FieldbyName('entitycode').AsFloat;
        itab1.FieldByName('entityname').asstring :=
                             itab2.FieldByName('entityname').asstring + ' *';
        itab1.FieldByName('totalqty').asfloat :=
                                              FieldByName('quantity').asfloat;
        itab1.FieldByName('totalcost').asfloat := FieldByName('cost').asfloat;
        itab1.FieldByName('invoicedate').asdatetime :=
                                        FieldByName('invoicedate').asdatetime;
        itab1.post;
      end;
      itab2.next;
    end;
    close;
  end;
  itab2.close;
end;

// Main calling routine for the reports...
// 24/11/99 Updated to include accepted invoices and chunks - MH
procedure TfReports.BitBtnViewClick(Sender: TObject);
var
  stAccDate,endAccDate,stPurDate,endPurDate: string;
  i: integer;
  SelStr, WhereStr, hoORsiteStr, OrdStr: string;
  chunksList, mappings: TStringList;
  chunkHdrDataExists, purchHdrDataExists: boolean;
begin
  log.event('Reports; View button pressed');
  try
    try
      { TODO -owilma -ctidy up : 
Shouldn't the check on BitBtnView caption be done before the datesValid
check?  When the user selects the button with caption 'Change' then 
it doesn't matter if the dates are valid or not }
      if datesValid then
      begin
        screen.Cursor := crHourGlass;
        if BitBtnView.Caption = '&View' then
        begin
          //change for ADO!!!
          GridVendors.datasource := datesds;
          GridItems.datasource := itemsds;
          GridTotals.datasource := totalsds;
          DoReportsClose;

          if errflag then
            exit;

          chunksList := GetChunkFiles;

          GetMinAndMaxAccDates(stAccDate, endAccDate, chunkHdrDataExists);
          GetMinAndMaxPurDates(stPurDate, endPurDate, purchHdrDataExists);

          // vendor invoice report
          if RadioButtonVendor.checked  then
          begin
            GridItems.visible := false;
            ptab2.disablecontrols;
            // empty the table
            dmADO.EmptySQLTable('VendTab1');
            //set common sql strings
            // no dates in SQL, will cause probs

            { Job 18648 - add flavour to select statement to ensure that all items are
                included in the calculation.}
            { Job 18887 - added Record ID to select statement to ensure that duplicate items
                with the same quantity are included in the calculation }
            SelStr := 'select distinct a.[Site Code], a.[delivery note no.], a.[date],'+#13+
                      'a.[supplier name], b.[Record ID], b.[entity code], b.[total cost], b.[flavour],'+#13+
                      'c.[division name], d.[whether sales taxable]'+#13;

            if SiteCode = 0 then
              hoORsiteStr := 'where (a.[Site Code] = b.[Site Code])'
            else
              hoORsiteStr := 'where (a.[Site Code] = '+intToStr(SiteCode)+')'+#13+
                             'and (a.[Site Code] = b.[Site Code])';

            WhereStr := hoORsiteStr+#13+
                        'and (a.[supplier name] = b.[supplier name])'+#13+
                        'and (a.[Delivery Note No.] = b.[Delivery Note No.])'+#13+
                        'and(b.[entity code] = d.[entity code])'+#13+
                        'and(d.[sub-category name] = e.[sub-category name])'+#13+
                        'and(e.[category name] = c.[category name])'+#13+
                        'and a.[date] BETWEEN '+#39+stAccDate+#39+' AND '+#39+endAccDate+#39+#13;
            if combo2.Text <> 'All Vendors' then
            begin
              WhereStr := WhereStr +'and(a.[supplier name] = '+ QuotedStr(combo2.text) + ')'+#13;
            end
            else
            begin
              if IsSite and not IsMaster then
                WhereStr := WhereStr +
                    'and a.[Supplier Name] IN ' + #13#10 +
                    '  (SELECT s2.[Supplier Name] ' + #13#10 +
                    '   FROM (select * from ac_SiteSuppliers where SiteId = dbo.fnGetSiteCode()) s1 LEFT OUTER JOIN Supplier s2 ' + #13#10 +
                    '      ON s1.SupplierID = s2.[Supplier Code] ' + #13#10 +
                    '   WHERE s1.SiteID = '+IntToStr(SiteCode) +') ';
            end;
            OrdStr := #13+'order by a.[supplier name], a.[Site Code], a.[date]';

            if chunkHdrDataExists then
            begin
              // query all the chunk files that belong to the selected period
              for i := 0 to chunksList.Count-1 do
              begin
                with DatesQuery do
                begin
                  close;
                  sql.Clear;
                  sql.Add(SelStr);
                  sql.add('FROM Accpurhd a' + ', ' + chunksList[i] + ' b, [category] c,');
                  sql.add('entity d, subcateg e');
                  sql.add(WhereStr);
                  sql.add(OrdStr);
                  Log.event('Reports; BitBtnViewClick: DatesQuery opened (Chunks): ' + SQL.Text);
                  open;
                end; //with
                // add results to Ptab1
                mappings:=Tstringlist.Create;
                Mappings.Add('Site Code=Site Code');
                Mappings.Add('supplier name=Vendor');
                Mappings.Add('delivery note no.=invoiceno');
                Mappings.Add('date=invoicedate');
                Mappings.Add('entity code=entitycode');
                Mappings.Add('division name=divisionname');
                Mappings.Add('total cost=cost');
                Mappings.Add('whether sales taxable=taxable');

                if DatesQuery.RecordCount > 0 then
                begin
                  Log.event('Reports; BitBtnViewClick: BatchMove DatesQuery (Chunked)');
                  dmADO.BatchMove(DatesQuery,Ptab1,mappings);
                end;
                mappings.Destroy;
              end; // for
              // check for accepted invoices (not chunked yet) between period dates (inclusive)
              with DatesQuery do
              begin
                close;
                sql.Clear;
                sql.Add(SelStr);
                sql.add('from [Accpurhd] a, [accpurch] b, [category] c,');
                sql.add('[entity] d, [subcateg] e');
                sql.add(WhereStr);
                sql.add(OrdStr);
                //prepare;
                log.event('Reports; BitBtnViewClick: DatesQuery opened (Not Chunked): ' + DatesQuery.SQL.Text);
                open;
              end; //with
              mappings:=Tstringlist.Create;

              Mappings.Add('Site Code=Site Code');
              Mappings.Add('supplier name=Vendor');
              Mappings.Add('delivery note no.=invoiceno');
              Mappings.Add('date=invoicedate');
              Mappings.Add('entity code=entitycode');
              Mappings.Add('division name=divisionname');
              Mappings.Add('total cost=cost');
              Mappings.Add('whether sales taxable=taxable');

              if DatesQuery.RecordCount > 0 then
              begin
                Log.event('Reports; BitBtnViewClick: BatchMove DatesQuery (Not Chunked)');
                dmADO.BatchMove(DatesQuery,Ptab1,mappings);
              end;
              mappings.Destroy;

              DatesQuery.Close;
              //mark all accepted invoice suppiers, for user info only
              with wwqRun do
              begin
                close;
                sql.Clear;
                sql.Add('UPDATE [VendTab1] ');
                sql.add('SET [Vendor] = SUBSTRING([Vendor],1,19)+''^''');
                log.event('Reports; BitBtnViewClick: wwqRun executed: ' + wwqRun.SQL.Text);
                ExecSQL;
                Close
              end;
            end; // if chunkHdrDataExists...

            if purchHdrDataExists then
            begin
              // get current invoices
              with datesquery do
              begin
                close;
                sql.clear;
                sql.add(SelStr);
                sql.add('from [purchhdr] a, [purchase] b, [category] c,');
                sql.add('[entity] d, [subcateg] e');
                sql.add(''+hoORsiteStr+#13+
                          'and (UPPER(ISNULL(a.deleted,''N'')) = ''N'')' +#13+
                          'and (a.[supplier name] = b.[supplier name])'+#13+
                          'and (a.[Delivery Note No.] = b.[Delivery Note No.])'+#13+
                          'and(b.[entity code] = d.[entity code])'+#13+
                          'and(d.[sub-category name] = e.[sub-category name])'+#13+
                          'and(e.[category name] = c.[category name])'+#13+
                          'and a.[date] BETWEEN '+#39+stPurDate+#39+' AND '+#39+endPurDate+#39+#13+'');
                if combo2.Text <> 'All Vendors' then
                begin
                  sql.add('and(a.[supplier name] = '+ QuotedStr(combo2.text) + ')');
                end
                else
                begin
                  if IsSite and not IsMaster then
                  begin
                     sql.add('and a.[Supplier Name] IN ');
                     sql.add('  (SELECT s2.[Supplier Name] ');
                     sql.add('   FROM (select * from ac_SiteSuppliers where SiteId = dbo.fnGetSiteCode()) s1 LEFT OUTER JOIN Supplier s2 ');
                     sql.add('      ON s1.SupplierID = s2.[Supplier Code] ');
                     sql.add('   WHERE s1.SiteID = '+IntToStr(SiteCode) +') ');
                  end;
                end;

                sql.add(OrdStr);
                //prepare;
                log.event('Reports; BitBtnViewClick: DatesQuery opened (Current): ' + DatesQuery.SQL.Text);
                open;
              end;

              mappings:=Tstringlist.Create;
              Mappings.Add('Site Code=Site Code');
              Mappings.Add('supplier name=Vendor');
              Mappings.Add('delivery note no.=invoiceno');
              Mappings.Add('date=invoicedate');
              Mappings.Add('entity code=entitycode');
              Mappings.Add('division name=divisionname');
              Mappings.Add('total cost=cost');
              Mappings.Add('whether sales taxable=taxable');
              Log.event('Reports; BitBtnViewClick: BatchMove DatesQuery (Current)');
              dmADO.BatchMove(DatesQuery,Ptab1,mappings);
              mappings.Destroy;

              DatesQuery.close;
              ptab1.Close;
            end; // if purchHdrDataExists...

            log.event('Reports; BitBtnViewClick: pTab1 opened: ' + pTab1.TableName);
            ptab1.Open;
            if ptab1.recordcount = 0 then
            begin
              if combo2.Text <> 'All Vendors' then
                showmessage('No invoices for this period for supplier: "' +combo2.Text + '"!')
              else
                showmessage('No vendor invoices for this period');
              ptab1.Close;
              exit;
            end;
            ptab1.Close;
            dmADO.EmptySQLTable('VendTab2');
            Ptab2.tableName := 'VendTab2';
            log.event('Reports; BitBtnViewClick: distinctQuery opened: ' + distinctQry.SQL.Text);
            { TODO -owilma -ctidy up :
distinctQry retrieves SiteName from site which is not a field in VendTab2.
VendTab2 is not used again until buildTable when it is queried with the 
site table to get the site name to be appended to the # table used in
the report.  I don't see why the site name is needed here or why vendtab2 is
needed at all }
            distinctqry.open;
            mappings:=Tstringlist.Create;
            // add mappings
            Mappings.Add('Site Code=Site Code');
            mappings.Add('invoiceNo=Invoiceno');
            mappings.Add('invoicedate=invoicedate');
            mappings.Add('vendor=vendor');
            Log.event('Reports; BitBtnViewClick: BatchMove DistinctQry');
            dmADO.BatchMove(Distinctqry,Ptab2,mappings);
            mappings.Destroy;

            dmADO.EmptySQLTable('VendTab3');

            log.event('Reports; BitBtnViewClick: SumQry opened: ' + SumQry.SQL.Text);
            sumqry.open;

            mappings:=Tstringlist.Create;
            // add mappings
            mappings.Add('invoiceNo=Invoiceno');
            mappings.Add('invoicedate=invoicedate');
            Mappings.Add('Site Code=Site Code');
            mappings.Add('vendor=vendor');
            mappings.Add('divisionname=divisionname');
            mappings.Add('taxable=taxable');
            Mappings.Add('SumCost=SumCost');
            Log.event('Reports; BitBtnViewClick: BatchMove SumQry');
            dmADO.BatchMove(sumqry,Ptab3,mappings);
            mappings.Destroy;

            CalculateTax;
            buildTable;
            FillTable;
            log.event('Reports; BitBtnViewClick: totalsQry opened: ' + totalsQry.SQL.Text);
            totalsqry.open;
            log.event('Reports; BitBtnViewClick: pTab2 opened: ' + pTab2.TableName);
            ptab2.TableName := '#tmpVendTab2';
            ptab2.open;
            FormatCurrencyFields;
            ptab2.enablecontrols;
            panel4.visible := false;
            panel3.visible := true;
            label11.Visible := True;
            label12.Visible := True;
          end
          else // item invoce report
          begin
            label11.Visible := False;
            label12.Visible := False;
            GridVendors.Visible := false;
            Itab1.DisableControls;

            { Job 18648 - add flavour to select statement to ensure that all items are
                included.}
            { Job 18887 - added Record ID to select statement to ensure that duplicate items
                with the same quantity are included in the calculation }
            SelStr := 'select distinct b.[Site Code], a.[sub-category name], b.[date], a.[entity code], '+#13+
                      'a.[extended rtl name], c.[delivery note no.], c.[Record ID], c.[quantity],'+#13+
                      'c.[total cost], c.[flavour]'+#13;

            if SiteCode = 0 then
              hoORsiteStr := 'where (b.[Site Code] = c.[Site Code])'
            else
              hoORsiteStr := 'where (b.[Site Code] = '+intToStr(SiteCode)+')'+#13+
                             'and (b.[Site Code] = c.[Site Code])';

            WhereStr := hoORsiteStr+#13+
                        'and (a.[entity code] = c.[entity code])'+#13+
                        'and (b.[supplier name] = c.[supplier name])'+#13+
                        'and (b.[delivery note no.] = c.[delivery note no.])'+#13+
                        'and (e.[category name] = d.[category name])'+#13+
                        'and (d.[sub-category name] = a.[sub-category name])'+#13+
                        'and (e.[division name] = ' + QuotedStr(combo1.text) + ')'+#13+
                        'and b.[date] BETWEEN '+#39+stAccDate+#39+' AND '+#39+endAccDate+#39+#13;

            if IsSite and not IsMaster then
            begin
                WhereStr := WhereStr +
                    ' and b.[Supplier Name] IN ' + #13#10 +
                    '  (SELECT s2.[Supplier Name] ' + #13#10 +
                    '   FROM (select * from ac_SiteSuppliers where SiteId = dbo.fnGetSiteCode()) s1 LEFT OUTER JOIN Supplier s2 ' + #13#10 +
                    '      ON s1.SupplierID = s2.[Supplier Code] ' + #13#10 +
                    '   WHERE s1.SiteID = '+IntToStr(SiteCode) +') ';
            end;


            dmADO.EmptySQLTable('ItemTab1');

            if chunkHdrDataExists then
            begin
              // query all the chunk files that belong to the selected period
              for i := 0 to chunksList.Count-1 do
              begin
                with items1qry do
                begin
                  close;
                  sql.Clear;
                  sql.Add(SelStr);
                  sql.add('from [entity] a, [Accpurhd] b' + ', [' + chunksList[i] + '] c');
                  sql.add(',[subcateg] d, [category] e');
                  sql.add(WhereStr);
                  log.event('Reports; BitBtnViewClick: items1Qry opened: ' + items1Qry.SQL.Text);
                  open;
                end; //with
                // add results to Itab1
                 mappings:=Tstringlist.Create;
                // add mappings
                mappings.Add('Site Code=Site Code');
                mappings.Add('entity code = entitycode');
                mappings.Add('sub-category name=Subcat');
                mappings.Add('extended rtl name=entityname');
                mappings.Add('delivery note no.=invoiceno');
                mappings.Add('date=invoicedate');
                mappings.Add('quantity=quantity');
                mappings.Add('total cost=cost');
                Log.event('Reports; BitBtnViewClick: BatchMove Items1Qry');
                dmADO.BatchMove(Items1qry,ITab1,mappings);
                mappings.Destroy;
              end; // for

              // check for accepted invoices (not chunked yet) between period dates (inclusive)
              with items1qry do
              begin
                close;
                sql.Clear;
                sql.Add(SelStr);
                sql.add('from [entity] a, [Accpurhd] b, [accpurch] c');
                sql.add(',[subcateg] d, [category] e');
                sql.add(WhereStr);
                log.event('Reports; BitBtnViewClick: items1Qry opened: ' + items1Qry.SQL.Text);
                open;
              end; //with
              // add results to Itab1
              mappings:=Tstringlist.Create;
              mappings.Add('Site Code=Site Code');
              mappings.Add('entity code=entitycode');
              mappings.Add('sub-category name=Subcat');
              mappings.Add('extended rtl name=entityname');
              mappings.Add('delivery note no.=invoiceno');
              mappings.Add('date=invoicedate');
              mappings.Add('quantity=quantity');
              mappings.Add('total cost=cost');
              Log.event('Reports; BitBtnViewClick: BatchMove Items1Qry');
              dmADO.BatchMove(Items1qry,ITab1,mappings);
              mappings.Destroy;
            end; // if chunkHdrDataExists...

            if purchHdrDataExists then
            begin
              with items1qry do
              begin
                close;
                sql.clear;
                sql.add(SelStr);
                sql.add('from [entity] a, [purchhdr] b, [purchase] c,');
                sql.add('[subcateg] d,[category] e');
                sql.add(''+hoORsiteStr+#13+
                          'and (b.[deleted] is null)'+#13+
                          'and (a.[entity code] = c.[entity code])'+#13+
                          'and (b.[supplier name] = c.[supplier name])'+#13+
                          'and (b.[delivery note no.] = c.[delivery note no.])'+#13+
                          'and (e.[category name] = d.[category name])'+#13+
                          'and (d.[sub-category name] = a.[sub-category name])'+#13+
                          'and (e.[division name] = ' + QuotedStr(combo1.text) + ')'+#13+
                          'and b.[date] BETWEEN '+#39+stPurDate+#39+' AND '+#39+endPurDate+#39+#13+'');

                if IsSite and not IsMaster then
                begin
                   sql.add('and b.[Supplier Name] IN ');
                   sql.add('  (SELECT s2.[Supplier Name] ');
                   sql.add('   FROM (select * from ac_SiteSuppliers where SiteId = dbo.fnGetSiteCode()) s1 LEFT OUTER JOIN Supplier s2 ');
                   sql.add('      ON s1.SupplierID = s2.[Supplier Code] ');
                   sql.add('   WHERE s1.SiteID = '+IntToStr(SiteCode) +') ');
                end;

                log.event('Reports; BitBtnViewClick: items1Qry opened: ' + items1Qry.SQL.Text);
                open;
              end;

              mappings:=Tstringlist.Create;
              mappings.Add('Site Code=Site Code');
              mappings.Add('sub-category name=Subcat');
              mappings.Add('entity code=entitycode');
              mappings.Add('extended rtl name=entityname');
              mappings.Add('delivery note no.=invoiceno');
              mappings.Add('date=invoicedate');
              mappings.Add('quantity=quantity');
              mappings.Add('total cost=cost');
              Log.event('Reports; BitBtnViewClick: BatchMove Items1Qry');
              dmADO.BatchMove(Items1qry,ITab1,mappings);
              mappings.Destroy;

              items1qry.Close;
              Itab1.Close;
            end; // if purchHdrDataExists...

            Itab1.Open;
            if Itab1.recordcount = 0 then
            begin
              showmessage('No invoices for this period for division : [' +combo1.Text + ']!');
              Itab1.Close;
              exit;
            end;
            Itab1.Close;
            dmADO.EmptySQLTable('ItemTab2');

            log.event('Reports; BitBtnViewClick: items2Qry opened: ' + items2Qry.SQL.Text);
            items2qry.open;
            mappings:=Tstringlist.Create;
            mappings.Add('Site Code=Site Code');
            mappings.Add('subcat=subcat');
            mappings.Add('entityname=entityname');
            mappings.Add('Quantity=quantity');
            mappings.Add('Cost=cost');
            mappings.Add('Invoicedate=invoicedate');
            Log.event('Reports; BitBtnViewClick: BatchMove Items2Qry');
            dmADO.BatchMove(Items2qry,ITab2,mappings);
            mappings.Destroy;

            FormatTable;
            log.event('Reports; BitBtnViewClick: subcatQry opened: ' + subcatQry.SQL.Text);
            subcatqry.open;
            Itab1.enablecontrols;
            panel4.visible := true;
            panel3.visible := false;
          end;  // item invoice report
          BitBtnView.Caption := 'Chan&ge';
          RadioButtonVendor.Enabled := false;
          RadioButtonItem.Enabled := false;
          stpick.Enabled := false;
          endpick.Enabled := false;
          if RadioButtonItem.checked = true then   // item invoices radio button
          begin
           SpeedButtonSubcategClick(self);
           GridItems.RedrawGrid;
           GridItems.Columns[3].DisplayLabel := GetLocalisedName(lsInvoice) + ' No.';
           GridItems.SetFocus;
          end
          else
          begin
            SpeedButtonVendorClick(self);
            GridVendors.RedrawGrid;
            GridVendors.SetFocus;
            GridTotals.RedrawGrid;
          end;
          combo1.Enabled := false;
          combo2.Enabled := false;
          BitBtnPrint.Enabled := true;
        end   // if BitBtnView.Caption = '&View'
        else
        begin
          BitBtnView.Caption := '&View';
          Label11.Visible := False;
          Label12.Visible := False;
          RadioButtonVendor.Enabled := true;
          RadioButtonItem.Enabled := true;
          stpick.Enabled := true;
          endpick.Enabled := true;
          combo1.Enabled := true;
          combo2.Enabled := true;
          panel3.Visible := false;
          panel4.Visible := false;
          DoReportsClose;
          if RadioButtonItem.checked = true then
          begin
           GridItems.RedrawGrid;
          end
          else
          begin
            GridVendors.RedrawGrid;
            GridTotals.RedrawGrid;
          end;
          BitBtnPrint.Enabled := false;
          qryItemsForDisplay.Close;
          wwqRun.Close;
        end;
      end;  // if datesValid
    except
      on E: Exception do
      begin
        Log.event('Reports; BitBtnViewClick: Error creating report - ' + E.Message);
        showmessage('Error creating report.' + #13 + E.Message);
      end;
    end;
  finally
     screen.Cursor := crDefault;
  end;
end;

{ Job 17407
  Changed to get a list of existing Acc chunk tables that belong to the user-specified
  period and to query only those tables.  Also changed to get the minimum and maximum
  dates from AccPurHd and compare these dates with the user-specified dates and pass
  the appropriate dates into the select queries.  This prevents queries based on
  unrealistic dates being run. }
{ GET LIST OF EXISTING CHUNK FILES FROM THE USER-SPECIFIED PERIOD }
function TfReports.GetChunkFiles: TStringList;
var
  syr, smth, sdy, eyr, emth, edy, numDays: word;
  accFileStartDate, accFileEndDate : TDate;
  accMinMth, accMinYr, accMaxMth, accMaxYr, chunkfile: string;
  chunksExist: boolean;
  chunksList: Tstringlist;
begin
  chunksExist := false;
  chunksList := TStringList.Create;

  { get month and year from the earliest and latest Acc chunk file names for
    comparing with the user selected start and end dates }
  with ADOStoredProc do
  begin
     Parameters.Refresh;
     Log.event('Reports; GetChunkFiles: Executing ADOStoredProc');
     ExecProc;
     if not VarIsNull(Parameters.ParamByName('@MinMonth').Value) then
     begin
       accMinMth := Parameters.ParamByName('@MinMonth').Value;
       accMinYr := Parameters.ParamByName('@MinYear').Value;
       accMaxMth := Parameters.ParamByName('@MaxMonth').Value;
       accMaxYr := Parameters.ParamByName('@MaxYear').Value;
       chunksExist := true;
     end;
  end;
  if chunksExist then
  begin
    numDays := DaysInAMonth(StrToInt(accMaxYr) ,StrToInt(accMaxMth));
    if UKUSmode = 'UK' then
    begin
      accFileStartDate := StrToDate('01'+'/'+accMinMth+'/'+accMinYr);
      accFileEndDate := StrToDate(IntToStr(numDays) +'/'+accMaxMth+'/'+accMaxYr);
    end
    else
    begin
      accFileStartDate := StrToDate(accMinMth+'/'+'01'+'/'+accMinYr);
      accFileEndDate := StrToDate(accMaxMth+'/'+IntToStr(numDays) +'/'+accMaxYr);
    end;

    { compare the user selected start date with the accFileStartDate created
      from the earliest Acc chunk file name and use the later of the two
      as the start date.
      compare the user selected end date with the accFileEndDate created
      from the latest Acc chunk file name and use the earlier of the two
      as the end date. }
    if stpick.Date < accFileStartDate then
      decodedate(accFileStartDate,syr,smth,sdy)
    else
      decodedate(stpick.date,syr,smth,sdy);

    if endpick.Date > accFileEndDate then
      decodedate(accFileEndDate,eyr,emth,edy)
    else
      decodedate(endpick.date,eyr,emth,edy);

    // build the list of Acc chunked tables
    while ((smth <= emth) AND (syr <= eyr)) OR ((smth > emth) AND (syr < eyr)) do
    begin
      chunkfile := 'acc'+ Formatdatetime('mmmyy', EncodeDate(syr,smth,sdy));
      try
        if dmADO.SQLTableExists(chunkFile) then
          chunksList.Add(chunkFile);
      finally
        //increment the (chunk) month to look for, year change is automatic
        decodedate(incMonth(EncodeDate(syr,smth,sdy),1),syr,smth,sdy);
      end;
    end; // while
  end;  // if chunksExist...

  result := chunksList;
end;


{ GET THE CORRECT MINIMUM AND MAXIMUM DATES FOR PASSING TO THE ACCEPTED
  INVOICE TABLE QUERIES }
procedure TfReports.GetMinAndMaxAccDates(var stAccDate: String; var endAccDate: String; var DataExists: boolean);
var
  accQryMinDate, accQryMaxDate : TDate;
begin
  accQryMinDate := Date;
  accQryMaxDate := Date;
  
  { get minimum and maximum dates from AccPurHd for comparing with the user
    selected start and end dates }
  with minMaxDatesQry do
  begin
    SQL.Clear;
    SQL.Add('SELECT Max([Date]) as maxDate, Min([Date]) as minDate');
    SQL.Add('FROM [AccPurHd]');
    if IsSite and not IsMaster then
    begin
      SQL.Add('WHERE [Supplier Name] IN ');
      SQL.Add('  (SELECT s2.[Supplier Name] ');
      SQL.Add('   FROM (select * from ac_SiteSuppliers where SiteId = dbo.fnGetSiteCode()) s1 LEFT OUTER JOIN Supplier s2 ');
      SQL.Add('      ON s1.SupplierID = s2.[Supplier Code] ');
      SQL.Add('   WHERE s1.SiteID = '+IntToStr(SiteCode) +') ');
    end;
    Log.event('Reports; GetMinAndMaxAccDates: minMaxDatesQry opened: ' + SQL.Text);
    open;
    DataExists := (not VarIsNull(FieldValues['minDate']));
    if DataExists then
    begin
      accQryMinDate := FieldValues['minDate'];
      accQryMaxDate := FieldValues['maxDate'];
    end;
  end;

  if DataExists then
  begin
    if stpick.Date < accQryMinDate then
      stAccDate := formatDateTime('yyyymmdd', accQryMinDate)
    else
      stAccDate := formatDateTime('yyyymmdd', stpick.date);

    if endpick.Date > accQryMaxDate then
      endAccDate := formatDateTime('yyyymmdd', accQryMaxDate)
    else
      endAccDate := formatDateTime('yyyymmdd', endpick.date);
  end;
end;


{ GET THE CORRECT MINIMUM AND MAXIMUM DATES FOR PASSING TO THE CURRENT
  INVOICE TABLE QUERIES }
procedure TfReports.GetMinAndMaxPurDates(var stPurDate: String; var endPurDate: String; var DataExists: boolean);
var
  purQryMinDate, purQryMaxDate : TDate;
begin
  purQryMinDate := Date;
  purQryMaxDate := Date;

  { get minimum and maximum dates from PurchHdr for comparing with the user
    selected start and end dates }
  with minMaxDatesQry do
  begin
    SQL.Clear;
    SQL.Add('SELECT Max([Date]) as maxDate, Min([Date]) as minDate');
    SQL.Add('FROM [PurchHdr]');
    if IsSite and not IsMaster then
    begin
      SQL.Add('WHERE [Supplier Name] IN ');
      SQL.Add('  (SELECT s2.[Supplier Name] ');
      SQL.Add('   FROM (select * from ac_SiteSuppliers where SiteId = dbo.fnGetSiteCode()) s1 LEFT OUTER JOIN Supplier s2 ');
      SQL.Add('      ON s1.SupplierID = s2.[Supplier Code] ');
      SQL.Add('   WHERE s1.SiteID = '+IntToStr(SiteCode) +') ');
    end;
    Log.event('Reports; GetMinAndMaxPurDates: minMaxDatesQry opened: ' + SQL.Text);
    open;
    DataExists := (not VarIsNull(FieldValues['minDate']));
    if DataExists then
    begin
      purQryMinDate := FieldValues['minDate'];
      purQryMaxDate := FieldValues['maxDate'];
    end;
  end;

  if DataExists then
  begin
    if stpick.Date < purQryMinDate then
      stPurDate := formatDateTime('yyyymmdd', purQryMinDate)
    else
      stPurDate := formatDateTime('yyyymmdd', stpick.date);

    if endpick.Date > purQryMaxDate then
      endPurDate := formatDateTime('yyyymmdd', purQryMaxDate)
    else
      endPurDate := formatDateTime('yyyymmdd', endpick.date);
  end;
end;


procedure TfReports.SpeedButtonItemClick(Sender: TObject);
begin
  label6.caption := 'Item Name';
  search2.searchfield := 'entityname';
  //itemordqry.close;
  //itemordqry.open;
  with qryItemsforDisplay do
  begin
    close;
    sql.Clear;
    sql.Add('select a.[SubCat],a.[EntityName],a.[InvoiceNo],a.[InvoiceDate],');
    sql.Add('a.[Quantity],a.[Cost],a.[TotalQty],a.[TotalCost],a.[Site Code],b.[Site Name]');
    sql.add('from itemtab1 a, site b');
    sql.add('where a.[Site Code] = b.[Site Code]');
    sql.add('order by entityname, subcat,[site name], invoicedate');
    log.event('Reports; SpeedButtonItemClick: qryItemsforDisplay opened: ' + wwqRun.SQL.Text);
    open;
  end;
  itemsds.dataset := qryItemsforDisplay;
  formatGridForItemRep;
  search2.SetFocus;
end;

procedure TfReports.SpeedButtonSubcategClick(Sender: TObject);
begin
  label6.caption := 'Sub-Category';
  search2.searchfield := 'subcat';
  //subcatqry.close;
  //subcatqry.open;
  with qryItemsforDisplay do
  begin
    close;
    sql.Clear;
    sql.Add('select a.[SubCat],a.[EntityName],a.[InvoiceNo],a.[InvoiceDate],');
    sql.Add('a.[Quantity],a.[Cost],a.[TotalQty],a.[TotalCost],a.[Site Code],b.[Site Name]');
    sql.Add('from itemtab1 a, site b');
    sql.add('where a.[Site Code] = b.[Site Code]');
    sql.add('order by subcat, entityname, [site name], invoicedate');
    log.event('Reports; SpeedButtonSubcategClick: qryItemsforDisplay opened: ' + wwqRun.SQL.Text);
    open;
  end;
  itemsds.dataset := qryItemsforDisplay;
  formatGridForItemRep;
  search2.SetFocus;
end;

procedure TfReports.SpeedButtonVendorClick(Sender: TObject);
begin
  label5.caption := 'Vendor Name';
  search1.searchfield := 'Vendor';
  //vendqry.close;
  //vendqry.open;
  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select * from "#tmpvendtab2" a');
    sql.add('order by a."Vendor", a."invoiceno" , a."invoicedate"');
    log.event('Reports; SpeedButtonVendorClick: wwqRun opened: ' + wwqRun.SQL.Text);
    open;
  end;
  datesds.dataset := wwqRun;
  if RadioButtonVendor.Checked then
    formatGridForVendRep
  else
    formatGridForItemRep;
  search1.SetFocus;
end;

procedure TfReports.SpeedButtonInvoiceNoClick(Sender: TObject);
begin
  label5.caption := GetLocalisedName(lsInvoice) + ' No.';
  search1.searchfield := 'invoiceno';

  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select * from "#tmpvendtab2" a');
    sql.add('order by a."invoiceno", a."Vendor", a."invoicedate"');
    log.event('Reports; SpeedButtonInvoiceNoClick: wwqRun opened: ' + wwqRun.SQL.Text);
    open;
  end;
  datesds.dataset := wwqRun;
  if RadioButtonVendor.Checked then
    formatGridForVendRep
  else
    formatGridForItemRep;
  search1.SetFocus;
end;

procedure TfReports.SpeedButtonDateClick(Sender: TObject);
begin
  label5.caption := 'Invoice Date';
  search1.searchfield := 'invoicedate';
  //invdateqry.close;
  //invdateqry.open;
  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select * from "#tmpvendtab2" a');
    sql.add('order by a."invoicedate", a."Vendor", a."invoiceno"');
    log.event('Reports; SpeedButtonDateClick: wwqRun opened: ' + wwqRun.SQL.Text);
    open;
  end;
  datesds.dataset := wwqRun;
  if RadioButtonVendor.Checked then
    formatGridForVendRep
  else
    formatGridForItemRep;
  search1.SetFocus;
end;

function TfReports.datesValid: boolean;
begin
  result := true;

  if floor(EndPick.DateTime) < floor(StPick.DateTime) then
  begin
    ShowMessage('End Date must be equal to or after Start Date');
    result := false;
  end;
end;

procedure TfReports.formatGridForVendRep;
var
  i: integer;
begin
  // format the main vendor report fields
  with wwqRun do
  begin
    FieldByName('Site Code').Visible := false;
    FieldByName('Site Name').DisplayLabel := 'Site';
    FieldByName('Site Name').DisplayWidth := 20;

    FieldByName('Vendor').DisplayWidth := 20;
    FieldByName('invoiceno').DisplayWidth := 15;
    FieldByName('invoiceno').DisplayLabel := GetLocalisedName(lsInvoice) + ' No.';
    FieldByName('invoicedate').DisplayLabel := 'Date';
    FieldByName('invoicedate').DisplayWidth := 10;
    FieldByName('tax').DisplayWidth := 9;
    FieldByName('cost').DisplayWidth := 9;

    for i := 6 to Fields.Count - 1 do
    begin
      Fields.Fields[i].DisplayWidth := 9;
      with Fields.Fields[i] as TNumericField do
        DisplayFormat := CurrencyFormat;
    end;
  end;

  // format the totals fields also
  for i := 0 to Totalsqry.Fields.Count - 1 do
  begin
    Totalsqry.Fields.Fields[i].DisplayWidth := 9;
    with Totalsqry.Fields.Fields[i] as TNumericField do
        DisplayFormat := CurrencyFormat;
  end;

  if UKUSmode = 'UK' then
  begin
    Totalsqry.FieldByName('tax').Visible := false;
    wwqRun.FieldByName('tax').DisplayLabel := 'VAT';
    TNumericField(wwqRun.FieldByName('tax')).DisplayFormat := CurrencyFormat;
    wwqRun.FieldByName('TotalCost').DisplayLabel := 'Total Cost';

    wwqRun.FieldByName('Tax').Index := wwqRun.Fields.Count + 1;
    wwqRun.FieldByName('TotalCost').Index := wwqRun.Fields.Count + 1;
  end
  else
  begin
    wwqRun.FieldByName('TotalCost').Visible := False;
  end;
end;

procedure TfReports.formatGridForItemRep;
begin
  with qryItemsforDisplay do
  begin
    with Fields.Fields[5] as TNumericField do Displayformat := CurrencyFormat;
    with Fields.Fields[6] as TNumericField do DisplayFormat := CurrencyFormat;
    with Fields.Fields[7] as TNumericField do Displayformat := CurrencyFormat;
    with Fields.Fields[8] as TNumericField do DisplayFormat := CurrencyFormat;
  end;
end;

procedure TfReports.FormatCurrencyFields;
var
  i : integer;
  ctr : TComponent;
begin
  // set the display format for the currency fields:
  for i := 0 to (self.componentCount - 1) do
  begin
    ctr := self.components[i];
    if ctr is TppdbText then
    begin
      if TppdbText(ctr).DisplayFormat = '$' then
        TppdbText(ctr).DisplayFormat := currencystring + '#,0.00';
    end
    else if ctr is TppdbCalc then
    begin
      if TppdbCalc(ctr).DisplayFormat = '$' then
        TppdbCalc(ctr).DisplayFormat := currencystring + '#,0.00';
    end;
  end; // for..
end;

// added separate procedure for this as calling FormatCurrencyFields repeatedly raises
// Delphi exception because PTab2 tablename has not been set and it makes it
// impossible to debug the application
procedure TfReports.FormatItemsCurrencyFields;
begin
  ItemReportDBText5.DisplayFormat := '#,0.00';
  ItemReportDBText6.DisplayFormat := CurrencyString + '#,0.00';
  ItemReportDBText7.DisplayFormat := '#,0.00';
  ItemReportDBText8.DisplayFormat := CurrencyString + '#,0.00';
end;

procedure TfReports.EndMaskKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
    begin
      if RadioButtonItem.Checked = true then
        combo1.setfocus
      else
        BitBtnView.setfocus;
    end;
end;

procedure TfReports.BitBtnPrintClick(Sender: TObject);
begin
  log.event('Reports; Print button pressed');
  if RadioButtonVendor.checked = true then
    begin
      vendlab.Caption := combo2.Text + ' for ' + SiteName;
      VendTabOrdqry.Close;
      log.event('Reports; BitBtnPrintClick: VendTabOrdqry opened: ' + VendTabOrdqry.SQL.Text);
      VendTabOrdqry.open;
      buildVendorReport;

      if UKUSMode = 'UK' then
        rptDivnLabel12.Caption := 'VAT';

      Vendreport.print;
    end
  else
    begin
      divlabel.Caption := combo1.Text +' ('+ SiteName+')';
      ItemRptPeriodLabel.Caption := DateToStr(StPick.date) +' - '+DateToStr(EndPick.date);
      ItemTabOrdqry.close;
      log.event('Reports; BitBtnPrintClick: ItemTabOrdqry opened: ' + ItemTabOrdqry.SQL.Text);
      ItemtabOrdqry.open;
      FormatItemsCurrencyFields;
//      if UKUSmode = 'UK' then
//        ItemReport.PrinterSetup.PaperName := 'A4'
//      else
//        ItemReport.PrinterSetup.PaperName := 'Letter';
      ItemReport.print;
    end;
  VendTabOrdqry.close;
  ItemTabOrdqry.close;
end;

procedure TfReports.setVendReportFields(fieldIndex: integer);
var
  divnOffset: integer;
begin
  divnOffset := 7 + fieldIndex;
  //set report labels and dbtexts
  case fieldIndex of
    1:  begin
          rptDivnLabel1.Caption := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText1.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText1.DisplayFormat := '$0.00';
          rptVendSumDBText1.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptTotalsSumDBText1.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
        end;
    2:  begin
          rptDivnLabel2.Caption := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText2.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText2.DisplayFormat := '$0.00';
          rptVendSumDBText2.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptTotalsSumDBText2.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
        end;
    3:  begin
          rptDivnLabel3.Caption := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText3.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText3.DisplayFormat := '$0.00';
          rptVendSumDBText3.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptTotalsSumDBText3.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
        end;
    4:  begin
          rptDivnLabel4.Caption := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText4.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText4.DisplayFormat := '$0.00';
          rptVendSumDBText4.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptTotalsSumDBText4.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
        end;
    5:  begin
          rptDivnLabel5.Caption := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText5.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText5.DisplayFormat := '$0.00';
          rptVendSumDBText5.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptTotalsSumDBText5.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
        end;
    6:  begin
          rptDivnLabel6.Caption := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText6.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText6.DisplayFormat := '$0.00';
          rptVendSumDBText6.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptTotalsSumDBText6.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
        end;
    7:  begin
          rptDivnLabel7.Caption := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText7.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText7.DisplayFormat := '$0.00';
          rptVendSumDBText7.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptTotalsSumDBText7.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
        end;
    8:  begin
          rptDivnLabel8.Caption := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText8.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText8.DisplayFormat := '$0.00';
          rptVendSumDBText8.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptTotalsSumDBText8.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
        end;
    9:  begin
          rptDivnLabel9.Caption := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText9.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText9.DisplayFormat := '$0.00';
          rptVendSumDBText9.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptTotalsSumDBText9.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
        end;
   10:  begin
          rptDivnLabel10.Caption := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText10.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText10.DisplayFormat := '$0.00';
          rptVendSumDBText10.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptTotalsSumDBText10.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
        end;
   11:  begin
          rptDivnLabel11.Caption := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText11.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptVendDBText11.DisplayFormat := '$0.00';
          rptVendSumDBText11.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
          rptTotalsSumDBText11.DataField := VendTabOrdqry.Fields[divnOffset].FieldName;
        end;
   end;
end;

procedure TfReports.buildVendorReport;
var
  NoOfDivns, i: integer;
begin
  with qryRun2 do
  begin
    close;
    SQL.Clear;

    if UKUSMode = 'UK' then
      SQL.Add('Select distinct DivisionName from VendTab3')
    else
      SQL.Add('Select distinct [Division Name] from Division');

    Open;
    NoOfDivns := RecordCount;
    Close;
  end;
  for i := 0 to NoOfDivns + 1 do
  begin
    setVendReportFields(i);
  end;
  rptVendDBText12.DisplayFormat := '$0.00';
  PeriodLabel.Caption := DateToStr(StPick.date) +' - '+DateToStr(EndPick.date);
end;

procedure TfReports.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_f4 : begin
              if panel4.visible = true then
                begin
                  SpeedButtonSite.Down := true;
                  SpeedButtonSiteclick(sender);
                end
            end;
    vk_f5 : begin
              if panel3.visible = true then
                begin
                  SpeedButtonVendor.Down := true;
                  SpeedButtonVendorclick(sender);
                end
              else
                begin
                  SpeedButtonSubcateg.Down := true;
                  SpeedButtonSubcategclick(sender);
                end
            end;
    vk_f6 :begin
              if panel3.visible = true then
                begin
                  SpeedButtonInvoiceNo.Down := true;
                  SpeedButtonInvoiceNoclick(sender);
                end
              else
                begin
                  SpeedButtonItem.Down := true;
                  SpeedButtonItemclick(sender);
                end;
            end;
    vk_f7 :begin
              if panel3.visible = true then
                begin
                  SpeedButtonDate.Down := true;
                  SpeedButtonDateclick(sender);
                end;
            end;
  end;
end;


procedure TfReports.ItemReportDBText8GetText(Sender: TObject;
  var Text: String);
var
  s1: string;

begin
   s1 := copy(text,pos('.',text) + 1,2);
  if length(s1) = 1 then
    text := text + '0';
end;

procedure TfReports.StPickKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
    endpick.setfocus;
end;

procedure TfReports.EndPickKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
  begin
    if RadioButtonItem.checked = true then
      combo1.setfocus
    else
      combo2.setfocus;
  end;
end;

procedure TfReports.combo2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
    BitBtnView.SetFocus;
end;

procedure TfReports.Combo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
    BitBtnView.SetFocus;
end;

procedure TfReports.FormCreate(Sender: TObject);
begin
  log.event('Reports; Form opened');
  if purchHelpExists then
    setHelpContextID(self, HLP_PERIOD_REPORT);
end;

procedure TfReports.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  log.event('Reports; Form closed');
end;

procedure TfReports.SpeedButtonSiteClick(Sender: TObject);
begin
  label6.caption := 'Site';
  search2.searchfield := 'Site Name';

  with qryItemsforDisplay do
  begin
    close;
    sql.Clear;
    sql.Add('select a.[SubCat],a.[EntityName],a.[InvoiceNo],a.[InvoiceDate],');
    sql.Add('a.[Quantity],a.[Cost],a.[TotalQty],a.[TotalCost],a.[Site Code],b.[Site Name]');
    SQL.Add('from itemtab1 a, site b');
    sql.add('where a.[Site Code] = b.[Site Code]');
    sql.add('order by [site name],subcat, entityname, invoicedate');
    log.event('Reports; SpeedButtonSiteClick: qryItemsforDisplay opened: ' + wwqRun.SQL.Text);
    open;
  end;
  itemsds.dataset := qryItemsforDisplay;
  formatGridForItemRep;
  search2.SetFocus;
end;

procedure TfReports.UpdateUKTax;
begin
  with wwqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('update VendTab3');
    SQL.Add('set TaxCost = CASE WHEN v.Taxable = ''Y'' THEN t.Tax ELSE 0 END, TotalCost = t.IncCost');
    SQL.Add('from VendTab3 v join (');
    SQL.Add('select v.[Site Code], v.Vendor, v.InvoiceNo, v.InvoiceDate, d.[Division Name], sum((v.Cost * t.[On-Sale Rate]) / 100) as Tax,');
    SQL.Add('  sum(v.Cost) + sum((v.Cost * t.[On-Sale Rate]) / 100) as IncCost');
    SQL.Add('from VendTab1 v, Products p, ProductTaxRules ptr, TaxRules t, SubCateg sc, Category c, Division d');
    SQL.Add('where v.EntityCode = p.[EntityCode]');
    SQL.Add('and p.EntityCode = ptr.EntityCode');
    SQL.Add('and ptr.TaxRule1 = t.[Index No]');  //Note the flaw. We are only considering TaxRule1.
    SQL.Add('and p.[Sub-Category Name] = sc.[Sub-Category Name]');
    SQL.Add('and sc.[Category Name] = c.[Category Name]');
    SQL.Add('and c.[Division Name] = d.[Division Name]');
    SQL.Add('group by v.[Site Code], v.Vendor, v.InvoiceNo, v.InvoiceDate, d.[Division Name]) t');
    SQL.Add('on v.Vendor = t.Vendor and v.InvoiceNo = t.InvoiceNo and v.InvoiceDate = t.InvoiceDate');
    SQL.Add('and v.[Site Code] = t.[Site Code] and v.[DivisionName] = t.[Division Name]');
    ExecSQL;
    Close;
  end;
end;

procedure TfReports.VendReportPreviewFormCreate(Sender: TObject);
begin
  dmADO.ReportPreviewFormCreate(Sender);
end;

procedure TfReports.ItemReportPreviewFormCreate(Sender: TObject);
begin
  dmADO.ReportPreviewFormCreate(Sender);
end;

end.
