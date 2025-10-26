unit uPromotionList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ActnList, StdCtrls, ExtCtrls, Wwdbigrd, Wwdbgrid,
  uAztecLog, db, uPromotionFilterFrame, uGlobals;

type
  TPromotionList = class(TForm)
    Label1: TLabel;
    PromotionActions: TActionList;
    CreateNew: TAction;
    Edit: TAction;
    Delete: TAction;
    EnableDisable: TAction;
    CopyPromotion: TAction;
    Export: TAction;
    Import: TAction;
    Reports: TAction;
    cbHideDisabledPromotions: TCheckBox;
    ToggleHideDisabled: TAction;
    Panel2: TPanel;
    btNew: TButton;
    btEdit: TButton;
    btDelete: TButton;
    btEnable: TButton;
    btCopy: TButton;
    btImport: TButton;
    btExport: TButton;
    btReports: TButton;
    btClose: TButton;
    btPriorities: TButton;
    SetPromotionOrder: TAction;
    dbgPromotions: TwwDBGrid;
    ShowSummary: TAction;
    btSummary: TButton;
    imCheck: TImage;
    PromotionFilterFrame: TPromotionFilterFrame;
    btnSwipeCardRange: TButton;
    lastBevel: TBevel;
    Bevel2: TBevel;
    btnViewDeleted: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgPromotionsDblClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure CreateNewExecute(Sender: TObject);
    procedure EditExecute(Sender: TObject);
    procedure EnableDisableUpdate(Sender: TObject);
    procedure EnableDisableExecute(Sender: TObject);
    procedure PromotionActionsExecute(Action: TBasicAction;
      var Handled: Boolean);
    procedure ToggleHideDisabledExecute(Sender: TObject);
    procedure EditUpdate(Sender: TObject);
    procedure ReportsExecute(Sender: TObject);
    procedure DeleteExecute(Sender: TObject);
    procedure CopyPromotionExecute(Sender: TObject);
    procedure dbgPromotionsTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure ExportExecute(Sender: TObject);
    procedure ImportExecute(Sender: TObject);
    procedure ShowSummaryExecute(Sender: TObject);
    procedure dbgPromotionsDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure btnSwipeCardRangeClick(Sender: TObject);
    procedure dbgPromotionsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure DeleteUpdate(Sender: TObject);
    procedure CopyPromotionUpdate(Sender: TObject);
    procedure ExportUpdate(Sender: TObject);
    procedure ImportUpdate(Sender: TObject);
    procedure btPrioritiesClick(Sender: TObject);
    procedure btnViewDeletedClick(Sender: TObject);
  private
    procedure AppException(Sender: TObject; E: Exception);
    procedure EnableViewDeletedButton;
    procedure ArchiveErasePromoDetails;
  end;

var
  PromotionList: TPromotionList;

implementation

uses uAztecSplash, udmPromotions, uPromotionWizard, uPromotionReports, dADOAbstract,
  uPromotionSummary, StrUtils, uSwipeCardRanges, uPromoCommon, uPriorityTemplates,
  uSitePromotionPriorities, uViewDeleted, uWait;

{$R *.dfm}

// Initialisation

procedure TPromotionList.FormCreate(Sender: TObject);
begin
   Application.OnException := AppException;

   SplashForm := TSplashForm.Create(Self);
   SplashForm.Show;
   Sleep(50);
   SplashForm.Dismiss;

   PromotionFilterFrame.ApplyFilter := dmPromotions.SetMainPromotionListFilter;
   PromotionFilterFrame.ClearFilter := dmPromotions.ClearMainPromotionListFilter;
end;

procedure TPromotionList.AppException(Sender: TObject; E: Exception);
begin
  Log('** ERROR - Exception: ' + E.ClassName + ', ' + E.Message);
  Application.ShowException(E);
end;

procedure TPromotionList.FormShow(Sender: TObject);
var
  Sites: TStringList;
begin
  if IsSite and IsMaster then
  begin
    dmPromotions.cmdAddMissingSitesDefaultTemplates.Execute;
  end;

  if (dmPromotions.promoRetentionPeriod > 0) then
  begin
    btnViewDeleted.Visible := true;
    lastBevel.Left := btnViewDeleted.Left + btnViewDeleted.Width + 2;
    try
      ArchiveErasePromoDetails;
    except
      on E : Exception do
      begin
        Log('Del Promo', 'ERROR in ArchiveErasePromoDetails' +
        ' ERR MSG: ' + E.Message);
        showMessage('ERROR in Deleted Promotions Maintenance process ' + #13 +
          'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.');
      end;
    end;
    EnableViewDeletedButton;
  end
  else
  begin
    btnViewDeleted.Visible := false;
    lastBevel.Left := btnSwipeCardRange.Left + btnSwipeCardRange.Width + 2;
  end;     

  with dbgPromotions do   // grid field names, etc...
  begin
    Selected.Clear;

    Selected.Add('CreatedAt'#9'20'#9'Created By'#9#9);
    Selected.Add('Name'#9'25'#9'Name'#9#9);
    Selected.Add('Description'#9'50'#9'Description'#9#9);
    Selected.Add('PromoTypeName'#9'11'#9'Type'#9#9);
    Selected.Add('EventOnly'#9'8'#9'Evt. Only'#9#9);

    if dmPromotions.usePromoDeals then
    begin
      self.ClientWidth := 965;
      Selected.Add('UserSelectsProducts'#9'4'#9'Deal'#9#9);
    end
    else
    begin
      self.ClientWidth := 934;
    end;

    Selected.Add('PromotionStatusLookup'#9'10'#9'Status'#9#9);
    Selected.Add('StartDate'#9'10'#9'Start Date'#9#9);
    Selected.Add('EndDate'#9'10'#9'End Date'#9#9);

    ApplySelected;
  end;

  dmPromotions.qPromotions.Parameters.ParamByName('sitecode').Value := IntToStr(dmPromotions.SiteCode);
  dmPromotions.qPromotions.Active := True;
  cbHideDisabledPromotions.Checked := dmPromotions.PromotionsHideDisabled;
  dmPromotions.UpdatePromotionsQuery;

  Sites := TStringList.Create;
  try
    with dmPromotions.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select 0 as SiteCode, ''Head Office'' as Name');
      SQL.Add('union');
      SQL.Add('select distinct p.SiteCode, s.Name');
      SQL.Add('from promotion p');
      SQL.Add('join ac_Site s');
      SQL.Add('on p.SiteCode = s.Id');
      Open;

      while not EOF do
      begin
        Sites.Add(FieldByName('Name').AsString + '=' + FieldByName('SiteCode').AsString);
        Next;
      end;
    end;
    PromotionFilterFrame.SiteList := Sites;
  finally
    Sites.Free;
  end;
end;

procedure PleaseWait(barPercent: smallint; actionText: string);
begin
  if fwait <> nil then
    fwait.UpdateBar(barPercent,actionText);
end; 

procedure TPromotionList.ArchiveErasePromoDetails;
var
  recs : string;
  dt1 : tdatetime;
begin
  fwait := Tfwait.Create(self);
  fwait.Show;

  try
    PleaseWait(1,'Deleted Promotions maintenance started...');
    sleep(500);
    Log(' Promo Maint', 'Deleted Promotions maintenance started (retention period: ' +
     inttostr(dmPromotions.promoRetentionPeriod) + ' days)');


    // this procedure no longer erases/archives details for Promos deleted before upgrade
    // to Aztec 3.26. That work is done externally (see sp_PromoBatchArchiveErase and PASTri.exe)
    with dmPromotions.adoqRun do
    begin
      // see if any Archived promotions expired...
      Close;
      SQL.Clear;
      SQL.Add('IF OBJECT_ID(''tempdb..#PromoIds'') IS NOT NULL DROP TABLE #PromoIds');
      ExecSQL;

      SQL.Clear;
      SQL.Add('declare @sitecode int = ' + inttostr(uGlobals.SiteCode));
      SQL.Add('create table #PromoIds (pid bigint)');

      SQL.Add('insert #PromoIds ');
      SQL.Add('SELECT p.PromotionID');
      SQL.Add('FROM Promotion_Archive p where Restored = 0 and Deleted = 0 and SiteCode = @SiteCode ');
      SQL.Add('AND ( CAST(ArchivedDT AS date) < DATEADD(dd, ' +
                inttostr(-1 * dmPromotions.promoRetentionPeriod) + ', CAST(GETDATE() AS date)) )');

      PleaseWait(10, 'Looking for Promotions Archived more than ' +
         inttostr(dmPromotions.promoRetentionPeriod) + ' days ago...');

      ExecSQL;
      sleep(400);

      Close;
      SQL.Clear;
      SQL.Add('select count(*) from #PromoIds');
      open;
      recs := fields[0].AsString;
      close;

      if recs <> '0' then
      begin
        Log(' Promo Maint', 'Deleting Archived details for ' + recs + ' Promotions (archived more than ' +
         inttostr(dmPromotions.promoRetentionPeriod) + ' days ago)...');
        PleaseWait(15, 'Deleting Archived details for ' + recs + ' Promotions......');
        sleep(200);
        dt1 := Now;

        dmPromotions.EraseExpiredArchivedPromoDetails;

        Log(' Promo Maint', 'Deleting Archived details for ' + recs + ' Promotions - Done, time taken: ' +
          formatDateTime('hh:nn:ss:zzz', Now - dt1));
        PleaseWait(95, 'Deleting Archived details for ' + recs + ' Promotions - Done');
        sleep(300);
      end;

      Log(' Promo Maint', 'Deleted Promotions maintenance finished.');
    end;

    PleaseWait(100,'Deleted Promotions maintenance finished.');
    sleep(400);
  finally
    if fwait <> nil then fwait.free;
  end;
end;

// Misc GUI stuff

procedure TPromotionList.EnableViewDeletedButton;
begin
  if not btnViewDeleted.Visible then exit;

  with dmPromotions.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('declare @sitecode int = ' + inttostr(uGlobals.SiteCode));
    SQL.Add('select sum(cct) as totc from');
    SQL.Add(' (select COUNT(*) as cct from PromotionPrices_Archive where SiteCode = @sitecode');
    SQL.Add('  union select COUNT(*) from PromotionSaleGroup_Archive where SiteCode = @sitecode');
    SQL.Add('  union select COUNT(*) from PromotionSaleGroupDetail_Archive where SiteCode = @sitecode) sq');
    Open;

    btnViewDeleted.Enabled := FieldByName('totc').AsInteger > 0;
  end;
end;


procedure TPromotionList.dbgPromotionsDblClick(Sender: TObject);
var
  Point: TPoint;
begin
  Point := TwwDBGrid(sender).ScreenToClient(Mouse.CursorPos);
  if TwwDBGrid(sender).MouseCoord(Point.x, Point.y).y > 0 then
    Edit.Execute;
end;

procedure TPromotionList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dmPromotions.qPromotions.Active := False;
end;

procedure TPromotionList.btCloseClick(Sender: TObject);
begin
  Log('Promotion Grid', 'Close Button pressed.');
  dmPromotions.InsertMissingPromotionPriorities;
  Close;
end;

// Actions

procedure TPromotionList.CreateNewExecute(Sender: TObject);
begin
  Log('Promotion Grid', 'New promotion pressed.');
  if TPromotionWizard.ShowWizard(-1, -1, dmPromotions.SiteCode, True) then
    dmPromotions.UpdatePromotionsQuery;
end;

procedure TPromotionList.EditUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled :=
    dbgPromotions.DataSource.DataSet.RecordCount <> 0;
end;

procedure TPromotionList.EditExecute(Sender: TObject);
begin
  Log('Promotion Grid', 'Edit promotion pressed.');
  if dbgPromotions.DataSource.Dataset.RecordCount = 0 then
    raise Exception.Create('Please pick a promotion to edit first');
  Log('  Copy Promotion - ', dbgPromotions.DataSource.DataSet.FieldByName('PromotionID').AsString);

  if TPromotionWizard.ShowWizard(
      TLargeintField(dbgPromotions.DataSource.DataSet.FieldByName('PromotionID')).AsLargeInt,
      TLargeintField(dbgPromotions.DataSource.DataSet.FieldByName('PromotionID')).AsLargeInt,
      dbgPromotions.DataSource.DataSet.FieldByName('SiteCode').AsInteger,
      dbgPromotions.DataSource.DataSet.FieldByName('CreatedOnThisSite').AsBoolean
    ) then
    dmPromotions.UpdatePromotionsQuery;
end;

procedure TPromotionList.EnableDisableUpdate(Sender: TObject);
var
  Dataset: TDataset;
begin
  // User is not allowed to enable or disable an promo with status of unpriced
  Dataset := dbgPromotions.DataSource.DataSet;
  TAction(Sender).Enabled := (Dataset.RecordCount <> 0) and dbgPromotions.DataSource.DataSet.FieldByName('CreatedOnThisSite').AsBoolean;
  if Dataset.RecordCount <> 0 then
    case TPromotionStatus(Dataset.FieldByName('Status').AsInteger) of
      psEnabled: TAction(Sender).Caption := 'Disable';
      psDisabled: TAction(Sender).Caption := 'Enable';
      psUnpriced: TAction(Sender).Enabled := False;
    end;
end;

procedure TPromotionList.EnableDisableExecute(Sender: TObject);
var
  Dataset: TDataset;
  mr: TModalResult;

  procedure SetStatus(Status: TPromotionStatus);
  begin
    Dataset.Edit;
    Dataset.FieldByName('Status').AsInteger := Ord(Status);
    Dataset.Post;
  end;

  function PromoIsIncludedInEvent: Boolean;
  begin
    with dmPromotions.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Append('IF EXISTS(SELECT PromotionID');
      SQL.Append('          FROM PromotionEventStatus');
      SQL.Append('          WHERE EnabledPromotionID = ' + Dataset.FieldByName('PromotionID').AsString +')');
      SQL.Append('  SELECT 1 as IncludedInEvents');
      SQL.Append('ELSE');
      SQL.Append('  SELECT 0 as IncludedInEvents');
      Open;

      if not EOF then
        Result := FieldByName('IncludedInEvents').AsInteger > 0
      else
        Result := False;
    end;
  end;

  procedure RemoveFromEvents;
  begin
    with dmPromotions.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Append('DELETE PromotionEventStatus');
      SQL.Append('WHERE EnabledPromotionID = ' + Dataset.FieldByName('PromotionID').AsString);
      ExecSQL;
    end;
  end;
begin
  Log('Promotion Grid', 'Enable/Disable promotion pressed.');

  if dbgPromotions.DataSource.Dataset.RecordCount = 0 then
    raise Exception.Create('Please pick a promotion to '+TAction(Sender).Caption+' first');
  Dataset := dbgPromotions.DataSource.DataSet;
  if Dataset.RecordCount <> 0 then
    case TPromotionStatus(Dataset.FieldByName('Status').AsInteger) of
      psEnabled:
      begin
        if PromoIsIncludedInEvent then
        begin
          mr := MessageDlg('This Promotion is included in one or more Events.' + #13#10 +
                           'Do you wish to remove this Promotion from all Events which include it?',
                           mtConfirmation,
                           [mbYes,mbNo],
                           0);
          if mr = mrYes then
            RemoveFromEvents;
        end;

        SetStatus(psDisabled);
        Log('  Disable Promotion - ', DataSet.FieldByName('PromotionID').AsString);
      end;
      psDisabled:
      begin
        SetStatus(psEnabled);
        Log('  Enable Promotion - ', DataSet.FieldByName('PromotionID').AsString);
      end;
    end;
end;

procedure TPromotionList.PromotionActionsExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
  dbgPromotions.SetFocus;
end;

procedure TPromotionList.ToggleHideDisabledExecute(Sender: TObject);
begin
  if cbHideDisabledPromotions.Checked then
     Log('Promotion Grid', 'cbHideDisabledPromotions Checked')
  else
     Log('Promotion Grid', 'cbHideDisabledPromotions Unchecked');

  dmPromotions.PromotionsHideDisabled := cbHideDisabledPromotions.Checked;
end;

procedure TPromotionList.ReportsExecute(Sender: TObject);
begin
  Log('Promotion Grid', 'Reports pressed.');
  TPromotionReports.ShowDialog;
end;

procedure TPromotionList.DeleteExecute(Sender: TObject);
begin
  Log('Promotion Grid', 'Delete promotion pressed.');
  if dbgPromotions.DataSource.Dataset.RecordCount = 0 then
    raise Exception.Create('Please pick a promotion to delete first');
  if MessageDlg(Format('Do you want to delete promotion ''%s''?',[dbgPromotions.DataSource.Dataset.FieldByName('Name').AsString]),
     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dmPromotions.BeginHourglass;
    with dmPromotions do try
      Log('  Delete Promotion - ', qPromotions.FieldByName('PromotionID').AsString);

      // by doing the Archive first only Details that are still active (Deleted=0) now are saved; 
      // if the Promotion is later restored it will only have the details current now.
      ArchiveOneDeletedPromotion(qPromotions.FieldByName('PromotionID').asString);

      adoqRun.SQL.Text := Format('DELETE Promotion where PromotionID = %s',
        [qPromotions.FieldByName('PromotionID').AsString]);
      adoqRun.ExecSQL;

      UpdatePromotionsQuery;
    finally
      dmPromotions.EndHourglass;
    end;

    EnableViewDeletedButton;
  end;
end;

procedure TPromotionList.CopyPromotionExecute(Sender: TObject);
begin
  Log('Promotion Grid', 'Copy promotion pressed.');
  if dbgPromotions.DataSource.Dataset.RecordCount = 0 then
    raise Exception.Create('Please pick a promotion to copy first');
  Log('  Copy Promotion - ', 'ID: ' + dbgPromotions.DataSource.DataSet.FieldByName('PromotionID').AsString +
                                                  ', SiteCode: ' + dbgPromotions.DataSource.DataSet.FieldByName('SiteCode').AsString);

  if TPromotionWizard.ShowWizard(
      -1,
      TLargeIntField(dbgPromotions.DataSource.DataSet.FieldByName('PromotionId')).AsLargeInt,
      dbgPromotions.DataSource.DataSet.FieldByName('SiteCode').AsInteger,
      dbgPromotions.DataSource.DataSet.FieldByName('CreatedOnThisSite').AsBoolean
    ) then
    dmPromotions.UpdatePromotionsQuery;
end;

procedure TPromotionList.dbgPromotionsTitleButtonClick(Sender: TObject;
  AFieldName: String);
var
  i: integer;
begin
  Log('Promotion Grid', 'dbgPromotionsTitleButtonClick.');
  with TwwDBGrid(Sender) do
  begin
    for i := 0 to Pred(Selected.Count) do
      if Copy(Selected[i], 1, length(AFieldName)) = AFieldName then
       dmPromotions.TogglePromotionsFieldOrder(i+1);
  end;
end;

procedure TPromotionList.ExportExecute(Sender: TObject);
begin
  Log('Promotion Grid', 'Export promotion pressed.');
  dmPromotions.BeginHourglass;
  try
    if dbgPromotions.DataSource.Dataset.RecordCount = 0 then
      raise Exception.Create('Please pick a promotion to export first');
    Log('  Export Promotion - ', dbgPromotions.DataSource.DataSet.FieldByName('PromotionID').AsString);
    TPromotionWizard.DoExportImport(dbgPromotions.DataSource.DataSet.FieldByName('SiteCode').AsInteger,
                                    TLargeIntField(dbgPromotions.DataSource.DataSet.FieldByName('PromotionID')).AslargeInt,
                                    False);
  finally
    dmPromotions.EndHourglass;
  end;
end;

procedure TPromotionList.ImportExecute(Sender: TObject);
begin
  Log('Promotion Grid', 'Import promotion pressed.');
  dmPromotions.BeginHourglass;
  try
    if dbgPromotions.DataSource.Dataset.RecordCount = 0 then
      raise Exception.Create('Please pick a promotion to import first');
    Log('  Import Promotion - ', dbgPromotions.DataSource.DataSet.FieldByName('PromotionID').AsString);
    TPromotionWizard.DoExportImport(dbgPromotions.DataSource.DataSet.FieldByName('SiteCode').AsInteger,
                                    TLargeIntField(dbgPromotions.DataSource.DataSet.FieldByName('PromotionID')).AsLargeInt,
                                    True);
    // Promotion status may have changed, so update view
    dmPromotions.UpdatePromotionsQuery;
  finally
    dmPromotions.EndHourglass;
  end;
end;

procedure TPromotionList.ShowSummaryExecute(Sender: TObject);
begin
  // vk call will be inside ShowPreview where tariffThread is executed
  //dmPromotions.AwaitPreload(pwTarrifPrices);
  TPromotionSummary.ShowPreview(TLargeIntField(dbgPromotions.DataSource.DataSet.FieldByName('PromotionID')).AsLargeInt);
end;

procedure TPromotionList.dbgPromotionsDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
var
  GlyphRect, TmpRect: TRect;
  GlyphBitmap: TBitmap;
begin
  if (Field.FieldName = 'EventOnly') or (Field.FieldName = 'UserSelectsProducts') then
  begin
    TwwDBGrid(Sender).Canvas.Pen.Style := psClear;
    TwwDBGrid(Sender).Canvas.Rectangle(Rect);
    TwwDBGrid(Sender).Canvas.Pen.Style := psSolid;
    if Field.AsBoolean then
      with TwwdbGrid(sender) do
      begin
        GlyphRect := imCheck.Picture.Bitmap.Canvas.ClipRect;
        Glyphbitmap := imCheck.Picture.Bitmap;

        TmpRect := Rect;
        TmpRect.Left := TmpRect.Left + ((TmpRect.Right - TmpRect.Left) - (GlyphRect.Right - GlyphRect.Left)) div 2;
        TmpRect.Top := TmpRect.top +  (
          (tmprect.Bottom - tmprect.Top) -
          (GlyphRect.Bottom - GlyphRect.Top)
        ) div 2;

        TmpRect.Top := TmpRect.Top + 1;

        TmpRect.Right := TmpRect.Left + (GlyphRect.Right - GlyphRect.Left);
        TmpRect.Bottom := TmpRect.Top + (GlyphRect.Bottom - GlyphRect.Top);
        Canvas.BrushCopy(TmpRect, GlyphBitmap, GlyphRect, clAqua);
      end;
  end;
end;

procedure TPromotionList.btnSwipeCardRangeClick(Sender: TObject);
begin
  uSwipeCardRanges.ShowSwipeCardRanges(True, (not IsMaster), upromocommon.DisablePromotionControls);
end;


procedure TPromotionList.dbgPromotionsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if not dmPromotions.qPromotionsCreatedOnThisSite.AsBoolean then
  begin
    AFont.Color := clGrayText;
  end;

  dbgPromotions.SelectedIndex;
end;

procedure TPromotionList.DeleteUpdate(Sender: TObject);
var
  Dataset: TDataset;
begin
  Dataset := dbgPromotions.DataSource.DataSet;
  if (Dataset.RecordCount <> 0) then
    TAction(Sender).Enabled := DataSet.FieldByName('CreatedOnThisSite').AsBoolean
  else
    TAction(Sender).Enabled := False;
end;

procedure TPromotionList.CopyPromotionUpdate(Sender: TObject);
var
  Dataset: TDataset;
begin
  Dataset := dbgPromotions.DataSource.DataSet;
  if (Dataset.RecordCount <> 0) then
    (Sender as TAction).Enabled := Dataset.FieldByName('CreatedOnThisSite').AsBoolean
  else
    (Sender as TAction).Enabled := False;
end;

procedure TPromotionList.ExportUpdate(Sender: TObject);
var
  Dataset: TDataset;
begin
  Dataset := dbgPromotions.DataSource.DataSet;
  if (Dataset.RecordCount <> 0) then
    TAction(Sender).Enabled := DataSet.FieldByName('CreatedOnThisSite').AsBoolean
  else
    TAction(Sender).Enabled := False;
end;

procedure TPromotionList.ImportUpdate(Sender: TObject);
var
  Dataset: TDataset;
begin
  Dataset := dbgPromotions.DataSource.DataSet;
  if (Dataset.RecordCount <> 0) then
    TAction(Sender).Enabled := DataSet.FieldByName('CreatedOnThisSite').AsBoolean
  else
    TAction(Sender).Enabled := False;
end;

procedure TPromotionList.btPrioritiesClick(Sender: TObject);
var
  PriorityTemplateWindow: TfPriorityTemplates;
  FilterText: String;
begin
  Log('Promotion Grid', 'Priorities pressed.');
  if PromotionFilterFrame.chkbxFiltered.Checked then
    FilterText := PromotionFilterFrame.edtFilter.Text
  else
    FilterText := '';

  // note - we test for IsSite as single site masters don't use templates & should see the site window
  if IsSite then
  begin
    TfSitePromotionPriorities.ShowDialog(FilterText, PromotionFilterFrame.chkbxMidwordSearch.Checked);
  end
  else
  begin
    PriorityTemplateWindow := TfPriorityTemplates.getWindowInstance(
                FilterText, PromotionFilterFrame.chkbxMidwordSearch.Checked);
    try
      PriorityTemplateWindow.ShowModal;
    finally
      PriorityTemplateWindow.Free;
    end;
  end;
end;

procedure TPromotionList.btnViewDeletedClick(Sender: TObject);
var
  fViewDeleted: TfViewDeleted;
begin
  fViewDeleted := TfViewDeleted.Create(self);
  try
    fViewDeleted.ShowModal;
    dmPromotions.UpdatePromotionsQuery;
  finally
    fViewDeleted.Free;
  end;

  EnableViewDeletedButton;
end;

end.
