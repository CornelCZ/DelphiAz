unit ustkutil;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Wwkeycb, Grids, Wwdbigrd, Wwdbgrid, Db, Wwdatsrc, DBTables,
  Wwtable, Wwquery, wwdblook, Buttons, Menus, Variants, ComCtrls, ExtCtrls,
  ADODB, Mask, wwdbedit;

type
  TfStkutil = class(TForm)
    pc1: TPageControl;
    tabChoice: TTabSheet;
    tabThread: TTabSheet;
    tabManual: TTabSheet;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    adoqThr: TADOQuery;
    dsThreads: TwwDataSource;
    adoqThStock: TADOQuery;
    dsThStocks: TwwDataSource;
    Panel1: TPanel;
    wwDBGrid2: TwwDBGrid;
    wwDBEdit1: TwwDBEdit;
    wwDBGrid3: TwwDBGrid;
    Label3: TLabel;
    Label4: TLabel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    dsManual: TwwDataSource;
    adotManual: TADOTable;
    wwDBGrid4: TwwDBGrid;
    rgOrdManual: TRadioGroup;
    btnAcceptChanges: TBitBtn;
    btnCancel: TBitBtn;
    adotManualEntityCode: TFloatField;
    adotManualSubCat: TStringField;
    adotManualImpExRef: TStringField;
    adotManualName: TStringField;
    adotManualOpStk: TFloatField;
    adotManualPurchStk: TFloatField;
    adotManualThRedQty: TFloatField;
    adotManualThCloseStk: TFloatField;
    adotManualActCloseStk: TFloatField;
    adotManualPurchUnit: TStringField;
    adotManualPurchBaseU: TFloatField;
    Label5: TLabel;
    Label6: TLabel;
    EdatePick: TDateTimePicker;
    Label7: TLabel;
    EtimePick: TDateTimePicker;
    partDayChk: TCheckBox;
    Bevel1: TBevel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    adotManualACount: TStringField;
    adotManualWasteTill: TFloatField;
    cbSubOnly: TCheckBox;
    Label1: TLabel;
    Label11: TLabel;
    procedure FormShow(Sender: TObject);
    procedure removeSTK;
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure rgOrdManualClick(Sender: TObject);
    procedure btnAcceptChangesClick(Sender: TObject);
    procedure EdatePickChange(Sender: TObject);
    procedure partDayChkClick(Sender: TObject);
    procedure adotManualAfterScroll(DataSet: TDataSet);
    procedure adotManualBeforePost(DataSet: TDataSet);
    procedure cbSubOnlyClick(Sender: TObject);
    procedure wwDBGrid4CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
  private
    { Private declarations }
    procedure SaveChanges;
  public
    { Public declarations }
    site,spc, newspc: Integer;
    sd,ed, sThSDT, sThEDT: TdateTime;
    st,et,Division, ThName, SThName: string;
    slaveTh : integer;
    isMTh, SThbyHZ, hasSTh : boolean;
  end;

var
  fStkutil: TfStkutil;

implementation

uses uADO, udata1, ulog;

{$R *.DFM}

procedure TfStkutil.FormShow(Sender: TObject);
begin
  self.Caption := 'Initialise First ' + data1.SSbig;

  if isMTh then
  begin
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select Tname, byHZ from threads where tid = ' + inttostr(slaveTh));
      open;

      SThName := FieldByName('tname').asstring;
      sThByHZ := FieldByName('byHZ').AsBoolean;

      Close;
      sql.Clear;
      sql.Add('SELECT stockcode, sdate, stime, edate, etime');
      sql.Add('FROM "stocks"');
      sql.Add('WHERE "tid" = ' + inttostr(slaveTh));
      sql.Add('and stockcode > 1');
      open;

      if recordcount = 0 then // the slave doesn't have 1 acc stock...
      begin
        close;
        hasSTh := False;
        label2.Caption :=
          'Thread "' + thName + '" is a Master Thread; its Subordinate Thread is "' +
           sthname + '".' + #13 + 'The Subordinate thread does not have any Accepted ' + data1.SSplural +
           ' yet.' + #13 + 'Initialising the Master Thread automatically initialises the' +
           ' Subordinate with the same figures.' + #13 + #13 +
          'There are two choices:'#13#10'1. Import the closing ' + data1.SSlow + ' figures fro' +
          'm the (accepted) ' + data1.SSbig + ' of another thread of the same Division (i' +
          'f any exist).'#13#10'2. Enter all opening ' + data1.SSlow +
          '/cost figures manually.'#13#10#13#10'Note: Choice' +
          ' 1 will also set your new ' + data1.SSlow + '''s Start Date and Start Tim' +
          'e. For choice 2 you will have to choose Start Date and Start Tim' +
          'e yourself.'#13#10#13#10'Choose from the available buttons, or choose "Can' +
          'cel" if you are not ready to continue at this time.';
      end
      else
      begin
        hasSth := True;
        label2.Caption :=
          'Thread "' + thName + '" is a Master Thread; its Subordinate Thread is "' +
           sthname + '".' + #13+
          'This Master Thread should only be initialised from an Accepted ' + data1.SSbig +
          ' of its Subordinate Thread' + #13 + 
          'If you choose to initialise it differently then the ' + data1.SSplural +
          ' which will be automatically created for the Subordinate may have unsuitable Closing ' +
          data1.SSbig +  '/Cost figures' + #13 + #13 +
          'There are two choices:'#13#10'1. Import the closing ' + data1.SSlow + ' figures fro' +
          'm the (accepted) ' + data1.SSbig + ' of another thread of the same Division (i' +
          'f any exist).'#13#10'2. Enter all opening ' + data1.SSlow +
          '/cost figures manually.'#13#10#13#10'Note: Choice' +
          ' 1 will also set your new ' + data1.SSlow + '''s Start Date and Start Tim' +
          'e. For choice 2 you will have to choose Start Date and Start Tim' +
          'e yourself.'#13#10#13#10'Choose from the available buttons, or choose "Can' +
          'cel" if you are not ready to continue at this time.';

        BitBtn1.Font.Color := clBlue;
        bitbtn3.Font.Color := clRed;
        bitbtn3.Caption := '2. Enter Manually' + #10 + '(not recommended)';
      end;
      close;
    end;
  end
  else
  begin
    label2.Caption :=
      'This is the first ever ' + data1.SSbig + ' for this Thread. Every ' + data1.SSbig + ' needs ' +
      'opening ' + data1.SSlow + ' count/cost values. Normally these figures are take' +
      'n from the closing figures of the previous ' + data1.SSlow + ' but in the case' +
      ' of the first ' + data1.SSlow + ' in a thread these figures do not exist.'#13#10#13#10'T' +
      'here are two choices:'#13#10'1. Import the closing ' + data1.SSlow + ' figures fro' +
      'm the (accepted) ' + data1.SSbig + ' of another thread of the same Division (i' +
      'f any exist).'#13#10'2. Enter all opening ' + data1.SSlow +
      '/cost figures manually.'#13#10#13#10'Note: Choice' +
      ' 1 will also set your new ' + data1.SSlow + '''s Start Date and Start Tim' +
      'e. For choice 2 you will have to choose Start Date and Start Tim' +
      'e yourself.'#13#10#13#10'Choose from the available buttons, or choose "Can' +
      'cel" if you are not ready to continue at this time.';
  end;

  label5.Caption :=
    'Type BOTH "Open ' + data1.SSbig + '" AND "Open Cost" figures.'#13#10'  '#13#10'BOTH figures ' +
    'should be expressed in ' + data1.SSbig + ' Units.'#13#10'  '#13#10'Any figure left empty will ' +
    'be assumed to be ZERO.';



  label8.Caption := 'Set Start for New ' + data1.SS6;
  label4.Caption := 'Select ' + data1.SSbig + ' to import closing figures';

  with dmADO.adoqRun do
  begin
    Close;
    sql.Clear;
    sql.Add('SELECT *');
    sql.Add('FROM "stocks" a');
    sql.Add('WHERE a."division" = '+ quotedstr(data1.TheDiv));
    sql.Add('AND a."SiteCode" = '+IntToStr(data1.TheSiteCode));
    sql.Add('and a."stockcode" >= 2');
    open;

    if recordcount = 0 then
    begin
      close;
      bitbtn1.Enabled := False;
    end;
    close;
  end;
  label3.Caption := 'Threads with available ' + data1.SSplural;

  pc1.ActivePageIndex := 0;
  Division := data1.TheDiv;
end;

procedure TfStkutil.removeSTK;
begin
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('Delete From "stkmain"');
    sql.Add('where "stkcode" = 1');
    sql.Add('and tid = ' + inttostr(data1.CurTid));
    ExecSQL;

    close;
    sql.Clear;
    sql.Add('Delete From "stocks"');
    sql.Add('where "stockcode" = 1');
    sql.Add('and tid = ' + inttostr(data1.CurTid));
    ExecSQL;

    // if this is a MTh with STh with no accepted stocks...
    if isMTh and not hasSTh then
    begin
      // remove any stock of the STh...
      close;
      sql.Clear;
      sql.Add('Delete From "stkmain"');
      sql.Add('where tid = ' + inttostr(slaveTh));
      ExecSQL;

      close;
      sql.Clear;
      sql.Add('Delete From "stocks"');
      sql.Add('where "stockcode" = 1');
      sql.Add('and tid = ' + inttostr(slaveTh));
      ExecSQL;

      // as the Slave does not yet have an accepted stock the only stock it COULD have is no. 2...
      data1.killStock(slaveTh, 2);
    end;

  end; // while
end; // procedure..

procedure TfStkutil.BitBtn5Click(Sender: TObject);
begin
    if MessageDlg('Importing Closing ' + data1.SSbig + '/Cost figures from Internal ' + data1.SSbig + ' for Division: "'+Division+
               '" '+#13+ 'End Date/Time: "' + adoqThStock.FieldByName('EDate').asstring + ' ' +
               adoqThStock.FieldByName('ETime').asstring + '".' +
               #13 + #13 + 'Continue?'
               ,mtWarning,[mbYes,mbNo],0) = mrYes then
    begin
      log.event('Import start');
      Screen.cursor := crHourGlass;
      try
        try

         removeSTK;
         newSPC := 1;

         with adoqThStock do
         begin
           dmADO.adoTRun.Close;
           dmADO.adoTRun.TableName := 'Stocks';
           dmADO.adoTRun.Open;

           dmADO.adoTRun.AppendRecord([FieldByName('sitecode').AsInteger,
                         data1.curTid,
                         newspc,
                         FieldByName('division').AsString,
                         FieldByName('sdate').AsDateTime,
                         FieldByName('stime').AsString,
                         FieldByName('edate').asDateTime,
                         FieldByName('etime').AsString,
                         FieldByName('sdt').AsDateTime,
                         FieldByName('edt').asDateTime,
                         FieldByName('Accdate').AsDateTime,
                         FieldByName('Acctime').AsString,
                         FieldByName('stage').AsString,
                         'A',
                         FieldByName('daterecalc').AsDateTime,
                         FieldByName('timerecalc').AsString,
                         FieldByName('stkkind').AsString,
                         null,
                         FieldByName('byhz').AsBoolean]);

           // if this is a MTh with STh with no accepted stocks...
           if isMTh and not hasSTh then
             dmADO.adoTRun.AppendRecord([FieldByName('sitecode').AsInteger,
                         slaveTh,
                         newspc,
                         FieldByName('division').AsString,
                         FieldByName('sdate').AsDateTime,
                         FieldByName('stime').AsString,
                         FieldByName('edate').asDateTime,
                         FieldByName('etime').AsString,
                         FieldByName('sdt').AsDateTime,
                         FieldByName('edt').asDateTime,
                         FieldByName('Accdate').AsDateTime,
                         FieldByName('Acctime').AsString,
                         FieldByName('stage').AsString,
                         'A',
                         FieldByName('daterecalc').AsDateTime,
                         FieldByName('timerecalc').AsString,
                         FieldByName('stkkind').AsString,
                         null,
                         FieldByName('byhz').AsBoolean]);

           dmADO.adoTRun.close;

         end; // with..

         log.event('Stock Header Done');

         // get the records from stkMain...
         with dmADO.adoqRun do
         begin
           close;
           sql.Clear;
           sql.Add('select *');
           sql.Add('From stkmain');
           sql.Add('where StkCode = '+ adoqThStock.FieldByName('stockcode').AsString);
           sql.Add('And tid = '+ adoqThStock.FieldByName('tid').AsString);
           open;

           dmADO.adoTRun.close;
           dmADO.adoTRun.TableName := 'StkMain';
           dmADO.adoTRun.open;
           first;
           while not eof do
           begin
             dmADO.adoTRun.Insert;
             dmADO.adoTRun.FieldByName('sitecode').Value     := FieldByName('sitecode').Value;
             dmADO.adoTRun.FieldByName('tid').Value          := data1.curTid;
             dmADO.adoTRun.FieldByName('StkCode').Value      := newspc;
             dmADO.adoTRun.FieldByName('hzid').Value       := FieldByName('hzid').value;
             dmADO.adoTRun.FieldByName('entitycode').Value   := FieldByName('entitycode').Value;
             dmADO.adoTRun.FieldByName('key2').Value       := FieldByName('key2').value;
             dmADO.adoTRun.FieldByName('opstk').Value        := FieldByName('opstk').value;
             dmADO.adoTRun.FieldByName('opcost').Value       := FieldByName('opcost').value;
             dmADO.adoTRun.FieldByName('purchstk').Value     := FieldByName('purchstk').value;
             dmADO.adoTRun.FieldByName('purchcost').Value    := FieldByName('purchcost').value;
             dmADO.adoTRun.FieldByName('thredqty').Value     := FieldByName('thredqty').value;
             dmADO.adoTRun.FieldByName('Actclosestk').Value  := FieldByName('Actclosestk').value;
             dmADO.adoTRun.FieldByName('Actclosecost').Value := FieldByName('Actclosecost').value;
             dmADO.adoTRun.FieldByName('prepredqty').Value   := FieldByName('prepredqty').value;
             dmADO.adoTRun.Post;

             // if this is a MTh with STh with no accepted stocks...
             if isMTh and not hasSTh then
             begin
               dmADO.adoTRun.Insert;
               dmADO.adoTRun.FieldByName('sitecode').Value     := FieldByName('sitecode').Value;
               dmADO.adoTRun.FieldByName('tid').Value          := slaveTh;
               dmADO.adoTRun.FieldByName('StkCode').Value      := newspc;
               dmADO.adoTRun.FieldByName('hzid').Value       := FieldByName('hzid').value;
               dmADO.adoTRun.FieldByName('entitycode').Value   := FieldByName('entitycode').Value;
               dmADO.adoTRun.FieldByName('key2').Value       := FieldByName('key2').value;
               dmADO.adoTRun.FieldByName('opstk').Value        := FieldByName('opstk').value;
               dmADO.adoTRun.FieldByName('opcost').Value       := FieldByName('opcost').value;
               dmADO.adoTRun.FieldByName('purchstk').Value     := FieldByName('purchstk').value;
               dmADO.adoTRun.FieldByName('purchcost').Value    := FieldByName('purchcost').value;
               dmADO.adoTRun.FieldByName('thredqty').Value     := FieldByName('thredqty').value;
               dmADO.adoTRun.FieldByName('Actclosestk').Value  := FieldByName('Actclosestk').value;
               dmADO.adoTRun.FieldByName('Actclosecost').Value := FieldByName('Actclosecost').value;
               dmADO.adoTRun.FieldByName('prepredqty').Value   := FieldByName('prepredqty').value;
               dmADO.adoTRun.Post;
             end;

             next;
           end;

           close;
           dmADO.adoTRun.Close;
         end; // with..
          Screen.cursor := crDefault;
          log.event('Import Complete');
          ShowMessage('Import Complete');
          ModalResult := mrOK;
        except
          on E: exception do
          begin
            removeSTK;
            Screen.cursor := crDefault;
            log.event('Import ERROR: ' + E.Message);
            ShowMessage('Unable to copy data, retry or contact Zonal with Error:'+#13+
                         #13+E.Message);
          end; // except inner
        end; //try inner

      except
        on E: exception do
        begin
          Screen.cursor := crDefault;
          log.event('Remove old Stocks ERROR: ' + E.Message);
          ShowMessage('Unable to copy data, retry or contact Zonal with Error:'+#13+
                       #13+E.Message);
        end; // except outer
      end; //try outer
    end; //if
end;

procedure TfStkutil.BitBtn1Click(Sender: TObject);
begin
  if isMTh and hasSTh then
  begin
    with adoqThr do
    begin
      Close;
      sql.Clear;
      sql.Add('SELECT distinct a.*');
      sql.Add('FROM "threads" a');
      sql.Add('WHERE a."division" = '+ quotedstr(data1.TheDiv));
      sql.Add('and a.tid in (select distinct b.tid from stocks b where b."stockcode" >= 2)');
      sql.Add('order by a.tid');
      open;

      Filter := 'Tid = ' + inttostr(slaveTh);
      Filtered := True;
      cbSubOnly.Visible := True;
      cbSubOnly.Checked := True;
    end;
  end
  else
  begin
    with adoqThr do
    begin
      Close;
      sql.Clear;
      sql.Add('SELECT distinct a.*');
      sql.Add('FROM "threads" a');
      sql.Add('WHERE a."division" = '+ quotedstr(data1.TheDiv));
      sql.Add('and a.tid in (select distinct b.tid from stocks b where b."stockcode" >= 2)');
      sql.Add('order by a.tid');
      open;
      Filtered := False;
      cbSubOnly.Visible := False;
    end;
  end;


  adoqThStock.open;
  pc1.ActivePage := tabThread;
  wwDBGrid3.Columns[6].DisplayLabel := data1.ss6 + ' Kind';
end;

procedure TfStkutil.BitBtn3Click(Sender: TObject);
begin
  with data1.adoqRun do
  begin
 // from Entcopy fill a temp Audit table which will be shown to the user
    dmAdo.EmptySQLTable('auditcur');

    close;
    sql.Clear;
    sql.Add('insert into auditcur ("entitycode", "name", "subcat",');
    sql.Add('"ImpExRef", "purchunit", "purchbaseU", "wastetill", purchstk)');
    sql.Add('SELECT b."entitycode", b."purchasename",');
    if data1.RepHdr = 'Sub-Category' then
      sql.Add('b.[SCat],')
    else
      sql.Add('b.[Cat],');
    sql.Add('b."ImpExRef", b."purchaseunit", b."purchbaseU", p.[Budgeted Cost Price],');
    sql.Add('CASE b."entitytype" WHEN ''Prep.Item'' THEN -999999 ELSE 0 END');
    sql.Add('FROM stkEntity b, products p');
    sql.Add('where b.Div = ' + quotedStr(data1.TheDiv));
    sql.Add('and (b."entitytype" = '+#39+'Purch.Line'+#39);
    sql.Add('   OR b."entitytype"= '+#39+'Prep.Item'+#39);
    sql.Add('   OR b."entitytype"= '+#39+'Strd.Line'+#39 + ')');
    sql.Add('and b.entitycode = p.entitycode');
    execSQL;

    // look to see if there's been any stuff already saved earlier...
    close;
    sql.Clear;
    sql.Add('select entitycode from StkMain');
    sql.Add('where sitecode = ' + inttostr(data1.TheSiteCode));
    sql.Add('and stkcode = 1 and tid = ' + inttostr(data1.CurTid));
    sql.Add('and actclosestk <> 0');
    open;

    if recordcount > 0 then
    begin
      if MessageDlg('There are ' + inttostr(recordcount) +
        ' non zero values saved to the system from a previous Thread Initialization.'+#13+''+#13+
        'Do you want these values loaded in the grid (you can still change them)?',
        mtConfirmation, [mbYes,mbNo], 0) = mrYes then
      begin
        // load from stkMain
        close;
        sql.Clear;
        sql.Add('Update AuditCur set opStk = a."ActCloseStk" / b."purchbaseU",');
        sql.Add('[wastetill] = a.[actclosecost] * b."purchbaseU"');
        sql.Add('FROM "Auditcur" b, "stkMain" a');
        sql.Add('WHERE a."entitycode" = b."entitycode"');
        sql.Add('AND a."StkCode" = 1');
        sql.Add('and a.tid = '+IntToStr(data1.curtid));
        sql.Add('and ((a."ActCloseStk" > 0) or (a.[actclosecost] > 0))');
        execSQL;

        close;
        sql.Clear;
        sql.Add('select * from AuditCur');
        open;

        while not eof do
        begin
          //import the floats in the string field
          edit;
          if FieldByName('opStk').asstring = '' then
            FieldByName('ACount').AsString := ''
          else
            FieldByName('ACount').AsString :=
              data1.dozGallFloatToStr(FieldByName('PurchUnit').asstring, FieldByName('opStk').asfloat);
          post;
          next;
        end;
        close;
      end;
    end;
    close;
  end;

  adotManual.open;

  if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
    adotManualSubCat.DisplayLabel := 'Sub-Category'
  else
    adotManualSubCat.DisplayLabel := 'Category';

  adotManualOpStk.DisplayLabel := 'Open ' + data1.ss6;
  adotManualPurchUnit.DisplayLabel := data1.ss6 + ' Unit';

  rgordmanual.Items[0] := adotManualSubCat.DisplayLabel;
  wwdbgrid4.Columns[0].DisplayLabel := adotManualSubCat.DisplayLabel;
  wwDBGrid4.Columns[2].DisplayLabel := data1.ss6 + ' Unit';
  wwDBGrid4.Columns[3].DisplayLabel := 'Open ' + data1.ss6;

  edatepick.Date := data1.LAD - 1;

  if data1.noTillsOnSite then
  begin
    partdaychk.Visible := False;
    label10.Caption := 'Last Complete Business Day is ' + datetostr(data1.LAD - 1);
  end
  else
  begin
    partdaychk.Visible := True;
    partDayChk.Caption := DateToStr(EdatePick.Date + 1);
    label10.Caption := 'Last Audited Business Day is ' + datetostr(data1.LAD - 1);
  end;

  label7.Visible := partdaychk.Visible;
  eTimePick.Visible := partdaychk.Visible;
  label9.Visible := partdaychk.Visible;

  pc1.ActivePage := tabManual;
end;

procedure TfStkutil.rgOrdManualClick(Sender: TObject);
begin
  if rgordmanual.ItemIndex = 0 then
  begin
    adotManual.IndexFieldNames := 'SubCat;Name';
  end
  else
  begin
    adotManual.IndexFieldNames := 'Name';
  end;
end;

procedure TfStkutil.btnAcceptChangesClick(Sender: TObject);
begin
  if adotManual.State = dsEdit then
    adotManual.post;

  case MessageDlg('Initialising ' + data1.SSbig + ' with manually entered Opening figures.' +
     #13 + #13 + 'Do you wish to save changes?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
    mrYes:
      SaveChanges;
    mrCancel:
      ModalResult := mrNone;
  end;
end;

procedure TfStkutil.EdatePickChange(Sender: TObject);
begin
	partDayChk.Caption := DateToStr(EdatePick.Date + 1);
end;

procedure TfStkutil.partDayChkClick(Sender: TObject);
begin
  etimepick.Enabled := partdaychk.Checked;
end;

procedure TfStkutil.adotManualAfterScroll(DataSet: TDataSet);
begin
  wwdbgrid4.PictureMasks.Strings[1] := 'ACount' + data1.setGridMask(adotManualPurchUnit.Value,'');
end;

procedure TfStkutil.adotManualBeforePost(DataSet: TDataSet);
begin
  if adotManual.FieldByName('ACount').asstring = '' then
  begin
    adotManual.FieldByName('opStk').asstring := '';
  end
  else
  begin
    adotManual.FieldByName('opStk').AsFloat :=
      data1.dozGallStrToFloat(adotManualPurchUnit.Value,adotManual.FieldByName('ACount').asstring);
  end;
end;

procedure TfStkutil.cbSubOnlyClick(Sender: TObject);
begin
  adoqThr.Filtered := cbSubOnly.Checked;
  wwdbgrid2.Refresh;
  wwDBGrid2.RedrawGrid;
end;

procedure TfStkutil.SaveChanges;
begin
  log.event('Import start');
  Screen.cursor := crHourGlass;

  try
    try
      removeSTK;

      newSPC := 1;

      dmADO.adoTRun.Close;
      dmADO.adoTRun.TableName := 'Stocks';
      dmADO.adoTRun.Open;

      if partDaychk.Checked then
      begin
        dmADO.adoTRun.AppendRecord([data1.thesitecode,
                   data1.curTid,
                   newspc,
                   data1.thediv,
                   null,
                   null,
                   edatepick.date - 1,
                   FormatDateTime('hh:mm',EtimePick.Time - StrToTime('00:01')),
                   null,
                   null,
                   date,
                   FormatDateTime('hh:mm',Now),
                   'Accepted',
                   'A',
                   date,
                   FormatDateTime('hh:mm',Now),
                   'Reg',
                   null, False]);

        // if this is a MTh with STh with no accepted stocks...
        if isMTh and not hasSTh then
          dmADO.adoTRun.AppendRecord([data1.thesitecode,
                   slaveTh,
                   newspc,
                   data1.thediv,
                   null,
                   null,
                   edatepick.date - 1,
                   FormatDateTime('hh:mm',EtimePick.Time - StrToTime('00:01')),
                   null,
                   null,
                   date,
                   FormatDateTime('hh:mm',Now),
                   'Accepted',
                   'A',
                   date,
                   FormatDateTime('hh:mm',Now),
                   'Reg',
                   null, False]);
      end
      else
      begin
        dmADO.adoTRun.AppendRecord([data1.thesitecode,
                   data1.curTid,
                   newspc,
                   data1.thediv,
                   null,
                   null,
                   edatepick.date - 1,
                   null,
                   null,
                   null,
                   date,
                   FormatDateTime('hh:mm',Now),
                   'Accepted',
                   'A',
                   date,
                   FormatDateTime('hh:mm',Now),
                   'Reg',
                   null, False]);

        // if this is a MTh with STh with no accepted stocks...
        if isMTh and not hasSTh then
          dmADO.adoTRun.AppendRecord([data1.thesitecode,
                   slaveTh,
                   newspc,
                   data1.thediv,
                   null,
                   null,
                   edatepick.date - 1,
                   null,
                   null,
                   null,
                   date,
                   FormatDateTime('hh:mm',Now),
                   'Accepted',
                   'A',
                   date,
                   FormatDateTime('hh:mm',Now),
                   'Reg',
                   null, False]);
      end;
      dmADO.adoTRun.close;

      log.event('Stock Header Done');

      // get the records from AuditCur
      with dmADO.adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('update stocks set');
        sql.Add('EDT = (CASE');
        sql.Add('       WHEN ETime is NULL THEN EDate + 1 + ' + quotedSTR(data1.roll));
        sql.Add('       WHEN ETime = '''' THEN EDate + 1 + ' + quotedSTR(data1.roll));
        sql.Add('       ELSE (');
        sql.Add('             CASE');
        sql.Add('               WHEN ETime >= ' + quotedSTR(data1.roll) + ' THEN EDate + 1 + ETime');
        sql.Add('               ELSE EDate + 2 + ETime');
        sql.Add('             END');
        sql.Add('            )');
        sql.Add('       END)');
        execSQL;

        close;
        sql.Clear;
        sql.Add('select *');
        sql.Add('From auditcur');
        open;

        dmADO.adoTRun.close;
        dmADO.adoTRun.TableName := 'StkMain';
        dmADO.adoTRun.open;
        first;

        while not eof do
        begin
          dmADO.adoTRun.Insert;
          dmADO.adoTRun.FieldByName('sitecode').Value     := data1.thesitecode;
          dmADO.adoTRun.FieldByName('tid').Value          := data1.curTid;
          dmADO.adoTRun.FieldByName('StkCode').Value      := newspc;
          dmADO.adoTRun.FieldByName('hzid').Value      := 0;
          dmADO.adoTRun.FieldByName('entitycode').Value   := FieldByName('entitycode').Value;
          dmADO.adoTRun.FieldByName('Actclosestk').Value  :=
            FieldByName('opstk').asfloat * FieldByName('purchbaseU').asfloat;
          dmADO.adoTRun.FieldByName('Actclosecost').Value :=
            FieldByName('wasteTill').asfloat / FieldByName('purchbaseU').asfloat;
          dmADO.adoTRun.Post;

          // if this is a MTh with STh with no accepted stocks...
          if isMTh and not hasSTh then
          begin
            dmADO.adoTRun.Insert;
            dmADO.adoTRun.FieldByName('sitecode').Value     := data1.thesitecode;
            dmADO.adoTRun.FieldByName('tid').Value          := slaveTh;
            dmADO.adoTRun.FieldByName('StkCode').Value      := newspc;
            dmADO.adoTRun.FieldByName('hzid').Value      := 0;
            dmADO.adoTRun.FieldByName('entitycode').Value   := FieldByName('entitycode').Value;
            dmADO.adoTRun.FieldByName('Actclosestk').Value  :=
              FieldByName('opstk').asfloat * FieldByName('purchbaseU').asfloat;
            dmADO.adoTRun.FieldByName('Actclosecost').Value :=
              FieldByName('wasteTill').asfloat / FieldByName('purchbaseU').asfloat;
            dmADO.adoTRun.Post;
          end;

          next;
        end;

        close;
        dmADO.adoTRun.Close;
      end; // with..

      Screen.cursor := crDefault;
      log.event('Import Complete');
      ShowMessage('Import Complete');
      ModalResult := mrOK;
    except
      on E: exception do
      begin
        removeSTK;
        Screen.cursor := crDefault;
        log.event('Import ERROR: ' + E.Message);
        ShowMessage('Unable to copy data, retry or contact Zonal with Error:'+#13+
                     #13+E.Message);
      end;
    end;
  except
    on E: exception do
    begin
      Screen.cursor := crDefault;
      log.event('Remove old Stocks ERROR: ' + E.Message);
      ShowMessage('Unable to copy data, retry or contact Zonal with Error:'+#13+
                   #13+E.Message);
    end;
  end;
end;

procedure TfStkutil.wwDBGrid4CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if (Field.FieldName = 'Name') then
  begin
    if (adotManual.FieldByName('PurchStk').Asinteger >= -1099998) and
     (adotManual.FieldByName('PurchStk').Asinteger <= -900000) then
    begin
      aFont.Style := [fsBold];
      aFont.Color := clYellow;
      aBrush.Color := clBlack;
    end
    else
    begin
      aFont.Style := [];
    end;
  end
end;

end.
