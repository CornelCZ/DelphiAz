unit uAuditLocations;
                                        
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Wwdbigrd, Wwdbgrid, Db, Wwdatsrc, DBTables, Wwtable, StdCtrls,
  Buttons, Variants, ADODB, ExtCtrls, Mask, RxCalc, Wwkeycb, wwDialog,
  Wwlocate, ComCtrls, DBCtrls, uGlobals;

type
  TfAuditLocations = class(TForm)
    wwsAuditCur: TwwDataSource;
    wwGrid1: TwwDBGrid;
    qryAuditLoc: TADOQuery;
    qryAuditLocEntityCode: TFloatField;
    qryAuditLocSubCat: TStringField;
    qryAuditLocImpExRef: TStringField;
    qryAuditLocName: TStringField;
    qryAuditLocOpStk: TFloatField;
    qryAuditLocPurchStk: TFloatField;
    qryAuditLocThRedQty: TFloatField;
    qryAuditLocThCloseStk: TFloatField;
    qryAuditLocActCloseStk: TFloatField;
    qryAuditLocUnit: TStringField;
    qryAuditLocPurchBaseU: TFloatField;
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
    qryAuditLocACount: TStringField;
    qryAuditLocWasteTill: TFloatField;
    qryAuditLocWastePC: TFloatField;
    qryAuditLocWastage: TFloatField;
    qryAuditLocWasteTillA: TFloatField;
    qryAuditLocWastePCA: TFloatField;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label5: TLabel;
    qryAuditLocLocationID: TSmallintField;
    qryAuditLocShouldBe: TSmallintField;
    locTabs: TPageControl;
    hzTab0: TTabSheet;
    dbtEntCode: TDBText;
    Bevel4: TBevel;
    btnClearAudit: TBitBtn;
    Op1: TOpenDialog;
    Save1: TSaveDialog;
    lblFormat: TLabel;
    btnSaveChanges: TBitBtn;
    btnAbandon: TBitBtn;
    btnCalculator: TBitBtn;
    btnWastage: TBitBtn;
    pnlRO: TPanel;
    Label6: TLabel;
    Bevel5: TBevel;
    LabelSearch: TLabel;
    wwSearch1: TwwIncrementalSearch;
    PanelRadioButtonSearch: TPanel;
    RadioButtonName: TRadioButton;
    RadioButtonImpExRef: TRadioButton;
    adoqImpExRefSearch: TADOQuery;
    EditImpExRefSearch: TEdit;
    qryAuditLocPurchCostPU: TFloatField;
    qryAuditLocNomPricePU: TFloatField;
    qryAuditLocRecID: TIntegerField;
    qryAuditLocIsPurchUnit: TBooleanField;
    rbExpOnly: TRadioButton;
    rbAll: TRadioButton;
    btnAutoFill: TBitBtn;
    btnEditList: TBitBtn;
    qryAuditLocMustCount: TBooleanField;
    rbMustCountOnly: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure btnSaveChangesClick(Sender: TObject);
    procedure SaveAudit;
    procedure FormCreate(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure qryAuditLocOpStkGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure wwGrid1RowChanged(Sender: TObject);
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
    procedure qryAuditLocAfterScroll(DataSet: TDataSet);
    procedure qryAuditLocBeforePost(DataSet: TDataSet);
    procedure qryAuditLocBeforeRefresh(DataSet: TDataSet);
    procedure qryAuditLocAfterPost(DataSet: TDataSet);
    procedure qryAuditLocAfterEdit(DataSet: TDataSet);
    procedure btnWastageClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure wwGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure locTabsChange(Sender: TObject);
    procedure rbExpOnlyClick(Sender: TObject);
    procedure wwGrid1Exit(Sender: TObject);
    procedure lblFormatDblClick(Sender: TObject);
    procedure LabelSearchDblClick(Sender: TObject);
    procedure WMSysCommand(var Msg: TWMSysCommand);
    message WM_SYSCOMMAND;
    procedure btnClearAuditClick(Sender: TObject);
    procedure qryAuditLocAfterOpen(DataSet: TDataSet);
    procedure RadioButtonSearchClick(Sender: TObject);
    procedure btnAutoFillClick(Sender: TObject);
    procedure btnEditListClick(Sender: TObject);
    procedure qryAuditLocRecIDGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure wwGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    prevRec : integer;
    ShowClosePrompt: boolean;
    sqMain, sqSub, sqOrd, sqView: string;
    FMidwordPartialRequeryRequired, haveMustCountItems: Boolean;

    procedure ChangeSQL;
    procedure MsgIfNoProducts;

    procedure SaveStockAudit;
    procedure SavePartialAudit(AAllowAbort: boolean; showConfirmation: boolean = true);
    procedure SaveFullAudit(AAllowAbort: boolean; showConfirmation: boolean = true);
    procedure SaveLineCheckAudit;
    procedure AutoAudit(const treatNegativeAsZero: Boolean = false; const blindAutoAudit: boolean = false);
  public
    { Public declarations }
    showb1, showb2, showb3, isLC: boolean;
  end;

var
  fAuditLocations: TfAuditLocations;

implementation

uses udata1, uADO, uRepSP, uCurrdlg, uWasteAdjLoc, uLog, uLocationList, uLC, uNegativeTheoStockWarning,
uAutoFillStockConfirmation;

{$R *.DFM}

procedure TfAuditLocations.ChangeSQL;
begin
  if qryAuditLoc.State = dsEdit then
    qryAuditLoc.Post;
  qryAuditLoc.DisableControls;

  with qryAuditLoc do
  begin
    close;
    sql.Clear;
    sql.Add(sqMain);
    sql.Add('WHERE LocationID = ' + inttostr(loctabs.ActivePage.Tag));
    if sqSub <> '' then  sql.Add('AND ' + sqSUB);

    sqView := '';             // what should I show???

    if (locTabs.ActivePage.Tag = 0) or (locTabs.ActivePage.Tag = 999) then  // -- Complete Site
    begin                                                                   //   or <No Location>
      if rbMustCountOnly.Checked then
        sqView := 'AND (MustCount = 1)'
      else if rbExpOnly.Checked then  // also show Must Count items even if not expected...
        sqView := 'AND ((shouldbe = 0) or ("ActCloseStk" <> 0) or ("WasteTill" <> 0) or ("WastePC" <> 0) OR (MustCount = 1))';

      sqOrd := 'Order By "SubCat", "Name"';
    end
    else    // ------------------------------------ Location tabs
    begin
      if rbMustCountOnly.Checked then
        sqView := 'AND (MustCount = 1)';
      sqOrd := 'Order By RecID';
    end;

    sql.Add(sqView);
    sql.Add(sqOrd);
    open;
  end;

  qryAuditLoc.EnableControls;
end; // procedure..


procedure TfAuditLocations.FormShow(Sender: TObject);
var
  newTab : TTabSheet;
  Offset: Integer;
begin
  ShowClosePrompt := TRUE;
  Offset := 0;

  // make the Tabs ...
  with dmADO.adoqRun do
  begin
    close;            // ---------- any Must Count Items???
    sql.Clear;
    sql.Add('select count(*) as items from [auditLocationscur] where MustCount = 1');
    open;
    haveMustCountItems := (FieldByName('items').asinteger > 0);
    close;

    // are there any products for <No Location>? Including ones with NO stock qty or movement...
    Close;
    sql.Clear;
    sql.Add('select entitycode from AuditLocationsCur');
    sql.Add('where LocationID = 999');
    open;

    if recordcount > 0 then  // there are some products, create the <No Location> tab...
    begin
      NewTab := TTabSheet.Create(locTabs);
      NewTab.PageControl := locTabs;
      newTab.Tag := 999;
      newTab.PageIndex := 1;
      newTab.Caption := '<No Location>';
      newTab.ImageIndex := 1;
      offset := 1;
    end;

    Close;
    sql.Clear;
    SQL.Add('select loc.[LocationID], loc.[LocationName], loc.Active');
    SQL.Add('from stkLocations loc  ');
    SQL.Add('WHERE loc.Deleted = 0 and loc.SiteCode = ' +IntToStr(data1.TheSiteCode));
    // show tabs only for Locations with items selected...
    SQL.Add('and loc.[LocationID] in (select distinct LocationID from AuditLocationsCur)');
    SQL.Add('order by loc.[LocationName]');
    open;

    while not eof do
    begin
      NewTab := TTabSheet.Create(locTabs);
      NewTab.PageControl := locTabs;
      newTab.Tag := FieldByName('LocationID').asinteger;
      newTab.PageIndex := recNo + offset;
      newTab.Caption := FieldByName('LocationName').asstring;
      newTab.ImageIndex := 1;
      next;
    end;

    close;
  end;

  locTabs.Visible := True;

  if locTabs.PageCount > 2 then
    locTabs.ActivePageIndex := 1 + offset  // normally open with first (true) Location, usually the 3rd Tab...
  else
    locTabs.ActivePageIndex := locTabs.PageCount - 1; // if no products in any Location, thus no Location Tabs...

  sqMain := 'select * from AuditLocationsCur';
  sqSub := '';
  sqOrd := 'Order By RecID';

  locTabsChange(self); // this creates and opens the main query as well as sets the grid fields etc.


  if isLC then  // ------------------------------------------------------- Line Check
  begin
    self.Caption := 'Line Check Audit - Fill in the Count for each item';
    btnWastage.Visible := False;
    label1.Visible := False;
    checkbox1.Visible := False;
    if fLC.curLCblind then
    begin
      btnSaveChanges.Caption := 'Commit LC';
      btnAbandon.Caption := 'Cancel LC';
    end
    else
    begin
      btnSaveChanges.Caption := 'Continue';
      btnAbandon.Caption := 'Cancel LC';
    end;
  end
  else          // -------------------------------------------------------  Stock Count
  begin
    btnWastage.Visible := data1.curWasteAdj;
    self.Caption := 'Audit ' + data1.SSbig + ' - Fill in the ' + data1.SSbig + ' Count in each Location for each item';
  end;

  //Resize the form to cater for the optional columns.
  if ((not isLC) and (not data1.curFillClose)) or (isLC and fLC.curLCblind) then
    Offset := 130;
  if not data1.curShowImpExpRef then
    Offset := Offset + 123;
  self.Width := self.Width - Offset;

  if not data1.curShowImpExpRef then
  begin
    LabelSearch.Caption := 'Name Search (Next = F3)';
    PanelRadioButtonSearch.Visible := False;
    wwSearch1.width := Bevel5.width - 2 * (wwSearch1.Left - Bevel5.Left);
    EditImpExRefSearch.Visible := FALSE;
  end;

  if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
    label3.Caption := 'Sub-Categ.'
  else
    label3.Caption := 'Category';

  label4.Caption := 'Audit ' + data1.SSsmall;
  FBoxSC.Items.Clear;
  fBoxSC.Items.Add('Show All');

  with data1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct [subcat] from [auditLocationscur] order by [subcat]');
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
end;

procedure TfAuditLocations.locTabsChange(Sender: TObject);
begin
  if wwgrid1.DataSource.DataSet.State = dsEdit then
    wwgrid1.DataSource.DataSet.Post;

  if locTabs.ActivePageIndex = 0 then      // ------------ Complete Site, Read Only...
  begin // make read only, show label not buttons...
    // sum-up, place in the Locationid = 0, fill ACount for it...
    with data1.adoqRun do
    begin
      dmADO.DelSQLTable('#ghost');

    close;
    sql.Clear;
    sql.Add('update auditLocationscur set ActCloseStk = IsNull(sq.ActCloseStk,0) / PurchBaseU ');
    if not isLC then
      sql.Add(',wastetilla = sq.wastetilla / PurchBaseU, wastepca = sq.wastepca / PurchBaseU, wastage = sq.wastage / PurchBaseU');
    sql.Add('from');
    sql.Add('  (select a.entitycode, sum(IsNull(a.ActCloseStk,0) * a.PurchBaseU) as ActCloseStk,');
    sql.Add('    sum(a.wastetilla * a.PurchBaseU) as wastetilla, sum(a.wastepca * a.PurchBaseU) as wastepca, sum(a.wastage * a.PurchBaseU) as wastage');
    sql.Add('   from auditLocationscur a where a.LocationID > 0');
    sql.Add('   group by a.entitycode) sq');
    sql.Add('where auditLocationscur.LocationId = 0 and auditLocationscur.entitycode = sq.entitycode');
    execSQL;


      close;
      sql.Clear;
      sql.Add('select * from AuditLocationsCur where Locationid = 0');
      open;

      while not eof do
      begin
        //import the floats in the string field
        edit;
        if FieldByName('ActCloseStk').asstring = '' then
          FieldByName('ACount').AsString := ''
        else
          FieldByName('ACount').AsString :=
            data1.dozGallFloatToStr(FieldByName('Unit').asstring, FieldByName('ActCloseStk').asfloat);
        post;
        next;
      end;
      close;
    end;

    ChangeSQL;

    with wwGrid1, wwGrid1.DataSource.DataSet do   // grid field names, etc...
    begin
      DisableControls;
      Selected.Clear;

      if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
        Selected.Add('SubCat'#9'20'#9'Sub-Category'#9'F')
      else
        Selected.Add('SubCat'#9'20'#9'Category'#9'F');
      Selected.Add('Name'#9'40'#9'Name'#9'F');
      if data1.curShowImpExpRef then
      begin
        Selected.Add('ImpExRef'#9'20'#9'Import/Export Reference'#9'F');
      end;
      Selected.Add('Unit'#9'11'#9'Unit'#9'F');
      if isLC then
        Selected.Add('OpStk'#9'11'#9'Base ' + data1.SSsmall + ''#9'F')
      else
        Selected.Add('OpStk'#9'11'#9'Open ' + data1.SSsmall + ''#9'F');
      Selected.Add('PurchStk'#9'11'#9'Purch ' + data1.SSsmall + ''#9'F');

      if isLC then
      begin
        if NOT fLC.curLCblind then  // show Theo Close (i.e. NOT blind)
        begin
          Selected.Add('ThRedQty'#9'10'#9'Th. Reduct.'#9'F');
          Selected.Add('ThCloseStk'#9'10'#9'Prev Variance'#9'F');
          Selected.Add('Wastage'#9'11'#9'Th. Level'#9'F');
        end;
      end
      else
      begin
        if data1.curFillClose then  // show Theo Close (i.e. NOT blind)
        begin
          Selected.Add('ThRedQty'#9'10'#9'Th. Reduct.'#9'F');
          Selected.Add('ThCloseStk'#9'10'#9'Th. Close ' + data1.SSsmall + ''#9'F');
        end;
        Selected.Add('Wastage'#9'11'#9'Wastage'#9'F');
      end;

      Selected.Add('ACount'#9'13'#9'Audit ' + data1.SSbig + ''#9'F');

      ApplySelected;
      EnableControls;
    end;

    wwGrid1.ReadOnly := True;
    wwGrid1.TitleLines := 1;

    if isLC then
    begin
      rbMustCountOnly.Visible := False;
      rbExpOnly.Visible := False;
      rball.Visible := False;
    end
    else
    begin
      rbExpOnly.Visible := true;
      rball.Visible := true;

      if haveMustCountItems then
      begin
        rbMustCountOnly.Visible := True;
        rbMustCountOnly.Checked := True;
        rbMustCountOnly.Top := 7;
        rbExpOnly.Top := 23;
        rball.Top := 40;
      end
      else
      begin
        rbMustCountOnly.Visible := False;
        rbExpOnly.Checked := True;
        rbExpOnly.Top := 9;
        rball.Top := 34;
      end;
    end;

    pnlRO.Visible := True;
    btnPrint.Enabled := FALSE;
    checkBox1.Enabled := FALSE;
    btnClearAudit.Visible := FALSE;
    btnEditList.Visible := FALSE;  // --- end of Complete Site...
  end
  else if locTabs.ActivePage.Tag = 999 then // ----------- <No Location> page, editable
  begin
    ChangeSQL;

    with wwGrid1, wwGrid1.DataSource.DataSet do   // grid field names, etc...
    begin
      DisableControls;
      Selected.Clear;

      if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
        Selected.Add('SubCat'#9'20'#9'Sub-Category'#9'F')
      else
        Selected.Add('SubCat'#9'20'#9'Category'#9'F');
      Selected.Add('Name'#9'40'#9'Name'#9'F');
      if data1.curShowImpExpRef then
      begin
        Selected.Add('ImpExRef'#9'20'#9'Import/Export Reference'#9'F');
      end;
      Selected.Add('Unit'#9'11'#9'Unit'#9'F');
      if isLC then
        Selected.Add('OpStk'#9'11'#9'Base ' + data1.SSsmall + ''#9'F')
      else
        Selected.Add('OpStk'#9'11'#9'Open ' + data1.SSsmall + ''#9'F');
      Selected.Add('PurchStk'#9'11'#9'Purch ' + data1.SSsmall + ''#9'F');

      if isLC then
      begin
        if NOT fLC.curLCblind then  // show Theo Close (i.e. NOT blind)
        begin
          Selected.Add('ThRedQty'#9'10'#9'Th. Reduct.'#9'F');
          Selected.Add('ThCloseStk'#9'10'#9'Prev Variance'#9'F');
          Selected.Add('Wastage'#9'11'#9'Th. Level'#9'F');
        end;
      end
      else
      begin
        if data1.curFillClose then  // show Theo Close (i.e. NOT blind)
        begin
          Selected.Add('ThRedQty'#9'10'#9'Th. Reduct.'#9'F');
          Selected.Add('ThCloseStk'#9'10'#9'Th. Close ' + data1.SSsmall + ''#9'F');
          btnAutoFill.Visible := not data1.curHideFillAudit;
        end
        else
        begin                       // do NOT show Theo Close (i.e. blind)
          btnAutoFill.Visible := False;
        end;
        Selected.Add('Wastage'#9'11'#9'Wastage'#9'F');
      end;

      Selected.Add('ACount'#9'13'#9'Audit ' + data1.SSbig + ''#9'F');

      ApplySelected;
      EnableControls;
    end;

    wwGrid1.ReadOnly := False;
    wwGrid1.TitleLines := 1;

    if isLC then
    begin
      rbMustCountOnly.Visible := False;
      rbExpOnly.Visible := False;
      rball.Visible := False;
    end
    else
    begin
      rbExpOnly.Visible := true;
      rball.Visible := true;

      if haveMustCountItems then
      begin
        rbMustCountOnly.Visible := True;
        rbMustCountOnly.Checked := True;
        rbMustCountOnly.Top := 7;
        rbExpOnly.Top := 23;
        rball.Top := 40;
      end
      else
      begin
        rbMustCountOnly.Visible := False;
        rbExpOnly.Checked := True;
        rbExpOnly.Top := 9;
        rball.Top := 34;
      end;
    end;

    pnlRO.Visible := False;
    btnPrint.Enabled := TRUE;
    checkBox1.Enabled := TRUE;
    btnClearAudit.Visible := TRUE;
    btnEditList.Visible := FALSE;  // --- end of <No Location>
  end
  else                                       // ----------------------- Location pages
  begin
    ChangeSQL;

    with wwGrid1, wwGrid1.DataSource.DataSet do   // grid field names, etc...
    begin
      DisableControls;
      Selected.Clear;

      Selected.Add('RecID'#9'3'#9'Row'#9#9);
      if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
        Selected.Add('SubCat'#9'20'#9'Sub-Category'#9'F')
      else
        Selected.Add('SubCat'#9'20'#9'Category'#9'F');
      Selected.Add('Name'#9'40'#9'Name'#9'F');
      if data1.curShowImpExpRef then
      begin
        Selected.Add('ImpExRef'#9'20'#9'Import/Export Reference'#9'F');
      end;
      Selected.Add('Unit'#9'11'#9'Unit'#9'F');

      if not isLC then
        Selected.Add('OpStk'#9'11'#9'Last ' + data1.SSbig + '~Audit Count'#9'T');

      if isLC then
      begin
        Selected.Add('Wastage'#9'10'#9'Prep Item~Indicator'#9'T');
      end
      else
      begin
        if data1.curWasteAdj then
          Selected.Add('Wastage'#9'10'#9'Wastage~Adjustment'#9'T')
        else
          Selected.Add('Wastage'#9'10'#9'Prep Item~Indicator'#9'T');
      end;

      Selected.Add('ACount'#9'13'#9'Audit ' + data1.SSbig + ''#9'F');

      ApplySelected;
      EnableControls;
    end;

    wwGrid1.ReadOnly := False;
    wwGrid1.TitleLines := 2;
    btnAutoFill.Visible := FALSE;

    if isLC then
    begin
      rbMustCountOnly.Visible := False;
    end
    else
    begin
      if haveMustCountItems then
      begin
        rbMustCountOnly.Visible := True;
        rbMustCountOnly.Checked := True;
        rbMustCountOnly.Top := 9;
        rball.Visible := True;
        rball.Top := 34;
      end
      else
      begin
        rbMustCountOnly.Visible := False;
        rbMustCountOnly.Checked := False;
        rball.Visible := False;
      end;
    end;

    rbExpOnly.Visible := false;

    pnlRO.Visible := False;
    btnPrint.Enabled := TRUE;
    checkBox1.Enabled := TRUE;
    btnClearAudit.Visible := TRUE;
    btnEditList.Visible := not isLC;
  end;

  wwGrid1.FixedCols := wwGrid1.Selected.Count - 1;
  self.wwGrid1RowChanged(wwGrid1);
end;

procedure TfAuditLocations.btnSaveChangesClick(Sender: TObject);
begin
  if qryAuditLoc.State = dsEdit then
    qryAuditLoc.Post;

  // sum-up, place in the LocationID = 0, fill ACount for it...
  with data1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('update auditLocationscur set ActCloseStk = sq.ActCloseStk / PurchBaseU ');
    if not isLC then
      sql.Add(',wastetilla = sq.wastetilla / PurchBaseU, wastepca = sq.wastepca / PurchBaseU, wastage = sq.wastage / PurchBaseU');
    sql.Add('from');
    sql.Add('  (select a.entitycode, sum(a.ActCloseStk * a.PurchBaseU) as ActCloseStk,');
    sql.Add('    sum(a.wastetilla * a.PurchBaseU) as wastetilla, sum(a.wastepca * a.PurchBaseU) as wastepca, sum(a.wastage * a.PurchBaseU) as wastage');
    sql.Add('   from auditLocationscur a where a.LocationID > 0');
    sql.Add('   group by a.entitycode) sq');
    sql.Add('where auditLocationscur.LocationId = 0 and auditLocationscur.entitycode = sq.entitycode');
    execSQL;

    close;
    sql.Clear;
    sql.Add('select * from AuditLocationsCur where Locationid = 0');
    open;

    while not eof do
    begin                //import the floats in the string field
      edit;
      if FieldByName('ActCloseStk').asstring = '' then
        FieldByName('ACount').AsString := ''
      else
        FieldByName('ACount').AsString :=
          data1.dozGallFloatToStr(FieldByName('Unit').asstring, FieldByName('ActCloseStk').asfloat);
      post;
      next;
    end;
    close;
  end;

  if isLC then
  begin
    if qryAuditLoc.Locate('ActCloseStk',null,[]) then
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
  else
  begin
    SaveStockAudit;
  end;
end;

procedure TfAuditLocations.SaveLineCheckAudit;
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

procedure TfAuditLocations.SaveStockAudit;
var
  PartiallyEnteredAudit: boolean;
  NegativeTheoCloseProducts: TStringList;
  NegativeTheoStockWarningForm: TfNegativeTheoStockWarning;
  AutoFillConfirmationForm: TfAutofillStockConfirmation;
  ConfirmationFormResult, emptyMustCountItems: Integer;
  s1 : string;
begin
  with data1.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from AuditLocationsCur where ActCloseStk is NULL and shouldbe = 0');
    Open;
    PartiallyEnteredAudit := RecordCount > 0;
    Close;
  end;

  if PartiallyEnteredAudit and data1.curAutoFillBlankCounts and not data1.curFillClose then
  begin
    // check to see if any Must Count items are left unfilled manually and offer to Save or Cancel...
    // only expected Must Count items must be filled manually.
    with data1.adoqRun do   // ****** Only check the WHOLE SITE, none of the Locations ************
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from AuditLocationsCur where ActCloseStk is NULL and shouldbe = 0 and MustCount = 1');
      SQL.Add('and LocationID = 0');
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

procedure TfAuditLocations.AutoAudit(const treatNegativeAsZero: Boolean = false; const blindAutoAudit: boolean = false);
begin
  if (not isLC) then
  begin
    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('update [AuditLocationsCur] set actclosestk = thclosestk');
      if blindAutoAudit then
        sql.Add(', [CloseStkAutofilled] = 1');
      sql.Add('where actclosestk is NULL');
      sql.Add('and thclosestk >= 0');
      if locTabs.Tag > 0 then
        sql.Add('and LocationID = ' + inttostr(locTabs.ActivePage.Tag));
      execSQL;

      close;
      sql.Clear;
      sql.Add('select * from AuditLocationsCur');
      if locTabs.ActivePage.Tag > 0 then
        sql.Add('where LocationID = ' + inttostr(locTabs.ActivePage.Tag));
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
                data1.dozGallFloatToStr(FieldByName('Unit').asstring, FieldByName('ActCloseStk').asfloat);
        post;
        next;
      end;
      close;
    end;
    if not blindAutoAudit then
      qryAuditLoc.Requery;
  end;
end;

procedure TfAuditLocations.SavePartialAudit(AAllowAbort: boolean; showConfirmation: boolean = true);
begin
  if AAllowAbort then
  begin
    if not showConfirmation or (MessageDlg('Not all audit figures have been entered, so the current ' + data1.SSlow +
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

procedure TfAuditLocations.SaveFullAudit(AAllowAbort: boolean; showConfirmation: boolean = true);
var
  DialogResult  : integer;
  DialogButtons : TMsgDlgButtons;
begin
  if AAllowAbort then
    DialogButtons := [mbYes, mbNo, mbCancel]
  else
    DialogButtons := [mbYes, mbCancel];

  if not showConfirmation then
    DialogResult := mrYes
  else
    DialogResult := MessageDlg('Do you wish to proceed with the ' + data1.SSlow + '?',
      mtConfirmation, DialogButtons, 0);

  case DialogResult of
    mrYes:
      begin
        log.event('fAuditLoc.SaveFullAudit, User selected to proceed with the Audit');
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

procedure TfAuditLocations.SaveAudit;
var
  stringDT : string;

  procedure StoreAuditChanges(fieldName, stringName: string);
  begin
    with data1.adoqRun do
    begin
      close;   // The changed sums per site are stored and not individual Location changes...
      sql.Clear;
      sql.Add('Insert INTO stkQtyChanges ([SiteCode], [Tid], [StkCode], [HzID], [FieldChanged], [CalcDateTime], ');
      sql.Add('  [EntityCode], [OldQty], [NewQty], [PurchUnit], [PurchBaseU], [ChangedBy])');
      sql.Add('SELECT a.[SiteCode], a.tid, a.StkCode, -2,');
      sql.Add(stringName + ', ' + stringDT + ', a.[EntityCode], a.['+ fieldName +'] / b.PurchBaseU, b.['+ fieldName +'], ');
      sql.Add(' b.[Unit], b.[PurchBaseU], ' + quotedStr(CurrentUser.UserName) + ' as ChangedBy');
      sql.Add('FROM AuditLocationsCur b, ');
      sql.Add(' (select a.[SiteCode], a.tid, a.StkCode, a.entitycode, sum(IsNull(a.ActCloseStk,0) * a.PurchBaseU) as ActCloseStk, ');
      sql.Add('  sum(a.wastetilla * a.PurchBaseU) as wastetilla, sum(a.wastepca * a.PurchBaseU) as wastepca');
      sql.Add('  FROM auditLocations a WHERE a.LocationID > 0');
      sql.Add('  AND a.StkCode = '+IntToStr(data1.StkCode));
      sql.Add('  AND a.tid = '+IntToStr(data1.curtid));
      sql.Add('  AND a.SiteCode = ' +IntToStr(data1.TheSiteCode));
      sql.Add('  group by a.[SiteCode], a.tid, a.StkCode, a.entitycode) a ');
      sql.Add('WHERE b.LocationID = 0 AND a.[EntityCode] = b.[EntityCode]');
      sql.Add('  AND a.['+ fieldName +'] <> b.['+ fieldName +'] * b.PurchBaseU ');
      ExecSQL;
    end;
  end;

begin
  log.event('In fAuditLoc.SaveAudit, ThreadId = ' + IntToStr(data1.curtid) +
   ' StockCode = ' + IntToStr(data1.StkCode));
  with data1.adoqRun do
  begin
    stringDT := quotedStr(formatDateTime('yyyymmdd hh:nn:ss', Now));

    if Assigned(fcurrDlg) and (fCurrDlg.astage >= 3) then // ONLY if this stock was fully calculated ...
    begin
      // store that a fresh Calculation was done
      close;
      sql.Clear;
      sql.Add('Insert INTO stkQtyChanges ([SiteCode], [Tid], [StkCode], [HzID], [FieldChanged], [CalcDateTime], [ChangedBy])');
      sql.Add('VALUES ('+IntToStr(data1.TheSiteCode)+', '+IntToStr(data1.curtid)+',');
      sql.Add('  '+IntToStr(data1.StkCode)+', -2, ''Stock Re-Calculation'',');
      sql.Add('  ' + stringDT + ', '+ quotedStr(CurrentUser.UserName) + ')');
      ExecSQL;

      // available [Audit] qty fields: [OpStk], [PurchStk], [ThRedQty], [ThCloseStk], [ActCloseStk], [PurchUnit],
      //                               [PurchBaseU], [WasteTill], [WastePC], [WasteTillA], [WastePCA], [Wastage]
      StoreAuditChanges('ActCloseStk', QuotedStr('Audit Count'));
      StoreAuditChanges('WasteTillA', QuotedStr('Till Waste Adjustment'));
      StoreAuditChanges('WastePCA', QuotedStr('PC Waste Adjustment'));
    end
    else  // this stock was NOT fully calculated before
    begin
      // just store that a fresh Calculation was done, no details
      close;
      sql.Clear;
      sql.Add('Insert INTO stkQtyChanges ([SiteCode], [Tid], [StkCode], [HzID], [FieldChanged], [CalcDateTime], [ChangedBy])');
      sql.Add('VALUES ('+IntToStr(data1.TheSiteCode)+', '+IntToStr(data1.curtid)+',');
      sql.Add('  '+IntToStr(data1.StkCode)+', -2, ''Stock Calculation'',');
      sql.Add('  ' + stringDT + ', '+ quotedStr(CurrentUser.UserName) + ')');
      ExecSQL;
    end;

    // delete recs from Audit that will be replaced by insert...
    close;
    sql.Clear;
    sql.Add('delete from AuditLocations where stkCode = ' + IntToStr(data1.StkCode));
    sql.Add('and tid = '+IntToStr(data1.curtid));
    sql.Add('');

    // the Append part, first the Locations (that have Row Numbers)

    // ----- for records Temporarily appended to a LocationList Audit Count (for one Stock Only) --------------
    //       save them in a special way by using the "appended row No." (i.e. as 1 for 1st appended row, etc.)
    //       stored in field PurchCostPU added to 1,000,000 as the RecID. This will allow List changes that
    //       do NOT overwrite stored Audit Counts for these "one Stock Only" additions...

    sql.Add('insert into AuditLocations ([SiteCode], [Tid], [StkCode], [RecID], [LocationID], [EntityCode],');
    sql.Add('                       [ActCloseStk], [CloseStkAutoFilled], [Unit], [PurchBaseU], [WasteTillA], [WastePCA], [LMDT])');
    sql.Add('SELECT '+IntToStr(data1.TheSiteCode)+', (' + IntToStr(data1.curtid)+') as tid, (' + IntToStr(data1.StkCode)+') as StkCode,');
    sql.Add(' RecID,  [LocationID], [EntityCode], [ActCloseStk], [CloseStkAutoFilled], [Unit], [PurchBaseU], [WasteTillA], [WastePCA]');
    sql.Add( ',' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) );
    sql.Add('FROM AuditLocationsCur  where ActCloseStk is NOT NULL and LocationID > 0 and LocationID < 999');
    sql.Add('');

    // the Append part, last the <No Location> (that does NOT have Row Numbers)
    sql.Add('insert into AuditLocations ([SiteCode], [Tid], [StkCode], [LocationID], [RecID], [EntityCode],');
    sql.Add('                       [ActCloseStk], [CloseStkAutoFilled], [Unit], [PurchBaseU], [WasteTillA], [WastePCA], [LMDT])');
    sql.Add('SELECT '+IntToStr(data1.TheSiteCode)+', (' + IntToStr(data1.curtid)+') as tid, (' + IntToStr(data1.StkCode)+') as StkCode,');
    sql.Add('  [LocationID], ROW_NUMBER() OVER (ORDER BY EntityCode) as [RecID], [EntityCode], [ActCloseStk], [CloseStkAutoFilled], [Unit], [PurchBaseU], [WasteTillA], [WastePCA]');
    sql.Add( ',' + quotedStr(formatDateTime('mm/dd/yyyy hh:nn:ss.zzz', Now)) );
    sql.Add('FROM AuditLocationsCur  where ActCloseStk is NOT NULL and LocationID = 999');

    execSQL;
  end; // with..

  log.event('Exiting fAuditLoc.SaveAudit');
end; // procedure..


procedure TfAuditLocations.FormCreate(Sender: TObject);
begin
  showb1 := True;
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

  lblFormat.Visible := (lblFormat.Caption <> '');
end;

procedure TfAuditLocations.btnPrintClick(Sender: TObject);
var
  ix : smallint;
  ss : string;
begin
  if qryAuditLoc.State = dsEdit then
    qryAuditLoc.Post;

  if isLC then
  begin
    with flc.adoqLocationCount do
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

    flc.adoqLocationCount.Open;
    flc.ppLocationCount.Print;
    flc.adoqLocationCount.Close;
  end
  else
  begin
    fRepSP := TfRepSP.Create(Self);

    if locTabs.ActivePage.Tag = 999 then
    begin
      // use "normal" count sheet
      fRepSP := TfRepSP.Create(Self);
      if checkbox1.Checked then
        fRepSP.pptTot.Visible := True;

      fRepSP.adoqCount.sql.Text := qryAuditLoc.sql.Text;

      if (qryAuditLoc.Filter <> '') and (qryAuditLoc.Filtered) then
      begin
        ss := StringReplace(qryAuditLoc.Filter, '= NULL', 'is NULL', [rfReplaceAll, rfIgnoreCase]);
        ix := fRepSP.adoqCount.sql.Count - 1;
        fRepSP.adoqCount.sql.Insert(ix,'AND (' + ss + ')');
      end;

      fRepSP.ppLabel23.Visible := TRUE;
      fRepSP.ppLabel23.Caption := 'For Products not assigned to any Location';
      fRepSP.ppLabel3.Caption := '"No Location" Count';

      fRepSP.ACSprint(false); // sets the fields

      fRepSP.ppDBText3.DataField := 'Unit';

      fRepSP.adoqCount.Open;
      fRepSP.ppCount.Print;
      fRepSP.adoqCount.Close;
    end
    else
    begin
      // use Location count sheet
      if checkbox1.Checked then
        fRepSP.ppLocationsTot.Visible := True;

      fRepSP.adoqLocationCount.sql.Text := qryAuditLoc.sql.Text;

      if (qryAuditLoc.Filter <> '') and (qryAuditLoc.Filtered) then
      begin
        ss := StringReplace(qryAuditLoc.Filter, '= NULL', 'is NULL', [rfReplaceAll, rfIgnoreCase]);
        ix := fRepSP.adoqCount.sql.Count - 1;
        fRepSP.adoqLocationCount.sql.Insert(ix,'AND (' + ss + ')');
      end;

      with data1.adoqRun do
      begin
        Close;
        sql.Clear;
        SQL.Add('select loc.PrintNote');
        SQL.Add('from stkLocations loc  ');
        SQL.Add('WHERE loc.SiteCode = ' +IntToStr(data1.TheSiteCode));
        sql.Add('AND LocationID = ' + inttostr(loctabs.ActivePage.Tag));
        open;
        fRepSP.ppMemoLocNote.Text := FieldByName('PrintNote').asstring;
        close;
      end;

      fRepSP.ppLabel67.Caption := 'For Count Location: ' + locTabs.ActivePage.Caption;
      fRepSP.ppLabel11.Caption := locTabs.ActivePage.Caption + '  Count';
      fRepSP.adoqLocationCount.Open;
      fRepSP.ppLocationCount.Print;
      fRepSP.adoqLocationCount.Close;
    end;

    fRepSP.Free;
  end;
end;

procedure TfAuditLocations.qryAuditLocOpStkGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if sender.asstring = '' then
  begin
    Text := '';
    exit;
  end;

  if (sender.FieldName = 'PurchStk') or (sender.FieldName = 'Wastage')  then
  begin
    if (Sender.Asinteger >= -1099998) and (Sender.Asinteger <= -900000) then
    begin
      Text := 'Prep. Item';
      exit;
    end
    else if not ((locTabs.ActivePage.Tag = 0) or (locTabs.ActivePage.Tag = 999)) then // Location pages, do not show Wastage
    begin
      Text := '';
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
  Text := data1.dozGallFloatToStr(qryAuditLocUnit.Value, sender.Asfloat);
end;

procedure TfAuditLocations.wwGrid1RowChanged(Sender: TObject);
var
  i : integer;
begin
  if qryAuditLoc.RecordCount = 0 then exit;

  wwgrid1.PictureMasks.Strings[0] := 'ACount' + data1.setGridMask(qryAuditLocUnit.Value,'');
  FMidwordPartialRequeryRequired := True;

  if (locTabs.ActivePageIndex <> 999) then
  begin
    for i := 1 to locTabs.PageCount - 1 do
    begin
      locTabs.Pages[i].ImageIndex := 1;
    end;

    with data1.adoqRun do
    begin
      Close;
      sql.Clear;
      sql.Add('SELECT distinct [LocationID] from AuditLocationsCur   WHERE  LocationID > 0');
      sql.Add('AND entitycode = ' + qryAuditLoc.FieldByName('EntityCode').asstring);
      open;

      while not eof do
      begin
        for i := 1 to locTabs.PageCount - 1 do
        begin
          if locTabs.Pages[i].Tag = fieldByName('LocationID').asinteger then
            locTabs.Pages[i].ImageIndex := 2;
        end;
        next;
      end;

      close;
    end;
  end;
end;


procedure TfAuditLocations.btnCalculatorClick(Sender: TObject);
begin
  // calculator
  rxCalculator1.Value := qryAuditLoc.FieldByName('ActCloseStk').asfloat;

  if not rxCalculator1.Execute then
    exit;

  if rxCalculator1.Value < 0 then
  begin
    showMessage('Audit levels smaller than ZERO are not permitted!');
  end
  else
  begin
    qryAuditLoc.edit;
    qryAuditLoc.FieldByName('ACount').asstring :=
      data1.dozGallFloatToStr(qryAuditLoc.FieldByName('Unit').asstring, rxCalculator1.Value); //ttext;
    qryAuditLoc.post;
  end;
end;

procedure TfAuditLocations.wwGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key in [VK_DOWN, VK_RETURN, VK_UP, VK_TAB] then
  begin

    if qryAuditLoc.State = dsEdit then
      qryAuditLoc.Post;

    qryAuditLoc.DisableControls;

    if qryAuditLoc.RecordCount > 0 then
    begin
      case key of
        VK_DOWN,
        VK_RETURN: begin //scroll down
                     qryAuditLoc.RecNo := qryAuditLoc.RecNo + 1;
                     //qryAuditLoc.Next;
                     //qryAuditLoc.Prior;
                   end;
           VK_UP : begin //scroll up
                     if qryAuditLoc.RecNo > 1 then
                       qryAuditLoc.RecNo := qryAuditLoc.RecNo - 1;
                   end;
          VK_TAB : begin
                     if ssShift in Shift then
                     begin // scroll up
                       if qryAuditLoc.RecNo > 1 then
                         qryAuditLoc.RecNo := qryAuditLoc.RecNo - 1;
                     end
                     else  // scroll down
                     begin
                       qryAuditLoc.RecNo := qryAuditLoc.RecNo + 1;
                     end;
                   end;
          else
             exit;
      end; // case..
    end;

    qryAuditLoc.EnableControls;

    key := 0;
    qryAuditLocAfterScroll(nil);
  end;
end;

procedure TfAuditLocations.FBoxSCCloseUp(Sender: TObject);
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

procedure TfAuditLocations.FBoxCntCloseUp(Sender: TObject);
begin
  with qryAuditLoc do
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

procedure TfAuditLocations.wwSearch1AfterSearch(Sender: TwwIncrementalSearch;
  MatchFound: Boolean);
begin
  wwFind.FieldValue := wwSearch1.Text;
end;

procedure TfAuditLocations.FBoxSCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  key := 0;
end;

procedure TfAuditLocations.FBoxCntKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  key := 0;
end;

procedure TfAuditLocations.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (locTabs.ActivePageIndex = 0) then
  begin
    // keys should not operate...
  end
  else
  begin
    if btnCalculator.Enabled then
    begin
      if (btnWastage.Visible) and (Key = VK_F5) then
      begin
        btnWastageClick(Sender);
        Key := 0;
      end;

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
      wwFind.FieldValue := EditImpExRefSearch.Text;
    end;
    if wwFind.FieldValue = '' then
        exit;
    wwFind.FindNext;
  end;
end;

procedure TfAuditLocations.FBoxSCKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TfAuditLocations.FBoxCntKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TfAuditLocations.qryAuditLocAfterScroll(DataSet: TDataSet);
begin
  if qryAuditLoc.RecordCount = 0 then
  begin
    btnCalculator.Enabled := False;
    btnWastage.Enabled := False;
    btnPrint.Enabled := False;
    wwgrid1.Enabled := False;
  end
  else
  begin
    wwgrid1.Enabled := true;
    btnCalculator.Enabled := true;
    btnPrint.Enabled := (locTabs.ActivePageIndex > 0);
    btnWastage.Enabled := (not ((qryAuditLoc.FieldByName('purchstk').asinteger >= -1099998)
                               and (qryAuditLoc.FieldByName('purchstk').asinteger <= -900000))); // not for PrepItems

    wwgrid1.PictureMasks.Strings[0] := 'ACount' + data1.setGridMask(qryAuditLocUnit.Value,'');
  end;
end;

procedure TfAuditLocations.qryAuditLocBeforePost(DataSet: TDataSet);
begin
  if qryAuditLoc.FieldByName('ACount').asstring = '' then
  begin
    qryAuditLoc.FieldByName('ActCloseStk').asstring := '';
  end
  else
  begin
    qryAuditLoc.FieldByName('ActCloseStk').AsFloat :=
       data1.dozGallStrToFloat(qryAuditLocUnit.Value,qryAuditLoc.FieldByName('ACount').asstring);
  end;

  prevRec := qryAuditLoc.RecordCount;
end;

procedure TfAuditLocations.qryAuditLocBeforeRefresh(DataSet: TDataSet);
begin
  prevRec := qryAuditLoc.RecordCount;

end;

procedure TfAuditLocations.qryAuditLocAfterPost(DataSet: TDataSet);
begin
  MsgIfNoProducts;

  prevRec := qryAuditLoc.RecordCount;
end;

procedure TfAuditLocations.qryAuditLocAfterEdit(DataSet: TDataSet);
begin
  prevRec := qryAuditLoc.RecordCount;
end;

// wastage adjustment
procedure TfAuditLocations.btnWastageClick(Sender: TObject);
begin
  fWasteAdjLoc := TfWasteAdjLoc.Create(self);

  fWasteAdjLoc.Top := self.Top;
  fWasteAdjLoc.Left := self.Left;

  fWasteAdjLoc.ShowModal;

  fWasteAdjLoc.Free;
end;

procedure TfAuditLocations.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ShowClosePrompt then
  begin
    if isLC then
    begin
      if MessageDlg('You are about to cancel the current Line Check process!' + #13 + #13 +
        'Are you sure?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
        canClose := True
      else
        canClose := False;
    end
    else
    begin
      if MessageDlg('You are about to exit the Audit form. '+ #13+#10+
                    'If you made any changes they will be lost.', mtConfirmation, [mbOK,mbCancel], 0) = mrOK then
        canClose := True
      else
        canClose := False;
    end;
  end;
end;

procedure TfAuditLocations.wwGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if ((locTabs.ActivePage.Tag > 0) and (locTabs.ActivePage.Tag < 999)) then
  begin                                                                     // for the Location grids...
    if (Field.FieldName = 'Unit') then
    begin
      if qryAuditLoc.FieldByName('isPurchUnit').asboolean then
      begin
        aFont.Style := [fsBold];
      end
      else
      begin
        aFont.Style := [];
      end;
    end
    else if Field.FieldName = 'Wastage' then   // PurchStk is not visible here...
    begin
      if (Field.Asinteger >= -1099998) and (Field.Asinteger <= -900000) then
      begin
        aFont.Style := [fsBold];
        aFont.Color := clYellow;
        aBrush.Color := clBlack;
      end
      else if (qryAuditLocWasteTillA.asfloat <> 0) or (qryAuditLocWastePCA.asfloat <> 0) then
      begin
        aFont.Style := [fsBold];
      end
      else
      begin
        aFont.Style := [];
      end;
    end
    else if Field.FieldName = 'RecID' then
    begin
      if (qryAuditLocRecID.Asinteger > 1000000) then
      begin
        aFont.Color := clBlack;
        aBrush.Color := clAqua;
      end
      else
      begin
        aFont.Style := [];
      end;
    end;
  end
  else                                                        //for Complete Site or <No Location> grids...
  begin
    if Field.FieldName = 'Wastage' then
    begin
      if (qryAuditLocWasteTillA.asfloat <> 0) or (qryAuditLocWastePCA.asfloat <> 0) then
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
    end;
  end; 

  if (Field.FieldName = 'OpStk') then  // for all Tabs
  begin
    if Field.Asinteger = -888888 then
    begin
      aFont.Style := [fsBold];
      aFont.Color := clWhite;
      aBrush.Color := clBlue;
    end
    else if qryAuditLoc.FieldByName('shouldbe').asinteger = 1 then
    begin
      aFont.Style := [fsBold];
      aFont.Color := clWhite;
      aBrush.Color := clRed;
    end
    else if qryAuditLoc.FieldByName('shouldbe').asinteger = 2 then
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
  else if (Field.FieldName = 'Name') and (qryAuditLoc.FieldByName('MustCount').asboolean) then
  begin
    aFont.Color := clBlack;
    aBrush.Color := clYellow;
  end;
end;

procedure TfAuditLocations.rbExpOnlyClick(Sender: TObject);
begin
  ChangeSQL;
end;

procedure TfAuditLocations.wwGrid1Exit(Sender: TObject);
begin
  if wwgrid1.DataSource.DataSet.State = dsEdit then
    wwgrid1.DataSource.DataSet.Post;
end;

procedure TfAuditLocations.lblFormatDblClick(Sender: TObject);
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

procedure TfAuditLocations.LabelSearchDblClick(Sender: TObject);
begin
  if data1.ssDebug then
    dbtentcode.Visible := not dbtentcode.Visible;
end;

{Used to minimise the whole app if the current form is minimised}
procedure TfAuditLocations.WMSysCommand;
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

procedure TfAuditLocations.btnClearAuditClick(Sender: TObject);
var
  s1, ss : string;
begin
  s1 := '';

  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('update AuditLocationsCur set ActCloseStk = NULL, ACount = ''''');
    sql.Add('WHERE Locationid = ' + inttostr(loctabs.ActivePage.Tag));
    if sqSub <> '' then    sql.Add('AND ' + sqSUB);

    ss := '';
    if (qryAuditLoc.Filter <> '') and (qryAuditLoc.Filtered) then
    begin
      ss := StringReplace(qryAuditLoc.Filter, '= NULL', 'is NULL', [rfReplaceAll, rfIgnoreCase]);
      sql.Add('AND ' + ss);
    end;

    // what should I show???
    sqView := '';
    if rbExpOnly.Checked then
    begin
      sqView := 'AND ((shouldbe = 0) or ("ActCloseStk" <> 0) or ("WasteTill" <> 0) or ("WastePC" <> 0))';
    end;

    sql.Add(sqView);

    if (ss <> '') or (sqSub <> '') then
      if (loctabs.ActivePage.Tag > 0) then
        s1 := #13+''+#13+'(This applies only to Location: "' + loctabs.ActivePage.Caption +
          '" and to the items that satisfy the filter)'
      else
        s1 := #13+''+#13+'(This applies only to the items that satisfy the filter)'
    else
      if (loctabs.ActivePage.Tag > 0) then
        s1 := #13+''+#13+'(This applies only to Location: "' + loctabs.ActivePage.Caption + '")'
      else
        s1 := '';

    if MessageDlg('WARNING: All Audit Count figures will be cleared!'+ s1 +#13+''+#13+
      'Do you want to continue?', mtWarning, [mbYes,mbNo], 0) = mrYes then
    begin
      if qryAuditLoc.State = dsEdit then
        qryAuditLoc.Post;
      qryAuditLoc.DisableControls;

      execSQL;

      qryAuditLoc.requery;
      qryAuditLoc.EnableControls;
    end;
  end;
end;

procedure TfAuditLocations.MsgIfNoProducts;
begin
  if qryAuditLoc.RecordCount = 0 then
  begin
    if (qryAuditLoc.Filtered) or (FBoxSC.ItemIndex > 0) then
      showmessage('There are no products for the selected filter criteria.')
    else
      showmessage('There are no products available.');
  end;
end; // procedure..


procedure TfAuditLocations.qryAuditLocAfterOpen(DataSet: TDataSet);
begin
  MsgIfNoProducts;
end;


procedure TfAuditLocations.RadioButtonSearchClick(Sender: TObject);
begin
  if RadioButtonName.Checked then
  begin
    LabelSearch.Caption := 'Incremental Search (Next = F3)';

    wwSearch1.Visible := True;
    EditImpExRefSearch.Visible := False;

    wwSearch1.SearchField := 'Name';
    wwFind.SearchField := wwSearch1.SearchField;
    wwFind.MatchType := mtPartialMatchStart;
    wwSearch1.FindValue;
  end
  else if RadioButtonImpExRef.Checked then
  begin
    wwSearch1.Visible := False;
    EditImpExRefSearch.Visible := True;
    wwFind.MatchType := mtPartialMatchAny;
    wwFind.SearchField := 'ImpExRef';
    LabelSearch.Caption := 'Midword Search (Next = F3)';
  end;
end;

procedure TfAuditLocations.btnAutoFillClick(Sender: TObject);
begin
  if MessageDlg('All Audit Count figures that are now empty will be filled'+ #13+
                'with the Theo. Close figures (except when those are negative).'+#13+ ' ' + #13 +
    'Do you want to continue?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
  begin
    try
      screen.Cursor := crHourGlass;
      qryAuditLoc.DisableControls;

      with data1.adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('update AuditLocationsCur set actclosestk = thclosestk');
        sql.Add('WHERE Locationid = 999');  // ----------------------------- only for <No Location>
        sql.Add('and actclosestk is NULL   and   thclosestk >= 0');
        execSQL;

        close;
        sql.Clear;
        sql.Add('select * from AuditLocationsCur');
        sql.Add('WHERE Locationid = 999');  // ----------------------------- only for <No Location>
        open;
        while not eof do
        begin
          //import the floats in the string field
          edit;
          if FieldByName('ActCloseStk').asstring = '' then
            FieldByName('ACount').AsString := ''
          else
            FieldByName('ACount').AsString :=
              data1.dozGallFloatToStr(FieldByName('Unit').asstring, FieldByName('ActCloseStk').asfloat);
          post;
          next;
        end;
        close;
      end;

      qryAuditLoc.requery;
      qryAuditLoc.EnableControls;
    finally
      screen.Cursor := crDefault;
    end; // try .. finally
  end;
end;

procedure TfAuditLocations.btnEditListClick(Sender: TObject);
var
  fLocationList: TfLocationList;
  curRecNo : integer;

  setString, s1, sSizes, sPositions : string;
  wintop, winleft, winheight, winwidth, splitter, i : integer;
begin
  fLocationList := TfLocationList.Create(self);
  try
    curRecNo := qryAuditLoc.RecNo;
    fLocationList.siteIDstr := intToStr(data1.TheSiteCode);
    fLocationList.lookDiv.Items.Add(data1.TheDiv);
    fLocationList.lookDiv.ItemIndex := 0;

    fLocationList.lookLocation.ItemIndex := fLocationList.lookLocation.Items.IndexOf(
      loctabs.ActivePage.Caption + #9 + inttostr(loctabs.ActivePage.Tag));

    fLocationList.curLocName := fLocationList.lookLocation.Text;
    fLocationList.curLocIDstr := fLocationList.lookLocation.Value;

    fLocationList.curDivision := data1.TheDiv;
    fLocationList.curDivIDstr := inttoStr(data1.curDivIx);

    fLocationList.ReloadProducts;
    fLocationList.ReloadList;

    fLocationList.Caption := 'Quick Change Product List for Location "' + fLocationList.curLocName + '"';

    fLocationList.formH := -1;

    with dmado.adoqRun do
    begin
      // if there are any rows appended to the nromal list "for this Stock only" then they need to be added here...

      SQL.Clear;
      SQL.Add('INSERT INTO #LocationList ([RecID],[EntityCode],');
      SQL.Add('         [Unit],[ManualAdd],  [SCat], [Name], [Descr], [isPrepItem], [isPurchUnit], [recid2], inList)');
      SQL.Add('Select alc.[RecID],alc.[EntityCode],alc.[Unit],1, se.[SCat], se.[PurchaseName], ');
      SQL.Add('CASE se.ETCode WHEN ''P'' THEN ''Prep.- '' + isNULL(p.[Retail Description], '''')' +
                              'ELSE p.[Retail Description] END  as Descr,');
      SQL.Add('CASE se.ETCode WHEN ''P'' THEN se.ETCode ELSE '''' END as isPrepItem, ');
      SQL.Add('CASE WHEN se.PurchaseUnit = alc.Unit THEN 1 ELSE 0 END as isPurchUnit, alc.RecID, 0');
      SQL.Add('FROM [AuditLocationsCur] alc');
      SQL.Add('   join stkEntity se on alc.EntityCode = se.EntityCode');
      SQL.Add('   join products p on se.EntityCode = p.EntityCode');
      SQL.Add('WHERE alc.RecID > 1000000');
      SQL.Add('AND alc.LocationID = ' + fLocationList.curLocIDstr);
      ExecSQL;

      SQL.Clear;
      SQL.Add('UPDATE #LocationList SET RecID = sq1.RN');  // , RecID2 = 1
      SQL.Add('FROM (SELECT *, ROW_NUMBER() OVER(order by recid, recid2) as RN');
      SQL.Add('      FROM #LocationList) sq1');
      SQL.Add('WHERE #LocationList.RecID = sq1.RecID and #LocationList.RecID2 = sq1.RecID2');
      ExecSQL;

      // now save them to a temp table for later...
      close;
      sql.Clear;
      sql.Add('if EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID(''tempdb..#appendedToList''))');
      sql.Add('   DROP TABLE [#appendedToList]');
      execSQL;

      SQL.Clear;
      SQL.Add('Select alc.[RecID], alc.[EntityCode], alc.[Unit], alc.[RecID2] alcRecID, alc.[EntityCode] * 0 as Audit');
      SQL.Add('into [#appendedToList]  ');
      SQL.Add('FROM #LocationList alc');
      SQL.Add('WHERE alc.ManualAdd = 1');
      execSQL;

      SQL.Clear;
      SQL.Add('UPDATE #LocationList SET RecID2 = 1');
      ExecSQL;


      fLocationList.adotList.Requery;

      close;
      sql.Clear;
      SQL.Add('SELECT StringValue FROM LocalConfiguration');
      SQL.Add('WHERE KeyName = ''LocationListConfigWindow'' and SiteCode = '+ intToStr(data1.TheSiteCode));
      open;
      setString := fieldByName('StringValue').AsString;
      close;
    end;

    try
      if pos('=WinTop ', setString) <> 0 then
      begin
        s1 := copy(setString, 1, pos('=WinTop ', setString) - 1);
        wintop := strtoint(s1);
        Delete(setString, 1, pos('=WinTop ', setString) + 7);

        s1 := copy(setString, 1, pos('=WinLeft ', setString) - 1);
        winleft := strtoint(s1);
        Delete(setString, 1, pos('=WinLeft ', setString) + 8);

        s1 := copy(setString, 1, pos('=WinHeight ', setString) - 1);
        winheight := strtoint(s1);
        Delete(setString, 1, pos('=WinHeight ', setString) + 10);

        s1 := copy(setString, 1, pos('=WinWidth ', setString) - 1);
        winwidth := strtoint(s1);
        Delete(setString, 1, pos('=WinWidth ', setString) + 9);

        s1 := copy(setString, 1, pos('=Splitter ', setString) - 1);
        splitter := strtoint(s1);
        Delete(setString, 1, pos('=Splitter ', setString) + 9);

        s1 := copy(setString, 1, pos('=Positions ', setString) - 1);
        sPositions := s1;
        Delete(setString, 1, pos('=Positions ', setString) + 10);

        s1 := copy(setString, 1, pos('=Sizes ', setString) - 1);
        sSizes := s1;
        Delete(setString, 1, pos('=Sizes ', setString) + 6);

        fLocationList.Position := poDesigned;
        fLocationList.Top := wintop;
        fLocationList.Left := winleft ;
        fLocationList.formH := winheight ;
        fLocationList.formW := winwidth ;
        fLocationList.gridProds.Width := splitter ;
      end;

      // if either the Positions or the Sizes are missing then keep the Defaults...
      if (sPositions <> '') and (sSizes <> '') then
      begin
        // set the position array    it looks like n1, n2 ,n3 ,n4...n10
        for i := 1 to 10 do
        begin
          s1 := copy(sPositions, 1, pos(', ', sPositions) - 1);
          fLocationList.fieldPositions[i] := strtoint(s1);
          Delete(sPositions, 1, pos(', ', sPositions) + 1);
        end;

        // set the sizes array
        for i := 1 to 10 do
        begin
          s1 := copy(sSizes, 1, pos(', ', sSizes) - 1);
          fLocationList.fieldSizes[i] := s1;
          Delete(sSizes, 1, pos(', ', sSizes) + 1);
        end;

          // set the popup check state...
        for i := 0 to (fLocationList.gridPopup.items.Count - 1) do
        begin
          if fLocationList.gridPopup.Items[i].Enabled then
          begin
            fLocationList.gridPopup.Items[i].Checked := (fLocationList.fieldPositions[i+1] > 0);
          end;
        end;
      end;

      fLocationList.SetGridFields(true);
    except
        on E:Exception do
        begin
          log.event('Error reading Location List screen settings (' + setString + '). ErrMsg: ' + E.Message);
          exit;
        end;
    end;

    fLocationList.lookDiv.Enabled := FALSE;
    fLocationList.lookLocation.Enabled := FALSE;
    fLocationList.lblDivision.Enabled := FALSE;
    fLocationList.lblLocation.Enabled := FALSE;
    fLocationList.btnSave.Visible := FALSE;
    fLocationList.btnDiscard.Visible := FALSE;
    fLocationList.btnDone.Visible := FALSE;
    fLocationList.btnReturnChangeList.Visible := TRUE;
    fLocationList.btnReturnNoChange.Visible := TRUE;

    if fLocationList.ShowModal = mrOK then
    begin
      qryAuditLoc.DisableControls;
      qryAuditLoc.Requery;
      qryAuditLoc.RecNo := curRecNo;
      qryAuditLoc.EnableControls;
      log.event('Audit Loc, Edit List, User changed the List');
    end
    else
    begin
      log.event('Audit Loc, Edit List, User cancelled List change');
    end;
  finally
    fLocationList.Release;
  end;
end;

procedure TfAuditLocations.qryAuditLocRecIDGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if sender.asinteger > 1000000 then
    Text := '+' + inttostr(sender.asinteger - 1000000)
  else
    Text := sender.asstring;
end;

procedure TfAuditLocations.wwGrid1DblClick(Sender: TObject);
var
  s, sRowID, thisLoc : string;
  i : integer;
begin
  with data1.adoqRun do
  begin
    Close;
    sql.Clear;
    sql.Add('SELECT locs.[LocationID], locs.[LocationName], alc.RecID, alc.Unit, alc.ACount, alc.EntityCode  FROM ');
    sql.Add('  (SELECT loc.[LocationID], loc.[LocationName], loc.[Active] from stkLocations loc ');
    sql.Add('   UNION                                                                        ');
    sql.Add('   SELECT 999, ''<No Location>'', 0) locs                                       ');
    sql.Add('JOIN                                                                            ');
    sql.Add('  (select * from AuditLocationsCur WHERE entitycode = ' + qryAuditLoc.FieldByName('EntityCode').asstring);
    sql.Add('   AND LocationID > 0) alc             ');
    sql.Add('ON locs.LocationID = alc.LocationID    ');
    sql.Add('ORDER BY locationName, RecID           ');
    open;

    if (recordcount = 1) and (fieldByName('LocationID').AsInteger = 999) then
    begin
      s := 'This product is not in a Location List (it is only on the "<No Location>" page).';
    end
    else
    begin
      s := 'Product "' + qryAuditLoc.FieldByName('Name').asstring + '" has these Counts by Location (Row, Unit, Count):';
      thisLoc := '';
      i := 0;

      while ((not eof) and (i < 20)) do
      begin
        if fieldByName('LocationName').AsString <> thisLoc then
        begin
          thisLoc := fieldByName('LocationName').AsString;
          s := s + #13 + #13 + thisLoc + ': ';
        end;

        if fieldByName('RecID').asInteger > 1000000 then
          sRowID := '+' + inttostr(fieldByName('RecID').asInteger - 1000000)
        else
          sRowID := fieldByName('RecID').AsString;

        if fieldByName('ACount').AsString = '' then
          s := s + #13 + '    ' + Format('%5s', [sRowID]) + ') ' + #9#9 +
                       Format('%15s', ['"' + fieldByName('Unit').asstring + '"']) + #9#9 + ' <no entry> '
        else
          s := s + #13 + '    ' + Format('%5s', [sRowID]) + ') ' + #9#9 +
                       Format('%15s', ['"' + fieldByName('Unit').asstring + '"']) + #9#9 +
                       Format('%10s', [fieldByName('ACount').AsString]);

        inc(i);
        next;
      end;

      if i < recordcount then
        s := s + #13#13 + '(only 20 out of ' + inttostr(recordcount) + ' entries are shown due to lack of space)';
    end;

    close;
    ShowMessage(s);
  end;
end;

end.

// Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initial Catalog=Aztec362us;Data Source=so_cornel
