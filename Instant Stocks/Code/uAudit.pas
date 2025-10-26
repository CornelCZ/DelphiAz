unit uAudit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Wwdbigrd, Wwdbgrid, Db, Wwdatsrc, DBTables, Wwtable, StdCtrls,
  Buttons, Variants, ADODB, ExtCtrls, Mask, RxCalc, Wwkeycb, wwDialog,
  Wwlocate, ComCtrls, DBCtrls, uGlobals;

type
  TfAudit = class(TForm)
    wwsAuditCur: TwwDataSource;
    wwGrid1: TwwDBGrid;
    wwtAuditCur: TADOQuery;
    wwtAuditCurEntityCode: TFloatField;
    wwtAuditCurSubCat: TStringField;
    wwtAuditCurImpExRef: TStringField;
    wwtAuditCurName: TStringField;
    wwtAuditCurOpStk: TFloatField;
    wwtAuditCurPurchStk: TFloatField;
    wwtAuditCurThRedQty: TFloatField;
    wwtAuditCurThCloseStk: TFloatField;
    wwtAuditCurActCloseStk: TFloatField;
    wwtAuditCurPurchUnit: TStringField;
    wwtAuditCurPurchBaseU: TFloatField;
    Panel1: TPanel;
    btnPrint: TBitBtn;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Bevel1: TBevel;
    RxCalculator1: TRxCalculator;
    FBoxCnt: TComboBox;
    FBoxSC: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    wwFind: TwwLocateDialog;
    wwtAuditCurACount: TStringField;
    wwtAuditCurWasteTill: TFloatField;
    wwtAuditCurWastePC: TFloatField;
    wwtAuditCurWastage: TFloatField;
    wwtAuditCurWasteTillA: TFloatField;
    wwtAuditCurWastePCA: TFloatField;
    Bevel2: TBevel;
    rbExpOnly: TRadioButton;
    rbExpSite: TRadioButton;
    rbAll: TRadioButton;
    Bevel3: TBevel;
    Label5: TLabel;
    wwtAuditCurHzID: TSmallintField;
    wwtAuditCurMoveQty: TFloatField;
    wwtAuditCurShouldBe: TSmallintField;
    hzTabs: TPageControl;
    hzTab0: TTabSheet;
    dbtEntCode: TDBText;
    Bevel4: TBevel;
    btnClearAudit: TBitBtn;
    Op1: TOpenDialog;
    Save1: TSaveDialog;
    lblFormat: TLabel;
    btnSaveChanges: TBitBtn;
    btnAbandon: TBitBtn;
    btnMultiUnit: TBitBtn;
    btnCalculator: TBitBtn;
    btnWastage: TBitBtn;
    pnlRO: TPanel;
    Label6: TLabel;
    btnAutoFill: TBitBtn;
    btnImpCounts: TBitBtn;
    btnExpCounts: TBitBtn;
    Bevel5: TBevel;
    LabelSearch: TLabel;
    wwSearch1: TwwIncrementalSearch;
    PanelRadioButtonSearch: TPanel;
    RadioButtonName: TRadioButton;
    RadioButtonImpExRef: TRadioButton;
    adoqImpExRefSearch: TADOQuery;
    EditImpExRefSearch: TEdit;
    wwtAuditCurPurchCostPU: TFloatField;
    wwtAuditCurNomPricePU: TFloatField;
    rbMustCountOnly: TRadioButton;
    wwtAuditCurMustCount: TBooleanField;
    procedure FormShow(Sender: TObject);
    procedure btnSaveChangesClick(Sender: TObject);
    procedure SaveAudit;
    procedure FormCreate(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure wwtAuditCurOpStkGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure wwGrid1RowChanged(Sender: TObject);
    procedure btnMultiUnitClick(Sender: TObject);
    procedure btnCalculatorClick(Sender: TObject);
    procedure wwGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FBoxSCCloseUp(Sender: TObject);
    procedure FBoxCntCloseUp(Sender: TObject);
    procedure wwSearch1AfterSearch(Sender: TwwIncrementalSearch;
      MatchFound: Boolean);
    procedure FBoxSCKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FBoxCntKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FBoxSCKeyPress(Sender: TObject; var Key: Char);
    procedure FBoxCntKeyPress(Sender: TObject; var Key: Char);
    procedure wwtAuditCurAfterScroll(DataSet: TDataSet);
    procedure wwtAuditCurBeforePost(DataSet: TDataSet);
    procedure wwtAuditCurBeforeRefresh(DataSet: TDataSet);
    procedure wwtAuditCurAfterPost(DataSet: TDataSet);
    procedure wwtAuditCurAfterEdit(DataSet: TDataSet);
    procedure btnWastageClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure wwGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure hzTabsChange(Sender: TObject);
    procedure rbExpOnlyClick(Sender: TObject);
    procedure wwGrid1Exit(Sender: TObject);
    procedure lblFormatDblClick(Sender: TObject);
    procedure LabelSearchDblClick(Sender: TObject);
    procedure WMSysCommand(var Msg: TWMSysCommand);
    message WM_SYSCOMMAND;
    procedure btnClearAuditClick(Sender: TObject);
    procedure btnAutoFillClick(Sender: TObject);
    procedure wwtAuditCurAfterOpen(DataSet: TDataSet);
    procedure btnImpCountsClick(Sender: TObject);
    procedure Label5DblClick(Sender: TObject);
    procedure btnExpCountsClick(Sender: TObject);
    procedure RadioButtonSearchClick(Sender: TObject);
  private
    { Private declarations }
    prevRec : integer;
    ShowClosePrompt: boolean;
    sqMain, sqSub, sqOrd, sqView, sqNoOrder: string;
    FSearchText: String;
    FMidwordPartialRequeryRequired: Boolean;

    procedure AutoAudit(const treatNegativeAsZero: Boolean = false; const blindAutoAudit: Boolean = false);
    procedure ChangeSQL;
    procedure MsgIfNoProducts;

    procedure SaveStockAudit;
    procedure SaveLineCheckAudit;
    procedure SavePartialAudit(AAllowAbort: boolean; ShowConfirmation: boolean = true);
    procedure SaveFullAudit(AAllowAbort: boolean; ShowConfirmation: boolean = true);
    procedure FindNextImpExRef;
  public
    { Public declarations }
    showb1, showb2, showb3, isLC: boolean;
    curhzname : string;
  end;

var
  fAudit: TfAudit;

implementation

uses udata1, uADO, uRepSP, uAud1Pr, uWasteAdj, uNewAudit, uLC, uCurrdlg, uLog, uNegativeTheoStockWarning,
uAutoFillStockConfirmation;

{$R *.DFM}

procedure TfAudit.ChangeSQL;
begin
  if wwtAuditCur.State = dsEdit then
    wwtAuditCur.Post;
  wwtAuditCur.DisableControls;

  with wwtAuditCur do
  begin
    close;
    sql.Clear;

    sql.Add(sqMain);

    // set the desired hz first (0 for byHZ=False, else use the TabIndex. This gives the WHERE...)
    if isLC then
    begin // create a"dummy" Where to enable the rest of the query to just use AND in safety...
      sql.Add('WHERE hzid < 1000');
    end
    else
    begin
      if data1.curByHZ then
      begin
        sql.Add('WHERE hzid = ' + inttostr(hztabs.ActivePage.Tag));
      end
      else
      begin
        sql.Add('WHERE hzid = 0');
      end;
    end;


    if sqSub <> '' then
    begin
      sql.Add('AND ' + sqSUB);
    end;

    // what should I show???
    sqView := '';

    if rbMustCountOnly.Checked then
    begin
      sqView := 'AND (MustCount = 1)';
    end
    else if rbExpOnly.Checked then  // also show Must Count items even if not expected...
    begin
      sqView := 'AND (("OpStk" <> 0) or ("MoveQty" <> 0) or (("PurchStk" <> 0) and ("PurchStk" <> -999999))' +
        ' or ("ThRedQty" <> 0) or ("ThCloseStk" <> 0) or ("ActCloseStk" <> 0) or ("WasteTill" <> 0)' +
        ' or ("WastePC" <> 0) or ("Wastage" <> 0) OR (MustCount = 1)';
      if data1.IncludePrepItemsInAudit then
        sqView := sqView +  ' or ((shouldbe = 0) and ("PurchStk" = -999999))';
      sqView := sqView + ')';
    end
    else if (rbExpSite.Visible) and (rbExpSite.Checked) then
    begin
      sqView := 'AND (("OpStk" <> 0) or ("MoveQty" <> 0) or (("PurchStk" <> 0) and ("PurchStk" <> -999999))' +
        ' or ("ThRedQty" <> 0) or ("ThCloseStk" <> 0) or ("ActCloseStk" <> 0) or ("WasteTill" <> 0)' +
        ' or ("WastePC" <> 0) or ("Wastage" <> 0) or (shouldbe = 2) OR (MustCount = 1))';
    end;

    if not isLC then
      sql.Add(sqView);

    sqNoOrder := sql.Text;
    sql.Add(sqOrd);

    open;
  end;

  wwtAuditCur.EnableControls;
end; // procedure..


procedure TfAudit.FormShow(Sender: TObject); // process No. 3.1.2
var
  newTab : TTabSheet;
  Offset: Integer;
  haveMustCountItems: boolean;
begin
  ShowClosePrompt := TRUE;

  Offset := 0;

  if not isLC then  // stock Audit
  begin
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select count(*) as items from [auditcur] where MustCount = 1');
      open;
      haveMustCountItems := (FieldByName('items').asinteger > 0);
      close;
    end;

    if data1.curByHZ then
    begin
      // use the HZtabs but first make them up...
      with dmADO.adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('select hzid, hzname, epur, eSales from stkHZs where Active = 1 order by hzid');
        open;

        while not eof do
        begin
          NewTab := TTabSheet.Create(hzTabs);
          NewTab.PageControl := hzTabs;
          newTab.Tag := FieldByName('hzid').asinteger;
          newTab.PageIndex := recNo;
          newTab.Caption := FieldByName('hzname').asstring;
          newTab.ImageIndex := -1;

          if FieldByName('esales').asboolean then
          begin
            if FieldByName('epur').asboolean then
              newTab.ImageIndex := 2
            else
              newTab.ImageIndex := 0
          end
          else
          begin
            if FieldByName('epur').asboolean then
              newTab.ImageIndex := 1;
          end;

          next;
        end;

        close;
      end;

      hzTabs.Visible := True;
      hzTabs.ActivePageIndex := 1;

      sqMain := 'select [HzID], [EntityCode], [SubCat], [ImpExRef], [Name], [OpStk],' + #13 + // [PurchStk], [MoveQty],
          '[ThRedQty], [ThCloseStk], [ActCloseStk], [PurchUnit], [PurchBaseU], [ACount], ' + #13 +
          '[WasteTill], [WastePC], [WasteTillA], [WastePCA], [Wastage], [ShouldBe], ' + #13 +
          '(purchstk + moveqty) as PurchStk, moveQty, PurchCostPU, NomPricePU, MustCount from AuditCur';
      sqSub := '';
      sqOrd := 'Order By "SubCat", "Name"';

      rbExpOnly.Visible := True;
      rbExpSite.Visible := True;
      rball.Visible := True;

      if haveMustCountItems then
      begin
        rbMustCountOnly.Visible := True;
        rbMustCountOnly.Checked := True;
        rbMustCountOnly.Top := 4;
        rbExpOnly.Top := 19;
        rbExpSite.Top := 34;
        rball.Top := 49;
      end
      else
      begin
        rbMustCountOnly.Visible := False;
        rbExpOnly.Top := 9;
        rbExpSite.Top := 27;
        rball.Top := 45;
      end;

      rbExpOnly.Caption := 'Holding Zone Expected Items Only';

      ChangeSQL;
    end
    else
    begin
      // DO NOT show the HZtabs...

      hzTabs.TabIndex := 0;
      hzTabs.Visible := False;

      sqMain := 'select * from AuditCur';
      sqSub := '';
      sqOrd := 'Order By "SubCat", "Name"';

      rbExpOnly.Visible := True;
      rbExpSite.Visible := False;
      rball.Visible := True;

      if haveMustCountItems then
      begin
        rbMustCountOnly.Visible := True;
        rbMustCountOnly.Checked := True;
        rbMustCountOnly.Top := 9;
        rbExpOnly.Top := 27;
        rball.Top := 45;
      end
      else
      begin
        rbMustCountOnly.Visible := False;
        rbExpOnly.Checked := True;
        rbExpOnly.Top := 16;
        rball.Top := 38;
      end;

      rbExpOnly.Caption := 'Show Expected Items Only';

      ChangeSQL;
    end;


    if data1.curFillClose then
    begin
      with wwGrid1, wwGrid1.DataSource.DataSet do   // grid field names, etc...
      begin
        DisableControls;
        Selected.Clear;

        if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
          Selected.Add('SubCat'#9'20'#9'Sub-Category'#9'F')
        else
          Selected.Add('SubCat'#9'20'#9'Category'#9'F');

        Selected.Add('Name'#9'40'#9'Name'#9#9);

        if data1.curShowImpExpRef then
        begin
          Selected.Add('ImpExRef'#9'20'#9'Import/Export Reference'#9'F');
          FixedCols := FixedCols + 1;
        end;

        Selected.Add('PurchUnit'#9'11'#9'Unit'#9'F');
        Selected.Add('OpStk'#9'11'#9'Open ' + data1.SSsmall + ''#9'F');

        if data1.curByHZ then
          Selected.Add('PurchStk'#9'11'#9'Purch/Transf'#9'F')
        else
          Selected.Add('PurchStk'#9'11'#9'Purch ' + data1.SSsmall + ''#9'F');

        Selected.Add('ThRedQty'#9'10'#9'Th. Reduct.'#9'F');
        Selected.Add('ThCloseStk'#9'10'#9'Th. Close ' + data1.SSsmall + ''#9'F');
        Selected.Add('Wastage'#9'11'#9'Wastage'#9'F');
        Selected.Add('ACount'#9'13'#9'Audit ' + data1.SSbig + ''#9'F');

        wwgrid1.ApplySelected;
        btnAutoFill.Visible := not data1.curHideFillAudit;

        EnableControls;
      end;
    end
    else
    begin
      with wwGrid1, wwGrid1.DataSource.DataSet do   // grid field names, etc...
      begin
        DisableControls;
        Selected.Clear;

        FixedCols := 6;

        if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
          Selected.Add('SubCat'#9'20'#9'Sub-Category'#9'F')
        else
          Selected.Add('SubCat'#9'20'#9'Category'#9'F');

        Selected.Add('Name'#9'40'#9'Name'#9#9);

        if data1.curShowImpExpRef then
        begin
          Selected.Add('ImpExRef'#9'20'#9'Import/Export Reference'#9'F');
          FixedCols := FixedCols + 1;
        end;

        Selected.Add('PurchUnit'#9'11'#9'Unit'#9'F');
        Selected.Add('OpStk'#9'11'#9'Open ' + data1.SSsmall + ''#9'F');
        if data1.curByHZ then
          Selected.Add('PurchStk'#9'11'#9'Purch/Transf'#9'F')
        else
          Selected.Add('PurchStk'#9'11'#9'Purch ' + data1.SSsmall + ''#9'F');
        Selected.Add('Wastage'#9'11'#9'Wastage'#9'F');
        Selected.Add('ACount'#9'13'#9'Audit ' + data1.SSbig + ''#9'F');

        wwgrid1.ApplySelected;

        // set form size, and buttons position
        Offset := 130;
        btnAutoFill.Visible := False;

        EnableControls;
      end;
    end;
    btnWastage.Visible := data1.curWasteAdj;
    self.Caption := 'Audit ' + data1.SSbig + ' - Fill in the ' + data1.SSbig + ' Count for each item';
  end
  else    // LINE CHECK mode
  begin
    rbMustCountOnly.Visible := False;
    rbExpOnly.Visible := false;
    rbExpSite.Visible := false;
    rball.Visible := false;

    sqMain := 'select *, cast(case se.ETCode when ''P'' then 1 else 0 end as bit) as IsPreparedItem' +#13#10 +
              'from AuditCur ac ' +#13#10 +
              'join stkEntity se ' +#13#10 +
              'on ac.EntityCode = se.EntityCode';
    sqSub := '';
    sqOrd := 'Order By "SubCat", "Name"';

    ChangeSQL;

    if NOT fLC.curLCblind then  // NOT Blind...
    begin
      with wwGrid1, wwGrid1.DataSource.DataSet do   // grid field names, etc...
      begin
        DisableControls;
        Selected.Clear;

        if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
          Selected.Add('SubCat'#9'20'#9'Sub-Category'#9'F')
        else
          Selected.Add('SubCat'#9'20'#9'Category'#9'F');

        Selected.Add('Name'#9'40'#9'Name'#9#9);

        if data1.curShowImpExpRef then
        begin
          Selected.Add('ImpExRef'#9'20'#9'Import/Export Reference'#9'F');
          FixedCols := FixedCols + 1;
        end;

        Selected.Add('PurchUnit'#9'11'#9'Unit'#9'F');
        Selected.Add('OpStk'#9'11'#9'Base ' + data1.SSsmall + ''#9'F');
        Selected.Add('PurchStk'#9'11'#9'Purch ' + data1.SSsmall + ''#9'F');
        Selected.Add('ThRedQty'#9'10'#9'Th. Reduct.'#9'F');
        Selected.Add('ThCloseStk'#9'10'#9'Prev Variance'#9'F');
        Selected.Add('Wastage'#9'11'#9'Th. Level'#9'F');
        Selected.Add('ACount'#9'13'#9'Audit ' + data1.SSbig + ''#9'F');

        wwgrid1.ApplySelected;
        btnSaveChanges.Caption := 'Continue';
        btnAbandon.Caption := 'Cancel LC';

        EnableControls;
      end;
    end
    else                     // Blind...
    begin
      with wwGrid1, wwGrid1.DataSource.DataSet do   // grid field names, etc...
      begin
        DisableControls;
        Selected.Clear;

        FixedCols := 5;//6;

        if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
          Selected.Add('SubCat'#9'20'#9'Sub-Category'#9'F')
        else
          Selected.Add('SubCat'#9'20'#9'Category'#9'F');

        Selected.Add('Name'#9'40'#9'Name'#9#9);

        if data1.curShowImpExpRef then
        begin
          Selected.Add('ImpExRef'#9'20'#9'Import/Export Reference'#9'F');
          FixedCols := FixedCols + 1;
        end;

        Selected.Add('PurchUnit'#9'11'#9'Unit'#9'F');
        Selected.Add('OpStk'#9'11'#9'Base ' + data1.SSsmall + ''#9'F');
        Selected.Add('PurchStk'#9'11'#9'Purch ' + data1.SSsmall + ''#9'F');
        //Selected.Add('Wastage'#9'11'#9'Wastage'#9'F');
        Selected.Add('ACount'#9'13'#9'Audit ' + data1.SSbig + ''#9'F');

        wwgrid1.ApplySelected;

        // set form size, and buttons position
        Offset := 130;

        btnSaveChanges.Caption := 'Commit LC';
        btnAbandon.Caption := 'Cancel LC';

        EnableControls;
      end;
    end;

    if curHZname <> '' then
      self.Caption := 'Line Check Audit for "' + curHZname +
        '" Holding Zone - Fill in the ' + data1.SSbig + ' Count for each item'
    else
      self.Caption := 'Line Check Audit - Fill in the ' + data1.SSbig + ' Count for each item';

    btnAutoFill.Visible := False;
    btnWastage.Visible := False;
    label1.Visible := False;
    checkbox1.Visible := False;
  end;

  //Resize the form to cater for the optional columns.
  if offset = 0 then
    fAudit.Constraints.MinWidth := 920
  else
    fAudit.Constraints.MinWidth := 790;

  if not data1.curShowImpExpRef then
    Offset := Offset + 123;
  fAudit.Width := fAudit.Width - Offset;

  if not data1.curShowImpExpRef then
  begin
    LabelSearch.Caption := 'Name Search (Next = F3)';
    PanelRadioButtonSearch.Visible := False;
    wwSearch1.Width := 324;
  end;

  if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
  begin
    label3.Caption := 'Sub-Categ.';
  end
  else
  begin
    label3.Caption := 'Category';
  end;

  label4.Caption := 'Audit ' + data1.SSsmall;

  FBoxSC.Items.Clear;
  fBoxSC.Items.Add('Show All');

  with data1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct [subcat] from [auditcur]');
    open;

    while not eof do
    begin
      fBoxSC.Items.Add(FieldByName('subCat').asstring);
      next;
    end;
    close;
  end;

  FBoxSC.ItemIndex := 0;
  FBoxCnt.ItemIndex := 0;

  // Help ID's
  if not isLC then  // STOCKS
  begin
    if data1.curByHZ then                  // By HZ
    begin
      if data1.curFillClose then  // NORMAL
      begin
        self.HelpContext := 1024;
      end
      else                        // BLIND
      begin
        self.HelpContext := 1025;
      end;
    end
    else                          // By Site
    begin                                                   
      if data1.curFillClose then  // NORMAL                 
      begin                                                 
        self.HelpContext := 1008;
      end                                                   
      else                        // BLIND                  
      begin
        self.HelpContext := 1021;
      end;
    end;
  end
  else              // LCs         // LCs
  begin
    if data1.curByHZ then                   // By HZ
    begin
      if NOT fLC.curLCblind then   // NORMAL
      begin
        self.HelpContext := 1026;
      end
      else                         // BLIND
      begin
        self.HelpContext := 1027;
      end;
    end
    else                           // By Site
    begin
      if NOT fLC.curLCblind then   // NORMAL
      begin
        self.HelpContext := 1022;
      end
      else                         // BLIND
      begin
        self.HelpContext := 1023;
      end;
    end;
  end; //if.. then.. else..
end;

///////////  MH  //////////////////////////////////////////////////////////////
//  Date: 27 apr 1999
//  Inputs: None
//  Outputs: None
//  Globals (R): None
//  Globals (W): None
//  Objects used: None
//
//
//
///////////////////////////////////////////////////////////////////////////////
procedure TfAudit.btnSaveChangesClick(Sender: TObject);
begin
  if wwtAuditCur.State = dsEdit then
    wwtAuditCur.Post;

  if isLC then// LINE CHECK Audit
  begin
    if wwtAuditCur.Locate('ActCloseStk',null,[]) then
      ShowMessage('You cannot continue with the Line Check until all figures have been entered.')
    else
    begin
      if fLC.curLCblind then
      begin
        ShowClosePrompt := FALSE;
        ModalResult := mrOK;
      end
      else
        SaveLineCheckAudit;
    end;
  end
  else  // STOCK Audit
  begin
    if (data1.curByHz) then
    begin
      // sum-up, place in the hzid = 0, fill ACount for it...
      with data1.adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('update auditcur set ActCloseStk = sq.ActCloseStk, wastetilla = sq.wastetilla,');
        sql.Add('  wastepca = sq.wastepca, wastage = sq.wastage');
        sql.Add('from');
        sql.Add('  (select a.entitycode, sum(a.ActCloseStk) as ActCloseStk,');
        sql.Add('    sum(a.wastetilla) as wastetilla, sum(a.wastepca) as wastepca, sum(a.wastage) as wastage');
        sql.Add('   from auditcur a where a.hzid > 0');
        sql.Add('   group by a.entitycode) sq');
        sql.Add('where auditcur.hzid = 0 and auditcur.entitycode = sq.entitycode');
        execSQL;

        close;
        sql.Clear;
        sql.Add('select * from AuditCur where hzid = 0');
        open;

        while not eof do
        begin
          //import the floats in the string field
          edit;
          if FieldByName('ActCloseStk').asstring = '' then
            FieldByName('ACount').AsString := ''
          else
            FieldByName('ACount').AsString :=
              data1.dozGallFloatToStr(FieldByName('PurchUnit').asstring, FieldByName('ActCloseStk').asfloat);
          post;
          next;
        end;
        close;
      end;
    end;

    SaveStockAudit;
  end;
end;

procedure TfAudit.SaveStockAudit;
var
  PartiallyEnteredAudit: boolean;
  NegativeTheoCloseProducts: TStringList;
  NegativeTheoStockWarningForm: TfNegativeTheoStockWarning;
  AutoFillConfirmationForm: TfAutoFillStockConfirmation;
  ConfirmationFormResult, emptyMustCountItems: Integer;
  s1 : string;
begin
  if (data1.curByHz) then
  begin
    with data1.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from AuditCur where ActCloseStk is NULL and shouldbe = 0');
      Open;
      PartiallyEnteredAudit := RecordCount > 0;
      Close;
    end;
  end
  else
    PartiallyEnteredAudit := wwtAuditCur.Locate('ActCloseStk',null,[]);

  if PartiallyEnteredAudit and data1.curAutoFillBlankCounts and not data1.curFillClose then
  begin
    // check to see if any Must Count items are left unfilled manually and offer to Save or Cancel...
    // only expected Must Count items must be filled manually...
    with data1.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from AuditCur where ActCloseStk is NULL and shouldbe = 0 and MustCount = 1');
      if (data1.curByHz) then
        SQL.Add(' and hzid > 0');
      Open;

      emptyMustCountItems := RecordCount;
      close;
    end;

    if emptyMustCountItems > 0 then
    begin
      if emptyMustCountItems = 1 then
        s1 := 'This ' + data1.SSlow + ' requires you to manually fill in a Count for a set list of items.' +
          #13 + 'There is 1 "Must Count" item still empty, so the current ' + data1.SSlow +
          ' cannot be continued.' + #13 + 'Do you want to save your entries so far and leave the Audit screen?'
      else
        s1 := 'This ' + data1.SSlow + ' requires you to manually fill in a Count for a set list of items.' +
          #13 + 'There are '+ inttostr(emptyMustCountItems) +' "Must Count" items still empty, so the current ' +
          data1.SSlow + ' cannot be continued.' + #13 +
          'Do you want to save your entries so far and leave the Audit screen?';

      if (MessageDlg(s1, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      begin
        SaveAudit;
        data1.UpdateCurrStage(2); // stage 2 = stage 1 + some audit figs saved.
        ModalResult := mrCancel;
        ShowClosePrompt := FALSE;
      end;
    end
    else  // either no template or no -expected- Must Count items are empty so go on with the autofill...
    begin
      AutoFillConfirmationForm := TfAutoFillStockConfirmation.Create(self);
      try
        ConfirmationFormResult := AutoFillConfirmationForm.ShowModal;
      finally
        AutoFillConfirmationForm.Free;
      end;

      if ConfirmationFormResult = ord(mrSaveStock) then
      begin
        SavePartialAudit(showb2, false);
      end
      else if ConfirmationFormResult = ord(mrAutoComplete) then
      begin
        NegativeTheoCloseProducts := data1.GetNegativeTheoCloseProducts;
        NegativeTheoStockWarningForm := TfNegativeTheoStockWarning.CreateWithProductList(self, NegativeTheoCloseProducts);
        try
          if NegativeTheoCloseProducts.Count <> 0 then
          begin
            if NegativeTheoStockWarningForm.ShowModal <> mrYes then
            begin
              exit;
            end;
          end;
          AutoAudit(true, true);
          SaveFullAudit(showb2, false);
        finally
          NegativeTheoCloseProducts.Free;
          NegativeTheoStockWarningForm.Free;
        end;
      end;
    end;
  end
  else if PartiallyEnteredAudit then
  begin
    SavePartialAudit(showb2);
  end
  else
    SaveFullAudit(showb2);
end;

procedure TfAudit.SaveLineCheckAudit;
begin
  fLC.PostAuditCalc; // save to stkCrDiv, do final calculations.
  fLC.PrintRep;      // print report.

  if MessageDlg('Do you wish to save this Line Check and exit?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    fLC.StoreLC;
    ShowClosePrompt := FALSE;
    ModalResult := mrOK;
  end;
end;

procedure TfAudit.SavePartialAudit(AAllowAbort: boolean; ShowConfirmation: boolean = true);
begin
  if AAllowAbort then
  begin
    if not ShowConfirmation or (MessageDlg('Not all audit figures have been entered, so the current ' + data1.SSlow +
          ' cannot be continued.' + #13 + 'Do you wish to leave the Audit screen?',
          mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      SaveAudit;
      data1.UpdateCurrStage(2); // stage 2 = stage 1 + some audit figs saved.
      ModalResult := mrCancel;
      ShowClosePrompt := FALSE;
    end;
  end
  else
    ShowMessage('You cannot continue with the ' + data1.SSlow + ' until all figures have been entered.');
end;

procedure TfAudit.SaveFullAudit(AAllowAbort: boolean; ShowConfirmation: boolean = true);
var
  DialogResult  : integer;
  DialogButtons : TMsgDlgButtons;
begin
  if AAllowAbort then
    DialogButtons := [mbYes, mbNo, mbCancel]
  else
    DialogButtons := [mbYes, mbCancel];

  if not ShowConfirmation then
    DialogResult := mrYes
  else
    DialogResult := MessageDlg('Do you wish to proceed with the ' + data1.SSlow + '?',
      mtConfirmation, DialogButtons, 0);

  case DialogResult of
    mrYes:
      begin
        log.event('fAudit.SaveFullAudit, User selected to proceed with the Audit');
        SaveAudit;
        data1.UpdateCurrStage(2); // stage 2 = stage 1 + some audit figs saved

        // go back to main and call uDataProc for rest of stock processing...
        ModalResult := mrOK;
        ShowClosePrompt := FALSE;
      end;
    mrNo:
      begin
        // stop/save & go back to main menu
        SaveAudit;
        data1.UpdateCurrStage(2); // stage 2 = stage 1 + some audit figs saved.

        ModalResult := mrCancel;
        ShowClosePrompt := FALSE;
      end;
  end;
end;

// fill empty cells with th closing stock
procedure TfAudit.AutoAudit(const treatNegativeAsZero: Boolean = false; const blindAutoAudit: boolean = false);
begin
  if (not isLC) then
  begin
    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('update [auditcur] set actclosestk = thclosestk');
      if blindAutoAudit then
        sql.Add(', [CloseStkAutofilled] = 1');
      sql.Add('where actclosestk is NULL');
      sql.Add('and thclosestk >= 0');
      if hztabs.ActivePage.Tag > 0 then
        sql.Add('and hzid = ' + inttostr(hztabs.ActivePage.Tag));
      execSQL;

      close;
      sql.Clear;
      sql.Add('select * from AuditCur');
      if hztabs.ActivePage.Tag > 0 then
        sql.Add('where hzid = ' + inttostr(hztabs.ActivePage.Tag));
      open;

      while not eof do
      begin
        //import the floats in the string field
        edit;
        if treatNegativeAsZero
                and (FieldByName('thclosestk').AsFloat < 0)
                and (FieldByName('ActCloseStk').AsString = '') then
          FieldByName('ActCloseStk').AsFloat := 0;

        if FieldByName('ActCloseStk').asstring = '' then
          FieldByName('ACount').AsString := ''
        else
          FieldByName('ACount').AsString :=
                data1.dozGallFloatToStr(FieldByName('PurchUnit').asstring, FieldByName('ActCloseStk').asfloat);
        post;
        next;
      end;
      close;
    end;
    if not blindAutoAudit then
      wwtAuditCur.Requery;
  end;
end;

///////////  MH  //////////////////////////////////////////////////////////////
//  Date: 27 apr 1999
//  Inputs: None
//  Outputs: None
//  Globals (R): None
//  Globals (W): None
//  Objects used: None
//
//
//
///////////////////////////////////////////////////////////////////////////////
procedure TfAudit.SaveAudit;
var
  stringDT : string;

procedure StoreAuditChanges(fieldName, stringName: string);
  begin
    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('Insert INTO stkQtyChanges ([SiteCode], [Tid], [StkCode], [HzID], [FieldChanged], [CalcDateTime], ');
      sql.Add('  [EntityCode], [OldQty], [NewQty], [PurchUnit], [PurchBaseU], [ChangedBy])');
      sql.Add('SELECT a.[SiteCode], a.tid, a.StkCode, b.HzID,');
      sql.Add(  stringName + ', ' + stringDT + ', a.[EntityCode], a.['+ fieldName +'], b.['+ fieldName +'], ');
      sql.Add(' b.[PurchUnit], b.[PurchBaseU], ' + quotedStr(CurrentUser.UserName) + ' as ChangedBy');
      sql.Add('FROM Audit a, AuditCur b');
      sql.Add('WHERE a.HzID = b.HzID AND a.[EntityCode] = b.[EntityCode]');
      sql.Add('  AND a.['+ fieldName +'] <> b.['+ fieldName +'] ');
      sql.Add('  AND a.StkCode = '+IntToStr(data1.StkCode));
      sql.Add('  AND a.tid = '+IntToStr(data1.curtid));
      sql.Add('  AND a.SiteCode = ' +IntToStr(data1.TheSiteCode));
      sql.Add('  AND a.PurchBaseU = b.PurchBaseU');
      ExecSQL;

      // now handle cases where the Purchase Base Unit has changed between calculations...
      close;
      sql.Clear;
      sql.Add('Insert INTO stkQtyChanges ([SiteCode], [Tid], [StkCode], [HzID], [FieldChanged], [CalcDateTime], ');
      sql.Add('  [EntityCode], [OldQty], [NewQty], [PurchUnit], [PurchBaseU], [ChangedBy])');
      sql.Add('SELECT a.[SiteCode], a.tid, a.StkCode, b.HzID,');
      sql.Add(  stringName + ', ' + stringDT + ', a.[EntityCode], ');
      sql.Add(  '(a.['+ fieldName +'] * a.PurchBaseU / b.PurchBaseU), b.['+ fieldName +'], ');
      sql.Add(' b.[PurchUnit], b.[PurchBaseU], ' + quotedStr(CurrentUser.UserName) + ' as ChangedBy');
      sql.Add('FROM Audit a, AuditCur b');
      sql.Add('WHERE a.HzID = b.HzID AND a.[EntityCode] = b.[EntityCode]');
      sql.Add('  AND ABS((a.['+ fieldName +'] * a.PurchBaseU / b.PurchBaseU) - b.['+ fieldName +']) >= 0.01');
      sql.Add('  AND a.StkCode = '+IntToStr(data1.StkCode));
      sql.Add('  AND a.tid = '+IntToStr(data1.curtid));
      sql.Add('  AND a.SiteCode = ' +IntToStr(data1.TheSiteCode));
      sql.Add('  AND a.PurchBaseU <> b.PurchBaseU');
      ExecSQL;
    end;
  end;

begin
 log.event('In fAudit.SaveAudit, ThreadId = ' + IntToStr(data1.curtid) +
   ' StockCode = ' + IntToStr(data1.StkCode));
 with data1.adoqRun do
  begin

    // 340635 - compare selected fields and store changes...

    stringDT := quotedStr(formatDateTime('yyyymmdd hh:nn:ss', Now));

    if Assigned(fcurrDlg) and (fCurrDlg.astage >= 3) then // ONLY if this stock was fully calculated ...
    begin
      // store that a fresh Calculation was done
      close;
      sql.Clear;
      sql.Add('Insert INTO stkQtyChanges ([SiteCode], [Tid], [StkCode], [HzID], [FieldChanged], [CalcDateTime], [ChangedBy])');
      sql.Add('VALUES ('+IntToStr(data1.TheSiteCode)+', '+IntToStr(data1.curtid)+',');
      sql.Add('  '+IntToStr(data1.StkCode)+', -1, ''Stock Re-Calculation'',');
      sql.Add('  ' + stringDT + ', '+ quotedStr(CurrentUser.UserName) + ')');
      ExecSQL;

      // available [Audit] qty fields: [OpStk], [PurchStk], [MoveQty], [ThRedQty], [ThCloseStk],
      //                               [ActCloseStk], [PurchUnit], [PurchBaseU],
      //                               [WasteTill], [WastePC], [WasteTillA], [WastePCA], [Wastage]

      StoreAuditChanges('ActCloseStk', QuotedStr('Audit Count'));
      StoreAuditChanges('WasteTillA', QuotedStr('Till Waste Adjustment'));
      StoreAuditChanges('WastePCA', QuotedStr('PC Waste Adjustment'));
      StoreAuditChanges('MoveQty', QuotedStr('HZ Internal Transfer'));
      StoreAuditChanges('PurchStk', QuotedStr('Purchase Qty'));
    end
    else  // this stock was NOT fully calcualted before
    begin
      // just store that a fresh Calculation was done, no details
      close;
      sql.Clear;
      sql.Add('Insert INTO stkQtyChanges ([SiteCode], [Tid], [StkCode], [HzID], [FieldChanged], [CalcDateTime], [ChangedBy])');
      sql.Add('VALUES ('+IntToStr(data1.TheSiteCode)+', '+IntToStr(data1.curtid)+',');
      sql.Add('  '+IntToStr(data1.StkCode)+', -1, ''Stock Calculation'',');
      sql.Add('  ' + stringDT + ', '+ quotedStr(CurrentUser.UserName) + ')');
      ExecSQL;
    end;

    // delete recs from Audit that will be replaced by insert...
    close;
    sql.Clear;
    sql.Add('delete from [audit] where stkCode = ' + IntToStr(data1.StkCode));
    sql.Add('and tid = '+IntToStr(data1.curtid));
    sql.Add('');
    // the Append part
    sql.Add('insert into [Audit] ([SiteCode], [tid],[StkCode], hzid, [entitycode], [name], [subcat],');
    sql.Add('[ImpExRef], [OpStk], [PurchStk], [ThRedQty],');
    sql.Add('[ThCloseStk], [ActCloseStk], [CloseStkAutofilled], [purchunit], [purchbaseU],');
    sql.Add('[wastetill], [wastetillA], [wastepc], [wastepcA], [wastage], moveqty, LMDT)');
    sql.Add('SELECT '+IntToStr(data1.TheSiteCode)+', (' + IntToStr(data1.curtid)+') as tid, (' + IntToStr(data1.StkCode)+') as StkCode,');
    sql.Add('a.hzid, a."entitycode", a."name", a."subcat",');
    sql.Add('a."ImpExRef", a."OpStk", a."PurchStk",');
    sql.Add('a."ThRedQty", a."ThCloseStk",');
    sql.Add('a."ActCloseStk", a."CloseStkAutofilled", a."purchunit", a."purchbaseU",');
    sql.Add('a.[wastetill], a.[wastetillA], a.[wastepc], a.[wastepcA], a.[wastage], moveqty');
    sql.Add( ',' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) );
    sql.Add('FROM "AuditCur" a where a."ActCloseStk" is NOT NULL');
    execSQL;
  end; // with..
  
  log.event('Exiting fAudit.SaveAudit');  
end; // procedure..


procedure TfAudit.FormCreate(Sender: TObject);
begin
  showb1 :=	True;
  showb2 := True;
  showb3 := True;
  isLC := False;

  lblFormat.Caption := '';
  if data1.curdozForm then
  begin
    lblFormat.Caption := 'D';
    if data1.curGallForm then
      lblFormat.Caption := lblFormat.Caption + #13 + 'G';
  end
  else
  begin
    if data1.curGallForm then
      lblFormat.Caption := 'G';
  end;

  if lblFormat.Caption = '' then
    lblFormat.Visible := False
  else
    lblFormat.Visible := True;

end;

procedure TfAudit.btnPrintClick(Sender: TObject);
var
  ix : smallint;
  ss : string;
begin
  if wwtAuditCur.State = dsEdit then
    wwtAuditCur.Post;

  if not isLC then
  begin
    fRepSP := TfRepSP.Create(Self);
    if checkbox1.Checked then
      fRepSP.pptTot.Visible := True;

    fRepSP.adoqCount.sql.Text := wwtAuditCur.sql.Text;

    if (wwtAuditCur.Filter <> '') and (wwtAuditCur.Filtered) then
    begin
      ss := StringReplace(wwtAuditCur.Filter, '= NULL', 'is NULL', [rfReplaceAll, rfIgnoreCase]);
      ix := fRepSP.adoqCount.sql.Count - 1;
      fRepSP.adoqCount.sql.Insert(ix,'AND (' + ss + ')');
    end;

    fRepSP.ppLabel23.Visible := (hzTabs.ActivePageIndex > 0);
    fRepSP.ppLabel23.Caption := 'For Holding Zone: ' + hzTabs.ActivePage.Caption;

    fRepSP.ACSprint(false); // sets the fields

    fRepSP.adoqCount.Open;
    fRepSP.ppCount.Print;
    fRepSP.adoqCount.Close;
    fRepSP.Free;
  end
  else
  begin
    flc.adoqCount.sql.Text := wwtAuditCur.sql.Text;
    if (wwtAuditCur.Filter <> '') and (wwtAuditCur.Filtered) then
    begin
      ss := StringReplace(wwtAuditCur.Filter, '= NULL', 'is NULL', [rfReplaceAll, rfIgnoreCase]);
      ix := flc.adoqCount.sql.Count - 1;
      flc.adoqCount.sql.Insert(ix,'AND (' + ss + ')');
    end;

    flc.adoqCount.Open;
    flc.ppCount.Print;
    flc.adoqCount.Close;
  end;
end;

procedure TfAudit.wwtAuditCurOpStkGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if sender.asstring = '' then
  begin
    Text := '';
    exit;
  end;

  if (sender.FieldName = 'PurchStk') then
  begin
    if (Sender.Asinteger >= -1099998) and (Sender.Asinteger <= -900000) then
    begin
      Text := ' Prep. Item ';
      exit;
    end;
  end;

  if (sender.FieldName = 'OpStk') then
  begin
    if Sender.Asinteger = -888888 then
    begin
      Text := ' New Item ';
      exit;
    end;
  end;

  // format dozens, gallons, normal floats...
  Text := data1.dozGallFloatToStr(wwtAuditCurPurchUnit.Value, sender.Asfloat);
end;

procedure TfAudit.wwGrid1RowChanged(Sender: TObject);
begin
  wwgrid1.PictureMasks.Strings[0] := 'ACount' + data1.setGridMask(wwtAuditCurPurchUnit.Value,'');
  FMidwordPartialRequeryRequired := True;
end;

procedure TfAudit.btnMultiUnitClick(Sender: TObject);
begin
  fAud1Pr := TfAud1Pr.Create(self);

  fAud1Pr.Top := self.Top;
  fAud1Pr.Left := self.Left;

  fAud1Pr.ShowModal;

  fAud1Pr.Free;
end;

procedure TfAudit.btnCalculatorClick(Sender: TObject);
begin
  // calculator
  rxCalculator1.Value := wwtAuditCur.FieldByName('ActCloseStk').asfloat;

  if not rxCalculator1.Execute then
    exit;

  if rxCalculator1.Value < 0 then
  begin
    showMessage('Audit levels smaller than ZERO are not permitted!');
  end
  else
  begin
    wwtAuditCur.edit;
    wwtAuditCur.FieldByName('ACount').asstring :=
      data1.dozGallFloatToStr(wwtAuditCur.FieldByName('PurchUnit').asstring, rxCalculator1.Value); //ttext;
    wwtAuditCur.post;
  end;
end;

procedure TfAudit.wwGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key in [VK_DOWN, VK_RETURN, VK_UP, VK_TAB] then
  begin

    if wwtAuditCur.State = dsEdit then
      wwtAuditCur.Post;

    wwtAuditCur.DisableControls;

    if wwtAuditCur.RecordCount > 0 then
    begin
      case key of
        VK_DOWN,
        VK_RETURN: begin //scroll down
                     wwtAuditCur.RecNo := wwtAuditCur.RecNo + 1;
                     //wwtAuditCur.Next;
                     //wwtAuditCur.Prior;
                   end;
           VK_UP : begin //scroll up
                     if wwtAuditCur.RecNo > 1 then
                       wwtAuditCur.RecNo := wwtAuditCur.RecNo - 1;
                   end;
          VK_TAB : begin
                     if ssShift in Shift then
                     begin // scroll up
                       if wwtAuditCur.RecNo > 1 then
                         wwtAuditCur.RecNo := wwtAuditCur.RecNo - 1;
                     end
                     else  // scroll down
                     begin
                       wwtAuditCur.RecNo := wwtAuditCur.RecNo + 1;
                     end;
                   end;
          else
             exit;
      end; // case..
    end;

    wwtAuditCur.EnableControls;

    key := 0;
    wwtAuditCurAfterScroll(nil);
  end;
end;

procedure TfAudit.FBoxSCCloseUp(Sender: TObject);
begin
  if FBoxSC.ItemIndex = 0 then
  begin
    sqSub := '';
  end
  else
  begin
    sqSub := 'SubCat = ' + quotedStr(FBoxSC.Items[FBoxSC.ItemIndex]);
  end;
  changeSQL;
  FMidwordPartialRequeryRequired := True;
end;

procedure TfAudit.FBoxCntCloseUp(Sender: TObject);
begin
  with wwtAuditCur do
  begin
    if state = dsEdit then
      Post;

    case FBoxCnt.ItemIndex of
      1: begin  //NULL
           Filter := 'ActCloseStk = NULL';
           Filtered := True;
         end;
      2: begin  // 0
           Filter := 'ActCloseStk = 0';
           Filtered := True;
         end;
      3: begin  // both
           Filter := '(ActCloseStk = NULL) OR (ActCloseStk = 0)';
           Filtered := True;
         end;
    else begin  // none
           Filter := '';
           Filtered := False;
         end;
    end; // case..
  end;

  MsgIfNoProducts;
end;

procedure TfAudit.wwSearch1AfterSearch(Sender: TwwIncrementalSearch;
  MatchFound: Boolean);
begin
  wwFind.FieldValue := wwSearch1.Text;
end;

procedure TfAudit.FBoxSCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  key := 0;
end;

procedure TfAudit.FBoxCntKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  key := 0;
end;

procedure TfAudit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (not isLC) and (data1.curByHz) and (hzTabs.ActivePageIndex = 0) then
  begin
    // keys should not operate...
  end
  else
  begin
    if btnMultiUnit.Enabled then
    begin
      if (btnWastage.Visible) and (Key = VK_F5) then
      begin
        btnWastageClick(Sender);
        Key := 0;
      end;

      if Key = VK_F6 then
      begin
        btnMultiUnitClick(Sender);
        Key := 0;
      end;
    end;

    if btnCalculator.Enabled then
    begin
      if Key = VK_F7 then
      begin
        btnCalculatorClick(Sender);
        Key := 0;
      end;
    end;
  end;

  if Key = VK_F3 then
  begin
    Key := 0;
    if RadioButtonImpExRef.Checked then
    begin
      FindNextImpExRef;
    end
    else begin
      if wwFind.FieldValue = '' then
        exit;
      wwFind.FindNext;
    end;
  end;
end;

procedure TfAudit.FBoxSCKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TfAudit.FBoxCntKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TfAudit.wwtAuditCurAfterScroll(DataSet: TDataSet);
begin
  if wwtAuditCur.RecordCount = 0 then
  begin
    btnMultiUnit.Enabled := False;
    btnCalculator.Enabled := False;
    btnWastage.Enabled := False;
    btnPrint.Enabled := False;
    wwgrid1.Enabled := False;
  end
  else
  begin
    wwgrid1.Enabled := true;
    btnCalculator.Enabled := true;
    btnPrint.Enabled := true;
    btnMultiUnit.Enabled := true;
    btnWastage.Enabled := not ((wwtAuditCur.FieldByName('purchstk').asinteger >= -1099998)
                               and (wwtAuditCur.FieldByName('purchstk').asinteger <= -900000)); // PrepItems

    wwgrid1.PictureMasks.Strings[0] := 'ACount' + data1.setGridMask(wwtAuditCurPurchUnit.Value,'');
  end;
end;

procedure TfAudit.wwtAuditCurBeforePost(DataSet: TDataSet);
begin
  if wwtAuditCur.FieldByName('ACount').asstring = '' then
  begin
    wwtAuditCur.FieldByName('ActCloseStk').asstring := '';
  end
  else
  begin
    wwtAuditCur.FieldByName('ActCloseStk').AsFloat :=
       data1.dozGallStrToFloat(wwtAuditCurPurchUnit.Value,wwtAuditCur.FieldByName('ACount').asstring);
  end;

  prevRec := wwtAuditCur.RecordCount;
end;

procedure TfAudit.wwtAuditCurBeforeRefresh(DataSet: TDataSet);
begin
  prevRec := wwtAuditCur.RecordCount;

end;

procedure TfAudit.wwtAuditCurAfterPost(DataSet: TDataSet);
begin
  MsgIfNoProducts;

  prevRec := wwtAuditCur.RecordCount;
end;

procedure TfAudit.wwtAuditCurAfterEdit(DataSet: TDataSet);
begin
  prevRec := wwtAuditCur.RecordCount;
end;

// wastage adjustment
procedure TfAudit.btnWastageClick(Sender: TObject);
begin
  fWasteAdj := TfWasteAdj.Create(self);

  fWasteAdj.Top := self.Top;
  fWasteAdj.Left := self.Left;

  fWasteAdj.ShowModal;

  fWasteAdj.Free;
end;

procedure TfAudit.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ShowClosePrompt then
  begin
    if not isLC then    // STOCK audit
    begin
      if MessageDlg('You are about to exit the Audit form. '+ #13+#10+
        'If you made any changes they will be lost.', mtConfirmation, [mbOK,mbCancel], 0) = mrOK then
        canClose := True
      else
        canClose := False;
    end
    else             // LINE CHECK audit
    begin
      if MessageDlg('You are about to cancel the current Line Check process!' + #13 + #13 +
        'Are you sure?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
        canClose := True
      else
        canClose := False;
    end;
  end;
end;

procedure TfAudit.wwGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if Field.FieldName = 'Wastage' then
  begin
    if (wwtAuditCurWasteTillA.asfloat <> 0) or (wwtAuditCurWastePCA.asfloat <> 0) then
    begin
      aFont.Style := [fsBold];
    end
    else
    begin
      aFont.Style := [];
    end;
  end
  else if (Field.FieldName = 'PurchStk') then
  begin
    if (Field.Asinteger >= -1099998) and (Field.Asinteger <= -900000) then
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
  else if (Field.FieldName = 'OpStk') then
  begin
    if Field.Asinteger = -888888 then
    begin
      aFont.Style := [fsBold];
      aFont.Color := clWhite;
      aBrush.Color := clBlue;
    end
    else if wwtAuditCur.FieldByName('shouldbe').asinteger = 1 then
    begin
      aFont.Style := [fsBold];
      aFont.Color := clWhite;
      aBrush.Color := clRed;
    end
    else if wwtAuditCur.FieldByName('shouldbe').asinteger = 2 then
    begin
      aFont.Style := [fsBold];
      aFont.Color := clWhite;
      aBrush.Color := clGreen;
    end
    else
    begin
      aFont.Style := [];
    end;
  end
  else if (Field.FieldName = 'Name') and (wwtAuditCur.FieldByName('MustCount').asboolean) then
  begin
    aFont.Color := clBlack;
    aBrush.Color := clYellow;
  end;
end;

procedure TfAudit.hzTabsChange(Sender: TObject);
begin
  if wwgrid1.DataSource.DataSet.State = dsEdit then
    wwgrid1.DataSource.DataSet.Post;

  if data1.curByHz and (not isLC) then
  begin
    if hzTabs.ActivePageIndex = 0 then
    begin // make read only, show label not buttons...

      // sum-up, place in the hzid = 0, fill ACount for it...
      with data1.adoqRun do
      begin
        dmADO.DelSQLTable('#ghost');
        close;
        sql.Clear;
        sql.Add('update auditcur set ActCloseStk = sq.ActCloseStk, wastetilla = sq.wastetilla,');
        sql.Add('  wastepca = sq.wastepca, wastage = sq.wastage');
        sql.Add('from');
        sql.Add('  (select a.entitycode, sum(a.ActCloseStk) as ActCloseStk,');
        sql.Add('    sum(a.wastetilla) as wastetilla, sum(a.wastepca) as wastepca, sum(a.wastage) as wastage');
        sql.Add('   from auditcur a where a.hzid > 0');
        sql.Add('   group by a.entitycode) sq');
        sql.Add('where auditcur.hzid = 0 and auditcur.entitycode = sq.entitycode');
        execSQL;

        close;
        sql.Clear;
        sql.Add('select * from AuditCur where hzid = 0');
        open;

        while not eof do
        begin
          //import the floats in the string field
          edit;
          if FieldByName('ActCloseStk').asstring = '' then
            FieldByName('ACount').AsString := ''
          else
            FieldByName('ACount').AsString :=
              data1.dozGallFloatToStr(FieldByName('PurchUnit').asstring, FieldByName('ActCloseStk').asfloat);
          post;
          next;
        end;
        close;
      end;

      ChangeSQL;

      wwGrid1.ReadOnly := True;
      pnlRO.Visible := True;
    end
    else
    begin
      ChangeSQL;
      wwGrid1.ReadOnly := False;
      pnlRO.Visible := False;
    end;
  end;
end;

procedure TfAudit.rbExpOnlyClick(Sender: TObject);
begin
  ChangeSQL;
end;

procedure TfAudit.wwGrid1Exit(Sender: TObject);
begin
  if wwgrid1.DataSource.DataSet.State = dsEdit then
    wwgrid1.DataSource.DataSet.Post;
end;

procedure TfAudit.lblFormatDblClick(Sender: TObject);
var
  s1, s2, s : string;
begin
  s1 := ' Dozen - [Doz' + data1.dozGalChar +
    'Units] where 1 Doz = 12 Units (e.g. "2' + data1.dozGalChar +
    '3 Dozen" means: 2 Dozen and 3 Units = 2 and 1/4 Dozen = 27 Units)';
  s2 := ' Gallon - [Gal' + data1.dozGalChar +
    'Pints] where 1 Gal = 8 Pints (e.g. "1' + data1.dozGalChar +
    '4 Gallon" means 1 Gallon and 4 Pints = 1 and 1/2 Gallon = 12 Pints)';
  if data1.curdozForm then
  begin
    s := s1;
    if data1.curGallForm then
      s := s1 + #13 + s2;
  end
  else
  begin
    if data1.curGallForm then
      s := s2;
  end;

  ShowMessage('Special Formatting in the Grid (delimiter character is " ' + data1.dozGalChar +
    ' "):' + #13 + s + #13 + #13 +
    'Any other unit: normal float with 2 decimal digits (format: #.## where # is a digit)');
end;

procedure TfAudit.LabelSearchDblClick(Sender: TObject);
begin
  if data1.ssDebug then
    dbtentcode.Visible := not dbtentcode.Visible;
end;

{Used to minimise the whole app if the current form is minimised}
procedure TfAudit.WMSysCommand;
begin
  if (Msg.CmdType = SC_MINIMIZE) then
  begin
    Application.Minimize;
  end
  else
  begin
    inherited;
  end;
end;

procedure TfAudit.btnClearAuditClick(Sender: TObject);
var
  s1, ss : string;
begin
  s1 := '';

  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('update AuditCur set ActCloseStk = NULL, ACount = ''''');

    // set the desired hz first (0 for byHZ=False, else use the TabIndex. This gives the WHERE...)
    if isLC then
    begin // create a"dummy" Where to enable the rest of the query to just use AND in safety...
      sql.Add('WHERE hzid < 1000');
    end
    else
    begin
      if data1.curByHZ then
      begin
        sql.Add('WHERE hzid = ' + inttostr(hztabs.ActivePage.Tag));
      end
      else
      begin
        sql.Add('WHERE hzid = 0');
      end;
    end;

    if sqSub <> '' then
    begin
      sql.Add('AND ' + sqSUB);
    end;

    ss := '';
    if (wwtAuditCur.Filter <> '') and (wwtAuditCur.Filtered) then
    begin
      ss := StringReplace(wwtAuditCur.Filter, '= NULL', 'is NULL', [rfReplaceAll, rfIgnoreCase]);
      sql.Add('AND ' + ss);
    end;

    // what should I show???
    sqView := '';
    if rbExpOnly.Checked then
    begin
      sqView := 'AND (("OpStk" <> 0) or ("MoveQty" <> 0) or ("PurchStk" <> 0) or ("ThRedQty" <> 0) ' +
        'or ("ThCloseStk" <> 0) or ("ActCloseStk" <> 0) or ("WasteTill" <> 0)' +
        ' or ("WastePC" <> 0) or ("Wastage" <> 0))';
    end
    else if (rbExpSite.Visible) and (rbExpSite.Checked) then
    begin
      sqView := 'AND (("OpStk" <> 0) or ("MoveQty" <> 0) or ("PurchStk" <> 0) or ("ThRedQty" <> 0) ' +
        'or ("ThCloseStk" <> 0) or ("ActCloseStk" <> 0) or ("WasteTill" <> 0)' +
        ' or ("WastePC" <> 0) or ("Wastage" <> 0) or (shouldbe = 2))';
    end;

    if not isLC then
      sql.Add(sqView);

    if (ss <> '') or (sqSub <> '') then
      if (not isLC) and (data1.curByHZ) and (hztabs.ActivePage.Tag > 0) then
        s1 := #13+''+#13+'(This applies only to Holding Zone: "' + hztabs.ActivePage.Caption +
          '" and to the items that satisfy the filter)'
      else
        s1 := #13+''+#13+'(This applies only to the items that satisfy the filter)'
    else
      if (not isLC) and (data1.curByHZ) and (hztabs.ActivePage.Tag > 0) then
        s1 := #13+''+#13+'(This applies only to Holding Zone: "' + hztabs.ActivePage.Caption + '")'
      else
        s1 := '';

    if MessageDlg('WARNING: All Audit Count figures will be cleared!'+ s1 +#13+''+#13+
      'Do you want to continue?', mtWarning, [mbYes,mbNo], 0) = mrYes then
    begin
      if wwtAuditCur.State = dsEdit then
        wwtAuditCur.Post;
      wwtAuditCur.DisableControls;

      execSQL;

      wwtAuditCur.requery;
      wwtAuditCur.EnableControls;
    end;
  end;
end;

procedure TfAudit.btnAutoFillClick(Sender: TObject);
begin
  if MessageDlg('All Audit Count figures that are now empty will be filled'+ #13+
                'with the Theo. Close figures (except when those are negative).'+#13+ ' ' + #13 +
    'Do you want to continue?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
  begin
    try
      screen.Cursor := crHourGlass;
      AutoAudit;
    finally
      screen.Cursor := crDefault;
    end; // try .. finally
  end;
end;

procedure TfAudit.MsgIfNoProducts;
begin
  if wwtAuditCur.RecordCount = 0 then
  begin
    if (wwtAuditCur.Filtered) or (FBoxSC.ItemIndex > 0) then
      showmessage('There are no products for the selected filter criteria.')
    else
      showmessage('There are no products available.');
  end;
end; // procedure..


procedure TfAudit.wwtAuditCurAfterOpen(DataSet: TDataSet);
begin
  MsgIfNoProducts;
end;

procedure TfAudit.btnImpCountsClick(Sender: TObject);
var
  row, s1, headStr : string;
  badRows, allRows, toImportRows : integer; // rows with File errors, all valid Rows, rows OK for this Stock
  theFile: TextFile;
  auditHoldingZone: smallint;
  auditHoldingZoneName: string;
  auditDateTimeStr: string;
  auditorName: string;
  auditedAtStr: string;
  auditNote: string[255];
begin
  op1.InitialDir := ExtractFilePath(Application.ExeName) + 'ExtAuditCounts';

  if not DirectoryExists(op1.InitialDir) then
    ForceDirectories(op1.InitialDir);

  if op1.Execute then
  begin
    // use any file even if it does not have STKA extension...

    AssignFile(theFile, op1.FileName);
    try
      Reset(theFile);

      // read the file header on first 2 rows
      // 1st row shows the HZid, HZname, Date-Time for which the Audit is meant, Auditor Name, and Date/Time of saved Count
      Readln(theFile, row);
      s1 := copy(row, 1, pos(',', row) - 1);
      auditHoldingZone := strtoint(s1);
      Delete(row, 1, pos(',', row));

      auditHoldingZoneName := copy(row, 1, pos(',', row) - 1);
      Delete(row, 1, pos(',', row));

      auditDateTimeStr := copy(row, 1, pos(',', row) - 1);
      Delete(row, 1, pos(',', row));

      auditorName := copy(row, 1, pos(',', row) - 1);
      Delete(row, 1, pos(',', row));

      auditedAtStr := row;
      // 2nd row show an optional note of max 255 characters
      Readln(theFile, auditNote);

      // prepare temp table to recieve the counts
      dmADO.DelSQLTable('#ImportAudit');

      with TADOQuery.Create(self) do
      begin
        try
          Connection := dmADO.AztecConn;

          close;
          sql.Clear;
          sql.Add('CREATE TABLE [#ImportAudit] (Item float NULL, AuditCount float NULL)');
          execSQL;

          badRows := 0;
          // all other rows are of the form <EntityCode>,<qty> with qty (float) assumed to be in Purchase Units
          while not System.Eof(theFile) do
          begin
            Readln(theFile, row);

            s1 := copy(row, 1, pos(',', row) - 1);
            System.Delete(row, 1, pos(',', row));

            close;
            sql.Clear;
            sql.Add('Insert [#ImportAudit] (Item, AuditCount)');
            sql.Add('Values (' + s1 + ', ' + row + ')');
            try
              execSQL;
            except
              inc(badRows);
            end; // try .. except
          end;

          // import ended, validate the data; format was "verified" above when inserting in table...
          // 1. eliminate any rows where item is not a stockable item for this DB
          close;
          sql.Clear;
          sql.Add('delete [#ImportAudit] where item not in');
          sql.Add('  (select entitycode from stkEntity where ETcode in (''G'', ''P'', ''S''))');
          inc(badRows,execSQL);

          // 2. eliminate any items entered twice
          close;
          sql.Clear;
          sql.Add('delete [#ImportAudit] where item in');
          sql.Add('  (select item from [#ImportAudit] group by item having count(item) > 1)');
          inc(badRows,execSQL);

        finally
          free;
        end;
      end;
      // now all entities-qty are in the temp table close the file
    finally
      CloseFile(theFile);
    end; // try .. finally


    with TADOQuery.Create(self) do
    begin
      try
        Connection := dmADO.AztecConn;

        // count all records then the records that have a corresponding entity code in the AuditCur table
        close;
        sql.Clear;
        sql.Add('select count(*) as thecount from [#ImportAudit]');
        open;
        allRows := FieldByName('thecount').asinteger;

        close;
        sql.Clear;
        sql.Add('select count(*) as thecount from [#ImportAudit] where item in');
        sql.Add('  (select entitycode from [Auditcur])');
        open;
        toImportRows := FieldByName('thecount').asinteger;
        close;

        if auditHoldingZone = 0 then
          headStr := 'Site Import File'
        else
          headStr := 'Holding Zone "' + auditHoldingZoneName + '" File';

        headStr := headStr + ' with Audit Date/Time: "' + auditDateTimeStr + '", Counted By: "' +
          auditorName + '", File Exported At: "' + auditedAtStr + '"';

        if auditNote <> '' then
          headStr := headstr + #13 + 'Auditor Note: ' + #13 + auditNote;

        headStr := headStr + #13 + #13 + 'Audit Counts for ' + inttostr(toImportRows) +
          ' items (out of ' + inttostr(allRows) + ' items in the file) can be imported.';

        if badRows > 0 then
          headStr := headStr + ' (The file also has ' + inttostr(badRows) +
             ' more Rows which are not valid.)';

        // now show user the file info (header, note, no of items valid/invalid) and ask if OK to continue
        // But should it overwrite any filled in figures?

        case MessageDlg(headStr + #13 + #13 + 'Click "Yes" to OVERWRITE any existing counts.' + #13 +
             'Click "No" to ADD to any existing counts.' + #13 +
             'Click "Abort" to stop the Import process.', mtConfirmation, [mbYes,mbNo,mbAbort], 0) of
          mrYes :  // import the figures, overwriting
            begin
              close;
              sql.Clear;
              sql.Add('update auditcur set actclosestk = sq.AuditCount');
              sql.Add('from ');
              sql.Add('  (select item, AuditCount from [#ImportAudit]) sq');
              sql.Add('where auditcur.entitycode = sq.item');
              if data1.curByHZ then
                sql.Add('and auditcur.hzid = ' + inttostr(hztabs.ActivePage.Tag));
              ExecSQL;

              //import and format the floats for records just imported in the string field
              close;
              sql.Clear;
              sql.Add('select * from AuditCur where entitycode in');
              sql.Add(' (select item from [#ImportAudit])');
              open;

              while not eof do
              begin
                edit;
                FieldByName('ACount').AsString :=
                  data1.dozGallFloatToStr(FieldByName('PurchUnit').asstring, FieldByName('ActCloseStk').asfloat);
                post;
                next;
              end;
              close;

              showMessage('Import done.');
            end;

          mrNo:    // import the figures adding to the existing ones
            begin
              close;
              sql.Clear;
              sql.Add('update auditcur set actclosestk = ');
              sql.Add('  (CASE WHEN actclosestk is NULL THEN sq.AuditCount');
              sql.Add('  ELSE actclosestk + sq.AuditCount END)');
              sql.Add('from ');
              sql.Add('  (select item, AuditCount from [#ImportAudit]) sq');
              sql.Add('where auditcur.entitycode = sq.item');
              if data1.curByHZ then
                sql.Add('and auditcur.hzid = ' + inttostr(hztabs.ActivePage.Tag));
              ExecSQL;

              //import and format the floats for records just imported in the string field
              close;
              sql.Clear;
              sql.Add('select * from AuditCur where entitycode in');
              sql.Add(' (select item from [#ImportAudit])');
              open;

              while not eof do
              begin
                edit;
                FieldByName('ACount').AsString :=
                  data1.dozGallFloatToStr(FieldByName('PurchUnit').asstring, FieldByName('ActCloseStk').asfloat);
                post;
                next;
              end;
              close;

              showMessage('Import done.');
            end;

          else
            begin
              showMessage('Import aborted.');
            end;
        end; // case
      finally
        free;
      end;
    end;
    wwtAuditCur.Requery;
  end;
end;

procedure TfAudit.Label5DblClick(Sender: TObject);
begin
  if data1.ssDebug and data1.curFillClose then
  begin
    btnImpCounts.Visible := not btnImpCounts.Visible;
    btnExpCounts.Visible := btnImpCounts.Visible;
  end;
end;

procedure TfAudit.btnExpCountsClick(Sender: TObject);
var
  expFile: TextFile;
  row, s1 : string;
  auditHoldingZone: smallint;
  auditHoldingZoneName: string;
begin
  save1.InitialDir := ExtractFilePath(Application.ExeName) + 'ExtAuditCounts';

  if data1.curByHZ then
  begin
    auditHoldingZone := hztabs.ActivePage.Tag;
    auditHoldingZoneName := hzTabs.ActivePage.Caption + '_';
  end
  else
  begin
    auditHoldingZone := 0;
    auditHoldingZoneName := '';
  end;

  save1.FileName := 'Audit_' + auditHoldingZoneName + data1.TheDiv + '_' +    // create default file name
              formatDateTime('yymmdd', data1.Edate) + '.STKA';

  if save1.Execute then
  begin
    if not DirectoryExists(ExtractFilePath(Save1.FileName)) then
      if not ForceDirectories(ExtractFilePath(Save1.FileName)) then
      begin
        showMessage('ERROR on creating File "' + Save1.FileName +
          '". Could not Create Export Path!');
        exit;
      end;

    AssignFile(expFile, Save1.FileName);
    try
      Rewrite(expFile);

      //write the header
      // 1st row shows the HZid, HZname, Date-Time for which the Audit is meant, Auditor Name, and Date/Time of saved Count
      row := inttostr(auditHoldingZone) + ',' + auditHoldingZoneName + ',' +
        formatDateTime('dd mmm yyyy', data1.Edate) + ',' + CurrentUser.UserName +
        ',' +formatDateTime('dd mmm yyyy', Now);

      writeln(expFile, row);

      // write the Note, user can type

      InputQuery('Audit Counts Export Note', 'Type max 170 char to append to the Export Note', s1);
      row := 'Div: ' + data1.TheDiv + '; Thread: ' + data1.curTidName + '; USER NOTE: ' + copy(s1,1,170);

      writeln(expFile, row);

      // now export all NON-NULL counts
      with TADOQuery.Create(self) do
      begin
        try
          Connection := dmADO.AztecConn;

          close;
          sql.Clear;
          sql.Add('Select EntityCode, ActCloseStk from AuditCur');
          sql.Add('where hzid = ' + inttostr(auditHoldingZone));
          sql.Add('and ActCloseStk is NOT NULL');
          open;

          // all other rows are of the form <EntityCode>,<qty> with qty (float) assumed to be in Purchase Units
          while not Eof do
          begin
            writeln(expFile, formatfloat('###########', FieldByName('entityCode').asfloat) +
              ',' + FieldByName('actCloseStk').asstring);
            next;
          end;

          close;
        finally
          free;
        end;
      end;

      // export is done; close the file ...
    finally
      CloseFile(expFile);
    end;
    showMessage('Export Done.');
  end;
end;

procedure TfAudit.RadioButtonSearchClick(Sender: TObject);
begin
  if RadioButtonName.Checked then
  begin
    LabelSearch.Caption := 'Incremental Search (Next = F3)';

    wwSearch1.Visible := True;
    EditImpExRefSearch.Visible := False;

    wwSearch1.SearchField := 'Name';
    wwFind.SearchField := wwSearch1.SearchField;
    wwSearch1.FindValue;
  end
  else if RadioButtonImpExRef.Checked then
  begin
    //Ensure we restart searching from the top
    FSearchText := '';

    wwSearch1.Visible := False;
    EditImpExRefSearch.Visible := True;
    LabelSearch.Caption := 'Midword Search (Next = F3)';
  end;
end;

procedure TfAudit.FindNextImpExRef;
var
  RecFound: Boolean;
  StartRecNo: Integer;
  bkmark: TBookmark;
  MidwordFullRequeryRequired: Boolean;
begin
  with adoqImpExRefSearch do
  begin
    StartRecNo := wwtAuditCur.RecNo;

    MidwordFullRequeryRequired := (FSearchText <> EditImpExRefSearch.Text);
    if MidwordFullRequeryRequired then
    begin
      StartRecNo := 0;
      FSearchText := EditImpExRefSearch.Text;
    end;

    if MidwordFullRequeryRequired or FMidwordPartialRequeryRequired then
    begin
      Close;
      Parameters.ParamByName('ImpExRef').Value := FSearchText;
      SQL.Text := StringReplace(SQL.Text,'AuditCurSubExpr',sqNoOrder,[rfReplaceAll]);
      Open;
    end
    else begin
      adoqImpExRefSearch.Next;
    end;
    
    wwtAuditCur.DisableControls;
    RecFound := False;
    bkMark := wwtAuditCur.GetBookmark;
    try
      while not (Eof or RecFound) do
      begin
        RecFound := wwtAuditCur.Locate('EntityCode',adoqImpExRefSearch.FieldByName('EntityCode').Value,[])
                    and (wwtAuditCur.RecNo >= StartRecNo);
        if not RecFound then
          Next;
      end;

      if not RecFound then
      begin
        wwtAuditCur.GotoBookmark(bkMark);
        MessageDlg('No more matches',
          mtInformation,
          [mbOK],
          0);
      end;
    finally
      FreeBookmark(bkMark);
      wwtAuditCur.EnableControls;
      FSearchText := EditImpExRefSearch.Text;
      FMidwordPartialRequeryRequired := False;
    end;
  end;
end;

end.


