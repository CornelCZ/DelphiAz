unit uAlliant;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, Buttons, Wwdatsrc, ppCache, ppDB, ppDBBDE, ppComm,
  ppProd, ppClass, ppReport, Grids, ppViewr, Wwdbigrd, Wwdbgrid, ppCtrls,
  ppPrnabl, ppBands, ExtCtrls, ppStrtch, ppMemo, ppVar, ppDBPipe, ppRelatv,
  Variants, ADODB, DB;

type
  TfAlliant = class(TForm)
    FileBox: TFileListBox;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Memo1: TMemo;
    ppReport1: TppReport;
    AlliaInvPipe: TppBDEPipeline;
    wwsAlliaInv: TwwDataSource;
    wwsAlliaFil: TwwDataSource;
    wwgAlliaFil: TwwDBGrid;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    ppReport1TitleBand1: TppTitleBand;
    ppReport1SummaryBand1: TppSummaryBand;
    ppReport1Label1: TppLabel;
    ppReport1DBText1: TppDBText;
    ppReport1Label2: TppLabel;
    ppReport1DBText2: TppDBText;
    ppReport1Line1: TppLine;
    ppReport1Line2: TppLine;
    ppReport1Line3: TppLine;
    ppReport1Label3: TppLabel;
    ppReport1Label4: TppLabel;
    ppReport1Label5: TppLabel;
    ppReport1Label6: TppLabel;
    ppReport1Label7: TppLabel;
    ppReport1Label8: TppLabel;
    ppReport1Label9: TppLabel;
    ppReport1Label10: TppLabel;
    ppReport1Label11: TppLabel;
    ppReport1Label12: TppLabel;
    ppReport1DBText3: TppDBText;
    ppReport1DBText4: TppDBText;
    ppReport1DBText5: TppDBText;
    ppReport1DBText6: TppDBText;
    ppReport1DBText7: TppDBText;
    ppReport1DBText8: TppDBText;
    ppReport1DBText9: TppDBText;
    ppReport1DBText10: TppDBText;
    ppReport1DBText11: TppDBText;
    ppReport1DBText12: TppDBText;
    ppReport1Line4: TppLine;
    ppReport1Line5: TppLine;
    ppReport1Line6: TppLine;
    ppReport1Line7: TppLine;
    ppReport1Line8: TppLine;
    ppReport1Line9: TppLine;
    ppReport1Line10: TppLine;
    ppReport1Line11: TppLine;
    ppReport1Line12: TppLine;
    ppReport1Line13: TppLine;
    ppReport1Line14: TppLine;
    ppReport1Label13: TppLabel;
    ppReport1Label14: TppLabel;
    ppReport1DBCalc1: TppDBCalc;
    ppReport1DBCalc2: TppDBCalc;
    ppReport1Line15: TppLine;
    ppReport1Line16: TppLine;
    ppReport1Line17: TppLine;
    ppReport1Line18: TppLine;
    ppReport1Line19: TppLine;
    ppReport1Line20: TppLine;
    ppReport1Line21: TppLine;
    ppReport1Line22: TppLine;
    ppReport1Line23: TppLine;
    ppReport1Line24: TppLine;
    ppReport1Line25: TppLine;
    ppReport1Line26: TppLine;
    ppReport1Line27: TppLine;
    ppReport1Line28: TppLine;
    ppReport1Line29: TppLine;
    Panel1: TPanel;
    BitBtn3: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ppRepLabel21: TppLabel;
    ppRepLabel22: TppLabel;
    ppReport1Label15: TppLabel;
    ppReport1Line30: TppLine;
    ppReport1Label16: TppLabel;
    ppReport1Line31: TppLine;
    ppReport1DBText13: TppDBText;
    ppReport1Label17: TppLabel;
    Label6: TLabel;
    Label7: TLabel;
    ppReport1Line32: TppLine;
    ppReport1Line33: TppLine;
    ppReport1Label18: TppLabel;
    ppReport1DBText14: TppDBText;
    ppReport1Memo1: TppMemo;
    ppReport1Label19: TppLabel;
    ppReport1DBText15: TppDBText;
    ppReport1Label20: TppLabel;
    ppReport1DBText16: TppDBText;
    ppRepCalc1: TppSystemVariable;
    ppRepCalc2: TppSystemVariable;
    ppReport1Calc1: TppSystemVariable;
    bbtErrRpt: TBitBtn;
    ppErrRpt: TppReport;
    ppErrPipe: TppDBPipeline;
    dsErrtbl: TwwDataSource;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppTitleBand1: TppTitleBand;
    ppLabel7: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    pplblNofiles: TppLabel;
    pplblImpSuc: TppLabel;
    pplblDupCur: TppLabel;
    pplblDupAcc: TppLabel;
    pplblBadFmt: TppLabel;
    ppLabel14: TppLabel;
    pplblNoInv: TppLabel;
    ppLine1: TppLine;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppLine5: TppLine;
    ppLabel17: TppLabel;
    ppShape1: TppShape;
    ppShape2: TppShape;
    ppLine4: TppLine;
    pplblSite: TppLabel;
    wwtAlliaFil: TADOTable;
    wwtAlliaFilDT: TDateTimeField;
    wwtAlliaFilName: TStringField;
    wwtAlliaFilInvNo: TStringField;
    wwtAlliaFilTotProd: TSmallintField;
    wwtAlliaFilMatched: TSmallintField;
    wwtAlliaFilImported: TStringField;
    wwtAlliaFilCredit: TStringField;
    wwtAlliaFilNoInv: TSmallintField;
    wwtAlliaFilUnMatched: TIntegerField;
    wwtAlliaInv: TADOTable;
    wwtPurchase: TADOTable;
    wwtPurchHdr: TADOTable;
    tblAccPurHd: TADOTable;
    wwtRun: TADOTable;
    wwqRun: TADOQuery;
    wwtAlliaRes: TADOTable;
    wwtAlliaResInvNo: TStringField;
    wwtAlliaResInvDate: TDateTimeField;
    wwtAlliaResTotProd: TSmallintField;
    wwtAlliaResMatched: TSmallintField;
    wwtAlliaResImported: TStringField;
    wwtAlliaResCredit: TStringField;
    wwtAlliaResUnMch: TSmallintField;
    wwqAlliaRes: TADOQuery;
    wwqAlliaResInvNo: TStringField;
    wwqAlliaResInvDate: TDateTimeField;
    wwqAlliaResTotProd: TSmallintField;
    wwqAlliaResMatched: TSmallintField;
    wwqAlliaResImported: TStringField;
    wwqAlliaResCredit: TStringField;
    wwqAlliaResUnMch: TSmallintField;
    wwtAlliant: TADOTable;
    wwqPUnits: TADOQuery;
    tblAlliaDup: TADOTable;
    qryErrRpt: TADOQuery;
    procedure GetFiles;
    procedure FormShow(Sender: TObject);
    procedure procFile(fName: string);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DoMatch;
    procedure MakeInv;
    procedure ppReport1PreviewFormCreate(Sender: TObject);
    procedure ModifInv;
    procedure ImportProds;
    procedure CreateInv;
    procedure bbtErrRptClick(Sender: TObject);
    procedure ppDBText4GetText(Sender: TObject; var Text: String);
    procedure ppErrRptPreviewFormCreate(Sender: TObject);
    procedure wwqAlliaResCalcFields(DataSet: TDataSet);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    thedir, sinvNo, crdmemo, invno, row, sfname, itype, logname: string;
    lastdt, maxdt, sinvDate, invdate, fdt: tdatetime;
    theFile, logfile: Text;
    unmch, totprod, fileno, vinvno, noinv, FileFmtErr, DupInvFounda,
    DupInvFoundc, TotalInv, GenericFiles: integer;
    error, credit, imperror: boolean;
  public
    { Public declarations }
    function FindDupCurr(fname: string): Boolean;
    function FindDupAcc(fname: string): Boolean;
  end;

var
  fAlliant: TfAlliant;

implementation

uses
  uMainMenu, uADO, uGlobals, uLog;

{$R *.DFM}

function TfAlliant.FindDupCurr(fname: string): Boolean;
var
  findinv : string;
begin
  if fmainmenu.TestFlag then
  begin
    findinv := 'ZZ' + invno;
  end
  else
  begin
    findinv := invno;
  end;

  if credit then
  begin
    result := false;
    exit;
  end;

  with wwtPurchhdr do
  begin
    close;
    try
      open;
      if locate('Supplier Name;Delivery Note No.',
                                         VarArrayOf(['US Foods' ,findinv ]), []) then
      begin
        with tblAlliaDup do
        begin
          close;
          open;
          Append;
          FieldByName('ImpFile').AsString := extractFileName(fname);
          FieldByName('ImpFileDT').AsDateTime := fdt;
          FieldByName('ImpInvNo').AsString := findinv;
          FieldByName('ImpLoc').AsString := 'C';
          FieldByName('PZDate').AsDateTime :=
                                       wwtPurchhdr.FieldByName('Date').AsDateTime;
          Post;
          close;
        end;
        result := true;
      end
      else
      begin
        result := false;
      end;
    except
      on E: Exception do
      begin
        Log.Event('fAlliant; ERROR - FindDupCurr: wwtPurchHdr table ' + wwtPurchHdr.TableName + ' - ' + E.Message);
        raise;
      end;
    end;
    close;
  end;
end;

function TfAlliant.FindDupAcc(fname: string): Boolean;
var
  findinv : string;
begin
  if fmainmenu.TestFlag then
  begin
    findinv := 'ZZ' + invno;
  end
  else
  begin
    findinv := invno;
  end;

  with tblAccPurhd do
  begin
    close;
    try
      open;
      if locate('Supplier Name;Delivery Note No.',
                                         VarArrayOf(['US Foods' ,findinv ]), []) then
      begin
        with tblAlliaDup do
        begin
          close;
          open;
          Append;
          FieldByName('ImpFile').AsString := extractFileName(fname);
          FieldByName('ImpFileDT').AsDateTime := fdt;
          FieldByName('ImpInvNo').AsString := findinv;
          FieldByName('ImpLoc').AsString := 'A';
          FieldByName('PZDate').AsDateTime :=
                                       tblAccPurhd.FieldByName('Date').AsDateTime;
          Post;
          close;
        end;
        result := true;
      end
      else
      begin
        result := false;
      end;
    except
      on E: Exception do
      begin
        Log.Event('fAlliant; ERROR - FindDupAcc: tblAlliaDup table ' + tblAlliaDup.TableName + ' - ' + E.Message);
        raise;
      end;
    end;
    close;
  end;
end;

// EXAMINE ALL invoices from c:\kraftfs\inv; consider all invoices with
// lmod date/time bigger than the last read invoice;
procedure TfAlliant.GetFiles;
var
  i, n: integer;
  //fdt renamed fdtloc as class private var fdt exists also - MH 10/12/1999
  fdtloc: tdatetime;
  fHandle: integer;
begin

  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select * from PurSysVar');
    try
      open;
    except
      on E: Exception do
      begin
        Log.Event('fAlliant ERROR - GetFiles: wwqRun query  - ' + E.Message + '; ' + wwqRun.SQL.Text);
        raise;
      end;
    end;

    thedir := FieldByName('ImportDir').asstring + '\';
    lastdt := FieldByName('ImportDT').asdatetime;
    close;
  end;

  wwtAlliafil.close;

  if not DirectoryExists(thedir) then
  begin
    bitbtn1.Visible := false;
    label1.Caption := 'The directory ' + thedir + ' does not exist.';
    exit;
  end;

  dmADO.EmptySQLTable('Alliafil');
  try
    wwtAlliafil.open;
  except
    on E: Exception do
    begin
      Log.Event('fAlliant; ERROR - GetFiles: wwtAlliaFil table ' + wwtAlliaFil.TableName + ' - ' + E.Message);
      raise;
    end;
  end;

  n := 0;
  maxdt := 0;

  FileBox.Directory := thedir;
  for i := 0 to FileBox.Items.Count - 1 do
  begin
    try
      fhandle := FileOpen(FileBox.Items[i], fmOpenWrite or fmShareDenyNone);
      fdtloc := FileDateToDateTime(FileGetDate(fhandle));
      FileClose(fhandle);
      if fdtloc > lastdt then // found new invoice
      begin
        inc(n);
        if fdtloc > maxdt then
          maxdt := fdtloc;
        wwtAlliafil.insert;
        wwtAlliafil.FieldByName('DT').asdatetime := fdtloc;
        wwtAlliafil.FieldByName('Name').asstring := FileBox.Items[i];
        wwtAlliafil.Post;
      end;
    except
      on E:exception do
      begin
        showmessage('Error trying to get handle and date/time of file no. ' +
         inttostr(i) + ' to be considered for import. File Name: ' + FileBox.Items[i]);
        log.event('fAlliant; ERROR - GetFiles: Error trying to get handle and date/time of file no. ' +
         inttostr(i) + ' to be considered for import. File Name: ' + FileBox.Items[i]);

        if not directoryExists(thedir+'\ImpErr') then
        begin
          ForceDirectories(thedir+'\ImpErr');
        end;

        logname := thedir + '\ImpErr\ErrFiles.txt';

        Assignfile(logfile, logname);
        try
          Append(logfile);
        except
          on Exception do
          begin
            Rewrite(logfile);
          end;
        end;

        writeln(logfile, '>ErrDT: ' + datetimetostr(Now) +
          'Error trying to get handle and date/time of file no. ' +
          inttostr(i) + ' to be considered for import. Name: ' +
          FileBox.Items[i] + ' Err. Msg: ' + E.message);
        CloseFile(logfile);
      end;
    end;
  end;
  wwtAlliafil.close;
  if n > 0 then
    label1.Caption := 'There are ' + inttostr(n) +
      ' valid new files to be processed.'
  else
  begin
    bitbtn1.Visible := false;
    label1.Caption := 'There are no new valid files at this time.';
  end;
end; // procedure

procedure TfAlliant.FormShow(Sender: TObject);
begin
  bbtErrRpt.Visible := False;
  error := false;
  GetFiles;
  vinvno := 1;
end;

procedure TfAlliant.ImportProds;
var
  fact: real;
  rowcount : integer;
begin
  imperror := true;
  rowcount := 0;
  try
    // read the type 2 records, and put the info in the Alliant table
    wwtAlliant.close;
    Application.ProcessMessages;
    dmADO.EmptySQLTable('Alliant');
    totprod := 0;
    Application.ProcessMessages;
    wwtAlliant.open;
    Application.ProcessMessages;
    Readln(theFile, row);
    Application.ProcessMessages;
    rowcount := 0;
    while copy(row, 12, 1) = '2' do
    begin
      inc(rowcount);
      with wwtAlliant do
      begin
        insert;
        FieldByName('filename').asstring := sfname;
        FieldByName('InvNo').asstring := invno;
        FieldByName('recno').asinteger := strtoint(copy(row, 87, 4));
        FieldByName('invdate').asdatetime := invdate;
        FieldByName('invtype').asstring := itype;
        FieldByName('ACode').asstring := copy(row, 21, 7);
        FieldByName('AName').asstring := copy(row, 28, 30);
        if copy(row, 116, 1) = ' ' then // units shipped.
          FieldByName('aunitq').asfloat := strtofloat(copy(row, 111, 5))
        else
          FieldByName('aunitq').asfloat := (-1.0) * strtofloat(copy(row, 111, 5));
        if copy(row, 120, 1) = ' ' then // eaches shipped.
          FieldByName('aeachq').asfloat := strtofloat(copy(row, 117, 3))
        else
          FieldByName('aeachq').asfloat := (-1.0) * strtofloat(copy(row, 117, 3));
        if copy(row, 128, 1) = ' ' then
          fact := 1.0
        else
          fact := -1.0;
        FieldByName('aweight').asfloat := fact *
          strtofloat(copy(row, 121, 5) + '.' + copy(row, 126, 2));

        FieldByName('ASUnit').asstring := copy(row, 182, 2);
        FieldByName('APUnit').asstring := copy(row, 184, 2);
        if copy(row, 162, 1) = ' ' then
          fact := 1.0
        else
          fact := -1.0;
        FieldByName('acostunit').asfloat := fact *
          strtofloat(copy(row, 153, 5) + '.' + copy(row, 158, 4));
        if copy(row, 120, 1) = ' ' then
          fact := 1.0
        else
          fact := -1.0;
        FieldByName('acosteach').asfloat := fact *
          strtofloat(copy(row, 163, 5) + '.' + copy(row, 168, 4));
        if copy(row, 181, 1) = ' ' then
          fact := 1.0
        else
          fact := -1.0;
        FieldByName('atotalcost').asfloat := fact *
          strtofloat(copy(row, 173, 6) + '.' + copy(row, 179, 2));
        FieldByName('convfact').asinteger := strtoint(copy(row, 222, 3));
        if copy(row, 226, 1) = 'Y' then
          FieldByName('WFlag').asstring := 'Y';
        post;
      end;
      Application.ProcessMessages;
      Readln(theFile, row); // next record...
      Application.ProcessMessages;
    end;

    totprod := wwtAlliant.RecordCount;
    imperror := false;
  except
    on E: Exception do
    begin
      writeln(logfile, '>ErrDT: ' + datetimetostr(Now) +
        ' ERROR importing products from ' + sfName + ', invoice ' + invno +
        ', type 2 row no. ' + inttostr(rowcount) + '; ErrMsg: ' + E.message);
      log.event('fAlliant; ERROR - ImportProds: >ErrDT: ' + datetimetostr(Now) +
        ' ERROR importing products from ' + sfName + ', invoice ' + invno +
        ', type 2 row no. ' + inttostr(rowcount) + '; ErrMsg: ' + E.message);

      imperror := true;
    end;
  end;
end; // procedure

procedure TfAlliant.procFile(fName: string);
var
  field: string;
  fact: real;
begin
  try
    noinv := 0;
    credit := false;
    label7.Caption := 'Opening file no.: ' + inttostr(fileno) + '...';
    wwtAlliant.close;
    Application.ProcessMessages;
    dmADO.EmptySQLTable('Alliant');
    Application.ProcessMessages;
    try
      AssignFile(thefile, fName);
      sfname := extractfilename(fname);
      Application.ProcessMessages;
      Reset(thefile);
      // read the header and get the invoice no., inv date;

      Read(theFile, row);
    except
      on E:exception do
      begin
        writeln(logfile, '>ErrDT: ' + datetimetostr(Now) +
          ' ERROR trying to open file ' + fName + ' Err. Msg: ' + E.message);
        log.event('fAlliant; ERROR - ProcFiles: >ErrDT: ' + datetimetostr(Now) +
          ' ERROR trying to open file ' + fName + ' Err. Msg: ' + E.message);
        with wwqRun do
        begin
          close;
          sql.Clear;
          sql.Add('update PurSysVar set importdt = ''' +
            formatdatetime('mm/dd/yyyy hh:nn:ss', fdt) + '''');
          log.event('fAlliant; ProcFiles: wwqRun executed: ' + wwqRun.SQL.Text);
          execSQL;
        end;
        CloseFile(theFile);
        exit;
      end;
    end; //try..except
    label7.Caption := 'Reading file no.: ' + inttostr(fileno) + '...';

    while not eof(theFile) do
    begin
      Application.ProcessMessages;
      if copy(row, 12, 1) <> '1' then // make sure this is a header record.
      begin

        if copy(row, 1, 27) = '         9 000000 000000000' then
        begin
          inc(GenericFiles);
          Application.ProcessMessages;
          //log format error
          with tblAlliaDup do
          begin
            close;
            log.event('fAlliant; ProcFiles: tblAlliaDup opened: ' + tblAlliaDup.TableName);
            open;
            Append;
            FieldByName('ImpFile').AsString := extractFileName(fname);
            FieldByName('ImpFileDT').AsDateTime := fdt;
            FieldByName('ImpInvNo').AsString := 'N/A';
            FieldByName('ImpLoc').AsString := 'G';
            FieldByName('PZDate').AsDateTime := now;
            Post;
            close;
          end;
          break;
        end
        else
        begin
          inc(FileFmtErr);
          Application.ProcessMessages;
          //log format error
          with tblAlliaDup do
          begin
            close;
            log.event('fAlliant; ProcFiles: tblAlliaDup opened: ' + tblAlliaDup.TableName);
            open;
            Append;
            FieldByName('ImpFile').AsString := extractFileName(fname);
            FieldByName('ImpFileDT').AsDateTime := fdt;
            FieldByName('ImpInvNo').AsString := 'N/A';
            FieldByName('ImpLoc').AsString := 'H';
            FieldByName('PZDate').AsDateTime := now;
            Post;
            close;
          end;
          break;
        end;
      end;
      inc(noinv);
      invno := copy(row, 5, 7); // got the invoice no.

      field := copy(row, 20, 8); // get the inv. date
      try
      invdate := encodedate(strtoint(copy(field, 1, 4)), strtoint(copy(field, 5, 2)),
        strtoint(copy(field, 7, 2)));
      except
        on exception do
        begin
          writeln(logfile, '>ErrDT: ' + datetimetostr(Now) +
            ' ERROR trying to encode inv. date from ' + fName + ' row 1, chars 20 to 27');
          log.event('fAlliant; ERROR - ProcFiles: >ErrDT: ' + datetimetostr(Now) +
            ' ERROR trying to encode inv. date from ' + fName + ' row 1, chars 20 to 27');
          break;
        end;
      end;

      itype := copy(row, 52, 2);
      if copy(row, 52, 2) = 'CD' then
      begin
        crdMemo := copy(row, 13, 7);
        wwtAlliaFil.edit;
        wwtAlliaFil.FieldByName('Credit').asstring := 'Y';
        wwtAlliaFil.Post;
        credit := true;
      end
      else
      begin
        credit := false;
      end;

      // check for duplicate invoices in the curr & accepted header tables
      if (NOT credit) and  FindDupCurr(fname) then
      begin
        showmessage('Could not create Invoice with Invoice No.: "' +invno+
                    '" for supplier "US Foods".' +#13+
                    'A Current invoice with this number already exists!'+#13+#13+
                    'Importing Next Invoice....');
        inc(DupInvFoundc);
        Break;
      end
      else if FindDupAcc(fname) then
      begin
        showmessage('Could not create Invoice with Invoice No.: "' +invno+
                    '" for supplier "US Foods".' +#13+
                    'An Accepted invoice with this number already exists!'+#13+#13+
                    'Importing Next Invoice....');
        inc(DupInvFounda);
        Break;
      end;

      readln(theFile, row); // this is just to advance to the next line...
      // now the rows should have type2, and import individual items...
      imperror := false;
      ImportProds;
      if imperror then
      begin
        inc(FileFmtErr);
        Application.ProcessMessages;
        //log format error
        with tblAlliaDup do
        begin
          close;
          log.event('fAlliant; ProcFiles: tblAlliaDup opened: ' + tblAlliaDup.TableName);
          open;
          Append;
          FieldByName('ImpFile').AsString := extractFileName(fname);
          FieldByName('ImpFileDT').AsDateTime := fdt;
          FieldByName('ImpInvNo').AsString := 'N/A';
          FieldByName('ImpLoc').AsString := 'I';
          FieldByName('PZDate').AsDateTime := now;
          Post;
          close;
        end;
        break;
      end;

      if copy(row, 12, 1) = '1' then // this is a new invoice in the same file..
      begin
        imperror := true;
        CreateInv;
        if imperror then
        begin
          inc(FileFmtErr);
          Application.ProcessMessages;
          //log format error
          with tblAlliaDup do
          begin
            close;
            log.event('fAlliant; ProcFiles: tblAlliaDup opened: ' + tblAlliaDup.TableName);
            open;
            Append;
            FieldByName('ImpFile').AsString := extractFileName(fname);
            FieldByName('ImpFileDT').AsDateTime := fdt;
            FieldByName('ImpInvNo').AsString := 'N/A';
            FieldByName('ImpLoc').AsString := 'R';
            FieldByName('PZDate').AsDateTime := now;
            Post;
            close;
          end;
          break;
        end;
        continue;
      end;

      // read the allowance (Alliant Credit) matching code ALLCRED
      if copy(row, 12, 1) = '9' then // this is a footer record..
      begin
        if strtofloat(copy(row, 65, 9) + '.' + copy(row, 74, 2)) <> 0.0 then
        begin
          with wwtAlliant do
          begin
            insert;
            FieldByName('filename').asstring := sfname;
            FieldByName('InvNo').asstring := invno;
            FieldByName('recno').asinteger := totprod + 1;
            FieldByName('invdate').asdatetime := invdate;
            FieldByName('invtype').asstring := itype;
            FieldByName('ACode').asstring := 'ALLCRED';
            FieldByName('AName').asstring := 'Ctrl Allowances - US Foods Crd';
            FieldByName('aunitq').asfloat := 1.0;

            FieldByName('ASUnit').asstring := 'EA';
            FieldByName('APUnit').asstring := 'EA';
            if copy(row, 76, 1) = ' ' then
              fact := 1.0
            else
              fact := -1.0;
            FieldByName('acostunit').asfloat := fact *
              strtofloat(copy(row, 65, 9) + '.' + copy(row, 74, 2));

            FieldByName('acosteach').asfloat := fact *
              strtofloat(copy(row, 65, 9) + '.' + copy(row, 74, 2));

            FieldByName('atotalcost').asfloat := fact *
              strtofloat(copy(row, 65, 9) + '.' + copy(row, 74, 2));
            FieldByName('convfact').asinteger := 1;
            post;
          end; //with
        end;//if
      end;//if
      imperror := true;
      CreateInv;
      if imperror then
      begin
        inc(FileFmtErr);
        Application.ProcessMessages;
        //log format error
        with tblAlliaDup do
        begin
          close;
          log.event('fAlliant; ProcFiles: tblAlliaDup opened: ' + tblAlliaDup.TableName);
          open;
          Append;
          FieldByName('ImpFile').AsString := extractFileName(fname);
          FieldByName('ImpFileDT').AsDateTime := fdt;
          FieldByName('ImpInvNo').AsString := 'N/A';
          FieldByName('ImpLoc').AsString := 'R';
          FieldByName('PZDate').AsDateTime := now;
          Post;
          close;
        end;
        break;
      end;
    end;//while

    // reset the ImportDT in PurSysVar to hold the DT of the last file succesfully
    // processed...

    with wwqRun do
    begin
      close;
      sql.Clear;
      sql.Add('update PurSysVar set importdt = ''' +
        formatdatetime('mm/dd/yyyy hh:nn:ss', fdt) + '''');
      log.event('fAlliant; ProcFiles: wwqRun executed: ' + wwqRun.SQL.Text);
      execSQL;
    end;
  finally
    CloseFile(theFile);
  end;
end; // procedure

procedure TfAlliant.CreateInv;
var
  Mappings: TStringList;
begin
 /////////////////////////
  try
    totprod := wwtAlliant.RecordCount;
      //wwtAlliant.close;

    label7.Caption := 'Invoice: ' + invno + ' has ' + inttostr(totprod) +
      ' products. Attempting product matching...';

    DoMatch;

      // transfer unmatched products to AlliaInv and delete from Alliant
    with wwqRun do
    begin
      Application.ProcessMessages;
      close;
      sql.Clear;
      sql.Add('select filename, InvNo, RecNo, ACode, InvDate,');
      sql.Add('invtype, AName, AUnitQ, AEachQ, AWeight, ASUnit,');
      sql.Add('APUnit, ACostUnit, ACostEach, ATotalCost, ConvFact');
      sql.Add('from Alliant');
      sql.add('where EntityCode is NULL');
      log.event('fAlliant; CreateInv: wwqRun opened: ' + wwqRun.SQL.Text);
      open;
      Application.ProcessMessages;

      Mappings := TStringList.Create;

      try
        dmADO.BatchMove(wwqRun, wwtAlliaInv, Mappings);
      finally
        Mappings.Free;
      end;

      close;
      Application.ProcessMessages;

      sql.Clear;
      sql.Add('delete from Alliant where EntityCode is NULL');
      log.event('fAlliant; CreateInv: wwqRun executed: ' + wwqRun.SQL.Text);
      execSQL;
      Application.ProcessMessages;
    end;

    wwtAlliant.Close;
    log.event('fAlliant; CreateInv: wwtAlliant opened: ' + wwtAlliant.TableName);
    wwtAlliant.open;
    unmch := totprod - wwtAlliant.RecordCount;
    Application.ProcessMessages;

    if credit then
    begin
      if wwtAlliant.RecordCount = 0 then
      begin
        with wwtAlliaFil do
        begin
          edit;
          FieldByName('credit').asstring := 'U';
          post;
        end;
      end
      else
      begin
        sinvno := invno;
        ModifInv;
      end;
    end
    else
    begin
      label7.Caption := inttostr(wwtAlliant.recordcount) + ' products out of ' +
        inttostr(totprod) + ' were matched. Creating invoice no.: ' +
        inttostr(vinvno) + '...';
      Application.ProcessMessages;

      sinvdate := invdate;
      sinvno := invno;
      error := false;
      MakeInv;
      //fail safe error flag KeyViolations have already been checked for so this
      // will protect against any table errors done onPost in MakeInv
      if error then
        exit;

      if vinvno = 1 then
        label7.Caption := '1 invoice created...'
      else
        label7.Caption := inttostr(vinvno) + ' invoices created...';
      inc(vinvno);
      Application.ProcessMessages;
    end; // normal invoice, create....

    with wwtAlliaRes do
    begin
      log.event('fAlliant; CreateInv: wwtAlliaRes inserted');
      insert;
      FieldByName('invno').asstring := invno;
      FieldByName('invdate').asdatetime := invdate;
      FieldByName('totprod').asinteger := totprod;
      FieldByName('matched').asinteger := wwtAlliant.RecordCount;
      FieldByName('imported').asstring := 'Y';
      FieldByName('credit').asstring := itype;
      post;
    end;
    Application.ProcessMessages;
    with wwtAlliaFil do
    begin
      fdt := FieldByName('dt').asdatetime;
      log.event('fAlliant; CreateInv: wwtAlliaFil edited');
      edit;
      //if credit then
        FieldByName('invno').asstring := invno;
        //FieldByName('dt').asdatetime := invdate;
      FieldByName('totprod').asinteger := totprod;
      FieldByName('matched').asinteger := wwtAlliant.RecordCount;
      FieldByName('imported').asstring := 'Y';
      post;
    end;
    imperror := false;
    Application.ProcessMessages;
  except
    on E: exception do
    begin
      writeln(logfile, '>ErrDT: ' + datetimetostr(Now) +
        ' ERROR creating invoice ' + invno + ', Err. Msg: ' + E.message);
      log.event('fAlliant; ERROR - CreateInv: >ErrDT: ' + datetimetostr(Now) +
        ' ERROR creating invoice ' + invno + ', Err. Msg: ' + E.message);
      imperror := true;
    end;
  end;
end; // procedure

procedure TfAlliant.MakeInv;
var
  i: integer;
  s: string;
  edorins : boolean;
begin
  // calculate any tax in Alliant.db....
  // create a new invoice record in PurchHdr
  if fmainmenu.TestFlag then
  begin
    s := 'ZZ';
  end
  else
  begin
    s := '';
  end;
  Application.ProcessMessages;
  with wwqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select sum(atotalcost) from alliant');
    log.event('fAlliant; MakeInv: wwqRun opened: ' + wwqRun.SQL.Text);
    open;
    Application.ProcessMessages;
  end;
  with wwtpurchhdr do
  begin
    Application.ProcessMessages;
    log.event('fAlliant; MakeInv: wwtPurchHdr opened: ' + wwtPurchHdr.TableName);
    open;
    Application.ProcessMessages;

    edorins := True;
    // if this a table using 'deleted' field the inv may be there, deleted,
    // in which case edit. If it not deleted then try to insert (and of course ERROR)...
    if locate('supplier name;delivery note no.',
      VarArrayOf(['US Foods', s + sinvno]), []) then
    begin
      if FieldByName('deleted').asstring = 'Y' then
      begin
        edorins := False;
        edit;
      end;
    end;

    if edorins then
      insert;

    FieldByName('site code').asinteger := fmainmenu.thesiteno;
    FieldByName('supplier name').asstring := 'US Foods';
    FieldByName('delivery note no.').asstring := s + sinvno;
    FieldByName('modified by').asstring := CurrentUser.UserName;
    FieldByName('LMDT').asstring := formatdatetime('dd/mm/yyyy hh:nn', now);
    FieldByName('Deleted').Value := Null;
    FieldByName('date').asdatetime := sinvdate;
    FieldByName('note').asstring := 'Imported Invoice; Unmatched from Invoice file: ' +
      inttostr(unmch) + ' products out of ' + inttostr(totprod);

    try
      post;
    except
      on E: exception do
      begin
        if E.Message = 'Key violation.' then
        begin
          showmessage('Could not create Invoice with Invoice No.: "' +
            FieldByName('delivery note no.').asstring + '" for supplier "US Foods".' +
            #13 + 'An invoice with this number already exists!' + #13 + #13 +
            'Importing of this invoice cannot continue....');
          log.event('fAlliant; ERROR - MakeInv: Could not create Invoice with Invoice No.: "' +
            FieldByName('delivery note no.').asstring + '" for supplier "US Foods".' +
            #13 + 'An invoice with this number already exists!' + #13 + #13 +
            'Importing of this invoice cannot continue....');
        end
        else
        begin
          showmessage('Could not create Invoice with Invoice No.: "' +
            FieldByName('delivery note no.').asstring + '" for supplier "US Foods".' +
            #13 + 'Error Message: ' + E.Message +
            #13 + 'Importing of this invoice cannot continue....');
          log.event('fAlliant; ERROR - MakeInv: Could not create Invoice with Invoice No.: "' +
            FieldByName('delivery note no.').asstring + '" for supplier "US Foods".' +
            #13 + 'Error Message: ' + E.Message +
            #13 + 'Importing of this invoice cannot continue....');
        end;
        error := true;
        cancel;
        close;
        exit;
      end;
    end;
    Application.ProcessMessages;
    close;
  end;
  wwqRun.close;
  // create new records in Purchase
  with wwtPurchase do
  begin
    Application.ProcessMessages;
    log.event('fAlliant; MakeInv: wwtPurchase opened: ' + wwtPurchase.TableName);
    open;
    wwtAlliant.First;
    i := 1;
    Application.ProcessMessages;
    while not (wwtAlliant.EOF) do
    begin
      Application.ProcessMessages;
      insert;
      FieldByName('site code').asinteger := fmainmenu.thesiteno;
      FieldByName('supplier name').asstring := 'US Foods';
      FieldByName('delivery note no.').asstring := s + sinvno;
      FieldByName('modified by').asstring := CurrentUser.UserName;
      FieldByName('LMDT').asdatetime := Now;
      FieldByName('record id').asinteger := i;
      FieldByName('entity code').asfloat :=
        wwtAlliant.FieldByName('entitycode').asfloat;
      FieldByName('purchase name').asstring :=
        wwtAlliant.FieldByName('name').asstring;
      FieldByName('flavour').asstring :=
        wwtAlliant.FieldByName('flavour').asstring;
      Application.ProcessMessages;
      if (wwtAlliant.FieldByName('wflag').asstring = 'Y') and
        (wwtAlliant.FieldByName('apunit').asstring = 'LB') then
      begin
        FieldByName('unit name').asstring := 'Lb';
        FieldByName('quantity').asfloat :=
          wwtAlliant.FieldByName('aweight').asfloat;
        FieldByName('cost per unit').asfloat :=
          wwtAlliant.FieldByName('acostunit').asfloat;
      end
      else
      begin
        FieldByName('unit name').asstring :=
          wwtAlliant.FieldByName('unit').asstring;
        if wwtAlliant.FieldByName('aunitq').asfloat > 0 then
        begin
          FieldByName('quantity').asfloat :=
            wwtAlliant.FieldByName('aunitq').asfloat;
          FieldByName('cost per unit').asfloat :=
            wwtAlliant.FieldByName('acostunit').asfloat;
        end
        else
        begin
          FieldByName('quantity').asfloat :=
            wwtAlliant.FieldByName('aeachq').asfloat;
          FieldByName('cost per unit').asfloat :=
            wwtAlliant.FieldByName('acosteach').asfloat;
        end;

      end;

      FieldByName('total cost').asfloat :=
        wwtAlliant.FieldByName('atotalcost').asfloat;
      FieldByName('shortage').value :=
        wwtAlliant.FieldByName('shortage').value;
      try
        post;
      except
        on E: exception do
        begin
          if E.Message = 'Key violation.' then // KV.
          begin
            log.event('fAlliant; ERROR - MakeInv: wwtPurchase Key violation');
            wwtAlliaInv.open;
            wwtAlliaInv.insert;
            wwtAlliaInv.FieldByName('reason').asstring := 'KV';
          end
          else
          begin // PE.
            log.event('fAlliant; ERROR - MakeInv: wwtPurchase PE');
            wwtAlliaInv.open;
            wwtAlliaInv.insert;
            wwtAlliaInv.FieldByName('reason').asstring := 'PE';
          end;
           /////////////////
          wwtAlliaInv.FieldByName('invno').asstring := s + sinvno;
          wwtAlliaInv.FieldByName('recno').asfloat :=
            wwtAlliant.FieldByName('recno').asfloat;
          wwtAlliaInv.FieldByName('acode').asstring :=
            wwtAlliant.FieldByName('acode').asstring;
          wwtAlliaInv.FieldByName('aname').asstring :=
            wwtAlliant.FieldByName('aname').asstring;
          Application.ProcessMessages;
          wwtAlliaInv.FieldByName('asunit').asstring :=
            wwtAlliant.FieldByName('asunit').asstring;
          wwtAlliaInv.FieldByName('apunit').asstring :=
            wwtAlliant.FieldByName('apunit').asstring;
          wwtAlliaInv.FieldByName('aweight').asfloat :=
            wwtAlliant.FieldByName('aweight').asfloat;
          wwtAlliaInv.FieldByName('acostunit').asfloat :=
            wwtAlliant.FieldByName('acostunit').asfloat;
          wwtAlliaInv.FieldByName('aunitq').asfloat :=
            wwtAlliant.FieldByName('aunitq').asfloat;
          wwtAlliaInv.FieldByName('aeachq').asfloat :=
            wwtAlliant.FieldByName('aeachq').asfloat;
          wwtAlliaInv.FieldByName('acosteach').asfloat :=
            wwtAlliant.FieldByName('acosteach').asfloat;
          wwtAlliaInv.FieldByName('atotalcost').asfloat :=
            wwtAlliant.FieldByName('atotalcost').asfloat;
          wwtAlliaInv.FieldByName('convfact').value :=
            wwtAlliant.FieldByName('convfact').value;
          wwtAlliaInv.FieldByName('invdate').value :=
            wwtAlliant.FieldByName('invdate').value;

          wwtAlliaInv.Post;
           /////////////////////
          cancel;
        end;
      end;
      wwtAlliant.next;
      i := i + 1;
      Application.ProcessMessages;
    end;
    wwtAlliaInv.close;
    close;
    Application.ProcessMessages;
  end; // with
end; // procedure

  // match the items from alliant table with the items from entity based on
  // field 'import/export reference' from dosprizm:entity table and fill the
  // remaining fields in Alliant table

procedure TfAlliant.DoMatch;
begin
  Application.ProcessMessages;
  log.event('fAlliant; DoMatch: wwqPUnits opened: ' + wwqPUnits.SQL.Text);
  wwqPunits.open;
  Application.ProcessMessages;
  with wwtAlliant do
  begin
    filter := '(APUnit = ''CS'') or (APUnit = ''EA'') or ((APUnit = ''LB'') and ' +
      '(WFlag = ''Y''))';
    filtered := true;
    first;
    while not eof do
    begin
      if wwqPunits.Locate('Import/Export Reference',
        FieldByName('acode').asstring, []) then
      begin // match found...
        Application.ProcessMessages;
        log.event('fAlliant; DoMatch: wwtAlliant edited');
        edit;
        FieldByName('entitycode').asfloat :=
          wwqPunits.FieldByName('entity code').asfloat;
        FieldByName('name').asstring :=
          wwqPunits.FieldByName('purchase name').asstring;
        FieldByName('flavour').asstring :=
          wwqPunits.FieldByName('flavour').asstring;
        FieldByName('unit').asstring :=
          wwqPunits.FieldByName('unit name').asstring;
        FieldByName('costunit').asfloat :=
          wwqPunits.FieldByName('unit cost').asfloat;
        post;
        Application.ProcessMessages;
      end;

      next;
    end;
    filtered := false;
  end;
  Application.ProcessMessages;
  wwqPunits.close;
  Application.ProcessMessages;
end; // procedure


// DO IMPORT
procedure TfAlliant.BitBtn1Click(Sender: TObject);
var
  s1: string;
begin
  log.event('fAlliant; Do Import button pressed');
  if not directoryExists(thedir+'\ImpErr') then
  begin
    ForceDirectories(thedir+'\ImpErr');
  end;

  logname := thedir + '\ImpErr\ErrFiles.txt';

  Assignfile(logfile, logname);
  try
    Append(logfile);
  except
    on Exception do
    begin
      Rewrite(logfile);
    end;
  end;
  writeln(logfile, '>>>>> Import DT: ' + datetimetostr(Now) + '<<<<');

  wwtAlliaRes.close;
  dmADO.EmptySQLTable('AlliaRes');
  log.event('fAlliant; BitBtn1Click: wwtAlliaRes opened: ' + wwtAlliaRes.TableName);
  wwtAlliaRes.open;
  panel1.Visible := true;
  Application.ProcessMessages;
  wwtAlliaInv.close;
  dmADO.EmptySQLTable('AlliaInv');
  tblAlliaDup.Close;
  dmADO.EmptySQLTable('AlliaDup');
  Application.ProcessMessages;
  TotalInv := 0;
  FileFmtErr := 0;
  GenericFiles := 0;
  DupInvFounda := 0;
  DupInvFoundc := 0;
  with wwtAlliafil do
  begin
    log.event('fAlliant; BitBtn1Click: wwtAlliaFil opened: ' + wwtAlliaFil.TableName);
    open;
    Application.ProcessMessages;
    first;
    fileno := 1;
    while not eof do
    begin
      fdt := FieldByName('DT').AsDateTime; //get curr file date/time
      procFile(thedir + FieldByName('Name').asstring);
      TotalInv := TotalInv + Noinv;
      inc(fileno);
      Application.ProcessMessages;
      next;
    end;
    memo1.Visible := true;
    memo1.Lines.Add('Results:');
    memo1.Lines.Add('There were ' + inttostr(recordcount) + ' new files found:');
    memo1.Lines.Add('   ' + inttostr(GenericFiles) + ' generic invoice files found.');
    s1 := 'Results: ' + inttostr(recordcount) + ' new files; ' +
      inttostr(GenericFiles) + ' generic; ';
    filter := 'InvNo <> ' + #39 + #39;
    filtered := true;
    memo1.Lines.Add('   ' + inttostr(recordcount) + ' valid and non-empty invoice files found.');
    memo1.Lines.Add('   ' + inttostr(FileFmtErr) + ' file format errors.');
    memo1.Lines.Add('   ' + inttostr(DupInvFoundc) + ' duplicate invoices found in Current.');
    memo1.Lines.Add('   ' + inttostr(DupInvFounda) + ' duplicate invoices found in Accepted.');
    memo1.Lines.Add(inttostr(wwtAlliaRes.recordcount) + ' invoices were found and processed.');
    writeln(logfile, s1 + inttostr(wwtAlliaRes.recordcount) + ' invoices proccsd; ' +
      inttostr(FileFmtErr) + ' file frmt errs; ' +
      inttostr(DupInvFoundc) + ' dup inv Curr; ' +
      inttostr(DupInvFounda) + ' dup inv Acc; ');
    filter := 'Credit = ' + #39 + 'L' + #39;
    first;
    while not eof do
    begin
      memo1.Lines.Add('WARNING: Invoice: ' + FieldByName('invno').asstring +
        ' could not be located for modification (credit invoice file name: ' +
        #34 + FieldByName('name').asstring + #34 + ')!');
      next;
    end;
    filter := 'Credit = ''U''';
    first;
    while not eof do
    begin
      memo1.Lines.Add('WARNING: No items from credit invoice file ' +
        #34 + FieldByName('name').asstring + #34 +
        ' could be matched, so invoice: ' + FieldByName('invno').asstring +
        ' was not modified!');
      next;
    end;
    memo1.Lines.Add('See grid below for individual invoice results.');
    Memo1.SetFocus;
    Memo1.Lines[0] := 'Results:'; // force memo to scroll back to top
    log.event('fAlliant; BitBtn1Click: wwqAlliaRes opened: ' + wwqAlliaRes.SQL.Text);
    wwqAlliaRes.open;
    wwgAlliaFil.Visible := true;
  end;
  log.event('fAlliant; BitBtn1Click: wwtAlliaInv opened: ' + wwtAlliaInv.TableName);
  wwtAlliaInv.open;
  Application.ProcessMessages;
  if wwtAlliaInv.RecordCount > 0 then
  begin
    label2.Visible := true;
    bitbtn2.Visible := true;
  end;
  //MH - 01/12/99
  log.event('fAlliant; BitBtn1Click: tblAlliaDup opened: ' + tblAlliaDup.TableName);
  tblAlliaDup.Open;
  if tblAlliaDup.RecordCount = 0 then
  begin
    bbtErrRpt.Visible := False;
  end
  else
  begin
    with wwqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select * from alliadup where imploc <> ''G''');
      log.event('fAlliant; BitBtn1Click: wwqRun opened: ' + wwqRun.SQL.Text);
      open;

      while not eof do
      begin
        s1 := FieldByName('imploc').asstring;

        if s1 = 'C' then
          s1 := 'Current Invoice Duplicate'
        else if s1 = 'A' then
          s1 := 'Accepted Invoice Duplicate'
        else if s1 = 'H' then
          s1 := 'File with Header Error(s)'
        else if s1 = 'I' then
          s1 := 'File with error(s) when Importing Products'
        else if s1 = 'R' then
          s1 := 'File with error(s) when Creating Invoice';

        writeln(logfile, 'Invoice File Errors:');
        writeln(logfile, FieldByName('impfile').asstring + ' ---> ' + s1);

        next;
      end;
      close;
    end;
    writeln(logfile, '');
    CloseFile(logfile);

  end;
  tblAlliaDup.Close;

  panel1.Visible := false;
  bitbtn1.Visible := false;
  bbtErrRpt.Visible := true;
  Application.ProcessMessages;
end;

procedure TfAlliant.BitBtn2Click(Sender: TObject);
begin
  log.event('fAlliant; Print Unmatched button pressed');
  // print unmatched items...
  log.event('fAlliant; BitBtn2Click: wwtAlliaInv opened: ' + wwtAlliaInv.TableName);
  wwtAlliaInv.open;
  ppReport1.ArchiveFileName := thedir+'\ImpUM\um'+
                                           formatDateTime('mmddyy',date)+'.RAF';

  ppReport1.Print;
  wwtAlliaInv.close;
end;

procedure TfAlliant.ppReport1PreviewFormCreate(Sender: TObject);
begin
  dmADO.ReportPreviewFormCreate(Sender);
end;

procedure TfAlliant.ModifInv;
var
  s: string;
  oldq, newq, runtot: real;
  locinv: boolean;
begin
  locinv := false;
  runtot := 0.0;
  if fmainmenu.TestFlag then
  begin
    s := 'ZZ';
  end
  else
  begin
    s := '';
  end;
  label7.Caption := 'Locating invoice to modify ...';
  Application.ProcessMessages;

  // try to locate the inv no in Purchhdr; if not locate then exit, the file
  with wwtpurchhdr do
  begin
    Application.ProcessMessages;
    log.event('fAlliant; ModifInv: wwtPurchHdr opened: ' + wwtPurchHdr.TableName);
    open;
    Application.ProcessMessages;
    if not locate('supplier name;delivery note no.',
      VarArrayOf(['US Foods', s + sinvno]), []) then
    begin
      with wwtAlliaFil do
      begin
        log.event('fAlliant; ModifInv: wwtAlliaFil edited');
        edit;
        FieldByName('Credit').asstring := 'L';
        post;
      end;
      close;
      exit;
    end
    else
    begin
      if not (FindField('deleted') = nil) then
        if FieldByName('deleted').asstring = 'Y' then
        begin
          with wwtAlliaFil do
          begin
            log.event('fAlliant; ModifInv: wwtAlliaFil edited');
            edit;
            FieldByName('Credit').asstring := 'L';
            post;
          end;
          close;
          exit;
        end;
    end;
    close;
  end;

  // locate and modify records in Purchase
  with wwtPurchase do
  begin
    Application.ProcessMessages;
    log.event('fAlliant; ModifInv: wwtPurchase opened: ' + wwtPurchase.TableName);
    open;
    wwtAlliant.First;
    label7.Caption := 'Modifying invoice...';
    Application.ProcessMessages;
    while not (wwtAlliant.EOF) do
    begin
      Application.ProcessMessages;
      if locate('supplier name;delivery note no.;entity code',
        VarArrayOf(['US Foods', s + sinvno,
        wwtAlliant.FieldByName('entitycode').asfloat]), []) then
      begin
        locinv := true;
        Application.ProcessMessages;
        if (wwtAlliant.FieldByName('wflag').asstring = 'Y') and
          (wwtAlliant.FieldByName('apunit').asstring = 'LB') then
        begin
          oldq := FieldByName('quantity').asfloat;
          newq := wwtAlliant.FieldByName('aweight').asfloat;
        end
        else
        begin
          if wwtAlliant.FieldByName('aunitq').asfloat <> 0.0 then
          begin
            oldq := FieldByName('quantity').asfloat;
            newq := wwtAlliant.FieldByName('aunitq').asfloat;
          end
          else
          begin
            oldq := FieldByName('quantity').asfloat;
            newq := wwtAlliant.FieldByName('aeachq').asfloat;
          end;
        end;
        runtot := runtot + wwtAlliant.FieldByName('atotalcost').asfloat;
        if oldq + newq > 0.0 then
        begin
          edit;
          FieldByName('quantity').asfloat := oldq + newq;
          FieldByName('total cost').asfloat :=
            FieldByName('total cost').asfloat +
            wwtAlliant.FieldByName('atotalcost').asfloat;
          if not (FindField('modified by') = nil) then
          begin
            FieldByName('modified by').asstring := CurrentUser.UserName;
          end;
          if not (FindField('last modified date') = nil) then
          begin
            FieldByName('last modified date').asdatetime := date;
          end;
          if not (FindField('last modified time') = nil) then
          begin
            FieldByName('last modified time').asstring := formatdatetime('hh:mm', now);
          end;
          post;
        end
        else
        begin
          delete;
        end;
      end
      else
      begin
        log.event('fAlliant; ModifInv: wwtAlliaInv opened: ' + wwtAlliaInv.TableName);
        wwtAlliaInv.open;
        wwtAlliaInv.insert;
        wwtAlliaInv.FieldByName('reason').asstring := 'LE';

        wwtAlliaInv.FieldByName('invno').asstring := s + sinvno;
        wwtAlliaInv.FieldByName('recno').asfloat :=
          wwtAlliant.FieldByName('recno').asfloat;
        wwtAlliaInv.FieldByName('acode').asstring :=
          wwtAlliant.FieldByName('acode').asstring;
        wwtAlliaInv.FieldByName('aname').asstring :=
          wwtAlliant.FieldByName('aname').asstring;
        Application.ProcessMessages;
        wwtAlliaInv.FieldByName('asunit').asstring :=
          wwtAlliant.FieldByName('asunit').asstring;
        wwtAlliaInv.FieldByName('apunit').asstring :=
          wwtAlliant.FieldByName('apunit').asstring;
        wwtAlliaInv.FieldByName('aweight').asfloat :=
          wwtAlliant.FieldByName('aweight').asfloat;
        wwtAlliaInv.FieldByName('acostunit').asfloat :=
          wwtAlliant.FieldByName('acostunit').asfloat;
        wwtAlliaInv.FieldByName('aunitq').asfloat :=
          wwtAlliant.FieldByName('aunitq').asfloat;
        wwtAlliaInv.FieldByName('aeachq').asfloat :=
          wwtAlliant.FieldByName('aeachq').asfloat;
        wwtAlliaInv.FieldByName('acosteach').asfloat :=
          wwtAlliant.FieldByName('acosteach').asfloat;
        wwtAlliaInv.FieldByName('atotalcost').asfloat :=
          wwtAlliant.FieldByName('atotalcost').asfloat;
        wwtAlliaInv.FieldByName('convfact').value :=
          wwtAlliant.FieldByName('convfact').value;
        wwtAlliaInv.FieldByName('invdate').value :=
          wwtAlliant.FieldByName('invdate').value;

        wwtAlliaInv.Post;
      end; // if locate else
      wwtAlliant.next;
      Application.ProcessMessages;
    end;
    wwtAlliaInv.close;
    close;
    Application.ProcessMessages;
  end; // with

  if locinv then
    with wwtpurchhdr do
    begin
      Application.ProcessMessages;
      log.event('fAlliant; ModifInv: wwtPurchHdr opened: ' + wwtPurchHdr.TableName);
      open;
      Application.ProcessMessages;
      if locate('supplier name;delivery note no.',
        VarArrayOf(['US Foods', s + sinvno]), []) then
      begin
        edit;

        if not (FindField('total amount') = nil) then
        begin
          FieldByName('total amount').asfloat :=
            FieldByName('total amount').asfloat + runtot;
        end;

        FieldByName('note').asstring := 'Imported Inv; Unmtch: ' +
          inttostr(unmch) + ' out of ' + inttostr(totprod) +
          ' Corrected CrdMemo: ' + crdMemo;
        post;
        label7.Caption := 'Invoice modified...';
        Application.ProcessMessages;
        close;
      end; // invoice to modify located in purchhdr and header modified....
    end;
end; // procedure

procedure TfAlliant.bbtErrRptClick(Sender: TObject);
begin
  qryErrRpt.Close;
  log.event('fAlliant; bbtErrRptClick: qryErrRpt opened: ' + qryErrRpt.SQL.Text);
  qryErrRpt.Open;

  pplblNofiles.Caption := IntToStr(FileNo-1);
  pplblNoInv.Caption   := IntToStr(TotalInv);
  pplblImpSuc.Caption  := IntToStr(TotalInv - (DupInvFoundc+DupInvFounda));
  pplblDupCur.Caption  := IntToStr(DupInvFoundc);
  pplblDupAcc.Caption  := IntToStr(DupInvFounda);
  pplblBadFmt.Caption  := IntToStr(FileFmtErr);
  pplblSite.caption    := fMainMenu.thesitename;
  if not directoryExists(thedir+'\ImpErr') then
  begin
    ForceDirectories(thedir+'\ImpErr');
  end;
  ppErrRpt.ArchiveFileName := thedir+'\ImpErr\ip'+formatDateTime('mmddyy',date)+'.RAF';
  log.event('fAlliant; bbtErrRptClick: ppErrRpt printed');
  ppErrRpt.Print;
  tblAlliaDup.Close;
end;

procedure TfAlliant.ppDBText4GetText(Sender: TObject; var Text: String);
begin
  if not ((text = 'A') or (text = 'C'))  then
  begin
    ppLabel4.Visible := False;
    ppDBText5.Visible := False;
  end
  else
  begin
    ppLabel4.Visible := True;
    ppDBText5.Visible := True;
  end;

  if text = 'C' then
    Text := 'Current Invoice Duplicates'
  else if text = 'A' then
    Text := 'Accepted Invoice Duplicates'
  else if text = 'G' then
    Text := 'Generic US Foods Files'
  else if text = 'H' then
    Text := 'Files with Header Errors'
  else if text = 'I' then
    Text := 'Files with errors when Importing Products'
  else if text = 'R' then
    Text := 'Files with errors when Creating Invoice';

end;

procedure TfAlliant.ppErrRptPreviewFormCreate(Sender: TObject);
begin
  dmADO.ReportPreviewFormCreate(Sender);
end;

procedure TfAlliant.wwqAlliaResCalcFields(DataSet: TDataSet);
begin
  if wwqAlliaRes.FieldByName('TotProd').asstring <> '' then
    wwqAlliaResUnmch.Value := wwqAlliaResTotProd.Value -
      wwqAlliaResmatched.Value;
end;

procedure TfAlliant.BitBtn3Click(Sender: TObject);
begin
  log.event('fAlliant; Alliant Import closed');
end;

procedure TfAlliant.FormCreate(Sender: TObject);
begin
  log.event('fAlliant; Alliant Form Opened');
  if purchHelpExists then
    setHelpContextID(self, HLP_ALLIANT_LINK);
end;

end.

