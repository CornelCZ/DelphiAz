unit uStockLocationService;

interface

uses
  SysUtils, uADo, uData1, ADODB, uLog;

type
  TStockLocationService = class
  public
    procedure CreateLocationListTempTable();
    procedure CreateMobileStockImportCountTempTable();
    procedure CreateAdditionalImportLocationItemsTempTable();
    procedure RenumberTempLocationList();
    procedure UpdateCountOfProductsInTempLocationList();
    procedure UpdateTempAllProductsListWithCountOfProductsInTempLocationList();
    procedure UpdateAuditLocationsCur(selectedLocationId: string);
    function HasConfiguredLocationListChangedSinceStartOfSession(sessionId: int64; locationId: integer): boolean;
    function GetLocationName(siteId: integer; locationId: integer): string;
    function GetAdditionalItemsWithConflictingRows(): string;
    procedure RemoveSessionsWithConflictingLocationRows();
    function GetCountOfValidSessionImports(): integer;
end;


var
  StockLocationService: TStockLocationService;

implementation

uses DB, dADOAbstract;

procedure TStockLocationService.CreateLocationListTempTable();
begin
  with data1.adoqRun do
    try
      // temp table #LocationList has to have a fixed order that also allows insertion and re-ordering
      // it uses a clustered index where the "primary" ordering is done by RecID with RecID2 being 1 most of the time
      // Records can be inserted or moved only one at a time.
      // So, when a record is inserted in front of the current 6th record the new record gets RecID = 6 and RecID2 = 0
      // thus appearing "in front" of the old 6th record. If the need is to place it behind, then it gets RecID2 = 2 (but
      // in this implementation this is only for the last record). The table is then looped through and the
      // field RecID is renumbered and RecID2 is reset to 1 ready for the next re-order.
      SQL.Clear;
      SQL.Add('IF object_id(''tempdb..#LocationList'') IS NOT NULL');
      SQL.Add('  DROP TABLE #LocationList');
      SQL.Add('CREATE TABLE #LocationList (  ');
      SQL.Add('  [RecID] [int] NULL,  [EntityCode] [float] NULL,  [SCat] [varchar] (20) NULL, ');
      SQL.Add('  [Name] [varchar] (40) NULL,  [Unit] [varchar] (10) NULL, [ManualAdd] [bit] NULL,  [recid2] [int] NULL, ');
      SQL.Add('  [Descr] [varchar] (40) NULL, [isPrepItem] [varchar] (1) NULL, [isPurchUnit] [int] NULL, inList [int] NULL, ');
      SQL.Add('  [FixedQty] [float] NULL, [StringFixedQty] [varchar] (10) NULL)');
      SQL.Add('CREATE CLUSTERED INDEX #LocationList_IX1 ON [#LocationList] (RecID, recid2)');
      ExecSQL;
    finally
      Close;
    end;
end;

procedure TStockLocationService.CreateMobileStockImportCountTempTable();
begin
  with data1.adoqRun do
    try
      SQL.clear;
      SQL.Add('IF object_id(''tempdb..#TempMobileStockImportCount'') IS NOT NULL');
      SQL.Add('  DROP TABLE #TempMobileStockImportCount');
      SQL.Add('Create table #TempMobileStockImportCount (');
      SQL.Add('SessionOrder int,');
      SQL.Add('SessionId bigint,');
      SQL.Add('EndTime datetime,');
      SQL.Add('LocationId int,');
      SQL.Add('RowId int,');
      SQL.Add('ProductId bigint,');
      SQL.Add('UnitName varchar(10),');
      SQL.Add('[Count] float )');
      ExecSql;
    finally
      Close;
    end;
end;

procedure TStockLocationService.CreateAdditionalImportLocationItemsTempTable();
begin
  with data1.adoqRun do
    try
      SQL.clear;
      SQL.Add('IF object_id(''tempdb..#AdditionalImportLocationItems'') IS NOT NULL');
      SQL.Add('  DROP TABLE #AdditionalImportLocationItems');
      SQL.Add('Create table #AdditionalImportLocationItems (');
      SQL.Add('SiteId int,');
      SQL.Add('SessionId bigint,');
      SQL.Add('LocationId int,');
      SQL.Add('DivisionId int,');
      SQL.Add('RowId int,');
      SQL.Add('ProductId bigint,');
      SQL.Add('UnitName varchar(10),');
      SQL.Add('ReuseDeletedRow bit)');
      ExecSql;
    finally
      Close;
    end;
end;

procedure TStockLocationService.RenumberTempLocationList();
begin
  // renumber the records to re-order by field RecID only...
  with data1.adoqRun do
    try
      SQL.Clear;
      SQL.Add('IF object_id(''tempdb..#LocationList'') IS NOT NULL');
      SQL.Add('UPDATE #LocationList SET RecID = sq1.RN, RecID2 = 1');
      SQL.Add('FROM (SELECT *, ROW_NUMBER() OVER(order by recid, recid2) as RN');
      SQL.Add('      FROM #LocationList) sq1');
      SQL.Add('WHERE #LocationList.RecID = sq1.RecID and #LocationList.RecID2 = sq1.RecID2');
      ExecSQL;
    finally
      Close;
    end;
end;

procedure TStockLocationService.UpdateCountOfProductsInTempLocationList();
begin
  with data1.adoqRun do
    try
      //  how many records are duplicated in the list? Mark them out
      SQL.Clear;
      SQL.Add('IF object_id(''tempdb..#LocationList'') IS NOT NULL');
      SQL.Add('UPDATE #LocationList SET inList = sq1.theCount');
      SQL.Add('FROM (SELECT entitycode, unit, COUNT(*) as theCount ');
      SQL.Add('      FROM #LocationList GROUP BY entitycode, unit) sq1');
      SQL.Add('WHERE #LocationList.entitycode = sq1.entitycode and #LocationList.unit = sq1.unit');
      ExecSQL;
    finally
      Close;
    end;
end;

procedure TStockLocationService.UpdateTempAllProductsListWithCountOfProductsInTempLocationList();
begin
  // mark the records from the product list that are already in the list
  with data1.adoqRun do
    try
      SQL.Clear;
      SQL.Add('IF object_id(''tempdb..#AllProducts'') IS NOT NULL');
      SQL.Add('UPDATE #AllProducts SET [in List] = sq1.theCount');
      SQL.Add('FROM (SELECT entitycode, unit, COUNT(*) as theCount ');
      SQL.Add('      FROM #LocationList GROUP BY entitycode, unit) sq1');
      SQL.Add('WHERE #AllProducts.[Product ID] = sq1.entitycode and #AllProducts.unit = sq1.unit');
      ExecSQL;
    finally
      Close;
    end;

end;

// UpdateAuditLocationsCur
// If the underlying list is changed in StkLocationLists then the new location
// products need to be added to AuditLocationsCur table in order to be displayed
// in the stock audit list.
procedure TStockLocationService.UpdateAuditLocationsCur(selectedLocationId: string);
var
  i: integer;
begin
  log.event('StockLocationService: Begin - UpdateAuditLocationsCur');
  // Re-load the AuditLocationsCur table

  // delete the records for "this" Location and for <No Location> as a change to a Location List
  // could mean a change to what's left in <No Location>
  with data1.adoqRun do
  try
    close;
    sql.Clear;
    sql.Add('delete auditLocationsCur');
    sql.Add('where LocationID = 999 or LocationID = ' + selectedLocationId);
    execSQL;

    //now load the newly changed Location List...
    close;
    sql.Clear;
    sql.Add('insert into auditLocationscur ([LocationID], [RecID], entitycode, [name], subcat,');
    sql.Add('ImpExRef, OpStk, PurchStk, ThRedQty, ThCloseStk, unit,');
    sql.Add('purchbaseU, isPurchUnit, [wastetill], [wastetillA], [wastepc], [wastepcA],');
    sql.Add('[wastage], ShouldBe, PurchCostPU, NomPricePU)');

    sql.Add('SELECT ll.LocationID, ll.RecID, b.entitycode,');
    sql.Add(' (CASE ');
    sql.Add('    WHEN (a.key2 < 1000) THEN b.purchasename'); // NORMAL items
    sql.Add('    ELSE b.retailname');                                                // 17841 - Prep.Items
    sql.Add('  END) as purchasename,');

    if data1.RepHdr = 'Sub-Category' then
      sql.Add('(b.[SCat]) as SubCatName, b.ImpExRef,')
    else
      sql.Add('(b.[Cat]) as SubCatName, b.ImpExRef,');

    sql.Add(' (CASE  WHEN ((a.key2 = 55) or (a.key2 = 1055)) THEN -888888'); // 17841 - NEW Items
    sql.Add('    ELSE OpStk END) as OpStk,');
    sql.Add(' (CASE  WHEN (a.key2 < 1000) THEN PurchStk'); // NORMAL items
    sql.Add('    ELSE -999999  END) as PurchStk,');    // 17841 - Prep.Items
    sql.Add('(a.ThRedQty) as ThRedQty, (a.ThCloseStk) as ThCloseStk, ll.Unit, NULL,  ');
    sql.Add(' (CASE WHEN (ll.Unit = a.purchunit) THEN 1 ELSE 0 END) as IsPurchUnit,');
    sql.Add('0, 0, 0, 0, NULL, 1, NULL, NULL  ');

    sql.Add('FROM stkLocationLists ll, StkCrDiv a, stkEntity b');
    sql.Add('WHERE ll.entitycode = a.entitycode and ll.LocationID = ' + selectedLocationId);
    sql.Add('and a.entitycode = b.entitycode and ll.Deleted = 0');
    execSQL;

    // get the Base Units for the Units...
    close;
    sql.Clear;
    sql.Add('update auditLocationsCur set purchbaseu = sq.[base units]');
    sql.Add('from (select b.[unit name], b.[base units] from Units b) sq');
    sql.Add('where unit = sq.[unit name] and LocationID > 0');
    execSQL;

    // now for any product NOT in at least one Location add it to the <No Location> list
    close;
    sql.Clear;
    sql.Add('insert into auditLocationscur ([LocationID], [RecID], entitycode, [name], subcat,');
    sql.Add('ImpExRef, OpStk, PurchStk, ThRedQty, ThCloseStk, unit,');
    sql.Add('purchbaseU, isPurchUnit, [wastetill], [wastetillA], [wastepc], [wastepcA],');
    sql.Add('[wastage], ShouldBe, PurchCostPU, NomPricePU)');
    sql.Add('SELECT 999, 0, a.entitycode, a.name, a.SubCat, ');
    sql.Add('ImpExRef, OpStk, PurchStk, ThRedQty, ThCloseStk, unit,');
    sql.Add('purchbaseU, isPurchUnit, [wastetill], [wastetillA], [wastepc], [wastepcA],');
    sql.Add('[wastage], ShouldBe, PurchCostPU, NomPricePU');
    sql.Add('FROM (select * from auditLocationscur where LocationID = 0) a');
    sql.Add('LEFT OUTER JOIN ');
    sql.Add('  (select distinct entitycode from auditLocationscur where LocationID > 0) ll ');
    sql.Add('ON a.entitycode = ll.entitycode ');
    sql.Add('WHERE ll.entitycode is NULL');
    execSQL;

    close;
    sql.Clear;
    sql.Add('Update AuditLocationsCur set ActCloseStk = a."ActCloseStk",');
    sql.Add('[wastetillA] = a.[wastetillA], [wastepcA] = a.[wastepca], ');
    sql.Add('[wastage] = b.[wasteTill] + a.[wastetillA] + b.[wastepc] + a.[wastepca]');
    sql.Add('FROM "AuditLocationsCur" b, "AuditLocations" a');
    sql.Add('WHERE a."entitycode" = b."entitycode"');
    sql.Add('and a.RecId = b.RecId');
    sql.Add('and a.LocationId = b.LocationId and a.LocationID < 999');
    sql.Add('and a.Unit = b.Unit');
    sql.Add('AND a."StkCode" = '+IntToStr(data1.StkCode));
    sql.Add('and a.tid = '+IntToStr(data1.curtid));
    i := execSQL;

    // also add the <No Location> records, this time match by EntityCode only...
    close;
    sql.Clear;
    sql.Add('Update AuditLocationsCur set ActCloseStk = a."ActCloseStk",');
    sql.Add('[wastetillA] = a.[wastetillA], [wastepcA] = a.[wastepca], ');
    sql.Add('[wastage] = b.[wasteTill] + a.[wastetillA] + b.[wastepc] + a.[wastepca]');
    sql.Add('FROM "AuditLocationsCur" b, "AuditLocations" a');
    sql.Add('WHERE a."entitycode" = b."entitycode"');
    sql.Add('and a.LocationId = b.LocationId and a.LocationID = 999');
    sql.Add('and a.Unit = b.Unit');
    sql.Add('AND a."StkCode" = '+IntToStr(data1.StkCode));
    sql.Add('and a.tid = '+IntToStr(data1.curtid));
    i := i + execSQL;

    if i > 0 then
    begin
      close;
      sql.Clear;
      sql.Add('select * from AuditLocationsCur');
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
    end;

    if data1.IncludePrepItemsInAudit then
    begin
      close;
      sql.Clear;
      sql.Add('update auditLocationscur set ThRedQty = sq.theCount');
      sql.Add('from');
      sql.Add('  (select sq1.Child, COUNT (DISTINCT t.Parent) as TheCount ');
      sql.Add('   from (select s1.* from ');
      sql.Add('     (select * from auditLocationscur a where PurchStk = -999999) ac ');
      sql.Add('     inner join ');
      sql.Add('     (select r.Child, r.Parent from stk121Rcp r where r.Ctype = ''P'' and r.Ptype is NULL) s1 ');
      sql.Add('     on ac.EntityCode = s1.Child) sq1');
      sql.Add('   inner join stkTRtemp t on t.Parent = sq1.Parent');
      sql.Add('   group by Child  ) sq');
      sql.Add('where auditLocationscur.entitycode = sq.Child');
      execSQL;
    end;

    // markup records depending if they should be there or not based on open/purch/move/sold/waste/thclose
    close;
    sql.Clear;
    sql.Add('update auditLocationscur set ShouldBe = 0');
    sql.Add('where (   ("OpStk" <> 0)');
    sql.Add('       or (("PurchStk" <> 0) and ("PurchStk" <> -999999))');
    sql.Add('       or ("ThRedQty" <> 0)');
    sql.Add('       or ("ThCloseStk" <> 0)');
    sql.Add('       or ("WasteTill" <> 0)');
    sql.Add('       or ("WastePC" <> 0)');
    sql.Add('       or ("Wastage" <> 0))');
    execSQL;

    // for Locations OpStk is meant to show the Location Audit Count of the previous stock
    // for the same Row ID (as long as there is the same Product-Unit).

    close;
    sql.Clear;
    sql.Add('update auditLocationscur set opstk = 0 where LocationID > 0 and LocationID < 999 and opstk <> -888888');
    execSQL;

    close;
    sql.Clear;
    sql.Add('Update AuditLocationsCur set OpStk = a.ActCloseStk');
    sql.Add('FROM "AuditLocationsCur" b, "AuditLocations" a');
    sql.Add('WHERE a."entitycode" = b."entitycode"');
    sql.Add('and a.RecId = b.RecId');
    sql.Add('and a.LocationId = b.LocationId and a.LocationID < 999');
    sql.Add('and a.Unit = b.Unit');
    sql.Add('AND a."StkCode" = '+IntToStr(data1.StkCode - 1));
    sql.Add('and a.tid = '+IntToStr(data1.curtid));
    execSQL;

    // markup records depending if they should be there or not based on last audited in Location
    // there should not be a need for this except in rare circumstances (normally OpStk per Site should take care of this)
    close;
    sql.Clear;
    sql.Add('update auditLocationscur set ShouldBe = 0');
    sql.Add('where (   ("OpStk" <> 0)');
    sql.Add('       and (ShouldBe <> 0))');
    execSQL;

    // empty ThRed if PrepItem
    close;
    sql.Clear;
    sql.Add('update auditLocationscur set thredqty = NULL where PurchStk = -999999');
    execSQL;

    // fill Wastage with -999999 if PrepItem for Locations only...
    close;
    sql.Clear;
    sql.Add('update auditLocationscur set Wastage = -999999 where PurchStk = -999999');
    sql.Add('  and LocationID > 0 and LocationID < 999');
    execSQL;
  finally
    Close;
  end;
  log.event('StockLocationService: End - UpdateAuditLocationsCur');
end;

// HasConfiguredLocationListChangedSinceStartOfSession
// Check if the configured location list was modified after the mobile stock session start date.
function TStockLocationService.HasConfiguredLocationListChangedSinceStartOfSession(sessionId: int64; locationId: integer): boolean;
begin
  log.event('StockLocationService: Begin - HasConfiguredLocationListChangedSinceStartOfSession');
  with data1.adoqRun do
    try
      SQL.Clear;
      SQL.Add('select *');
      SQL.Add('from ac_MobileStockSession');
      SQL.Add('where StartTime < (select max(LMDT) as lastLocationListUpdate');
      SQL.Add('					          from stkLocationLists');
      SQL.Add('					          where SiteCode = ' + IntToStr(data1.TheSiteCode));
      SQL.Add('                   and LocationID = ' + IntToStr(locationId));
      SQL.Add('                   and DivisionID = ' + IntToStr(data1.curDivIx));
      SQL.Add('                   and deleted = 0');
      SQL.Add('					          group by SiteCode, LocationID, DivisionID)');
      SQL.Add('and SiteId = ' + IntToStr(data1.TheSiteCode));
      SQL.Add('and SessionId = '+ IntToStr(sessionId));
      Open;

      result := RecordCount > 0;
    finally
      Close;
    end;
  log.event('StockLocationService: End - HasConfiguredLocationListChangedSinceStartOfSession');
end;

function TStockLocationService.GetLocationName(siteId: integer; locationId: integer): string;
begin
  try
    with data1.adoqRun do
    begin
      SQL.Clear;
      SQL.Add('select LocationName from StkLocations');
      SQL.Add('where SiteCode = ' + IntToStr(siteId));
      SQL.Add('and LocationId = ' + IntToStr(LocationId));
      Open;
      First;

      if RecordCount = 0 then
        result := 'Invalid location id'
      else
        result := FieldByName('LocationName').AsString;
    end;
  finally
    data1.adoqRun.Close;
  end;
end;

// GetAdditionalItemsWithConflictingRows
// Returns a string, listing any additional product counts for the
// same location but from different sessions which have the same
// RowId but specify a different product and/or unit.
// This would cause a PK violation when attempting to insert the new rows
// into StkLocationLists.
function TStockLocationService.GetAdditionalItemsWithConflictingRows(): string;
var
  LocationRowConflictList: string;
  tmpLocationQuery: TADOQuery;
begin
  log.event('StockLocationService: Begin - GetAdditionalItemsWithConflictingRows');
  tmpLocationQuery := TADOQuery.Create(nil);
  tmpLocationQuery.Connection := dmADO.AztecConn;
  LocationRowConflictList := '';

  with tmpLocationQuery do
    try
      SQL.Clear;
      SQL.Add('IF object_id(''tempdb..#AdditionalImportLocationItems'') IS NOT NULL');
      SQL.Add('select a.LocationId, a.RowId, Count(*) AS DuplicateCount');
      SQL.Add('from #AdditionalImportLocationItems a');
      SQL.Add('   JOIN #AdditionalImportLocationItems b');
      SQL.Add('	   ON a.LocationId = b.LocationId');
      SQL.Add('	   and a.RowId = b.RowId');
      SQL.Add('where a.SessionId <> b.SessionId');
      SQL.Add('and ((a.ProductId <> b.ProductId) OR (a.ProductId = b.ProductId and a.UnitName <> b.UnitName))');
      SQL.Add('group by a.LocationId, a.RowId');
      Open;

      while not Eof do
      begin
        LocationRowConflictList := LocationRowConflictList + 'Location: ' + GetLocationName(Data1.TheSiteCode, FieldByName('LocationId').AsInteger) +
        ' - Row: ' + IntToStr(FieldByName('RowId').AsInteger)+#13;
        Next;
      end;

      result := LocationRowConflictList;
    finally
      Close;
  end;
  log.event('StockLocationService: End - GetAdditionalItemsWithConflictingRows');
end;

procedure TStockLocationService.RemoveSessionsWithConflictingLocationRows();
var
  tmpLocationQuery: TADOQuery;
begin
  log.event('StockLocationService: Begin - RemoveSessionsWithConflictingLocationRows');
  tmpLocationQuery := TADOQuery.Create(nil);
  tmpLocationQuery.Connection := dmADO.AztecConn;
  with data1.adoqRun do
    try
      SQL.Clear;
      SQL.Add('IF object_id(''tempdb..#AdditionalImportLocationItems'') IS NOT NULL');
      SQL.Add('select distinct a.SessionId, a.LocationId');
      SQL.Add('from #AdditionalImportLocationItems a');
      SQL.Add('   JOIN #AdditionalImportLocationItems b');
      SQL.Add('	   ON a.LocationId = b.LocationId');
      SQL.Add('	   and a.RowId = b.RowId');
      SQL.Add('where a.SessionId <> b.SessionId');
      SQL.Add('and ((a.ProductId <> b.ProductId) OR (a.ProductId = b.ProductId and a.UnitName <> b.UnitName))');
      SQL.Add('group by a.SessionId, a.LocationId, a.RowId');
      Open;

      while not Eof do
      begin
        tmpLocationQuery.close;
        tmpLocationQuery.sql.Clear;
        tmpLocationQuery.sql.Add('delete #TempMobileStockImportCount');
        tmpLocationQuery.sql.Add('where sessionId = ' + fieldByname('SessionId').AsString);
        tmpLocationQuery.sql.Add('and locationid = ' + fieldByname('LocationId').AsString);
        tmpLocationQuery.sql.Add('delete #AdditionalImportLocationItems');
        tmpLocationQuery.sql.Add('where sessionId = ' + fieldByname('SessionId').AsString);
        tmpLocationQuery.sql.Add('and locationid = ' + fieldByname('LocationId').AsString);
        tmpLocationQuery.ExecSQL;
        Next;
      end;
    finally
      Close;
      tmpLocationQuery.close;
  end;
  log.event('StockLocationService: End - RemoveSessionsWithConflictingLocationRows');
end;

function TStockLocationService.GetCountOfValidSessionImports(): integer;
var
  tmpLocationQuery: TADOQuery;
begin
  log.event('StockLocationService: Begin - GetCountOfValidSessionImports');
  tmpLocationQuery := TADOQuery.Create(nil);
  tmpLocationQuery.Connection := dmADO.AztecConn;
  with tmpLocationQuery do
    try
      SQL.Clear;
      SQL.Add('IF ((object_id(''tempdb..#AdditionalImportLocationItems'') IS NOT NULL) AND ');
      SQL.Add('   (object_id(''tempdb..#TempMobileStockImportCount'') IS NOT NULL) )');
      SQL.Add('select * from #TempMobileStockImportCount');
      SQL.Add('where LocationId NOT IN (');
      SQL.Add('  select distinct a.LocationId');
      SQL.Add('  from #AdditionalImportLocationItems a');
      SQL.Add('   JOIN #AdditionalImportLocationItems b');
      SQL.Add('	   ON a.LocationId = b.LocationId');
      SQL.Add('	   and a.RowId = b.RowId');
      SQL.Add('  where a.SessionId <> b.SessionId');
      SQL.Add('  and ((a.ProductId <> b.ProductId) OR (a.ProductId = b.ProductId and a.UnitName <> b.UnitName))');
      SQL.Add('  group by a.SessionId, a.LocationId, a.RowId');
      SQL.Add(')');
      Open;

      Result := RecordCount;
    finally
      Close;
    end;
  log.event('StockLocationService: End - GetCountOfValidSessionImports');
end;
end.
