{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y-,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
unit uDMWklyPrchRep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, ppCtrls, ppPrnabl, ppClass, ppBands, ppProd, ppReport,
  ppComm, ppCache, ppDB, ppDBBDE, Wwdatsrc, ppStrtch,
  ppSubRpt, ppRegion, ppVar, ppRelatv, ppDBPipe, Variants, ADODB, ComObj;

type
  TfrmDMWklyPrchRep = class(TDataModule)
    TblWklyPurchDS: TwwDataSource;
///////// Report Objects //////////////////
    WklyPurchPipe: TppBDEPipeline;
    WklyPurchRep: TppReport;
    VendorHdrLbl: TppLabel;
    InvNoHdrLbl: TppLabel;
    InvDateHdrLbl: TppLabel;
    InvTotLbl: TppLabel;
    InvSupNameDBtxt: TppDBText;
    InvTotalDBtxt: TppDBText;
    InvDateDBtxt: TppDBText;
    InvNoDBtxt: TppDBText;
    DBtxt1: TppDBText;
    DBtxt2: TppDBText;
    DBtxt3: TppDBText;
    DBtxt6: TppDBText;
    DBtxt4: TppDBText;
    DBtxt5: TppDBText;
    DBtxt7: TppDBText;
    DBtxt8: TppDBText;
    Lbl1: TppLabel;
    Lbl2: TppLabel;
    Lbl3: TppLabel;
    Lbl4: TppLabel;
    Lbl5: TppLabel;
    Lbl6: TppLabel;
    Lbl7: TppLabel;
    Lbl8: TppLabel;
    DBtxt9: TppDBText;
    Lbl10: TppLabel;
    DBtxt10: TppDBText;
    DBtxt11: TppDBText;
    TitleLbl: TppLabel;
    PrintedLbl: TppLabel;
    SiteNameLbl: TppLabel;
    PeriodLbl: TppLabel;
    DatesLbl: TppLabel;
    DBTxt12: TppDBText;
    WklyPurchRepHdrBand1: TppHeaderBand;
    WklyPurchRepLine1: TppLine;
    WklyPurchRepLine2: TppLine;
    WklyPurchRepLine3: TppLine;
    WklyPurchRepLine4: TppLine;
    WklyPurchRepLine5: TppLine;
    WklyPurchRepLine7: TppLine;
    WklyPurchRepLine8: TppLine;
    WklyPurchRepLine9: TppLine;
    WklyPurchRepLine10: TppLine;
    WklyPurchRepLine11: TppLine;
    WklyPurchRepLine12: TppLine;
    WklyPurchRepLine13: TppLine;
    WklyPurchRepLine14: TppLine;
    WklyPurchRepLine15: TppLine;
    WklyPurchRepLine16: TppLine;
    WklyPurchRepLine17: TppLine;
    WklyPurchRepLine18: TppLine;
    WklyPurchRepLine19: TppLine;
    WklyPurchRepLine20: TppLine;
    Shape12: TppLine;
    Shape11: TppLine;
    Shape10: TppLine;
    Shape9: TppLine;
    Shape8: TppLine;
    Shape7: TppLine;
    Shape6: TppLine;
    Shape5: TppLine;
    Shape4: TppLine;
    Shape3: TppLine;
    Shape2: TppLine;
    Shape1: TppLine;
    WklyPurchRepLine33: TppLine;
    WklyPurchRepLine34: TppLine;
    WklyPurchRepLine35: TppLine;
    WklyPurchRepSummaryBand1: TppSummaryBand;
    OthersSmryDS: TwwDataSource;
    WklyPurchRepSubReport1: TppSubReport;
    CodeSmrySubTitleBand1: TppTitleBand;
    CodeSmrySubDetailBand1: TppDetailBand;
    CodeSmrySubLabel1: TppLabel;
    CodeSmryPipe: TppBDEPipeline;
    CodeSmryDS: TwwDataSource;
    CodeSmrySub: TppChildReport;
    S1lbl: TppDBText;
    A1lbl: TppDBText;
    S2lbl: TppDBText;
    A2lbl: TppDBText;
    S3lbl: TppDBText;
    A3lbl: TppDBText;
    S4lbl: TppDBText;
    A4lbl: TppDBText;
    S5lbl: TppDBText;
    A5lbl: TppDBText;
    S6lbl: TppDBText;
    A6lbl: TppDBText;
    S7lbl: TppDBText;
    A7lbl: TppDBText;
    S8lbl: TppDBText;
    A8lbl: TppDBText;
    CodeSmrySubLine1: TppLine;
    CodeSmrySubLine2: TppLine;
    CodeSmrySubLine3: TppLine;
    CodeSmrySubLine4: TppLine;
    CodeSmrySubLine5: TppLine;
    CodeSmrySubLine6: TppLine;
    CodeSmrySubLine7: TppLine;
    CodeSmrySubLine8: TppLine;
    CodeSmrySubLine9: TppLine;
    CodeSmrySubLine10: TppLine;
    CodeSmrySubLine11: TppLine;
    CodeSmrySubLine12: TppLine;
    CodeSmrySubLine13: TppLine;
    CodeSmrySubLine14: TppLine;
    CodeSmrySubLine15: TppLine;
    CodeSmrySubShape1: TppShape;
    WklyPurchRepCalc2: TppSystemVariable;
    WklyPurchRepCalc1: TppSystemVariable;
    ppVariable1: TppVariable;
    QGetPurchHdr: TADOQuery;
    QWeeks: TADOQuery;
    QGetCurrPurchHdr: TADOQuery;
    PconfigsTbl: TADOTable;
    wwCodeCatsTbl: TADOTable;
    wwFixedCatsTbl: TADOTable;
    wwCodeSubsTbl: TADOTable;
    QAlter: TADOQuery;
    wwqRun: TADOQuery;
    wwQCodedCats: TADOQuery;
    QWklyTots: TADOQuery;
    QGetInvCatSubTots: TADOQuery;
    TblWklyPurch: TADOTable;
    otherssmry2TBL: TADOTable;
    otherssmryTBL: TADOTable;
    OthersSmryQry2: TADOQuery;
    OthersSmryQry1: TADOQuery;
    QWklyPrchOrd: TADOQuery;
    qryWklyPurch: TADOQuery;
///////// Report Objects end //////////////////
    procedure frmDMWklyPrchRepDestroy(Sender: TObject);
    procedure WklyPurchRepPreviewFormCreate(Sender: TObject);
    procedure WklyPurchRepDetailBand1BeforePrint(Sender: TObject);
    procedure WklyPurchRepPreviewFormClose(Sender: TObject);
    procedure frmDMWklyPrchRepCreate(Sender: TObject);
    procedure InvSupNameDBtxtGetText(Sender: TObject; var Text: String);

  private
    { Private declarations }
    procedure GetOthersCoded;
  public
    { Public declarations }
    CatListChange: Boolean; // flag used to check if a prim cat name has been added/deleted
    //PZdata: String;
    function RemoveBSlash(theStr: String): String; // rmve illegal chars for column headings
    Procedure MakeReportTable;  // Create table used for reporting
    procedure GetAllCatSubTots(theDataSet: TDataSet);   // get cat sub totals for week
    procedure SortRepTable; // sort the report table , not used in curent ver (0.4)
  end;

var
  frmDMWklyPrchRep: TfrmDMWklyPrchRep;
  badChar: array[1..6] of char = ('\','/','&','.',' ','-'); // illegal column chars

  implementation

uses
  U1WklyPurch, ComCtrls, ppViewr, uGlobals, uADO, uLog;

{$R *.DFM}

function TfrmDMWklyPrchRep.RemoveBSlash(theStr: String): String;
// As catnames are used as column names then illegal chars have to be rmoved
Var
  i,j: integer;
begin
  for i := 1 to 6 do
  begin
    for j := 1 to length(thestr) do
    begin
      if BadChar[i] = copy(theStr,j,1) then
      begin
        delete(theStr,j,1);
        insert('_',theStr,j);
      end; //if
    end; //for j
  end; //for i
  Result :=  theStr;
end;

Procedure TfrmDMWklyPrchRep.MakeReportTable;
var
 CategStr,          // holds the name of the categories to be used as col heading for sql
 CatName,           // holds the name of the catgories used for retrieving subtots
 FileName,          // holds the path and filename of archived purch headers
 SqlStartStr,       // query text
 SqlEndStr: string; // query text
 i: integer;        // index counter
 Mappings: TStrings;
begin
  log.Event('Weekly Purchase Report DM; MakeReportTable');
  try
    // Create the report table from accepted invoice headers
    with QGetPurchHdr do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE accpurhd SET [total amount] = 0.00 WHERE [total amount] IS NULL');
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Add('SELECT [supplier name] as [Vendor], [date] as [Inv Date],');
      SQL.Add(' [delivery note no.] as [Invoice No.],	Convert(float, [total amount]) as [Inv Total]');
      SQL.Add('from accpurhd');
      SQL.Add('where [date] >= '''+ FormatDateTime('yyyymmdd', frm1WklyPurch.RepStart)+'''');
      SQL.Add('and [date] <= '''+ FormatDateTime('yyyymmdd', frm1WklyPurch.RepEnd)+'''');
      if SiteCode <> 0 then //not all sites
      begin
        SQL.Add('and [site code] = '+IntToStr(SiteCode));
        if not IsMaster then
        begin
          SQL.Add('and [supplier name] in ');
          SQL.Add('  (SELECT s2.[Supplier Name] ');
          SQL.Add('   FROM (select * from ac_SiteSuppliers where SiteId = dbo.fnGetSiteCode()) s1 LEFT OUTER JOIN Supplier s2 ');
          SQL.Add('      ON s1.SupplierID = s2.[Supplier Code] ');
          SQL.Add('   WHERE s1.SiteID = '+IntToStr(SiteCode) +') ');
        end;
      end;
      Open;
    end;
    TblWklyPurch.Close;
    //GetAccHdrsBM.Execute;

    Mappings := TStringList.Create;
    try
      Mappings.Add('Vendor=Vendor');
      Mappings.Add('Inv Date=Inv Date');
      Mappings.Add('Invoice No.=Invoice No.');
      Mappings.Add('Inv Total=Inv Total');

      log.event('Weekly Purchase Report DM; MakeReportTable: BatchMove QGetPurchHdr');
      dmADO.BatchMove(QGetPurchHdr, TblWklyPurch, Mappings, batCopy);
    finally
      Mappings.Free;
    end;
    QGetPurchHdr.Close;

    with QGetCurrPurchHdr do
    begin
    // append current invoice headers to report table
    // for 6p2 - get invoice totals from Purchase.db for all selected invoices...
      Close;
      SQL.Clear;
      SQL.Add('SELECT a.[site code], a.[supplier name] AS [Vendor], ');
      SQL.Add('a.[delivery note no.] AS [Invoice No.], a.[date] AS [Inv Date], ');
      SQL.Add('SUM(b.[total cost]) AS [Inv Total]');
      SQL.Add('FROM purchhdr a, purchase b');
      SQL.Add('WHERE a.[date] >= '''+ FormatDateTime('yyyymmdd', frm1WklyPurch.RepStart)+'''');
      SQL.Add('AND a.[date] <= '''+ FormatDateTime('yyyymmdd', frm1WklyPurch.RepEnd)+'''');
      SQL.Add('AND a.[deleted] IS NULL');
      if SiteCode <> 0 then //not all sites
      begin
        SQL.Add('AND b.[site code] = '+IntToStr(SiteCode));
        if not IsMaster then
        begin
          SQL.Add('and a.[supplier name] in ');
          SQL.Add('  (SELECT s2.[Supplier Name] ');
          SQL.Add('   FROM (select * from ac_SiteSuppliers where SiteId = dbo.fnGetSiteCode()) s1 LEFT OUTER JOIN Supplier s2 ');
          SQL.Add('      ON s1.SupplierID = s2.[Supplier Code] ');
          SQL.Add('   WHERE s1.SiteID = '+IntToStr(SiteCode) +') ');
        end;
      end
      else
        SQL.Add('AND b.[site code] = a.[site code]');
      SQL.Add('AND b.[supplier name] = a.[supplier name]');
      SQL.Add('AND b.[delivery note no.] = a.[delivery note no.]');
      SQL.Add('GROUP BY a.[site code], a.[supplier name], a.[delivery note no.], a.[date]');

      Open;
    end;
    TblWklyPurch.CLose;
    //GetCurrHdrsBM.Execute;

    Mappings := TStringList.Create;
    try
      Mappings.Add('Vendor=Vendor');
      Mappings.Add('Inv Date=Inv Date');
      Mappings.Add('Invoice No.=Invoice No.');
      Mappings.Add('Inv Total=Inv Total');

      log.event('Weekly Purchase Report DM; MakeReportTable: BatchMove QGetCurrPurchHdr');
      dmADO.BatchMove(QGetCurrPurchHdr, TblWklyPurch, Mappings);
    finally
      Mappings.Free;
    end;

    QGetCurrPurchHdr.Close;
  except
    on E: Exception do
    begin
      Log.Event('Weekly Purchase Report DM; ERROR - MakeReportTable: ' + E.Message + QGetCurrPurchHdr.SQL.Text);
      raise;
    end;
  end;

  try
    TblWklyPurch.Open;
    if TblWklyPurch.IsEmpty then
    begin
      ShowMessage('No Invoices For This Period.');
      frm1wklypurch.Generated := False;
      TblWklyPurch.Close;
      Exit;
    end;
    TblWklyPurch.Close;
  except
    on E: Exception do
    begin
      Log.Event('Weekly Purchase Report DM ERROR - MakeReportTable: TblWklyPurch ' + tblWklyPurch.TableName +'; ' + E.Message);
      raise;
    end;
  end;

  // get list of category names
  wwFixedCatsTbl.Close;
  log.event('Weekly Purchase Report DM; MakeReportTable: wwFixedCatsTbl opened: ' + wwFixedCatsTbl.TableName);
  wwFixedCatsTbl.Open;
  wwFixedCatsTbl.First;

  try
    // add new category columns to WKLYPURCH.DB
    While not wwFixedCatsTbl.EOF do
    begin
      CategStr := wwFixedCatsTbl.FieldByName('Map Name').AsString;
      if pos('[', CategStr) > 0 then
        raise Exception.Create('The report category ' + CategStr + ' contains the invalid character ''[''.' + #13#10#10 +
                               'Please contact Zonal to have this corrected before trying to view the report again.');
      with QAlter do
      begin
        Close;
        SQL.Clear;
        ParamCheck := False;
        SQL.Add('Alter Table wklypurch ADD');
        SQL.Add('['+ CategStr + '] money');
        log.event('Weekly Purchase Report DM; MakeReportTable: QAlter executed: ' + QAlter.SQL.Text);
        ExecSQL;
        wwFixedCatsTbl.next;
      end; //With QAlter
    end; //While

    // add Others Coded Columns to WKLYPURCH.DB
    for i := 1 to 2 do
    begin
      CategStr := 'C' + IntToStr(i) + ' CHAR(2)';
      with QAlter do
      begin
        Close;
        SQL.Clear;
        ParamCheck := False;
        SQL.Add('Alter Table wklypurch ADD');
        SQL.Add(CategStr);
        log.event('Weekly Purchase Report DM; MakeReportTable: QAlter executed: ' + QAlter.SQL.Text);
        ExecSQL;
      end; //With QAlter

      CategStr := 'Others_Coded' + IntToStr(i) + ' money';
      with QAlter do
      begin
        Close;
        SQL.Clear;
        ParamCheck := False;
        SQL.Add('Alter Table wklypurch ADD');
        SQL.Add(CategStr);
        log.event('Weekly Purchase Report DM; MakeReportTable: QAlter executed: ' + QAlter.SQL.Text);
        ExecSQL;
      end; //With QAlter
    end; //for
    // filename will hold the pc's PRIZM\DATA dir & filename
    FileName := 'acc'+formatDateTime('mmmyy',frm1wklypurch.RepStart);

    SqlStartStr := 'Select e.[Vendor], e.[invoice no.], e.[inv date],'+
                          'c.[sub-category name] as [category name] ,SUM(d.[total cost]) as [Total Cost]';

    SqlEndStr := 	'entity c,' +
                  'wklypurch e' + #13 +
                  'Where e.[invoice no.] = d.[delivery note no.]'	+
                  'and e.[Vendor] = d.[supplier name]' +
                  'and c.[sub-category name] IN (SELECT DISTINCT b.[sub-category name]' +
                  ' FROM subcateg b)' +
                  'and d.[entity code] = c.[entity code]'	+
                  'Group By e.[Vendor], e.[invoice no.],'	+
                   'c.[sub-category name], e.[inv date]';
    with QGetInvCatSubTots.SQL do
    begin
      // check for archived accepted invoice sub totals per category
      Clear;
      Add(SqlStartStr);
      FileName := 'acc'+formatDateTime('mmmyy',frm1wklypurch.RepStart);
      Add('From '+FileName+' d,');
      Add(SqlEndStr);

      try
        GetAllCatSubTots(QGetInvCatSubTots);
      except
        on E: Exception do
          log.event('Weekly Purchase Report DM; MakeReportTable: Error accessing Chunk table - ' + E.Message);
      end;

      // get accepted invoice sub totals per category
      Clear;
      Add(SqlStartStr);
      Add('From accpurch d,');
      Add(SqlEndStr);
      GetAllCatSubTots(QGetInvCatSubTots);

      // get current invoice sub totals per category
      Clear;
      Add(SqlStartStr);
      Add('From purchase d,');
      Add(SqlEndStr);
      GetAllCatSubTots(QGetInvCatSubTots);
    end; //with

    log.event('Weekly Purchase Report DM; MakeReportTable: TblWklyPurch opened: ' + TblWklyPurch.TableName);
    TblWklyPurch.Open;
    TblWklyPurch.First;
    //set nulls to 0.0
    While not TblWklyPurch.EOF do
    begin
      for i := 4 to TblWklyPurch.Fieldcount - 1 do
      begin
        if TblWklyPurch.FieldByName('Inv Total').AsString <> '' then
        begin
          if TblWklyPurch.Fields[i].DataType = ftCurrency	 then
          begin
            if TblWklyPurch.Fields[i].Value = null then
            begin
              TblWklyPurch.edit;
              TblWklyPurch.Fields[i].Value := 0.0;
              TblWklyPurch.post;
            end;//if
          end; //if
        end
        else
        begin
          if TblWklyPurch.Fields[i].DataType = ftCurrency	 then
          begin
            if TblWklyPurch.Fields[i].Value = null then
            begin
              TblWklyPurch.edit;
              TblWklyPurch.Fields[i].Clear;
              TblWklyPurch.post;
            end;//if
          end;//if
        end;//ifelse
       end; //for
       TblWklyPurch.next;
    end; //while

    //sort invoice records
    QWklyPrchOrd.Close;
    QWklyPrchOrd.SQL.Clear;
    QWklyPrchOrd.SQL.Add('Select * From WklyPurch');
    Case frm1WklyPurch.OrderByRadioGrp.ItemIndex of
       0: begin
            QWklyPrchOrd.SQL.Add('Order By Vendor, [Inv Date], [Invoice No.], [Inv Total] DESC');
            VendorHdrLbl.Color  := clMedGray;
            InvDateHdrLbl.Color := clWhite;
            InvNoHdrLbl.Color   := clWhite;
          end;
       1: begin
            QWklyPrchOrd.SQL.Add('Order By [Inv Date], [Vendor], [Invoice No.], [Inv Total] DESC');
            InvDateHdrLbl.Color:= clMedGray;
            InvNoHdrLbl.Color  := clWhite;
            VendorHdrLbl.Color := clWhite;
          end;
       2: begin
            QWklyPrchOrd.SQL.Add('Order By [Invoice No.], [Vendor], [Inv Date], [Inv Total] DESC');
            InvNoHdrLbl.Color   := clMedGray;
            InvDateHdrLbl.Color := clWhite;
            VendorHdrLbl.Color  := clWhite;
          end;
    end; //case

    try
      QWklyPrchOrd.Open;
    except
      on E: Exception do
        raise Exception.Create(E.Message + QWklyPrchOrd.SQL.Text);
    end;

    // remake the WKLYPURCH.DB table with the same data but sorted
    TblWklyPurch.Close;
    dmADO.EmptySQLTable('WklyPurch');

    //SortedHdrsBm.Execute;
    Mappings := TStringList.Create;
    try
      try
        dmADO.BatchMove(QWklyPrchOrd, TblWklyPurch, Mappings);
      except
        on E: Exception do
          raise Exception.Create('BatchMove QWklyPrchOrd to TblWklyPurch' + E.Message);
      end;
    finally
      Mappings.Free;
    end;

    // get grand totals for each cat for the week
    TblWklyPurch.Open;
    QWklyTots.Close;
    QWklyTots.SQL.Clear;
    QWklyTots.SQL.Add('SELECT SUM(a."Inv Total") as InvTotal,');
    for i := 4 to TblWklyPurch.FieldCount - 1 do
    begin
      if TblWklyPurch.Fields[i].DataType = ftBCD then
      begin
        CatName := TblWklyPurch.Fields[i].FieldName;
        if (i < TblWklyPurch.FieldCount-1) then
          QWklyTots.SQL.Add('SUM(a."' + CatName + '") as "' + CatName + '",')
        else
          QWklyTots.SQL.Add('SUM(a."' + CatName + '") as "' + CatName + '"')
      end;
    end;
    QWklyTots.SQL.Add('FROM wklypurch a');
    log.event('Weekly Purchase Report DM; MakeReportTable: QWklyTots opened: ' + QWklyTots.SQL.Text);
    QWklyTots.Open;
    // append above into TblWklyPurch.db
    TblWklyPurch.Append;
    TblWklyPurch.Fields[0].value := 'TOTALS';  //
    for i := 3 to TblWklyPurch.FieldCount - 5 do
    begin
      TblWklyPurch.Edit;
      TblWklyPurch.Fields[i].Value := QwklyTots.Fields[i-3].Value;
      TblWklyPurch.Post;
    end; //for

    TblWklyPurch.Edit;
    TblWklyPurch.FieldByName('Others_Coded1').AsCurrency :=
      QwklyTots.FieldByName('Others_Coded1').AsCurrency;
    TblWklyPurch.FieldByName('Others_Coded2').AsCurrency :=
      QwklyTots.FieldByName('Others_Coded2').AsCurrency;
    TblWklyPurch.Post;

    TblWklyPurch.First;
    QGetInvCatSubTots.Close;
    wwFixedCatsTbl.Close;
    frm1wklypurch.Generated := True;
  except
    on E: Exception do
    begin
      Log.Event('Weekly Purchase Report DM; ERROR - MakeReportTable: ' + E.Message);
      raise;
    end;
  end;
end; // Procedure TfrmDMWklyPrchRep.MakeReportTable

procedure TfrmDMWklyPrchRep.GetAllCatSubTots(theDataSet: TDataSet);
begin
  try
    theDataSet.Close;
    log.event('Weekly Purchase Report DM; GetAllCatSubTots: theDataSet opened');
    theDataSet.Open;

    // insert the accepted category totals into correspnding categories in WKLYPURCH.DB
    theDataSet.First;
    log.event('Weekly Purchase Report DM; GetAllCatSubTots: TblWklyPurch opened: ' + TblWklyPurch.TableName);
    TblWklyPurch.Active := True;

    dmADO.EmptySQLTable('CodeSubs');
    While not theDataSet.EOF do
    begin
      if TblWklyPurch.Locate('Vendor;Invoice No.', // locate use sql?
              VarArrayOf([theDataSet.FieldByName('Vendor').AsString,
              theDataSet.FieldByName('Invoice No.').AsString]),[]) then
      begin
        if wwFixedCatsTbl.Locate('Category Name',
                  theDataSet.FieldByName('Category Name').AsString,[]) then
        begin
          TblWklyPurch.edit;
          TblWklyPurch.FieldByName(wwFixedCatsTbl.FieldByName('map name').AsString).AsFloat :=
          theDataSet.FieldByName('total cost').AsFloat;
          TblWklyPurch.post;
        end //if
        else
        begin
          log.event('Weekly Purchase Report DM; GetAllCatSubTots: wwCodeSubsTbl opened: ' + wwCodeSubsTbl.TableName);
          wwCodeSubsTbl.Open;
          wwCodeCatsTbl.Open;
          if wwCodeCatsTbl.Locate('Category Name',
                                    theDataSet.FieldByName('Category Name').AsString, []) then
          begin
            wwCodeSubsTbl.AppendRecord([theDataSet.FieldByName('Vendor'),
                                         theDataSet.FieldByName('Invoice No.'),
                                         theDataSet.FieldByName('Inv Date'),
                                         theDataSet.FieldByName('Category Name'),
                                         Null,
                                         theDataSet.FieldByName('total cost')]);

            wwCodeSubsTbl.Edit;
            wwCodeSubsTbl.FieldByName('Code').AsString := wwCodeCatsTbl.FieldByName('Code').AsString;
            wwCodeSubsTbl.Post;
          end;
            wwCodeSubsTbl.Close;
            wwCodeCatsTbl.Close;
        end;
      end; // if
      theDataSet.next;
    end; // While
    // set 'Others Coded' fields
    GetOthersCoded;
    theDataSet.Close;
    TblWklyPurch.Close;
  except
    on E: Exception do
    begin
      Log.Event('Weekly Purchase Report DM; ERROR - GetAllCatSubTots: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TfrmDMWklyPrchRep.GetOthersCoded;
var
 firstColCode: string;
begin
  try
    if dmADO.SQLTableExists('#GhostOthers') then dmAdo.DelSQLTable('#GhostOthers');
    with wwQRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE #GhostOthers(');
      SQL.Add('     [Vendor] [varchar] (20) collate database_default NULL,');
      SQL.Add('     [Inv Date] [datetime] NULL ,');
      SQL.Add('     [Invoice No.] [varchar] (15) collate database_default NULL,');
      SQL.Add('     [Inv Total] [float] NULL ,');
      SQL.Add('     [Cat1] [money] NULL ,');
      SQL.Add('     [Cat2] [money] NULL ,');
      SQL.Add('     [Cat3] [money] NULL ,');
      SQL.Add('     [Cat4] [money] NULL ,');
      SQL.Add('     [Cat5] [money] NULL ,');
      SQL.Add('     [Cat6] [money] NULL ,');
      SQL.Add('     [Cat7] [money] NULL ,');
      SQL.Add('     [Cat8] [money] NULL ,');
      SQL.Add('     [C1] [char] (2) collate database_default NULL ,');
      SQL.Add('     [Others_Coded1] [money] NULL ,');
      SQL.Add('     [C2] [char] (2) collate database_default NULL ,');
      SQL.Add('     [Others_Coded2] [money] NULL ');
      SQL.Add(') ON [PRIMARY]');
      ExecSQL;
      Close;
    end;
    TblWklyPurch.First;
    While not TblWklyPurch.Eof do
    begin
      wwQCodedCats.Close;
      wwQCodedCats.Parameters.ParamByName('Invoice').Value := TblWklyPurch.FieldByName('Invoice No.').AsString;
      wwQCodedCats.Parameters.ParamByName('Vendor').Value := TblWklyPurch.FieldByName('Vendor').AsString;
      log.event('Weekly Purchase Report DM; GetOthersCoded: wwQCodedCats opened: ' + wwQCodedCats.SQL.Text);
      wwQCodedCats.Open;   // get the coded categories
      if wwQCodedCats.RecordCount > 0 then
      begin
        while not wwQCodedCats.EOF do
        begin
          if wwQCodedCats.RecNo > 2 then
          begin
            with wwQRun do
            begin
              Close;
              SQL.Clear;
              //if odd then insert new record and set the values of C1 and Others_Coded1
              //else if even then update record and set the values of C2 and Others_Coded2 where
              //vendor, invoice no match and C1 matches the saved firstcolcode
              if odd(wwQCodedCats.RecNo) then
              begin
                firstColCode := wwQCodedCats.FieldByName('Code').AsString;
                SQL.ADD('INSERT INTO #GhostOthers ([Vendor],[Invoice No.], [Inv Date], C1, Others_Coded1)');
                SQL.ADD('(SELECT [Vendor], [Invoice No.], [Date], [Code] AS C1, [Total Cost] AS Others_Coded1');
                SQL.ADD(' FROM [CodeSubs]');
                SQL.ADD(' WHERE [Vendor] = ' + QuotedStr(wwQCodedCats.FieldByName('Vendor').AsString));
                SQL.ADD(' AND [Invoice No.] = ' + QuotedStr(wwQCodedCats.FieldByName('Invoice No.').AsString));
                SQL.ADD(' AND [Code] = ' + QuotedStr(firstColCode) + ')');
                ExecSQL;
              end
              else
              begin
                SQL.ADD('UPDATE #GhostOthers');
                SQL.ADD('  SET C2 = c.Code, Others_Coded2 = c.[Total Cost]');
                SQL.ADD('  FROM #GhostOthers m, CodeSubs c');
                SQL.ADD('  WHERE m.Vendor = c.Vendor');
                SQL.Add('    AND m.C1 = ' + QuotedStr(firstColCode));
                SQL.ADD('    AND m.[Invoice No.] = c.[Invoice No.]');
                SQL.ADD('    AND c.[Code] = ' + QuotedStr(wwQCodedCats.FieldByName('Code').AsString));
                SQL.ADD('    AND c.[Invoice No.] = ' + QuotedStr(wwQCodedCats.FieldByName('Invoice No.').AsString));
                ExecSQL;
              end;
              Close;
            end;
          end
          else
          begin
            TblWklyPurch.Edit;
            if odd(wwQCodedCats.RecNo) then
            begin
              TblWklyPurch.FieldByName('C1').AsString := wwQCodedCats.FieldByName('Code').AsString;
              TblWklyPurch.FieldByName('Others_Coded1').AsString := wwQCodedCats.FieldByName('total cost').AsString;
            end
            else
            begin
              TblWklyPurch.FieldByName('C2').AsString := wwQCodedCats.FieldByName('Code').AsString;
              TblWklyPurch.FieldByName('Others_Coded2').AsString := wwQCodedCats.FieldByName('total cost').AsString;
            end;
            TblWklyPurch.Post;
          end;
          wwQCodedCats.Next;
        end;
      end;
      TblWklyPurch.Next;
    end;
    // add records from #ghostothers to tblwklypurch
    with wwqrun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO WKLYPURCH([Vendor],[Invoice No.], [Inv Date], C1, Others_Coded1, C2, Others_Coded2)');
      SQL.Add('(SELECT [Vendor],[Invoice No.], [Inv Date], C1, Others_Coded1, C2, Others_Coded2 from [#GhostOthers])');
      ExecSQL;
      Close;
    end;
  except
    on E: Exception do
    begin
      Log.Event('Weekly Purchase Report DM; ERROR - GetOthersCoded: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TfrmDMWklyPrchRep.frmDMWklyPrchRepDestroy(Sender: TObject);
begin
  log.event('Weekly Purchase Report DM; DataModule Closed');
  try
    TblWklyPurch.active := False;
    PconfigsTbl.active := False;
    wwFixedCatsTbl.active := False;
    wwFixedCatsTbl.active := False;
    wwCodeCatsTbl.active := False;
    wwCodeSubsTbl.active := False;
    QGetPurchHdr.Close;
    QGetCurrPurchHdr.Close;
    QWklyPrchOrd.Close;
    QAlter.Close;
    QGetInvCatSubTots.Close;
    QWklyTots.Close;
    Qweeks.Close;
    wwQCodedCats.Close;
  except
    on E:Exception do
    begin
      log.event('Weekly Purchase Report DM; ERROR: Error Closing File.' + #13 + E.Message);
      showmessage('Error Closing File.' + #13 + E.Message);
    end;
  end;//except
end;

procedure TfrmDMWklyPrchRep.WklyPurchRepPreviewFormCreate(Sender: TObject);
begin
  dmADO.ReportPreviewFormCreate(Sender);
  WklyPurchRep.PreviewForm.Caption := 'Weekly ' + appGUIString + ' Report - Preview';
end;

procedure TfrmDMWklyPrchRep.WklyPurchRepDetailBand1BeforePrint(
  Sender: TObject);
begin
  if (DBtxt9.Text = '') and (InvSupNameDBtxt.Text <> 'TOTALS') then
    DBtxt10.DataField := ''
  else
    DBtxt10.DataField := 'Others_Coded1';

  if (DBtxt11.Text = '')  and (InvSupNameDBtxt.Text <> 'TOTALS') then
    DBtxt12.DataField := ''
  else
    DBtxt12.DataField := 'Others_Coded2';

  if InvTotalDBtxt.Text = '' then
  begin
    InvNoDBtxt.Visible := False;
    InvSupNameDBtxt.Visible := False;
    InvDateDBtxt.Visible := False;
    InvTotalDBtxt.Visible := False;
    DBtxt1.Visible := False;
    DBtxt2.Visible := False;
    DBtxt3.Visible := False;
    DBtxt4.Visible := False;
    DBtxt5.Visible := False;
    DBtxt6.Visible := False;
    DBtxt7.Visible := False;
    DBtxt8.Visible := False;
    Shape1.Visible := False;
    Shape2.Visible := False;
    Shape3.Visible := False;
    Shape4.Visible := False;
    Shape5.Visible := False;
    Shape6.Visible := False;
    Shape7.Visible := False;
    Shape8.Visible := False;
    Shape9.Visible := False;
    Shape10.Visible := False;
    Shape11.Visible := False;
  end
  else
  begin
    InvNoDBtxt.Visible := True;
    InvSupNameDBtxt.Visible := True;
    InvDateDBtxt.Visible := True;
    InvTotalDBtxt.Visible := True;
    DBtxt1.Visible := True;
    DBtxt2.Visible := True;
    DBtxt3.Visible := True;
    DBtxt4.Visible := True;
    DBtxt5.Visible := True;
    DBtxt6.Visible := True;
    DBtxt7.Visible := True;
    DBtxt8.Visible := True;
    Shape1.Visible := True;
    Shape2.Visible := True;
    Shape3.Visible := True;
    Shape4.Visible := True;
    Shape5.Visible := True;
    Shape6.Visible := True;
    Shape7.Visible := True;
    Shape8.Visible := True;
    Shape9.Visible := True;
    Shape10.Visible := True;
    Shape11.Visible := True;
  end;
end;

// code OK but proc not used in current ver(0.4)
procedure TfrmDMWklyPrchRep.SortRepTable;
{Var
	i: integer;
  CatName: string; }
begin
  {TblWklyPurch.Open;
  TblWklyPurch.Last;
  TblWklyPurch.Delete;
  TblWklyPurch.Close;

  //sort invoice records
  TblWklyPurch.Open;
  QWklyPrchOrd.Close;
  QWklyPrchOrd.SQL.Clear;
  QWklyPrchOrd.SQL.Add('Select * From ":PurchTab:WklyPurch.db" a');
  Case frm1WklyPurch.OrderByRadioGrp.ItemIndex of
  	0:	QWklyPrchOrd.SQL.Add(
      'Order By a."Vendor", a."Inv Date", a."Invoice No.", a."Inv Total" desc');
     1: QWklyPrchOrd.SQL.Add(
      'Order By a."Inv Date", a."Vendor", a."Invoice No.", a."Inv Total" desc');
     2: QWklyPrchOrd.SQL.Add(
      'Order By a."Invoice No.", a."Vendor", a."Inv Date", a."Inv Total" desc');
  end; //case
  QWklyPrchOrd.Open;
  // remake the WKLYPURCH.DB table with the same data but sorted
  TblWklyPurch.BatchMove(QWklyPrchOrd, batCopy);
  //Append overall totals to bottom of table
  QWklyTots.Close;
  QWklyTots.SQL.Clear;
  QWklyTots.SQL.Add('SELECT 	SUM(a."Inv Total")');
  for i := 4 to TblWklyPurch.FieldCount - 1 do
  begin
     if TblWklyPurch.Fields[i].DataType = ftCurrency	 then
     begin
  		QWklyTots.SQL.Add(',SUM(a.');
     	CatName := TblWklyPurch.Fields[i].FieldName;
     	QWklyTots.SQL.Add(CatName + ')');
		end;
  end;
  QWklyTots.SQL.Add('FROM ":purchtab:wklypurch.db" a');
  QWklyTots.Open;
  // append above into TblWklyPurch.db
  TblWklyPurch.Append;
  TblWklyPurch.Fields[0].value := 'TOTALS';
  for i := 3 to TblWklyPurch.FieldCount - 5 do//9
  begin
        TblWklyPurch.Edit;
     	TblWklyPurch.Fields[i].Value := QwklyTots.Fields[i-3].Value;
     	TblWklyPurch.Post;
  end; //for
  TblWklyPurch.Edit;
  TblWklyPurch.FieldByName('Others_Coded1').AsCurrency :=
  							QwklyTots.FieldByName('SUM OF Others_Coded1').AsCurrency;
  TblWklyPurch.FieldByName('Others_Coded2').AsCurrency :=
  							QwklyTots.FieldByName('SUM OF Others_Coded2').AsCurrency;
	TblWklyPurch.Post;

  TblWklyPurch.First;}
end;

procedure TfrmDMWklyPrchRep.WklyPurchRepPreviewFormClose(Sender: TObject);
begin
  frm1wklypurch.InitStartScreen;
end;

procedure TfrmDMWklyPrchRep.frmDMWklyPrchRepCreate(Sender: TObject);
//var
	//ParamList: Tstrings;
begin
 // ParamList := TStringList.Create;
      //	Session.GetAliasParams('dosprizm',ParamList);
 // PZdata := ParamList.Values['PATH'];
 // ParamList.Free;
  log.event('Weekly Purchase Report DM; DataModule opened');
  if UKUSmode = 'UK' then
  begin
    InvNoHdrLbl.Caption := 'Del. No.';
    InvDateHdrLbl.Caption := 'Del. Date';
    InvTotLbl.Caption := 'Del. Total';
  end
  else
  begin
    InvNoHdrLbl.Caption := GetLocalisedName(lsInvoice) + ' No.';
    InvDateHdrLbl.Caption := 'Inv. Date';
    InvTotLbl.Caption := 'Inv. Total';
  end;
end;

procedure TfrmDMWklyPrchRep.InvSupNameDBtxtGetText(Sender: TObject;
  var Text: String);
begin
  if Text = 'zzzzTOTALS' then
    Text := 'TOTALS';
end;

end.
