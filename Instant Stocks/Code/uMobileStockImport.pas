unit uMobileStockImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, ExtCtrls, Grids, DBGrids, uData1, ADODB, uADO,
  Wwdbigrd, Wwdbgrid, uLog, uStockLocationService;

type
  TfrmMobileStockCountImport = class(TForm)
    lblMobileStockHeader: TLabel;
    rgImportMethods: TRadioGroup;
    btnImport: TButton;
    btnCancel: TButton;
    dsMobileStockImports: TDataSource;
    ADOqMobileStockSessions: TADOQuery;
    wwDBGridMobileStockSessions: TwwDBGrid;
    ADOqRun: TADOQuery;
    lblHint: TLabel;
    lblDivision: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblThread: TLabel;
    lblByLoc: TLabel;
    qryMobileStockCountInLocation: TADOQuery;
    procedure btnImportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure wwDBGridMobileStockSessionsCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
  private
    { Private declarations }
    SelectedSessionLocationList: TStringList;
    SelectedSessionIdList: TStringList;
    procedure ShowValidMobileStockSessions;
    procedure SetSelectedSessionData();
    Procedure PrepareSessionStockCounts();
    procedure UpdateStockCountsFromImport;
    procedure FormatStockCountsForDisplayGrid;
    procedure PrepareImportCountsNotInConfiguredLocationList(sessionId: Int64; locationId: integer);
    procedure AddAdditionalLocationCountsToLocationList();
    function MobileStockRecordsWithLocationsExist(stockEndDate, stockRollEndDate: String) : boolean;
  public
    { Public declarations }

  end;

Const
  IMPORT_METHOD_OVERWRITE       = 0;
  IMPORT_METHOD_ADD_TO_EXISTING = 1;
  IMPORT_METHOD_UNAUDITED_ONLY  = 2;

procedure DisplayMobileStockImportForm;

implementation

{$R *.dfm}

procedure DisplayMobileStockImportForm;
var
  MobileStockImportForm: TfrmMobileStockCountImport;
begin
  MobileStockImportForm := TfrmMobileStockCountImport.Create(nil);

  try
    MobileStockImportForm.ShowModal;
  finally
    FreeAndNil(MobileStockImportForm);
  end;
end;

procedure TfrmMobileStockCountImport.btnImportClick(Sender: TObject);
var
  sDisplay, sLog, additionalItemsConflictList : string;
  conflictingRowCountDlgText: string;
  numberOfImportRecords: integer;
begin
  log.event('Mobile Stock Import: Begin - btnImportClick');

  if wwDBGridMobileStockSessions.SelectedList.Count = 0 then
  begin
    ShowMessage('No Mobile Stock sessions were selected.'+#13+
                'Use the Ctrl + Left mouse button click to select one or more records');
    Exit;
  end;

  ADOqMobileStockSessions.DisableControls;
  Screen.Cursor := crHourGlass;
  try
    try
      SetSelectedSessionData();
      PrepareSessionStockCounts();

      if data1.curByLocation then
      begin
        additionalItemsConflictList := StockLocationService.GetAdditionalItemsWithConflictingRows();

        if Length(additionalItemsConflictList) > 0 then
        begin
          conflictingRowCountDlgText := 'Multiple sessions contain conflicting product counts for the same location row.'+ #13 +
                     'These sessions need to be imported individually.' +#13#13 + additionalItemsConflictList;

          if StockLocationService.GetCountOfValidSessionImports() = 0 then
          begin
            MessageDlg(conflictingRowCountDlgText, mtWarning, [mbOk], 0);
            log.event('Mobile Stock Import: Import cancelled. Conflicting additional location product counts found: ' + additionalItemsConflictList);
            exit;
          end;

          if MessageDlg(conflictingRowCountDlgText + #13 +
                     'Click OK to import the remaining session location counts' +#13+
                     'Click Abort to cancel the import', mtWarning, [mbOk, mbAbort], 0) = mrOk then
          begin
            StockLocationService.RemoveSessionsWithConflictingLocationRows();
          end
          else
          begin
            log.event('Mobile Stock Import: User cancelled import due to conflicting additional location product counts found: ' + additionalItemsConflictList);
            exit;
          end;
        end;
      end;

      with ADOqRun do
      begin
        if data1.curByLocation then
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT COUNT(DISTINCT SessionID) as Sessions, COUNT(DISTINCT LocationId) as Locations, ');
          SQL.Add(' COUNT(DISTINCT ProductID) as Products, COUNT(*) as TotRows');
          SQL.Add('FROM #TempMobileStockImportCount');
          open;

          sDisplay := '-- Sessions: ' + fieldByName('Sessions').asstring + #13 +
                '-- Locations: ' + fieldByName('Locations').asstring + #13 +
                '-- Unique Products: ' + fieldByName('Products').asstring + #13 +
                '-- Total Rows: ' + fieldByName('TotRows').asstring;
          sLog := fieldByName('Sessions').asstring + ' Sess, ' +
                fieldByName('Locations').asstring + ' Locs, ' +
                fieldByName('Products').asstring + ' Prods, ' +
                fieldByName('TotRows').asstring +' Rows';
          close;

          Close;
          SQL.Clear;
          SQL.Add('SELECT COUNT(*) as AddedRows');
          SQL.Add('FROM #AdditionalImportLocationItems');
          open;

          sDisplay := sDisplay + #13 +'-- Added Rows: ' + fieldByName('AddedRows').asstring;
          sLog := slog +', ' + fieldByName('AddedRows').asstring + ' AddedRows';
        end
        else  // not by Location....
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT COUNT(DISTINCT SessionID) as Sessions,COUNT(DISTINCT ProductID) as Products, COUNT(*) as TotRows');
          SQL.Add('FROM #TempMobileStockImportCount');
          open;

          sDisplay := '-- Sessions: ' + fieldByName('Sessions').asstring + #13 +
                '-- Unique Products: ' + fieldByName('Products').asstring + #13 +
                '-- Total Rows: ' + fieldByName('TotRows').asstring;
          sLog := fieldByName('Sessions').asstring + ' Sess, ' +
                fieldByName('Products').asstring + ' Prods, ' +
                fieldByName('TotRows').asstring +' Rows';
          close;
        end;
      end;

      with ADOqRun do
      begin
        SQL.Clear;
        SQL.Add('SELECT COUNT(*) AS NumberOfImportRecords FROM #TempMobileStockImportCount');
        Open;
        numberOfImportRecords := FieldByName('NumberOfImportRecords').AsInteger;
        Close;
      end;

      if numberOfImportRecords = 0 then
      begin
        MessageDlg('There are no mobile stock counts to import from the selected locations', mtInformation, [mbOK], 0);
        log.event('Mobile Stock Import: Import cancelled - nothing to import');
        exit;
      end;

      if MessageDlg('About to start a Mobile ' + data1.SSbig + ' Import:' + #13 + #13 + sDisplay + #13 + #13 +
             'Click "OK" to confirm.', mtConfirmation, [mbOK,mbCancel], 0) = mrCancel then
      begin
        log.event('Mobile Stock Import: User canceled the Import');
        exit;
      end;

      log.event('Mobile Stock Import: Begin Import (' + sLog + ')');
      AddAdditionalLocationCountsToLocationList();
      UpdateStockCountsFromImport;
      FormatStockCountsForDisplayGrid;

      // now the Import is done mark the Imported Sessions...
      with ADOqRun do
      begin
        Close;
        sql.Clear;
        sql.Add('update ac_MobileStockSession set LastImported = GetDate()');
        sql.Add('from ac_MobileStockSession m, (SELECT DISTINCT SessionID FROM #TempMobileStockImportCount) i');
        SQL.Add('where m.SessionID = i.SessionID');
        execSQL;
      end;

      ADOqMobileStockSessions.Requery;
      ShowMessage('Mobile Stock Import Complete');
    except
      on E: Exception do
      begin
        log.event('Mobile Stock Import: An exception occurred during import:');
        log.event('    EXCEPTION: '+E.Message);
        ShowMessage('A problem occurred during the Mobile Stock Import: '+E.Message);
      end;
    end;
  finally
    ADOqRun.Close;
    ADOqMobileStockSessions.EnableControls;
    wwDBGridMobileStockSessions.SelectedList.Clear;
    wwDBGridMobileStockSessions.RefreshDisplay;
    Screen.Cursor := crDefault;
  end;
  log.event('Mobile Stock Import: End - btnImportClick');
end;

procedure TfrmMobileStockCountImport.SetSelectedSessionData();
var
  i: Integer;
begin
  log.event('Mobile Stock Import: Begin - SetSelectedSessionData');

  SelectedSessionLocationList := TStringList.Create;
  SelectedSessionLocationList.Sorted := true;

  SelectedSessionIdList :=  TStringList.Create;
  SelectedSessionIdList.Sorted := true;
  SelectedSessionIdList.Duplicates := dupIgnore;
  SelectedSessionIdList.Delimiter := ',';

  with wwDBGridMobileStockSessions do
  begin
    for i := 0 to SelectedList.Count - 1 do
    begin
      ADOqMobileStockSessions.GotoBookmark(SelectedList.items[i]);
      SelectedSessionLocationList.Add(ADOqMobileStockSessions.FieldByName('SessionId').AsString + '=' + ADOqMobileStockSessions.FieldByName('LocationId').AsString);
      SelectedSessionIdList.Add(ADOqMobileStockSessions.FieldByName('SessionId').AsString);
    end;
  end;
  log.event('Mobile Stock Import: End - SetSelectedSessionData');
end;

procedure TfrmMobileStockCountImport.PrepareSessionStockCounts();
var
  i: integer;
  locationId: integer;
  locationName: string;
  sessionId: Int64;
  locationSeparatorPos: integer;
begin
  log.event('Mobile Stock Import: Begin - PrepareSessionStockCounts');
  dmADO.DelSQLTable('#TempMobileStockImportCount');
  dmADO.DelSQLTable('#AdditionalImportLocationItems');

  with ADOqRun do
  begin
    StockLocationService.CreateMobileStockImportCountTempTable();
    StockLocationService.CreateAdditionalImportLocationItemsTempTable();

    if data1.curByLocation then
    begin

       for i := 0 to SelectedSessionLocationList.Count-1 do
       begin
        sessionId := StrToInt64(SelectedSessionLocationList.Names[i]);

        // Get the locationId value from the SessionId/LocationId name=value pair for the current index
        // can't use TStringList.Value(sessionId) since this is duplicated for each location.
        locationSeparatorPos := pos('=', SelectedSessionLocationList[i]);
        locationId := StrToInt(copy(SelectedSessionLocationList[i],
                                    locationSeparatorPos+1,
                                    Length(SelectedSessionLocationList[i]) - locationSeparatorPos));

        if data1.confirmMobileStockCountImports AND
           StockLocationService.HasConfiguredLocationListChangedSinceStartOfSession(sessionId, locationId) then
        begin
          locationName := StockLocationService.GetLocationName(data1.TheSiteCode, locationId);
          if MessageDlg('The location product list for session '''+ IntToStr(sessionId)+' - '+locationName +''' was changed after this mobile stock count session was started.'+ #13 +
                        'Only partial counts will be imported.'+#13+
                        'Would you like to continue importing this location?',
                        mtConfirmation, [mbYes, mbNo], 0) = mrNo then
             continue;
        end;

        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO #TempMobileStockImportCount (SessionOrder, SessionId, EndTime, LocationId, RowId, ProductId, UnitName, [Count])');
        SQL.Add('SELECT 0 as SessionOrder, ms.SessionID, ms.EndTime, msc.LocationId, msc.RowId, msc.ProductID, msc.UnitName, msc.[Count]');
        SQL.Add('FROM ac_MobileStockSession ms');
        SQL.Add('JOIN ac_MobileStockSessionCounts msc ON ms.SessionID = msc.SessionId');
        SQL.Add('JOIN AuditLocationsCur alc ON msc.LocationId = alc.LocationID AND msc.rowId = alc.RecID ');
        SQL.Add('                           AND msc.ProductId = alc.EntityCode AND LOWER(msc.UnitName) = LOWER(alc.Unit)');
        SQL.Add('WHERE ms.SessionID = '+ IntToStr(sessionId));
        SQL.Add('AND msc.LocationId = '+ IntToStr(locationId));
        SQL.Add('ORDER BY ms.EndTime');
        ExecSQL;

        PrepareImportCountsNotInConfiguredLocationList(sessionId, locationId);
       end;
    end
    else  // not by Location....
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO #TempMobileStockImportCount(SessionOrder, SessionId, EndTime, ProductId, UnitName, [Count])');
      SQL.Add('SELECT 0 as SessionOrder, ms.SessionID, ms.EndTime, msc.ProductID, msc.UnitName, SUM(msc.[Count]) as [Count]');
      SQL.Add('FROM ac_MobileStockSession ms');
      SQL.Add('JOIN ac_MobileStockSessionCounts msc ON ms.SessionID = msc.SessionId');
      SQL.Add('JOIN AuditCur ac ON msc.ProductId = ac.EntityCode AND LOWER(msc.UnitName) = LOWER(ac.PurchUnit)');
      SQL.Add('WHERE ms.SessionID IN ('+SelectedSessionIdList.DelimitedText+')');
      SQL.Add('AND msc.LocationId = 999');
      SQL.Add('GROUP BY ms.SessionID, ms.EndTime, msc.ProductID, msc.UnitName');
      ExecSQL;
    end;

    // set the SessionOrder for each record based on its EndTime, with the ealiest Time as 1, then 2, etc.
    Close;
    sql.Clear;
    sql.Add('select distinct EndTime from #TempMobileStockImportCount order by EndTime');
    open;

    while not eof do
    begin
      data1.adoqRun.Close;
      data1.adoqRun.SQL.Clear;
      data1.adoqRun.SQL.Add('UPDATE #TempMobileStockImportCount SET SessionOrder = ' + inttostr(recno));
      data1.adoqRun.SQL.Add('WHERE EndTime = '+ QuotedStr(formatDateTime('yyyymmdd hh:nn:ss.zzz', fieldByName('EndTime').asDateTime)));
      data1.adoqRun.ExecSQL;
      next;
    end;
    close;
  end;

  log.event('Mobile Stock Import: End - PrepareSessionStockCounts');
end;

procedure TfrmMobileStockCountImport.UpdateStockCountsFromImport;
begin
  log.event('Mobile Stock Import: Begin - UpdateStockCountsFromImport');
  with ADOqRun do
  begin
    // in order to ensure that later sessions override earlier sessions (in case Stock Counts
    // overlap in the same Location/Row) the update will be done by SessionOrder (derived from Session End Date)
    Close;
    sql.Clear;
    sql.Add('select distinct SessionOrder from #TempMobileStockImportCount order by SessionOrder');
    open;

    while not eof do
    begin
      data1.adoqRun.Close;
      data1.adoqRun.SQL.Clear;

      if data1.curByLocation then
      begin
        data1.adoqRun.SQL.Add('UPDATE AuditLocationsCur');
        if (rgImportMethods.ItemIndex = IMPORT_METHOD_OVERWRITE)
            or (rgImportMethods.ItemIndex = IMPORT_METHOD_UNAUDITED_ONLY) then
          data1.adoqRun.SQL.Add('SET ActCloseStk = c.Count')
        else
          data1.adoqRun.SQL.Add('SET ActCloseStk = ISNULL(ActCloseStk, 0) + c.Count');
        data1.adoqRun.SQL.Add('FROM AuditLocationscur alc, #TempMobileStockImportCount c');
        data1.adoqRun.SQL.Add('WHERE alc.LocationId = c.LocationId');
        data1.adoqRun.SQL.Add('AND alc.RecId = c.RowId');
        data1.adoqRun.SQL.Add('AND alc.EntityCode = c.ProductId');
        data1.adoqRun.SQL.Add('AND LOWER(alc.Unit) = LOWER(c.UnitName)');
        data1.adoqRun.SQL.Add('AND c.SessionOrder = '+ fieldByName('SessionOrder').asstring);
        if rgImportMethods.ItemIndex = IMPORT_METHOD_UNAUDITED_ONLY then
          data1.adoqRun.SQl.Add('AND ISNULL(alc.ActCloseStk, 0) = 0');
      end
      else
      begin
        data1.adoqRun.SQL.Add('UPDATE AuditCur');
        if (rgImportMethods.ItemIndex = IMPORT_METHOD_OVERWRITE)
           or (rgImportMethods.ItemIndex = IMPORT_METHOD_UNAUDITED_ONLY) then
          data1.adoqRun.SQL.Add('SET ActCloseStk = S.Count')
        else
          data1.adoqRun.SQL.Add('SET ActCloseStk = ISNULL(ActCloseStk, 0) + S.Count');
        data1.adoqRun.SQL.Add('FROM Auditcur A, #TempMobileStockImportCount S');
        data1.adoqRun.SQL.Add('WHERE A.EntityCode = S.ProductID');
        data1.adoqRun.SQL.Add('AND LOWER(a.PurchUnit) = LOWER(s.UnitName)');
        data1.adoqRun.SQL.Add('AND s.SessionOrder = '+ fieldByName('SessionOrder').asstring);
        if rgImportMethods.ItemIndex = IMPORT_METHOD_UNAUDITED_ONLY then
          data1.adoqRun.SQl.Add('AND ISNULL(A.ActCloseStk, 0) = 0');
      end;

      data1.adoqRun.ExecSQL;
      next;
    end;

    close;
  end;
  log.event('Mobile Stock Import: End - UpdateStockCountsFromImport');
end;

procedure TfrmMobileStockCountImport.PrepareImportCountsNotInConfiguredLocationList(sessionId: Int64; locationId: integer);
var
  importAddedItemsDlgResult: integer;
  locationName: string;
begin
  log.event('Mobile Stock Import: Begin - PrepareImportCountsNotInConfiguredLocationList');

  data1.adoqRun.Close;
  data1.adoqRun.SQL.Clear;

  if data1.curByLocation then
  begin
    with data1.adoqRun do
    begin

      // Get any added location items from the mobile stock count that have a row value greater than the
      // last item in the configured list. These items can be added to the configured location list.
      SQL.Add('INSERT INTO #AdditionalImportLocationItems(SiteId, SessionId, LocationId, DivisionId, RowId, ProductId, UnitName, ReuseDeletedRow)');
      SQL.Add('select SiteId, SessionId, LocationId, '+IntToStr(data1.curDivIx)+' AS DivisionId, RowId, ProductId, UnitName, CAST(0 AS bit) AS ReuseDeletedRow');
      SQL.Add('from ac_MobileStockSessionCounts');
      SQL.Add('where SiteId = '+ IntToStr(data1.TheSiteCode));
      SQL.Add('and LocationId = ' + IntToStr(locationId));
      SQL.Add('and SessionId = ' + IntToStr(sessionId));
      SQL.Add('and RowId > (select ISNULL(Max(RecID),0) AS MaxRowId from stkLocationLists where SiteCode = ' + IntToStr(data1.TheSiteCode) +
                            ' and LocationID = '+IntToStr(locationId)+
                            ' and DivisionID = '+IntToStr(data1.curDivIx)+
                            ' and Deleted = 0)');
      SQL.Add('order by RowId');
      ExecSQL;

      // Check if there is an existing deleted row in stkLocationLists, this can be updated
      // with the added product details.
      // ReuseDeletedRow = true, this means ressurect a deleted row in stkLocationLists
      // ReuseDeletedRow = false, add a new record in stkLocationLists
      Close;
      SQL.Clear;
      SQL.Add('Update #AdditionalImportLocationItems');
      SQL.Add('set ReuseDeletedRow = y.Deleted');
      SQL.Add('from #AdditionalImportLocationItems x JOIN stkLocationLists y');
      SQL.Add('ON x.SiteId = y.SiteCode');
      SQL.Add('   and x.LocationID = y.LocationId');
      SQL.Add('   and x.DivisionID = y.DivisionId');
      SQL.Add('   and x.RowId = y.RecID');
      SQL.Add('Where y.Deleted = 1');
      ExecSQL;

      ADOqRun.Close;
      ADOqRun.SQL.Clear;
      ADOqRun.SQL.Add('select * from #AdditionalImportLocationItems');
      ADOqRun.SQL.Add('where SiteId = '+ IntToStr(data1.TheSiteCode));
      ADOqRun.SQL.Add('and LocationId = ' + IntToStr(locationId));
      ADOqRun.SQL.Add('and SessionId = ' + IntToStr(sessionId));
      ADOqRun.Open;

      importAddedItemsDlgResult := mrYes;

      if data1.confirmMobileStockCountImports AND (ADOqRun.RecordCount > 0) then
      begin
        locationName := StockLocationService.GetLocationName(data1.TheSiteCode, locationId);
        importAddedItemsDlgResult := MessageDlg('The mobile stocks import for session '''+IntToStr(sessionId)+''' contains additional product rows not configured in the '''+locationName+''' location list.'+ #13 +
        'Would you like to add these items to the location configuration?'+ #13 +
        'Number of additional products: ' + IntToStr(ADOqRun.RecordCount),
             mtConfirmation,
             [mbYes, mbNo], 0);
      end;

      if ADOqRun.RecordCount > 0 then
      begin
        if importAddedItemsDlgResult = mrNo then
        begin
          ADOqRun.Close;
          ADOqRun.SQL.Clear;
          ADOqRun.SQL.Add('delete from #AdditionalImportLocationItems');
          ADOqRun.SQL.Add('where SiteId = '+ IntToStr(data1.TheSiteCode));
          ADOqRun.SQL.Add('and LocationId = ' + IntToStr(locationId));
          ADOqRun.SQL.Add('and SessionId = ' + IntToStr(sessionId));
          ADOqRun.ExecSQL;
        end
        else
        begin
          Close;
          SQL.Clear;
          SQL.Add('INSERT INTO #TempMobileStockImportCount (SessionOrder, SessionId, EndTime, LocationId, RowId, ProductId, UnitName, [Count])');
          SQL.Add('SELECT 0 as SessionOrder, ms.SessionID, ms.EndTime, msc.LocationId, msc.RowId, msc.ProductID, msc.UnitName, msc.[Count]');
          SQL.Add('FROM ac_MobileStockSession ms');
          SQL.Add('JOIN ac_MobileStockSessionCounts msc ON ms.SessionID = msc.SessionId');
          SQL.Add('JOIN #AdditionalImportLocationItems alc ON msc.SessionId = alc.SessionId AND');
          SQL.Add('                                           msc.LocationId = alc.LocationID AND');
          SQL.Add('                                           msc.rowId = alc.RowId AND');
          SQL.Add('                                           msc.ProductId = alc.ProductId AND');
          SQL.Add('                                           LOWER(msc.UnitName) = LOWER(alc.UnitName)');
          SQL.Add('WHERE ms.SessionID = '+ IntToStr(sessionId));
          SQL.Add('AND msc.LocationId = '+ IntToStr(locationId));
          SQL.Add('ORDER BY ms.EndTime');
          ExecSQL;
        end;
      end;
        ADOqRun.Close;
        ADOqRun.SQL.Clear;
        data1.adoqRun.Close;
        data1.adoqRun.SQL.Clear;
    end;
  end;
  log.event('Mobile Stock Import: End - PrepareImportCountsNotInConfiguredLocationList');
end;

procedure TfrmMobileStockCountImport.AddAdditionalLocationCountsToLocationList();
var
  curentLocationId: integer;
begin
  log.event('Mobile Stock Import: Begin - AddAdditionalLocationCountsToLocationList');
  data1.adoqRun.Close;
  data1.adoqRun.SQL.Clear;

  if data1.curByLocation then
  begin
    with data1.adoqRun do
    begin
      ADOqRun.Close;
      ADOqRun.SQL.Clear;
      ADOqRun.SQL.Add('select distinct SiteId, LocationId, DivisionId, RowId, ProductId, UnitName, ReuseDeletedRow');
      ADOqRun.SQL.Add('from #AdditionalImportLocationItems');
      ADOqRun.Open;
      ADOqRun.First;

      if ADOqRun.RecordCount > 0 then
      begin
        curentLocationId := ADOqRun.FieldByName('LocationId').AsInteger;
        while not ADOqRun.Eof do
        begin
          Close;
          SQL.Clear;

          if ADOqRun.FieldByName('ReuseDeletedRow').AsBoolean = true then
          begin
            SQL.Add('UPDATE stkLocationLists');
            SQL.Add('set EntityCode = ' + ADOqRun.FieldByName('ProductId').AsString +
                    ', Unit = ' + QuotedStr(ADOqRun.FieldByName('UnitName').AsString) +
                    ', Deleted = 0, LMDT = GETDATE()');
            SQL.Add('where SiteCode = ' +  ADOqRun.FieldByName('SiteId').AsString);
            SQL.Add('and LocationId = ' + ADOqRun.FieldByName('LocationId').AsString);
            SQL.Add('and DivisionId = ' + ADOqRun.FieldByName('DivisionId').AsString);
            SQL.Add('and RecId = ' + ADOqRun.FieldByName('RowId').AsString);
            SQL.Add('and Deleted = 1');
            ExecSql;
          end
          else
          begin
            SQL.Add('INSERT INTO stkLocationLists(SiteCode, LocationID, DivisionID, RecID, EntityCode, Unit, ManualAdd, Deleted, LMDT)');
            SQL.Add('select ' +  ADOqRun.FieldByName('SiteId').AsString + ', ' +
                                 ADOqRun.FieldByName('LocationId').AsString + ', ' +
                                 ADOqRun.FieldByName('DivisionId').AsString + ', ' +
                                 ADOqRun.FieldByName('RowId').AsString + ', ' +
                                 ADOqRun.FieldByName('ProductId').AsString + ', ' +
                                 QuotedStr(ADOqRun.FieldByName('UnitName').AsString) + ', ' +
                                 'NULL, 0, GETDATE()');
            ExecSql;
          end;
          ADOqRun.Next;

          if ADOqRun.Eof OR (ADOqRun.FieldByName('LocationId').AsInteger <> curentLocationId) then
          begin
            // The location list has been modified on the fly, so need to update AuditLocationCur
            // in order for the new location items to be shown in the audit screen.
            StockLocationService.UpdateAuditLocationsCur(IntToStr(curentLocationId));
            curentLocationId := ADOqRun.FieldByName('LocationId').AsInteger;
          end;
        end;
      end;
    end;
  end;
  ADOqRun.Close;
  data1.adoqRun.Close;
  log.event('Mobile Stock Import: End - AddAdditionalLocationCountsToLocationList');
end;

procedure TfrmMobileStockCountImport.FormatStockCountsForDisplayGrid;
begin
  log.event('Mobile Stock Import: Begin - FormatStockCountsForDisplayGrid');

  with ADOqRun do
  begin
    Close;
    SQL.Clear;

    if data1.curByLocation then
    begin
      SQL.Add('select * from AuditLocationsCur');
      Open;

      while not Eof do
      begin
        Edit;
        if FieldByName('ActCloseStk').AsString = '' then
          FieldByName('ACount').AsString := ''
        else
          FieldByName('ACount').AsString :=
            data1.dozGallFloatToStr(FieldByName('Unit').AsString, FieldByName('ActCloseStk').AsFloat);
        Post;
        Next;
      end;
    end
    else
    begin
      SQL.Add('select * from AuditCur');
      Open;

      while not Eof do
      begin
        Edit;
        if FieldByName('ActCloseStk').AsString = '' then
          FieldByName('ACount').AsString := ''
        else
          FieldByName('ACount').AsString :=
            data1.dozGallFloatToStr(FieldByName('PurchUnit').AsString, FieldByName('ActCloseStk').AsFloat);
        Post;
        Next;
      end;
    end;

    Close;
  end;
  log.event('Mobile Stock Import: End - FormatStockCountsForDisplayGrid');
end;

procedure TfrmMobileStockCountImport.ShowValidMobileStockSessions;
var
  StockRollEndDate: String; //Stock rollover end date
  StockEndDate: String; //Stock end date
begin
  log.event('Mobile Stock Import: Begin - ShowValidMobileStockSessions');
  StockEndDate     := FormatDateTime('yyyy-mm-dd hh:nn:ss', data1.EDT - 1);
  StockRollEndDate := FormatDateTime('yyyy-mm-dd hh:nn:ss', data1.EDT + 5);

  with ADOqMobileStockSessions do
  begin
    if data1.curByLocation then
    begin
      lblByLoc.Visible := TRUE;
      Close;
      SQL.Clear;
      SQL.Add('SELECT sl.SessionID, sl.LocationId, ');
      SQL.Add('CASE WHEN isNULL(sl.StockTakerName, '''') = '''' THEN sl.UserName ELSE sl.StockTakerName END AS [StockTaker],');
      SQL.Add('CASE WHEN sl.LocationId = 999 THEN ''No Location'' ELSE loc.LocationName END AS [Location Name],');
      SQL.Add('sl.StartTime AS [Start Time], sl.EndTime AS [End Time], sl.mCount, boh.bCount, sl.LastImported');
      SQL.Add('FROM');
      SQL.Add(' (SELECT DISTINCT ms.*, msc.LocationId, msc.mCount');
      SQL.Add('  FROM ac_MobileStockSession ms');
      SQL.Add('  JOIN (SELECT SessionID, LocationID, COUNT(*) as mCount');
      SQL.Add('        FROM ac_MobileStockSessionCounts GROUP BY SessionID, LocationID) msc');
      sql.Add('  ON ms.SessionID = msc.SessionId) sl');
      SQL.Add('LEFT OUTER JOIN stkLocations loc ON sl.LocationId = loc.LocationID');
      SQL.Add('LEFT OUTER JOIN (SELECT LocationId, COUNT(*) as bCount');
      SQL.Add('                FROM AuditLocationsCur GROUP BY LocationID) boh ON sl.LocationId = boh.LocationID');
      SQL.Add('WHERE sl.StockThread = '   + IntToStr(data1.CurTid));
      SQL.Add('AND sl.StartTime > '     + QuotedStr(StockEndDate));
      SQL.Add('AND sl.StartTime <= '    + QuotedStr(StockRollEndDate));
      SQL.Add('AND sl.EndTime > '       + QuotedStr(StockEndDate));
      SQL.Add('AND sl.EndTime <= '      + QuotedStr(StockRollEndDate));
      SQL.Add('ORDER BY sl.EndTime DESC');
      Open;

      with wwDBGridMobileStockSessions, wwDBGridMobileStockSessions.DataSource.DataSet do   // grid field names, etc...
      begin
        DisableControls;
        Selected.Clear;
        Selected.Add('SessionID'#9'7'#9'Session'#9'F');
        Selected.Add('Location Name'#9'22'#9'Location Name'#9'F');
        Selected.Add('Start Time'#9'18'#9'Start Time'#9'F');
        Selected.Add('End Time'#9'18'#9'End Time'#9'F');
        Selected.Add('StockTaker'#9'18'#9'Mobile Auditor Name'#9'F');
        Selected.Add('mCount'#9'6'#9'Import~Count'#9'F');
        Selected.Add('bCount'#9'6'#9'List~Count'#9'F');
        Selected.Add('LastImported'#9'18'#9'Session Imported Time~(any Location)'#9'F');
        ApplySelected;
        TitleLines := 2;
        EnableControls;
      end;

    end
    else
    begin    // not by Location
      if MobileStockRecordsWithLocationsExist(stockEndDate, StockRollEndDate) then
      begin
        MessageDlg('Mobile Stocks data exists, but cannot be imported as it uses count locations, which are now ' +
                ' disabled.' +#13#10#13#10 +
                'Either re-enable count locations to allow this data to be imported, or perform a new ' +
                ' count for these items without locations.', mtWarning, [mbOk], -1);
        PostMessage(Self.Handle,wm_close,0,0);
        exit;
      end;

      lblByLoc.Visible := FALSE;
      Close;
      SQL.Clear;
      SQL.Add('SELECT sl.SessionID, sl.LocationId, ');
      SQL.Add('CASE WHEN isNULL(sl.StockTakerName, '''') = '''' THEN sl.UserName ELSE sl.StockTakerName END AS [StockTaker],');
      SQL.Add('''No Location''  AS [Location Name],');
      SQL.Add('sl.StartTime AS [Start Time], sl.EndTime AS [End Time], sl.LastImported');
      SQL.Add('FROM');
      SQL.Add(' (SELECT DISTINCT ms.*, msc.LocationId');
      SQL.Add('  FROM ac_MobileStockSession ms');
      SQL.Add('  JOIN ac_MobileStockSessionCounts msc ON ms.SessionID = msc.SessionId where msc.LocationID = 999) sl');
      SQL.Add('JOIN Threads t ON sl.StockThread = t.Tid');
      SQL.Add('WHERE sl.StockThread = '   + IntToStr(data1.CurTid));
      SQL.Add('AND sl.StartTime > '     + QuotedStr(StockEndDate));
      SQL.Add('AND sl.StartTime <= '    + QuotedStr(StockRollEndDate));
      SQL.Add('AND sl.EndTime > '       + QuotedStr(StockEndDate));
      SQL.Add('AND sl.EndTime <= '      + QuotedStr(StockRollEndDate));
      SQL.Add('ORDER BY sl.EndTime DESC');
      Open;

      with wwDBGridMobileStockSessions, wwDBGridMobileStockSessions.DataSource.DataSet do   // grid field names, etc...
      begin
        DisableControls;
        Selected.Clear;
        Selected.Add('SessionID'#9'10'#9'Session'#9'F');
        Selected.Add('Start Time'#9'18'#9'Start Time'#9'F');
        Selected.Add('End Time'#9'18'#9'End Time'#9'F');
        Selected.Add('StockTaker'#9'20'#9'Mobile Auditor Name'#9'F');
        Selected.Add('LastImported'#9'18'#9'Session Imported Time'#9'F');
        ApplySelected;
        TitleLines := 1;
        EnableControls;
      end;
    end;
  end;
  log.event('Mobile Stock Import: End - ShowValidMobileStockSessions');
end;

function TfrmMobileStockCountImport.MobileStockRecordsWithLocationsExist(stockEndDate, stockRollEndDate: String) : boolean;
begin
  qryMobileStockCountInLocation.Close;
  qryMobileStockCountInLocation.Parameters.ParamByName('Tid').Value := data1.CurTid;
  qryMobileStockCountInLocation.Parameters.ParamByName('StockEndDate').Value := StockEndDate;
  qryMobileStockCountInLocation.Parameters.ParamByName('StockRollEndDate').Value := StockRollEndDate;
  qryMobileStockCountInLocation.Parameters.ParamByName('StockEndDate2').Value := StockEndDate;
  qryMobileStockCountInLocation.Parameters.ParamByName('StockRollEndDate2').Value := StockRollEndDate;
  qryMobileStockCountInLocation.Open;
  result := (qryMobileStockCountInLocation.RecordCount > 0);
end;

procedure TfrmMobileStockCountImport.FormShow(Sender: TObject);
begin
  log.event('Mobile Stock Import: Begin - FormShow');
  try
    self.Caption := 'Mobile ' + data1.SSbig + ' Counts';
    lblDivision.Caption := data1.TheDiv;
    lblThread.Caption := data1.curTidName;
    lblByLoc.Caption := data1.SSbig + ' Count is By Location';
    ShowValidMobileStockSessions;
  except
    on E: exception do
    begin
      log.event('An exception occurred retreiving the Mobile Stock sessions: ' + E.Message);
      ShowMessage('Could not retreive Mobile Stock Counts: ' + E.Message);
      Exit;
    end;
  end;
  log.event('Mobile Stock Import: End - FormShow');
end;

procedure TfrmMobileStockCountImport.wwDBGridMobileStockSessionsCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if  (Field.FieldName = 'mCount') or (Field.FieldName = 'bCount') then
  begin
    if ADOqMobileStockSessions.FieldByName('mCount').asinteger > ADOqMobileStockSessions.FieldByName('bCount').asinteger then
    begin
      if gdSelected in State then
      begin
        aFont.Style := [fsBold];
        aFont.Color := clYellow;
        aBrush.Color := clBlue;
      end
      else
      begin
        aFont.Style := [fsBold];
        aFont.Color := clYellow;
        aBrush.Color := clBlack;
      end;
    end
    else
    begin
      aFont.Style := [];
    end;
  end;
end;

end.
