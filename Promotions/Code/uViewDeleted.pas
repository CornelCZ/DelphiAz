unit uViewDeleted;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uAztecLog, uGlobals, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid,
  StdCtrls, wwfltdlg, wwDialog, Wwlocate, Wwkeycb, Buttons, DB, ADODB, strUtils;

type
  TfViewDeleted = class(TForm)
    panelBottom: TPanel;
    panelTop: TPanel;
    GridDelPromos: TwwDBGrid;
    btnRestore: TButton;
    pnlSearch: TPanel;
    Label14: TLabel;
    rbSInc: TRadioButton;
    rbsMid: TRadioButton;
    btnPriorSearch: TBitBtn;
    btnNextSearch: TBitBtn;
    edSearch: TEdit;
    incSearch1: TwwIncrementalSearch;
    wwFind: TwwLocateDialog;
    Label13: TLabel;
    edFilt: TEdit;
    rbStart: TRadioButton;
    rbMid: TRadioButton;
    lblFilterStatus: TLabel;
    btnFilter: TBitBtn;
    btnNoFilter: TBitBtn;
    btnResetFilters: TBitBtn;
    lblProdCount: TLabel;
    lookType: TComboBox;
    cbDeal: TCheckBox;
    cbEvOnly: TCheckBox;
    LabelSubCategory: TLabel;
    Button1: TButton;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure GridDelPromosCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure GridDelPromosTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure rbSIncClick(Sender: TObject);
    procedure btnPriorSearchClick(Sender: TObject);
    procedure btnNextSearchClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFilterClick(Sender: TObject);
    procedure btnNoFilterClick(Sender: TObject);
    procedure btnResetFiltersClick(Sender: TObject);
  private
    { Private declarations }
    mainFilter : string;
    procedure SetGridTempTable;
    procedure SetMainFilter;
  public
    { Public declarations }
  end;

var
  fViewDeleted: TfViewDeleted;

implementation

uses udmPromotions;

{$R *.dfm}

procedure TfViewDeleted.FormShow(Sender: TObject);
begin
  dmPromotions.tViewDeleted.TableName := '#DelPromos';
  SetGridTempTable;
end;

procedure TfViewDeleted.SetGridTempTable;
begin
  GridDelPromos.DataSource.DataSet.DisableControls;
  GridDelPromos.DataSource.DataSet.Close;

  // create a Temp Table, fill it with the "header" of Deleted Promotions that have Archived Details
  with dmPromotions.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('declare @sitecode int = ' + inttostr(uGlobals.SiteCode));
    SQL.Add('IF OBJECT_ID(''tempdb..#DelPromos'') IS NOT NULL DROP TABLE #DelPromos');
    SQL.Add('SELECT p.Name, p.Description, p.EventOnly, p.ExtendedFlag, p.SiteCode, p.PromotionID, ');
    SQL.Add(' case when (ExtendedFlag = 1 and p.PromoTypeID = 3) ');
    SQL.Add('    then (''Enh. '' + pt.PromoTypeName) ELSE pt.PromoTypeName end as PromoTypeName,');
    SQL.Add(' case p.PromoTypeID when 4 then null else StartDate end as StartDate, ');
    SQL.Add(' EndDate, pa.ArchivedDT, p.UserSelectsProducts, p.LMDT ');
    SQL.Add('INTO #DelPromos ');
    SQL.Add('FROM (select * from Promotion_Repl where Deleted = 1 and SiteCode = @SiteCode) p ');
    SQL.Add('JOIN PromoType pt on p.PromoTypeID = pt.PromoTypeID ');
    SQL.Add('JOIN ');
    SQL.Add(' (select * from Promotion_Archive p1 where p1.Deleted = 0 and p1.Restored = 0');
    SQL.Add('  and ( EXISTS (SELECT 1 FROM PromotionPrices_Archive pp WHERE pp.PromotionID = p1.PromotionID) ');
    SQL.Add('      or EXISTS (SELECT 1 FROM PromotionSaleGroup_Archive g WHERE g.PromotionID = p1.PromotionID))');
    SQL.Add(' ) pa on pa.PromotionID = p.PromotionID');
    ExecSQL; 

    close;
    sql.Clear;
    sql.Add('select distinct PromoTypeName from #DelPromos');
    sql.Add('union select ('' - SHOW ALL - '')');
    open;
    first;

    lookType.Items.Clear;
    while not eof do
    begin
      lookType.Items.Add(FieldByName('PromoTypeName').asstring);
      next;
    end;
    close;
    lookType.Refresh;
    lookType.ItemIndex := 0;
  end;

  GridDelPromos.DataSource.DataSet.Open;

  with GridDelPromos, GridDelPromos.DataSource.DataSet do   // grid field names, etc...
  begin
    Selected.Clear;
    Selected.Add('Name'#9'21'#9'Name'               );
    Selected.Add('Description'#9'41'#9'Description' );
    Selected.Add('PromoTypeName'#9'12'#9'Type'      );
    Selected.Add('EventOnly'#9'6'#9'Evt Only'#9'F'  );
    Selected.Add('UserSelectsProducts'#9'5'#9'Deal' );
    Selected.Add('StartDate'#9'10'#9'Start Date'    );
    Selected.Add('EndDate'#9'10'#9'End Date'        );
    Selected.Add('ArchivedDT'#9'12'#9'Deleted On'   );
    ApplySelected;
  end;

  GridDelPromos.RefreshDisplay;
  GridDelPromos.Refresh;
  GridDelPromos.DataSource.DataSet.EnableControls;
  btnResetFiltersClick(self);
  GridDelPromos.DataSource.DataSet.First;
end;

procedure TfViewDeleted.btnRestoreClick(Sender: TObject);
var
  i, alreadyRestored, alreadyDeleted, restoredOk : integer;
  s : string;

  procedure DoRestore;
  begin
    with dmPromotions.adoqRun do
    begin
      close;
      SQL.Clear;
      SQL.Add('update i set lmdt = a.ArchivedDT');
      SQL.Add('from #PromoIds i join Promotion_Archive a on i.pid = a.PromotionId');
      ExecSQL;

      dmPromotions.RestoreArchivedPromotions; // try to Restore.....................

      // now check to see if any Promotion was restored by another User or Erased...
      SQL.Clear;
      SQL.Add('select * from #PromoIds where pid = -1');
      open;
      alreadyRestored := recordcount;

      close;
      SQL.Clear;
      SQL.Add('select * from #PromoIds where pid = -2');
      open;
      alreadyDeleted := recordcount;
      close;
    end;
  end;

begin
  if GridDelPromos.SelectedList.Count > 1 then
  begin
    if MessageDlg('WARNING!'+#13+'This action will Restore the ' +
          inttostr(GridDelPromos.SelectedList.Count)  + ' selected Promotions'+#13+#13+
          'Click "OK" to Restore.'+#13+
          'Click "Cancel" to abort and keep the Promotions deleted.',
          mtWarning,[mbOK,mbCancel],0) = mrOK then
    begin
      screen.Cursor := crHourGlass;
      with dmPromotions.adoqRun do
      begin
        Close;
        SQL.Clear;
        SQL.Add('IF OBJECT_ID(''tempdb..#PromoIds'') IS NOT NULL DROP TABLE #PromoIds');
        SQL.Add('create table #PromoIds (pid bigint, lmdt datetime)');
        ExecSQL;

        SQL.Clear;
        for i := 0 to GridDelPromos.SelectedList.Count - 1 do
        begin
          dmPromotions.tViewDeleted.GotoBookmark(GridDelPromos.SelectedList.items[i]);
          SQL.Add('insert #PromoIds (pid) values(' +
             dmPromotions.tViewDeleted.fieldByName('PromotionID').AsString + ')');
        end;
        i := GridDelPromos.SelectedList.Count;
        ExecSQL;

        DoRestore;

        restoredOK := i - alreadyRestored - alreadyDeleted;

        Log('Del Promo', inttostr(i) + ' Promotions to Restore; ' + inttostr(restoredOK) + ' restored, ' +
           inttostr(alreadyRestored) + ' already restored, ' + inttostr(alreadyDeleted) + ' already erased.');


        s := 'Restore Promotions result (selected to Restore ' + inttostr(i) + ' promotions):' +#10#13 +
          '  Promotions Restored and ready to use: ' + inttostr(restoredOK);

        if alreadyRestored > 0 then
          s := s + #10#13 + '  Already restored by another User: ' + inttostr(alreadyRestored) + ' (and ready to use)';

        if alreadyDeleted > 0 then
          s := s + #10#13 + '  Not restored, Retention Period just expired: ' + inttostr(alreadyDeleted) + ' (permanently deleted)';

        showMessage(s);

        close;
      end;

      GridDelPromos.SelectedList.Clear;
      SetGridTempTable;
      screen.Cursor := crDefault;
    end;
  end
  else
  begin
    if MessageDlg('WARNING!'+#13+'This action will Restore the "' +
          dmPromotions.tViewDeleted.fieldByName('Name').AsString  + '" Promotion'+ #13 +
          '(deleted on ' + dmPromotions.tViewDeleted.fieldByName('ArchivedDT').AsString + ')'+#13+#13+
          'Click "OK" to Restore the selected Promotion.'+#13+
          'Click "Cancel" to abort and keep the Promotion deleted.',
          mtWarning,[mbOK,mbCancel],0) = mrOK then
    begin
      screen.Cursor := crHourGlass;
      with dmPromotions.adoqRun do
      begin
        Close;
        SQL.Clear;
        SQL.Add('IF OBJECT_ID(''tempdb..#PromoIds'') IS NOT NULL DROP TABLE #PromoIds');
        SQL.Add('create table #PromoIds (pid bigint, lmdt datetime)');
        SQL.Add('insert #PromoIds (pid) values(' + dmPromotions.tViewDeleted.fieldByName('PromotionID').AsString + ')');
        ExecSQL;

        DoRestore;

        if alreadyRestored > 0 then
        begin
          Log('Del Promo', 'Promotion to be Restored was restored by another User.');
          showMessage('The Promotion you were trying to Restore was already restored by another User.' +
            #10#13 + 'This is just information, there is no error, the Promotion is now ready to use.');
        end
        else if alreadyDeleted > 0 then
        begin
          Log('Del Promo', 'Promotion to be Restored was erased by another User starting Promotions.');
          showMessage('The Promotion you were trying to Restore is no longer ' +
            #10#13 +  'available because its Retention Period has just expired.');
        end
        else
        begin
          showMessage('Promotion Restored and ready to use.');
        end;
        close;
      end;

      SetGridTempTable;
      screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfViewDeleted.GridDelPromosCalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  if '[' + (AFieldName) + ']'  = dmPromotions.tViewDeleted.IndexFieldNames then
  begin
    aBrush.Color := clYellow;
    aFont.Color := clBlack;
  end
  else if '[' + (AFieldName + '] DESC') = dmPromotions.tViewDeleted.IndexFieldNames then
  begin
    aBrush.Color := clRed;
    aFont.Color := clWhite;
  end;
end;

procedure TfViewDeleted.GridDelPromosTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  with dmPromotions.tViewDeleted do
  begin
    DisableControls;

    if '[' + (AFieldName) + ']' = IndexFieldNames then // already Yellow, go to red...
    begin
      IndexFieldNames := '[' + AFieldName + '] DESC';
    end
    else if '[' + (AFieldName + '] DESC') = IndexFieldNames then // already Red, go to nothing...
    begin
      IndexFieldNames := 'ArchivedDT DESC, StartDate DESC, Name ';
    end
    else
    begin
      IndexFieldNames := '[' + AFieldName + ']';
    end;

    EnableControls;
  end;
end;

procedure TfViewDeleted.rbSIncClick(Sender: TObject);
begin
  incSearch1.Visible := rbsinc.Checked;
  edSearch.Visible := not incSearch1.Visible;

  if incSearch1.Visible then
  begin
    wwFind.MatchType := mtPartialMatchStart;
    incSearch1.SetFocus;
  end
  else
  begin
    wwFind.MatchType := mtPartialMatchAny;
    edSearch.SetFocus;
  end;
end;

procedure TfViewDeleted.btnPriorSearchClick(Sender: TObject);
var
   SavePlace: TBookmark;
   matchyes : boolean;
   tempTab : TADOTable;
begin
  if incSearch1.Visible then
    wwFind.FieldValue := incSearch1.Text
  else
    wwFind.FieldValue := edSearch.Text;

  if wwFind.FieldValue = '' then
    exit;

  tempTab := TADOTable(incSearch1.DataSource.Dataset); // ensures the correct Table is searched

  // find prior has to be done programatically...
  with tempTab do
  begin
    disablecontrols;
    SavePlace := GetBookmark; { get a bookmark so that we can return to the same record }
    try
      matchyes := false;
      while (not bof) do
      begin
        Prior;
        // check for match  ... incSearch1.SearchField ensures the correct field name is used
        if rbsInc.Checked then // incremental.
          matchyes := AnsiStartsText(incSearch1.Text, FieldByName(incSearch1.SearchField).asstring)
        else                   // mid-word.
          matchyes := AnsiContainsText(FieldByName(incSearch1.SearchField).asstring,edSearch.Text);

        if matchyes then break;
      end;
      
      if not matchyes then  {if match not found Move back to the bookmark}
      begin
        GotoBookmark(SavePlace);
        showMessage('No More Matches found!');
      end;
    finally
      FreeBookmark(SavePlace);
    end;
    enablecontrols;
  end;
end;

procedure TfViewDeleted.btnNextSearchClick(Sender: TObject);
begin
  if incSearch1.Visible then
    wwFind.FieldValue := incSearch1.Text
  else
    wwFind.FieldValue := edSearch.Text;

  if wwFind.FieldValue = '' then
    exit;
  wwFind.FindNext;
end;

procedure TfViewDeleted.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F2: begin
             Key := 0;
             btnPriorSearchClick(Sender);
           end;
    VK_F3: begin
             Key := 0;
             btnNextSearchClick(Sender);
           end;
    VK_F5: begin
             Key := 0;
             btnFilterClick(Sender);
           end;
    VK_F6: begin
             Key := 0;
             btnNoFilterClick(Sender);
           end;
  end; // case..
end;

procedure TfViewDeleted.btnFilterClick(Sender: TObject);
begin
  SetMainFilter;

  if mainFilter = '' then
  begin
    dmPromotions.tViewDeleted.Filter := '';
    dmPromotions.tViewDeleted.Filtered := False;
    showMessage('Filter conditions not set. No Filtering is done.');
    lblFilterStatus.Color := clGreen;
    lblFilterStatus.Caption := 'Filtering is OFF';
  end
  else
  begin
    dmPromotions.tViewDeleted.Filter := mainFilter;
    dmPromotions.tViewDeleted.Filtered := True;
    lblFilterStatus.Color := clRed;
    lblFilterStatus.Caption := 'Filtering is ON';
  end;

  dmPromotions.tViewDeleted.Requery;
  GridDelPromos.RefreshDisplay;
  lblProdCount.Caption := inttostr(dmPromotions.tViewDeleted.recordcount);
  lblProdCount.Color := lblFilterStatus.Color;
  Application.ProcessMessages;
end;

procedure TfViewDeleted.SetMainFilter;
var
  s1, filt1, filt2, filt3, filtName : string;
begin
  if lookType.Text <> ' - SHOW ALL - ' then filt1 := ' and PromoTypeName = ' + quotedStr(lookType.Text);
  if cbEvOnly.Checked         then filt2 := ' and EventOnly = 1';
  if cbDeal.Checked    then filt3 := ' and UserSelectsProducts = 1';

  s1 := trim(LowerCase(edFilt.Text));
  if s1 <> '' then
  begin
    if rbmid.Checked then
      s1 := '*' + s1;
    filtName := ' and ([Name] LIKE ' + quotedStr(s1 + '*') + ' or Description LIKE ' + quotedStr(s1 + '*') + ')';
  end;

  mainFilter := filt1 + filt2 + filt3 + filtName;
  Delete(mainFilter, 1, 5);
end;

procedure TfViewDeleted.btnNoFilterClick(Sender: TObject);
begin
  dmPromotions.tViewDeleted.Filter := '';
  dmPromotions.tViewDeleted.Filtered := False;

  mainFilter := '';
  lblFilterStatus.Color := clGreen;
  lblFilterStatus.Caption := 'Filtering is OFF';

  dmPromotions.tViewDeleted.Requery;
  GridDelPromos.RefreshDisplay;
  lblProdCount.Caption := inttostr(dmPromotions.tViewDeleted.recordcount);
  lblProdCount.Color := lblFilterStatus.Color;
  Application.ProcessMessages;
end;

procedure TfViewDeleted.btnResetFiltersClick(Sender: TObject);
begin
  lookType.ItemIndex := 0;  // lookType.Text = ' - SHOW ALL - '

  cbEvOnly.Checked := FALSE;
  cbDeal.Checked := FALSE;
  edFilt.Text := '';

  dmPromotions.tViewDeleted.Filter := '';
  dmPromotions.tViewDeleted.Filtered := False;

  mainFilter := '';
  lblFilterStatus.Color := clGreen;
  lblFilterStatus.Caption := 'Filtering is OFF';

  dmPromotions.tViewDeleted.Requery;
  GridDelPromos.RefreshDisplay;
  lblProdCount.Caption := inttostr(dmPromotions.tViewDeleted.recordcount);
  lblProdCount.Color := lblFilterStatus.Color;
  Application.ProcessMessages;
end;

end.
