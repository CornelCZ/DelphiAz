unit uConfTh;

interface

uses                                                               
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Wwdotdot, Wwdbcomb, ExtCtrls, Mask, wwdbedit, Buttons,
  Grids, Wwdbigrd, Wwdbgrid, DB, Wwdatsrc, ADODB, wwdblook, wwcheckbox,
  wwclearbuttongroup, wwradiogroup;

type
  TfConfTh = class(TForm)
    adoqTh: TADOQuery;
    wwDataSource1: TwwDataSource;
    wwDBGrid1: TwwDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    adoqDiv: TADOQuery;
    wwDBEdit1: TwwDBEdit;
    Panel1: TPanel;
    edName: TEdit;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lookDiv: TwwDBLookupCombo;
    BitBtn5: TBitBtn;
    edNote: TMemo;
    wwcbSetNomPrices: TwwCheckBox;
    wwcbBlindStock: TwwCheckBox;
    adoqThTid: TSmallintField;
    adoqThDivision: TStringField;
    adoqThTName: TStringField;
    adoqThActive: TStringField;
    adoqThType: TStringField;
    adoqThNomPrice: TStringField;
    adoqThFillClose: TStringField;
    adoqThMadeBy: TStringField;
    adoqThMadeDT: TDateTimeField;
    adoqThTNote: TStringField;
    adoqThLMDT: TDateTimeField;
    adoqThlmby: TStringField;
    adoqThNames: TADOQuery;
    wwcbDozForm: TwwCheckBox;
    adoqThDozForm: TStringField;
    adoqThEditTak: TStringField;
    wwcbEditTakings: TwwCheckBox;
    wwcbGPreporting: TwwCheckBox;
    adoqThisGP: TStringField;
    wwCbCPS: TwwCheckBox;
    adoqThDoCPS: TStringField;
    adoqThCPSmode: TStringField;
    rgCPS: TwwRadioGroup;
    BitBtn6: TBitBtn;
    cbDBAutoRep: TwwCheckBox;
    btnAutoRep: TButton;
    adoqThAutoRep: TStringField;
    adoqAutoReps: TADOQuery;
    pnlAutoRep: TPanel;
    Label6: TLabel;
    Panel2: TPanel;
    dsAutoRep: TwwDataSource;
    wwDBGrid2: TwwDBGrid;
    adoqARView: TADOQuery;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    wwcbGallon: TwwCheckBox;
    Label7: TLabel;
    wwcbTakingsIncludeVar: TwwCheckBox;
    adoqThGallForm: TStringField;
    adoqThTillVarTak: TStringField;
    wwcbNoPurAcc: TwwCheckBox;
    adoqThNOPurAcc: TStringField;
    wwcbUseHZ: TwwCheckBox;
    adoqThByHZ: TBooleanField;
    wwcbWasteAdj: TwwCheckBox;
    adoqThWasteAdj: TBooleanField;
    btnMasTh: TBitBtn;
    adoqThSlaveTh: TIntegerField;
    lblMasTh: TLabel;
    pnlMakeMaster: TPanel;
    Label5: TLabel;
    gridMakeMaster: TwwDBGrid;
    dsMakeMaster: TwwDataSource;
    adoqMakeMaster: TADOQuery;
    Label8: TLabel;
    Label9: TLabel;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    cbAudSig: TwwCheckBox;
    cbManagerSig: TwwCheckBox;
    Bevel1: TBevel;
    Label11: TLabel;
    adoqThMngSig: TBooleanField;
    adoqThAudSig: TBooleanField;
    pnlCountSheet: TPanel;
    Label10: TLabel;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    Bevel2: TBevel;
    Label12: TLabel;
    adoqThACSfields: TStringField;
    adoqThACSheight: TFloatField;
    rgInstTR: TwwRadioGroup;
    cbAskTR: TwwCheckBox;
    adoqThInstTR: TBooleanField;
    adoqThAskTR: TBooleanField;
    adoqThLCBase: TBooleanField;
    cbLCBase: TwwCheckBox;
    wwcbDisplayImpExRef: TwwCheckBox;
    PanelOptionalFields: TPanel;
    Bevel3: TBevel;
    Label13: TLabel;
    cbOp: TCheckBox;
    cbPurS: TCheckBox;
    cbPurC: TCheckBox;
    cbNomP: TCheckBox;
    cbTheoClose: TCheckBox;
    cbShowImpExpRef: TCheckBox;
    LabelOptionalFieldsWarning: TLabel;
    rbSingle: TRadioButton;
    rb1_5: TRadioButton;
    adoqThShowImpExRef: TBooleanField;
    wwcbMAST: TwwCheckBox;
    adoqThMobileAutoCount: TBooleanField;
    adoqThDayStartMAC: TBooleanField;
    rgMAST: TwwRadioGroup;
    adoqThEndOnDoW: TSmallintField;
    adoqThHideFillAudit: TBooleanField;
    adoqThNomPriceTariffRO: TBooleanField;
    adoqThNomPriceOldRO: TBooleanField;
    btnCountSheetFields: TBitBtn;
    Bevel4: TBevel;
    cbHideFillAudit: TwwCheckBox;
    Bevel5: TBevel;
    wwcbNPfromTariffRO: TwwCheckBox;
    wwcbNPfromOldRO: TwwCheckBox;
    Label15: TLabel;
    wwdbcEndDateDoW: TwwDBComboBox;
    Label14: TLabel;
    Bevel6: TBevel;
    wwCbConfirmMobileLocationImportCounts: TwwCheckBox;
    adoqThConfirmMobileStockImport: TBooleanField;
    cbAutoFillBlankItems: TwwCheckBox;
    adoqThAutoFillBlindStockBlankCounts: TBooleanField;
    wwcbMobileStocks: TwwCheckBox;
    adoqThUseMustCountItems: TBooleanField;
    cbUseMustCountItems: TwwCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure adoqThAfterPost(DataSet: TDataSet);
    procedure wwDBGrid1Exit(Sender: TObject);
    procedure adoqThBeforePost(DataSet: TDataSet);
    procedure adoqThTNameValidate(Sender: TField);
    procedure wwCbCPSClick(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure cbDBAutoRepClick(Sender: TObject);
    procedure btnAutoRepClick(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure btnNewAutoRepClick(Sender: TObject);
    procedure wwDBGrid2Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMasThClick(Sender: TObject);
    procedure adoqMakeMasterAfterScroll(DataSet: TDataSet);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure btnCountSheetFieldsClick(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure rgInstTRClick(Sender: TObject);
    procedure OptionalFieldComboBoxClick(Sender: TObject);
    procedure wwcbDisplayImpExRefExit(Sender: TObject);
    procedure wwcbSetNomPricesClick(Sender: TObject);
    procedure wwcbBlindStockClick(Sender: TObject);
    procedure wwcbMASTClick(Sender: TObject);
    procedure wwcbUseHZClick(Sender: TObject);
    procedure adoqThAfterEdit(DataSet: TDataSet);
    procedure wwdbcEndDateDoWChange(Sender: TObject);
    procedure wwcbMobileStocksExit(Sender: TObject);
    procedure cbAutoFillBlankItemsClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    autorepsno : integer;
    beforePostBool, showWarningOnChange : boolean;
    okSlavesStr : string;
  public
    { Public declarations }
  end;

var
  fConfTh: TfConfTh;

implementation

uses uADO, udata1, uSecurity, ulog, uGlobals;

{$R *.dfm}

procedure TfConfTh.BitBtn1Click(Sender: TObject);
begin
  // refresh the temp table used to set the AutoReps
  dmADO.DelSQLTable('#stkARView');

  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select AR, [Text], (''N'') as SetAR INTO #stkARView from stkAReps order by [Text]');
    execSQL;
  end;

  panel1.Align := alClient;
  adoqDiv.open;
  edName.Text := '';
  edNote.Text := '';
  lookDiv.Text := '';
  panel1.Visible := True;
end;

procedure TfConfTh.BitBtn2Click(Sender: TObject);
begin
  if MessageDlg('Deactivating a Thread means no new activity will be done on it.'+
    #13+#10+'However reports will still be visible for the deactivated thread.'+
    #13+#10+''+#13+#10+'WARNING: Deactivated Threads CANNOT be re-activated!' + 
    #13+#10+''+#13+#10+'Are you sure you want to Deactivate this thread?',
    mtWarning, [mbYes,mbNo], 0) = mrYes then
  begin
    adoqTh.Edit;
    adoqTh.FieldByName('Active').asstring := 'N';
    adoqTh.Post;
    adoqTh.Requery;
  end;
end;

procedure TfConfTh.BitBtn4Click(Sender: TObject);
begin
  panel1.Visible := False;
end;

procedure TfConfTh.BitBtn3Click(Sender: TObject);
var
  maxTid : integer;
begin
  // check Name given, div chosen
  if edName.Text = '' then
  begin
    showMessage('You have to type a Thread Name!');
    edName.SetFocus;
    exit;
  end
  else
  begin
      if not (edName.Text[1] in [#48 .. #57, #65 .. #90, #97 .. #122]) then
      begin
        showMessage('The Thread Name has to start with an alphanumeric character (0..9, A..Z, a..z)!');
        edName.SetFocus;
        exit;
      end;
  end;

  if lookDiv.Text = '' then
  begin
    showMessage('You have to assign the Thread to a Division!');
    lookDiv.SetFocus;
    exit;
  end;

  // check unique name for division
  if adoqTh.locate('division;tname', VarArrayOf([lookDiv.Text ,edName.Text ]), []) then
  begin
    ShowMessage('There is already a Thread with Name: "'+ edName.Text + '"' +
      #13+#10+'assigned to Division: "'+ lookDiv.Text + '" in the system.' + #13 +
      'Please type a different name or choose a different Division to proceed.');
    edName.SetFocus;
    exit;
  end;

  // all OK here...
  if MessageDlg('A new Thread with Name: "'+ edName.Text + '"' +
    #13+#10+'assigned to Division: "'+ lookDiv.Text + '" will be added to the system.' +
    #13+#10+''+#13+#10+'Proceed?',
    mtWarning, [mbYes,mbNo], 0) = mrYes then
  begin
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select max(tid) as maxTid from Threads');
      open;
      maxTid := FieldByName('maxTid').asinteger;
      close;
    end;

    adoqTh.insert;
    adoqTh.FieldByName('tid').asinteger := maxTid + 1;
    adoqTh.FieldByName('Division').asstring := lookDiv.Text;
    adoqTh.FieldByName('tname').asstring := edName.Text;
    adoqTh.FieldByName('Active').asstring := 'Y';
    adoqTh.FieldByName('madeBy').asstring := CurrentUser.UserName;
    if edNote.Text <> '' then
      adoqTh.FieldByName('tnote').asstring := edNote.Text;


    adoqTh.Post;
    adoqTh.Requery;
    adoqTh.Locate('tid', maxTid + 1, []);
  end;

  if uGlobals.isSite and uGlobals.isMaster then
  begin
    // create stksectids to hold the threads permissions for this user
    dmADO.DelSQLTable('stksectids');
    with dmADO.adoqRun do
    begin
      if CurrentUser.IsZonalUser then
      begin
        close;
        sql.Clear;
        sql.Add('select distinct a.tid, b.permid into dbo.[stksectids] ');
        sql.Add('from threads a, stkSecPerms b');
        sql.Add('where b.parent > 1');
        execSQL;
      end
      else
      begin
        close;
        sql.Clear;
        sql.Add('select distinct tid, permid into dbo.[stksectids] from stkSecurity');
        sql.Add('where RoleID '+ CurrentUser.Roles.AsSQLCheck);
        sql.Add('and permset = ''Y''');
        execSQL;
      end;
    end;
  end;

  panel1.Visible := False;
end;

procedure TfConfTh.FormShow(Sender: TObject);
var
  t1, ts : integer;
begin

  // check out and correct any errors about master and slaves...

  // rules: MTh has positive no. as SlaveTh
  //        STh has negative number which means the MTh
  //        Check all MTh's and STh's are still Valid else make both threads normal.
  with dmADO.adoqRun do
  begin
    // strip out MTh info (negative numbers) from any Slave Threads (it will be put back once it checks out OK)
    dmADO.adoqRun2.close;
    dmADO.adoqRun2.sql.Clear;
    dmADO.adoqRun2.sql.Add('update Threads set Slaveth = 0 where Slaveth < 0');
    dmADO.adoqRun2.execSQL;

    dmADO.adoqRun2.close;
    dmADO.adoqRun2.sql.Clear;
    dmADO.adoqRun2.sql.Add('select * from Threads');
    dmADO.adoqRun2.open;

    close;
    sql.Clear;
    sql.Add('select * from Threads where SlaveTh > 0');
    open;

    while not eof do
    begin
      // master still active?
      if FieldByName('active').AsString = 'Y' then
      begin
        // slave still active? slave has 0 or negative SlaveTh?
        if dmADO.adoqRun2.Locate('tid', FieldByName('SlaveTh').asinteger, []) then
        begin
          // is the STh still valid?
          if (dmADO.adoqRun2.FieldByName('active').AsString = 'Y')
            and (dmADO.adoqRun2.FieldByName('SlaveTh').AsInteger <= 0) then
          begin
            // yes, it's OK write the Mth, etc. in the Slave Thread record...
            dmADO.adoqRun2.Edit;
            dmADO.adoqRun2.FieldByName('slaveTh').asinteger := -1 * FieldByName('tid').asinteger;
            dmADO.adoqRun2.FieldByName('editTak').asString := 'N';
            dmADO.adoqRun2.FieldByName('tillVarTak').asstring := FieldByName('tillVarTak').asstring;
            dmADO.adoqRun2.FieldByName('byHZ').asboolean := FieldByName('byHZ').asboolean;
            dmADO.adoqRun2.FieldByName('EndOnDoW').asstring := FieldByName('EndOnDoW').asstring;
            dmADO.adoqRun2.Post;
          end
          else
          begin // error, SlaveTh is invalid!!!! log error and make this thread normal...
            t1 := FieldByName('tid').asinteger;
            ts := FieldByName('SlaveTh').asinteger;
            try
              edit;
              FieldByName('SlaveTh').AsInteger := 0;
              post;
            except
              // do nothing
            end; // try .. except

            log.event('ERROR: Thread ' + inttostr(t1) +' was set as MTh with STh = ' + inttostr(ts) +
              ' but the STh is INVALID (Active,byHZ,SlaveTh=' + dmADO.adoqRun2.FieldByName('active').AsString +
              ',' + dmADO.adoqRun2.FieldByName('byHz').AsString +
              ',' + dmADO.adoqRun2.FieldByName('SlaveTh').AsString + ')! Thread was made normal.');
          end;
        end
        else
        begin // error, MTh with no Slave!!!! log error and make this thread normal...
          t1 := FieldByName('tid').asinteger;
          ts := FieldByName('SlaveTh').asinteger;
          try
            edit;
            FieldByName('SlaveTh').AsInteger := 0;
            post;
          except
            // do nothing
          end; // try .. except

          log.event('ERROR: Thread ' + inttostr(t1) +' was set as MTh with STh = ' + inttostr(ts) +
            ' but the STh tID could not be found! Thread was made normal.');
        end;
      end
      else
      begin // make Mth normal...
        t1 := FieldByName('tid').asinteger;
        ts := FieldByName('SlaveTh').asinteger;
        try
          edit;
          FieldByName('SlaveTh').AsInteger := 0;
          post;
        except
          // do nothing
        end; // try .. except

        log.event('ERROR: Thread ' + inttostr(t1) +' was set as MTh with STh = ' + inttostr(ts) +
          ' but the MTh is now inactive! Thread was made normal.');
      end;

      next;
    end;

    close;
  end;


  label1.Caption := 'Type a ' + data1.SSbig + ' Thread Name (max. 30 characters).' + #13 +
    'This name will be used to identify the Thread.' + #13 +
    'Thread Names have to be unique for each Division.' + #13 +
    'Thread Names can be changed later.';

  wwcbBlindStock.Caption := 'Blind ' + data1.SSbig + ' (Theo figures not shown on Audit)';
  label13.Caption := ' Not availalble on Blind ' + data1.SSplural + ' ';

  rgCPS.Caption := ' Set Cumulative Periods 1st ' + data1.SSplural + ': ';

  wwcbNoPurAcc.Caption := 'When accepting the ' + data1.SSbig + ' lock all Purchases used by the ' + data1.SSbig;
  rgInstTR.Caption := ' What Recipes to use for Theo Reduction in ' + data1.SSbig + ' calculation: ';
  cbLCBase.Caption := data1.SSplural + ' of this Thread can be used as Base for Line && Spot Checks';
  cbAskTR.Caption := 'Set when starting new ' + data1.SSbig;
  wwcbMAST.Caption := 'Do un-attended Mobile Auto Count ' + data1.SSbig + ' Take (MAC ' + data1.SSplural + ')';
  wwcbNPfromOldRO.Caption := 'Disallow change of Nominal Prices manually set on prior ' + data1.SSplural;

  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select count(AR) as thecount from stkAReps');
    open;
    autorepsNo := FieldByName('thecount').AsInteger;
    close;
  end;

  adoqThNames.Open;
  adoqTh.open;
  adoqDiv.open;
  adoqAutoReps.open;

  if btnAutoRep.Enabled and adoqAutoReps.Active then
  begin
    btnAutoRep.Caption := 'Set Reports to Auto-Print (' + inttostr(adoqAutoReps.RecordCount) +
     ' of ' + inttostr(autoRepsNo) + ')';
  end
  else
  begin
    btnAutoRep.Caption := 'Set Reports to Auto-Print';
  end;


  // SECURITY ***** SECURITY ***** SECURITY ***** SECURITY ***** SECURITY ***** SECURITY ***** SECURITY *****
  bitBtn1.Visible := data1.UserAllowed(0, 1);
  bitbtn2.Visible := data1.UserAllowed(0, 3);
  bitbtn6.Visible := data1.UserAllowed(0, 5);

  // editing...
  wwcbSetNomPrices.Enabled := data1.UserAllowed(0, 2);

  wwcbGPreporting.Enabled := wwcbSetNomPrices.Enabled;
  wwcbEditTakings.Enabled := wwcbSetNomPrices.Enabled;
  cbManagerSig.Enabled := wwcbSetNomPrices.Enabled;
  wwcbCPS.Enabled := wwcbSetNomPrices.Enabled;
  wwcbDozForm.Enabled := wwcbSetNomPrices.Enabled;
  wwcbTakingsIncludeVar.Enabled := wwcbSetNomPrices.Enabled;
  wwcbGallon.Enabled := wwcbSetNomPrices.Enabled;
  wwcbNoPurAcc.Enabled := wwcbSetNomPrices.Enabled;
  wwcbUseHZ.Enabled := wwcbSetNomPrices.Enabled;
  wwCbConfirmMobileLocationImportCounts.Enabled := wwcbUseHZ.Enabled and wwcbUseHZ.Checked;
  wwcbWasteAdj.Enabled := wwcbSetNomPrices.Enabled;
  rgCPS.Enabled := wwcbSetNomPrices.Enabled and wwcbCPS.checked;
  wwdbEdit1.Enabled := wwcbSetNomPrices.Enabled;
  cbDBAutoRep.Enabled := wwcbSetNomPrices.Enabled;
  btnAutoRep.Enabled := wwcbSetNomPrices.Enabled and cbDBAutoRep.checked;
  wwDBGrid1.ReadOnly := not wwcbSetNomPrices.Enabled;
  rgInstTR.Enabled := wwcbSetNomPrices.Enabled;
  wwcbMAST.Enabled := wwcbSetNomPrices.Enabled;
  rgMAST.Enabled := wwcbMast.Checked and wwcbMast.Enabled;


  if wwDBGrid1.ReadOnly then
    self.Caption := 'Threads Configuration (No Editing)';

  // SECURITY _____ SECURITY _____ SECURITY _____ SECURITY _____ SECURITY _____ SECURITY _____ SECURITY _____
  adoqTh.First;
end;

procedure TfConfTh.adoqThAfterPost(DataSet: TDataSet);
var
  t1, ts, okAsSlaves, slaves, masters, diffHZ, i : integer;
begin
  showWarningOnChange := FALSE;

  wwDataSource1.Enabled := not (adoqTh.RecordCount = 0);
  if adoqTh.RecordCount = 0 then
  begin
    bitbtn2.Enabled := False;
    bitbtn6.Enabled := bitbtn2.Enabled;
    btnMasTh.Enabled := bitbtn2.Enabled;
    btnAutoRep.Enabled := False;
    btnCountSheetFields.Enabled := False;
  end
  else
  begin
    btnCountSheetFields.Enabled := True;
    bitbtn2.Enabled := (adoqTh.FieldByName('active').asstring = 'Y');
    if wwdbcEndDateDoW.ItemIndex = 0 then
      label14.Caption := ' User can choose any day' + #13 + ' as End Date (default usage)'
    else
      label14.Caption := ' End Date automatically set' + #13 + ' to most recent ' + wwdbcEndDateDoW.Text;

    if adoqTh.FieldByName('active').asstring = 'N' then
    begin
      btnMasTh.Enabled := False;
      lblMasTh.Caption := 'This Thread is no longer Active.';
      lblMasTh.Color := clTeal;
      lblMasTh.Font.Color := clWhite;

      for i:= 0 to self.ControlCount -1 do
      begin
        if self.Controls[i].Tag = 99 then
          self.Controls[i].Enabled := FALSE;
      end;
    end
    else
    begin
      for i:= 0 to self.ControlCount -1 do  // enable all checkboxes etc., disable below, selectively
      begin                                 // depending on Thread being Master or Slave or Normal...
        if self.Controls[i].Tag = 99 then
          self.Controls[i].Enabled := TRUE;
      end;

      if adoqTh.FieldByName('SlaveTh').asinteger > 0 then // Master Thread ??
      begin
        if adoqThNames.Locate('tid', adoqTh.FieldByName('SlaveTh').asinteger, []) then
        begin
          // is the STh still valid?
          if (adoqTHNames.FieldByName('active').AsString = 'Y')
            and (adoqTHNames.FieldByName('SlaveTh').AsInteger <= 0) then
          begin
            btnmasth.Caption := 'Make This a'#10'Normal Thread';
            btnMasTh.Enabled := True;
            lblMasTh.Caption := 'Thread "' + adoqTh.FieldByName('tname').asstring +
              '" is a Master Thread.'#13 +
              'The Subordinate Thread for it is: "' + adoqThNames.FieldByName('tname').asstring + '"';
            lblMasTh.Color := clBlue;
            lblMasTh.Font.Color := clWhite;
            wwcbEditTakings.Enabled := False;
            bitBtn2.Enabled := False;
            wwcbMast.Enabled := False;

            // if this Master Thread had a change of End On DoW then give this setting to the Slave as well
            // also if it had a change of "Use HZs or Locations"...
            if beforePostBool then
            begin
              beforePostBool := FALSE;

              if (adoqTHNames.FieldByName('EndOnDoW').AsString <> adoqTH.FieldByName('EndOnDoW').AsString)
                 or (adoqTHNames.FieldByName('byHz').AsBoolean <> adoqTH.FieldByName('byHz').AsBoolean)
                 or (adoqTHNames.FieldByName('ConfirmMobileStockImport').AsBoolean <> adoqTH.FieldByName('ConfirmMobileStockImport').AsBoolean) then
                with dmADO.adoqRun do
                begin
                  close;
                  sql.Clear;
                  sql.Add('update Threads set EndOnDoW = ' + quotedStr(adoqTh.FieldByName('EndOnDoW').asstring));
                  sql.Add(', byHZ = ' + booltostr(adoqTh.FieldByName('ByHZ').asboolean));
                  sql.Add(', ConfirmMobileStockImport = ' + booltostr(adoqTh.FieldByName('ConfirmMobileStockImport').asboolean));
                  sql.Add(', lmdt = GetDate() , lmby = ' + quotedStr(CurrentUser.UserName) +
                                  ' where tid = ' + adoqTh.FieldByName('SlaveTh').asstring);

                  // there's an issue here that causes the cursor to jump to the 2nd record in the grid
                  // after changing the byHZ checkbox then moving off the grid row.
                  if execSQL > 0 then
                    adoqTh.Requery;
                end;
            end;
          end
          else
          begin // error, SlaveTh is invalid!!!! log error and make this thread normal...
            with adoqTh do
            begin
              t1 := adoqTh.FieldByName('tid').asinteger;
              ts := adoqTh.FieldByName('SlaveTh').asinteger;
              disablecontrols;
              try
                edit;
                FieldByName('SlaveTh').AsInteger := 0;
                post; // this will re-enter the same proc BUT will quickly exit it...
              except
                // do nothing
              end; // try .. except

              enablecontrols;
              log.event('ERROR: Thread ' + inttostr(t1) +' was set as MTh with STh = ' + inttostr(ts) +
                ' but the STh is INVALID (Active,byHZ,SlaveTh=' + adoqTHNames.FieldByName('active').AsString +
                ',' + adoqTHNames.FieldByName('byHz').AsString +
                ',' + adoqTHNames.FieldByName('SlaveTh').AsString + ')! Thread was made normal.');
              exit; // the texts, buttons etc. were already set OK by the locate 4 lines above...
            end;
          end;
        end
        else
        begin // error, MTh with no Slave!!!! log error and make this thread normal...
          with adoqTh do
          begin
            t1 := adoqTh.FieldByName('tid').asinteger;
            ts := adoqTh.FieldByName('SlaveTh').asinteger;
            disablecontrols;
            try
              edit;
              FieldByName('SlaveTh').AsInteger := 0;
              post; // this will re-enter the same proc BUT will quickly exit it...
            except
              // do nothing
            end; // try .. except

            enablecontrols;
            log.event('ERROR: Thread ' + inttostr(t1) +' was set as MTh with STh = ' + inttostr(ts) +
              ' but the STh tID could not be found! Thread was made normal.');
            exit; // the texts, buttons etc. were already set OK by the locate 4 lines above...
          end;
        end;
      end
      else // reuse adoqThNames to determine the Master-Slave possibilities for the current thread..
      begin
        // is this a slave thread?
        if adoqThNames.Locate('slaveTh', adoqTh.FieldByName('tid').asinteger, []) then
        begin
          btnmasth.Caption := 'This is a'#10'Sub. Thread';
          btnMasTh.Enabled := False;
          lblMasTh.Caption := 'This thread is a Subordinate Thread.'#13 +
            'The Master Thread for it is: "' + adoqThNames.FieldByName('tname').asstring + '"';
          lblMasTh.Color := clAqua;
          lblMasTh.Font.Color := clBlack;
          wwcbEditTakings.Enabled := False;
          wwcbTakingsIncludeVar.Enabled := False;
          wwCBUseHZ.Enabled := False;
          wwCbConfirmMobileLocationImportCounts.Enabled := False;
          bitBtn2.Enabled := False;
          rgInstTR.Enabled := False;
          wwcbMast.Enabled := TRUE;
          wwdbcEndDateDoW.Enabled := FALSE;
        end
        else
        begin // thread is normal...
          // can it be made into a MTh? Look for Tids in same Div that are NOT MTh or STh already
          // and have the same byHZ setting as this thread.
          // but not if it is a MAC thread...
          if (wwcbMast.Checked and wwcbMast.Enabled) then
          begin
              btnmasth.Caption := 'This cannot be'#10'Master Thread';
              btnMasTh.Enabled := False;
              lblMasTh.Caption := 'This is a MAC '+data1.SSplural+ ' Thread.'#13 +
                'It CANNOT be made into a Master Thread';
              lblMasTh.Color := clTeal;
              lblMasTh.Font.Color := clWhite;
          end
          else
          begin
            with adoqThNames do
            begin
              first;
              okAsSlaves := 0;
              okSlavesStr := '';
              slaves := 0;
              masters := 0;
              diffHz := 0;
              while not eof do
              begin
                if (FieldByName('active').asstring = 'Y') // deactivated threads don't count
                  and (FieldByName('tid').AsString <> adoqTh.FieldByName('tid').AsString) then // can't be MTh to itself
                begin
                  if FieldByName('slaveTh').asinteger > 0 then // found a MTh
                  begin
                    inc(masters);
                  end
                  else
                  begin
                    if FieldByName('byHZ').AsBoolean <> adoqTh.FieldByName('byHZ').asboolean then
                    begin  // different by Holding Zone setting
                      inc(diffHz);
                    end
                    else
                    begin
                      dmADO.adoqRun.close;
                      dmADO.adoqRun.sql.Clear;
                      dmADO.adoqRun.sql.Add('select tid from Threads where SlaveTh = ' +
                        FieldByName('tid').AsString);
                      dmADO.adoqRun.open;
                      if dmADO.adoqRun.recordcount > 0 then // found a STh
                      begin
                        dmADO.adoqRun.close;
                        inc(slaves);
                      end
                      else
                      begin  // this Thread could become a STh...
                        dmADO.adoqRun.close;

                        if okSlavesStr <> '' then
                          okSlavesStr := okSlavesStr + ', ';

                        okSlavesStr := okSlavesStr + FieldByName('tid').AsString;

                        inc(okAsSlaves);
                      end;
                    end;
                  end;
                end;

                next;
              end;
            end;

            // ok, evaluate results, set button and label accordingly...
            if okAsSlaves > 0 then
            begin
              btnmasth.Caption := 'Make This a'#10'Master Thread';
              btnMasTh.Enabled := True;
              lblMasTh.Caption := 'This thread is a Normal Thread.'#13 +
                'It can be made into a Master Thread (' + inttostr(okasslaves) +
                ' available as Subordinate)';
              lblMasTh.Color := clGreen;
              lblMasTh.Font.Color := clWhite;
            end
            else
            begin
              btnmasth.Caption := 'This cannot be'#10'Master Thread';
              btnMasTh.Enabled := False;
              lblMasTh.Caption := 'This is a Normal Thread. It CANNOT be made into a Master Thread' +
                #13 + 'Other Threads for this Div.: ' + inttostr(masters) + ' Masters, ' + inttostr(slaves) +
                ' Sub., ' + inttostr(diffHZ) + ' diff. HZ setup';
              lblMasTh.Color := clTeal;
              lblMasTh.Font.Color := clWhite;
            end;
          end;

          bitBtn2.Enabled := True;

          // if wwcbMAST is checked then most others are disabled...
          wwcbSetNomPrices.Enabled := not (wwcbMast.Checked and wwcbMast.Enabled);
          wwcbBlindStock.Enabled := not (wwcbMast.Checked and wwcbMast.Enabled);
          wwcbEditTakings.Enabled := not (wwcbMast.Checked and wwcbMast.Enabled);
          wwcbCPS.Enabled := not (wwcbMast.Checked and wwcbMast.Enabled);
          cbdbAutoRep.Enabled := not (wwcbMast.Checked and wwcbMast.Enabled);
          wwcbWasteAdj.Enabled := not (wwcbMast.Checked and wwcbMast.Enabled);
          wwcbDisplayImpExRef.Enabled := not (wwcbMast.Checked and wwcbMast.Enabled);
          btnCountSheetFields.Enabled := not (wwcbMast.Checked and wwcbMast.Enabled);
          wwdbcEndDateDoW.Enabled := not (wwcbMast.Checked and wwcbMast.Enabled);
        end;
      end;

      wwCbConfirmMobileLocationImportCounts.Enabled := wwcbUseHZ.Checked and wwcbUseHZ.Enabled;
      wwcbNPfromTariffRO.Enabled := wwcbSetNomPrices.Checked and wwcbSetNomPrices.Enabled;
      wwcbNPfromOldRO.Enabled := wwcbSetNomPrices.Checked and wwcbSetNomPrices.Enabled;
      cbHideFillAudit.Enabled := (not wwcbBlindStock.Checked) and wwcbBlindStock.Enabled;
      cbAutoFillBlankItems.Enabled := wwcbBlindStock.Checked and wwcbBlindStock.Enabled;
      cbUseMustCountItems.Enabled := cbAutoFillBlankItems.Enabled and cbAutoFillBlankItems.Checked;
      rgCPS.Enabled := wwcbCPS.Checked and wwcbCPS.Enabled;
      btnAutoRep.Enabled := wwcbSetNomPrices.Enabled and cbDBAutoRep.checked;
      if btnAutoRep.Enabled and adoqAutoReps.Active then
        btnAutoRep.Caption := 'Set Reports to Auto-Print (' + inttostr(adoqAutoReps.RecordCount) +
         ' of ' + inttostr(autoRepsNo) + ')'
      else
        btnAutoRep.Caption := 'Set Reports to Auto-Print';
      rgMAST.Enabled := wwcbMast.Checked and wwcbMast.Enabled;
      cbAskTR.Enabled := rgInstTR.Enabled and (rgInstTR.ItemIndex = 1);
      label15.Enabled := (wwdbcEndDateDoW.ItemIndex > 0);
    end; // if .. else .. (for threads that are ACTIVE)
  end;
  adoqThNames.Requery;
end;

procedure TfConfTh.wwDBGrid1Exit(Sender: TObject);
begin
  if wwdbgrid1.DataSource.DataSet.State = dsEdit then
    wwdbgrid1.DataSource.DataSet.post;
end;

procedure TfConfTh.adoqThBeforePost(DataSet: TDataSet);
begin
  adoqTh.FieldByName('lmdt').AsDateTime := Now;
  adoqTh.FieldByName('lmBy').asstring := CurrentUser.UserName;
  beforePostBool := TRUE;
end;

procedure TfConfTh.adoqThTNameValidate(Sender: TField);
begin
  IF Sender.AsString = '' then
  begin
    raise Exception.Create('The Thread Name has to have at least one alphanumeric character (0..9, A..Z, a..z)!');
  end
  else
  begin
    if (Uppercase(VarToStr(Sender.OldValue)) <> Uppercase(Sender.AsString)) and (adoqThNames.Locate('tname', Sender.AsString, [])) then
      raise Exception.Create('There is already a Thread with Name: "'+ Sender.AsString + '"' +
      #13+#10+'assigned to Division: "'+ adoqTh.FieldByName('division').asstring + '" in the system.' + #13 +
      'Please type a different name or choose a different Division to proceed.');
  end;
end;

procedure TfConfTh.wwCbCPSClick(Sender: TObject);
begin
  rgCPS.Enabled := wwcbCPS.Checked and wwcbCPS.Enabled;
end;

procedure TfConfTh.BitBtn6Click(Sender: TObject);
begin
  fSecurity := TfSecurity.Create(self);
  if fSecurity.okToShow then
  begin
    fSecurity.showThread := adoqTh.FieldByName('tid').asinteger;
    fSecurity.curTName := adoqTh.FieldByName('tname').asstring;
    fSecurity.curDiv := adoqTh.FieldByName('division').asstring;
    fSecurity.curTid := adoqTh.FieldByName('tid').asinteger;
    fSecurity.Caption := 'Site Security Configuration - ONE THREAD ONLY';
    fSecurity.ShowModal;
  end;
  fSecurity.Free;
end;

procedure TfConfTh.cbDBAutoRepClick(Sender: TObject);
begin
  btnAutoRep.Enabled := wwcbSetNomPrices.Enabled and cbDBAutoRep.checked;
end;

procedure TfConfTh.btnAutoRepClick(Sender: TObject);
begin
  // create the temp table to set the AutoReps
  dmADO.DelSQLTable('#stkARView');

  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select AR, [Text], (''N'') as SetAR INTO #stkARView from stkAReps order by [Text]');
    execSQL;

    close;
    sql.Clear;
    sql.Add('update #stkARView set [setAR] = ''Y''');
    sql.Add('where AR in (select a.[AR] from stkAutoRep a where a.Tid = ' +
      adoqTh.FieldByName('tid').AsString + ')');
    execSQL;
  end;

  adoqARView.Open;

  bitbtn7.Caption := 'Save Settings';
  bitbtn8.Visible := True;
  pnlAutoRep.Align := alClient;
  pnlAutoRep.Visible := True;

end;

procedure TfConfTh.BitBtn8Click(Sender: TObject);
begin
  pnlAutoRep.Visible := False;
  adoqARView.Close;
end;

procedure TfConfTh.BitBtn7Click(Sender: TObject);
var
  errstr : string;
begin
  pnlAutoRep.Visible := False;
  adoqARView.Close;

  // save settings...
  // do all in a transaction to avoid wiping out settings and then fail on writing...

  if bitbtn7.Caption = 'Done' then // this is a new thread, not yet saved, just wait for now...
    exit;

  if dmADO.AztecConn.InTransaction then
  begin
    log.event('Error in Save Auto Rep Settings (before BeginTrans): Already in Transaction');
    showMessage('Error trying to save Auto-Print Settings!' + #13 + #13 +
      'Cannot begin transaction');

    exit;
  end;

  dmADO.AztecConn.BeginTrans;

  try
    errstr := 'delete from stkAutoRep';
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('delete stkAutoRep');
      sql.Add('where "tid" = ' + adoqTh.FieldByName('tid').AsString);
      execSQL;

      errstr := 'Insert in stkAutoRep';

      close;
      sql.Clear;
      sql.Add('insert stkAutoRep (Tid, AR, LMDT, LMBy)');
      sql.Add('select (' + adoqTh.FieldByName('tid').AsString + ') as Tid, AR,');
      sql.Add('(' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) + ') as LMDT,');
      sql.Add('(' + quotedStr(CurrentUser.UserName) + ') as LMBy');
      sql.Add('from #stkARView');
      sql.Add('where [setAR] = ''Y''');
      execSQL;
    end;
  except
    on E:exception do
    begin
      // Error in transaction, attempt to rollback
      if dmADO.AztecConn.InTransaction then
      begin
        dmADO.RollbackTransaction;

        showMessage('Transaction Error trying to Save Auto-Print settings! (' + errstr + ')' + #13 + #13 +
          'Error Message: ' + E.Message);

        log.event('Error in Save Auto-Print - Trans. Rolled Back (' + errstr + '): ' + E.Message);
      end
      else
      begin
        showMessage('Transaction Error trying to Save Auto-Print settings! (' + errstr + ')' + #13 + #13 +
          'Error Message: ' + E.Message + #13 + #13 +
          'Data Integrity concerning Auto-Print may have been compromised!');

        log.event('Error in Save Auto-Print - Trans. NOT Rolled Back (' + errstr + '): ' + E.Message);
      end;

      exit;
    end;
  end;

  dmADO.CommitTransaction;

  adoqAutoReps.Requery;
  btnAutoRep.Caption := 'Set Reports to Auto-Print (' + inttostr(adoqAutoReps.RecordCount) +
    ' of ' + inttostr(autoRepsNo) + ')';

end;

procedure TfConfTh.btnNewAutoRepClick(Sender: TObject);
begin
  adoqARView.Open;

  bitbtn7.Caption := 'Done';
  bitbtn8.Visible := False;
  pnlAutoRep.Align := alClient;
  pnlAutoRep.Visible := True;
end;

procedure TfConfTh.wwDBGrid2Exit(Sender: TObject);
begin
  if wwdbgrid2.DataSource.DataSet.State = dsEdit then
    wwdbgrid2.DataSource.DataSet.post;
end;

procedure TfConfTh.FormCreate(Sender: TObject);
begin
  self.ClientWidth := 808;
  self.ClientHeight := 614;
  beforePostBool := FALSE;
end;

procedure TfConfTh.btnMasThClick(Sender: TObject);
var
  mtid, stid : string;
begin
  if btnmasth.Caption = 'Make This a'#10'Master Thread' then
  begin
    // show suitable Threads in a grid for user to choose one...
    label9.Caption := 'Make Thread "' + adoqTh.FieldByName('tname').asstring + '" a Master Thread';

    with adoqMakeMaster do
    begin
      close;
      sql.Clear;
      sql.add('select a.tid, a.tname, a.tnote, count(b.sitecode) as atSites,');
      sql.add('min(b.minSD) as minSD, max(b.maxED) as maxED, avg(b.avgPer) as avgPer');
      sql.add('from Threads a LEFT OUTER JOIN');
      sql.add(' (select sitecode, tid, min(Sdate) as minSD, max(Edate) as maxED,');
      sql.add('   avg(CAST((edate - sdate + 1) AS float)) as avgPer');
      sql.add('  from Stocks');
      sql.add('  where stockcode > 1');
      sql.add('  and tid in (' + okSlavesStr + ')');
      sql.add('  group by sitecode, tid');
      sql.add('  having count(stockcode) > 0');
      sql.add(' ) b');
      sql.add('ON a.tid = b.tid');
      sql.add('where a.tid in (' + okSlavesStr + ')');
      sql.add('group by a.tid, a.tname, a.tnote');
      open;

      TNumericField(FieldByName('avgPer')).displayformat := '#.##';

      first;
    end;

    // show info about the current Thread ???

    pnlMakeMaster.Align := alClient;
    pnlMakeMaster.Visible := True;
  end
  else if btnmasth.Caption = 'Make This a'#10'Normal Thread' then
  begin
    if MessageDlg(lblMasTh.Caption+#13+''+#13+'Do you want to make it a Normal Thread?',
      mtConfirmation, [mbYes,mbNo], 0) = mrYes then
    begin
      mtid := adoqTh.FieldByName('tid').asstring;
      stid := adoqTh.FieldByName('slaveTh').asstring;

      // normalize the Master Thread...
      with dmADO.adoqRun do
      begin
        // 1. deal with master  2. deal with slave
        close;
        sql.Clear;
        sql.Add('update Threads set slaveTh = 0, lmdt = GetDate(), lmby = ' +
                                 quotedStr(CurrentUser.UserName)  + '  where tid = ' + mtid);
        sql.Add('');
        sql.Add('update Threads set slaveTh = 0, lmdt = GetDate(), lmby = ' +
                                 quotedStr(CurrentUser.UserName)  + '  where tid = ' + stid);
        execSQL;
      end;

      adoqTh.Requery;
      adoqTh.Locate('tid', mtid, []);
    end;
  end;
end;

procedure TfConfTh.adoqMakeMasterAfterScroll(DataSet: TDataSet);
begin
  bitbtn9.Caption := 'Make "' + adoqTh.FieldByName('tname').asstring + '" a Master Thread'#10 +
    'with "' + adoqMakeMaster.FieldByName('tname').asstring + '" as Subordinate.';
end;

procedure TfConfTh.BitBtn10Click(Sender: TObject);
begin
  pnlMakeMaster.Visible := False;
end;

procedure TfConfTh.BitBtn9Click(Sender: TObject);
var
  mtid, stid, tillVarTak, mDoW : string;
begin
  mtid := adoqTh.FieldByName('tid').asstring;
  tillVarTak := adoqTh.FieldByName('tillVarTak').asstring;
  stid := adoqMakeMaster.FieldByName('tid').asstring;

  with dmADO.adoqRun do
  begin
    // check if both Threads have the same "weekday" setting. if not warn user that
    // the Slave Thread will be given the same setting as the Master and ask to Confirm...

    mDow := wwdbcEndDateDoW.Text;

    Close;
    sql.Clear;
    sql.Add('select EndOnDoW from Threads where Tid = ' + stid);  //  fieldbyName('EndOnDoW').asinteger
    open;

    if wwdbcEndDateDoW.Value <> fieldbyName('EndOnDoW').asstring then
      if MessageDlg('The Threads have different settings for "End Date only allowed this weekday"'+#13+#10+
        'If you continue, the setting of the Master Thread (which is: "' + wwdbcEndDateDoW.Text
        + '")'+#13+#10+ 'will be applied to the Subordinate Thread as well.' +#13+#10+ #13+#10 +
        'Continue?', mtConfirmation, [mbYes,mbNo], 0) = mrNo then
        exit;

    // make the Master Thread...
    // 1. deal with master  2. deal with slave
    close;
    sql.Clear;
    sql.Add('update Threads set slaveTh = ' + stid + ',');
    sql.Add('editTak = ''Y'', lmdt = GetDate(), lmby = ' +
                                 quotedStr(CurrentUser.UserName)  + '  where tid = ' + mtid);
    sql.Add('');
    sql.Add('update Threads set slaveTh = -' + mtid + ',');
    sql.Add('editTak = ''N'', tillVarTak = ' + quotedStr(tillVarTak) + ', lmdt = GetDate(), lmby = ' +
             quotedStr(CurrentUser.UserName) + ', EndOnDoW = ' + 
             adoqTh.FieldByName('EndOnDoW').asstring + '  where tid = ' + stid);
    execSQL;
  end;

  adoqTh.Requery;
  adoqTh.Locate('tid', mtid, []);

  pnlMakeMaster.Visible := False;
end;

procedure TfConfTh.wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if Field.FieldName <> 'TName' then
    exit;
    
  if adoqTh.FieldByName('slaveTh').asinteger > 0 then // master
  begin
    abrush.Color := clBlue;
    aFont.Color := clWhite;
    aFont.Style := [fsBold];
  end
  else if adoqTh.FieldByName('slaveTh').asinteger < 0 then // slave
  begin
    abrush.Color := clAqua;
    aFont.Color := clBlack;
    aFont.Style := [];
  end
  else
  begin
    abrush.Color := clWhite;
    aFont.Color := clBlack;
    aFont.Style := [];
  end;
end;

procedure TfConfTh.btnCountSheetFieldsClick(Sender: TObject);
var
  fieldops : string[6];
begin
  // load checkboxes
  with adoqTh do
  begin
    fieldops := FieldByName('acsfields').asstring;

    cbOp.Checked := (fieldops[1] = '1');
    cbPurS.Checked := (fieldops[2] = '1');
    cbPurC.Checked := (fieldops[3] = '1');

    if FieldByName('fillClose').asstring = 'Y' then
    begin
      cbNomP.Enabled := True;
      cbTheoClose.Enabled := True;
      cbNomP.Checked := (fieldops[4] = '1');
      cbTheoClose.Checked := (fieldops[5] = '1');
    end
    else
    begin
      cbNomP.Enabled := False;
      cbTheoClose.Enabled := False;
      cbNomP.Checked := False;
      cbTheoClose.Checked := False;
    end;

    cbShowImpExpRef.Checked := (fieldops[6] = '1');

    if FieldByName('ACSheight').asfloat = 1.5 then
      rb1_5.Checked := True
    else
      rbSingle.Checked := True;
  end;

  pnlCountSheet.Align := alClient;
  pnlCountSheet.Visible := True;
end;

procedure TfConfTh.BitBtn12Click(Sender: TObject);
begin
  pnlCountSheet.Visible := False;
end;

procedure TfConfTh.BitBtn11Click(Sender: TObject);
var
  fieldops : string[6];
begin
  fieldops := '000000';

  if cbOp.Checked then
    fieldops[1] := '1';
  if cbPurS.Checked then
    fieldops[2] := '1';
  if cbPurC.Checked then
    fieldops[3] := '1';
  if cbNomP.Checked then
    fieldops[4] := '1';
  if cbTheoClose.Checked then
    fieldops[5] := '1';
  if cbShowImpExpRef.Checked then
    fieldops[6] := '1';

  with adoqTh do
  begin
    if state <> dsEdit then
      Edit;

    FieldByName('acsfields').asstring := fieldops;

    if rb1_5.Checked then
      FieldByName('ACSheight').asfloat := 1.5
    else
      FieldByName('ACSheight').asfloat := 1;

    Post;
  end;
  pnlCountSheet.Visible := False;
end;

procedure TfConfTh.rgInstTRClick(Sender: TObject);
begin
  cbAskTR.Enabled := rgInstTR.Enabled and (rgInstTR.ItemIndex = 1);
end;

procedure TfConfTh.OptionalFieldComboBoxClick(Sender: TObject);
var
  Weight: Integer;
begin
  Weight := 0;

  if cbOp.Checked then
    Inc(Weight);
  if cbPurS.Checked then
    Inc(Weight);
  if cbPurC.Checked then
    Inc(Weight);
  if cbNomP.Checked then
    Inc(Weight);
  if cbTheoClose.Checked then
    Inc(Weight);
  if cbShowImpExpRef.Checked then
    Inc(Weight,2);

  if Weight > 3 then
  begin
    MessageDlg(
      Format('There is insufficient space remaing to fit column %s' + #13#10 +
             'onto the Audit Count Sheet.  Remove other optional fields before adding' + #13#10 +
             'this optional field.',[QuotedStr((Sender as TCheckBox).Caption)]),
      mtError,
      [mbOK],
      0);

    (Sender as TCheckBox).Checked := False;
  end;
end;

procedure TfConfTh.wwcbDisplayImpExRefExit(Sender: TObject);
begin
  if wwdbgrid1.DataSource.DataSet.State = dsEdit then
    wwdbgrid1.DataSource.DataSet.post;
end;

procedure TfConfTh.wwcbMASTClick(Sender: TObject);
begin
  if showWarningOnChange and wwcbUseHZ.Checked and wwcbMast.Checked then
  begin
    MessageDlg('You just configured this Thread to allow un-attended MAC '+ data1.SSplural + '.' +
      #13#10 + 'This Thread is set up to use Holding Zones or Count Locations.' +
      #13#10 + 'Be advised that MAC '+ data1.SSplural + ' will NOT be done at sites that use Holding Zones',
      mtInformation, [mbOK], 0);
  end;

  rgMAST.Enabled := wwcbMast.Checked and wwcbMast.Enabled;
end;

procedure TfConfTh.wwcbUseHZClick(Sender: TObject);
begin
  if showWarningOnChange and wwcbUseHZ.Checked and wwcbMast.Checked then
  begin
    MessageDlg('You just configured this Thread to use Holding Zones or Count Locations.' + #13#10 +
      'This Thread is set up to allow un-attended MAC '+ data1.SSplural + '.' +
      #13#10 + 'Be advised that MAC '+ data1.SSplural + ' will NOT be done at sites that use Holding Zones',
      mtInformation, [mbOK], 0);
  end;

  if showWarningOnChange and (adoqTh.FieldByName('SlaveTh').asinteger > 0) then
  begin
    MessageDlg('This is a Master Thread!' + #13#10 +
      'Its Subordinate Thread will automatically get the same '+ #13#10 +
      'setting for "Use Holding Zones or Count Locations".',
      mtInformation, [mbOK], 0);
  end;

  wwCbConfirmMobileLocationImportCounts.Enabled := wwcbUseHZ.Checked;
  if not wwcbUseHZ.Checked then
  begin
    if wwCbConfirmMobileLocationImportCounts.DataSource.DataSet.State = dsEdit then
    begin
      wwCbConfirmMobileLocationImportCounts.Checked := false; // setting this doesn't get updated in the dataset (??)
      wwCbConfirmMobileLocationImportCounts.DataSource.DataSet.FieldByName('ConfirmMobileStockImport').Value := false;
    end;
  end;
end;

procedure TfConfTh.adoqThAfterEdit(DataSet: TDataSet);
begin
  showWarningOnChange := TRUE;
end;

procedure TfConfTh.wwdbcEndDateDoWChange(Sender: TObject);
begin
  if wwdbcEndDateDoW.ItemIndex = 0 then
    label14.Caption := ' User can choose any day' + #13 + ' as End Date (default usage)'
  else
    label14.Caption := ' End Date automatically set' + #13 + ' to most recent ' + wwdbcEndDateDoW.Text;
  label15.Enabled := (wwdbcEndDateDoW.ItemIndex <> 0);
end;

procedure TfConfTh.wwcbSetNomPricesClick(Sender: TObject);
begin
  wwcbNPfromTariffRO.Enabled := wwcbSetNomPrices.Checked and wwcbSetNomPrices.Enabled;
  wwcbNPfromOldRO.Enabled := wwcbSetNomPrices.Checked and wwcbSetNomPrices.Enabled;
end;

procedure TfConfTh.wwcbBlindStockClick(Sender: TObject);
begin
  cbHideFillAudit.Enabled := (not wwcbBlindStock.Checked) and wwcbBlindStock.Enabled;
  cbAutoFillBlankItems.Enabled := wwcbBlindStock.Checked and wwcbBlindStock.Enabled;
  cbUseMustCountItems.Enabled := cbAutoFillBlankItems.Enabled and cbAutoFillBlankItems.Checked;
end;

procedure TfConfTh.wwcbMobileStocksExit(Sender: TObject);
begin
  if wwdbgrid1.DataSource.DataSet.State = dsEdit then
    wwdbgrid1.DataSource.DataSet.post;
end;

procedure TfConfTh.cbAutoFillBlankItemsClick(Sender: TObject);
begin
  cbUseMustCountItems.Enabled := cbAutoFillBlankItems.Enabled and cbAutoFillBlankItems.Checked;
end;

procedure TfConfTh.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if wwdbgrid1.DataSource.DataSet.State = dsEdit then
    wwdbgrid1.DataSource.DataSet.post;
end;

end.
