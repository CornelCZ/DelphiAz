unit uADOUtils;

///////////////////////////////////////////////////////////////////////////////
//
// 20 March 2003  CC - changes made to transform ADO BigInt fields into
//                     Paradox string 20 fields when making up a ZS or ZM file, as
//                     well as writing to ADO BigInt fields using ".AsLargeInt" instead
//                     of using ".Value" which does not work.
//                     Look for string "// CC - 20 MAR 2003" to find the code changes.
//
//
//
///////////////////////////////////////////////////////////////////////////////


interface

uses db, dbtables, ADODB, classes, sysutils, BDE;

function ADOTableExists(table: TADOTable): boolean;

function ADOTableDelete(table: TADOTable): boolean;

function ADOTableCreate(table: TADOTable): boolean;

// Functions that work for TTable or TADOTable components

function DataSetExists(input: TDataSet): boolean;

function DataSetGetTableName(input: TDataSet): string;

procedure DataSetCreate(input: TDataSet);

procedure DataSetDelete(input: TDataSet);

procedure DataSetEmpty(input: TDataSet);

procedure DataSetGetFieldNames(input: TDataSet; var list: TStrings);

procedure DataSetGetIndexNames(input: TDataSet; var list: TStrings);

procedure ReadUDLDetails(UDLPath: string; var DataSource, InitialCatalog: string);

type
  TADOBatchMove = class(TBatchmove)
  // To Do: clone source and destination access components so that the
  // components being called with are not affected (i.e. separate ADOtable/TTable)
  private
    FDestination: TDataset;
    FSource: TDataSet;
    FMode: TBatchMode;
    FAbortOnKeyViol: Boolean;
    FAbortOnProblem: Boolean;
    FTransliterate: Boolean;
    FRecordCount: Longint;
    FMovedCount: Longint;
    FKeyViolCount: Longint;
    FProblemCount: Longint;
    FChangedCount: Longint;
    FMappings: TStrings;
    FKeyViolTableName: TFileName;
    FProblemTableName: TFileName;
    FChangedTableName: TFileName;
    FCommitCount: Integer;
    procedure SetMappings(Value: TStrings);
    procedure SetSource(Value: TDataSet);
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute;
  public
    property ChangedCount: Longint read FChangedCount;
    property KeyViolCount: Longint read FKeyViolCount;
    property MovedCount: Longint read FMovedCount;
    property ProblemCount: Longint read FProblemCount;
  published
    property AbortOnKeyViol: Boolean read FAbortOnKeyViol write FAbortOnKeyViol default True;
    property AbortOnProblem: Boolean read FAbortOnProblem write FAbortOnProblem default True;
    property CommitCount: Integer read FCommitCount write FCommitCount default 0;
    property ChangedTableName: TFileName read FChangedTableName write FChangedTableName;
    property Destination: TDataSet read FDestination write FDestination;
    property KeyViolTableName: TFileName read FKeyViolTableName write FKeyViolTableName;
    property Mappings: TStrings read FMappings write SetMappings;
    property Mode: TBatchMode read FMode write FMode default batAppend;
    property ProblemTableName: TFileName read FProblemTableName write FProblemTableName;
    property RecordCount: Longint read FRecordCount write FRecordCount default 0;
    property Source: TDataSet read FSource write SetSource;
    property Transliterate: Boolean read FTransliterate write FTransliterate default True;
  end;

implementation


uses useful, variants, typinfo;

type
  TMYCustomADODataset = class(TCustomADODataset);

// private global functions

function GetFieldTypeString(input: TFieldType):string;
begin
  result := GetEnumName(TypeInfo(TFieldType), ord(input));
end;

// interface functions/classes

function ADOTableExists(table: TADOTable): boolean;
begin
  result := false;
  with TADOQuery.create(nil) do try
    connection := TADOTable(table).Connection;
    connectionstring := TADOTable(table).ConnectionString;
    if table.tablename[1] = '#' then
      sql.text := format('select object_id(''tempdb..%s'') as oid',
        [table.tablename])
    else
      sql.text := format('select object_id(''%s'') as oid',
        [table.tablename]);
    open;
    if not fieldbyname('oid').isnull then
      result := true;
    close;
  finally
    free;
  end;
end;

function ADOTableDelete(table: TADOTable): boolean;
begin
  result := true;
  if ADOTableExists(table) then
  with TADOQuery.create(nil) do try
    //table.Active := false;  ?
    connection := TADOTable(table).Connection;
    connectionstring := TADOTable(table).ConnectionString;
    sql.text := 'drop table '+TADOTable(table).TableName;
    ExecSQL;
  finally
    free;
  end;
end;

function ADOTableCreate(table: TADOTable): boolean;
var
  pxfields: TStringList;
  i: integer;
  tmpstr: string;
begin
  // code to create table via ADO connection, based on a TTable
  // see the main CASE statement for the field type mappings
  // that are supported.
  result := true;
  // get TStrings list of primary key field names
  pxfields := TStringList.create;
  try
    for i := 0 to pred(table.IndexDefs.Count) do
    begin
      if ixPrimary in table.IndexDefs[i].Options then
      begin
        tmpstr := table.IndexDefs[i].Fields;
      end;
    end;
    if tmpstr <> '' then
      separatelist(tmpstr, ';', TStrings(pxfields));

    with TADOQuery.create(nil) do try
      //table.Active := false;  ?
      connection := TADOTable(table).Connection;
      connectionstring := TADOTable(table).ConnectionString;
      sql.add(format('create table [%s] (', [TADOTable(table).TableName]));
      for i := 0 to pred(table.FieldDefList.Count) do
      begin
        with table.fielddeflist[i] do
        begin
          case datatype of
          ftSmallint:
            tmpstr := format('[%s] [smallint]', [name]);
          ftInteger:
            tmpstr := format('[%s] [int]', [name]);
          ftDateTime, ftDate, ftTime:
            tmpstr := format('[%s] [datetime]', [name]);
          ftString:
            tmpstr := format('[%s] [varchar] (%d) collate database_default ', [name, size]);
          ftFloat:
            tmpstr := format('[%s] [float]', [name]);
          ftCurrency:
            tmpstr := format('[%s] [money]', [name]);
          ftMemo:
            tmpstr := format('[%s] [text] collate database_default ', [name]);
          else
            raise Exception.create(
              format('Unsupported field type %s passed to ADOCreateTable',
                [GetFieldTypeString(datatype)]));
          end;
          if pxfields.indexof(name) <> -1 then
            tmpstr := tmpstr + ' not null';
        end;
        if i < pred(table.FieldDefList.Count) then
          sql.Add(tmpstr +',')
        else
          sql.add(tmpstr);
      end;
      sql.add(') on [primary]');
      if pxfields.Count <> 0 then
      begin
        sql.add(format('alter table [%s] with nocheck add', [TADOTable(table).TableName]));
        sql.add(format('constraint [PK_%s] primary key clustered (',
          [TADOTable(table).TableName]));
        for i := 0 to pred(pxfields.Count) do
        begin
          tmpstr := format('[%s]', [pxfields.strings[i]]);
          if i < pred(pxfields.count) then
            tmpstr := tmpstr + ',';
          sql.add(tmpstr);
        end;
        sql.Add(') on [primary]')
      end;
      ExecSQL;
    finally
      free;
    end;
  finally
    pxfields.free;
  end;
end;

constructor TADOBatchMove.Create(AOwner: TComponent);
begin
  inherited;
  FAbortOnKeyViol := True;
  FAbortOnProblem := True;
  FTransliterate := True;
  FMappings := TStringList.Create;
end;

destructor TADOBatchMove.Destroy;
begin
  FMappings.free;
  inherited;
end;

procedure TADOBatchMove.Execute;
var
  sourceactive, destactive: boolean;
  indexdefs: TIndexdefs;
  dest_primarykeypresent: boolean;
  primarykeyindex: integer;
  i: integer;
function destkeyfields: string;
  begin
    result := '';
    if destination is TTable then
    begin
      with destination as TTable do
      begin
        if indexdefs.Count = 0 then
          raise Exception.create('TADOBatchmove: Operation requires an index');
        result := indexdefs[primarykeyindex].Fields
      end;
    end;
    if destination is TADOTable then
    with destination as TADOTable do
    begin
      indexdefs.update;
      if indexdefs.count = 0 then
        raise Exception.create('TADOBatchmove: Operation requires an index');
      result := indexdefs[primarykeyindex].fields;
    end else
    if destination is TCustomADODataset then
    with destination as TMYCustomADODataset do
    begin
      if indexdefs.count = 0 then
        raise Exception.create('TADOBatchmove: Operation requires an index');
      result := indexdefs[primarykeyindex].fields;
    end;
  end;
  function sourcekeydata: variant;
  var
    idxfields, curname: string;
    i: integer;
    idxnames: array[0..50] of string;
    idxcount: integer;
  begin
    idxfields := destkeyfields;
    idxcount := 0;
    curname := '';
    for i := 1 to succ(length(idxfields)) do
    begin
      if (i > length(idxfields)) or (idxfields[i] = ';') then
      begin
        idxnames[idxcount] := curname;
        inc(idxcount);
        curname := '';
      end else
      begin
        curname := curname + idxfields[i];
      end;
    end;
    if idxcount > 1 then
    begin
      result := vararraycreate([0, pred(idxcount)], varVariant);
      for i := 0 to pred(idxcount) do
        result[i] := source.FieldValues[idxnames[i]];
    end
    else
      result := source.FieldValues[idxnames[0]];
  end;
  procedure deleterow;
  var
    dest_key_fields: string;
    source_key_data: variant;
  begin
    dest_key_fields := destkeyfields;
    source_key_data := sourcekeydata;
    if destination.Locate(dest_key_fields, source_key_data, []) then
      destination.delete;
  end;
  procedure addrow;
  var
    i: integer;
    fromfieldname, tofieldname: string;
    dest_key_fields: string;
    source_key_data: variant;
  begin
    inc(FMovedCount);
    // PW Bugfix.. raises error if we attempt to read destination key details,
    // but this should not be done if we are not updating records.
    if mode in [batUpdate, batAppendUpdate] then
    begin
      dest_key_fields := destkeyfields;
      source_key_data := sourcekeydata;
    end;
    // if we want to do updates, check if the key is found in the destination
    // and edit the destination record
    if (mode in [batUpdate, batAppendUpdate]) and destination.Locate(dest_key_fields, source_key_data, []) then
      destination.edit
    // if we only want to update keys that are found, and none was found then exit
    else if mode = batUpdate then
      exit
    // if we are appending, or appendupddating and key was not found, then insert
    // a destination record
    else
      destination.append;

    if mappings.count > 0 then
    begin
      // loop over the mappings, "blank" mappings i.e. 'name' treated as 'name=name2'
      for i := 0 to pred(mappings.count) do
      begin
        fromfieldname := mappings.Names[i];
        if fromfieldname = '' then
          fromfieldname := mappings.Strings[i];
        tofieldname := mappings.Values[fromfieldname];
        if tofieldname = '' then tofieldname := fromfieldname;
        if (source.FindField(fromfieldname) <> nil) and
          (destination.FindField(tofieldname) <> nil) then
        begin

          // CC - 20 MAR 2003 -------------------------------------------------------------------
          // Read all bigint fields in using ASBIGINT...
          if (destination is TADOTable) then
          begin
            if source.FindField(fromFieldName).IsNull then
              destination.FindField(toFieldName).Clear
            else if (destination.FindField(toFieldName).DataType = ftLargeint) then
              TLargeIntField(destination.FindField(toFieldName)).AsLargeInt := source.FieldValues[fromFieldName]
            // PW - 07 Nov 2008 -----------------------------------------------------------------
            // When converting paradox Time fields, take account of difference in epoch
            else if (source.FindField(fromFieldName).DataType = ftTime) then
              destination.FindField(toFieldName).AsFloat := Frac(VarToDateTime(source.FieldValues[fromFieldName]))+2.0
            else
              destination.FindField(toFieldName).value := source.FieldValues[fromFieldName];
          end
          else
            destination.FindField(toFieldName).value := source.FieldValues[fromFieldName];
          // end  CC - 20 MAR 2003 ----------------------------------------------------------------
        end
        else
          raise Exception.create('TADOBatchmove: some mapped fields don''t exist.');
      end;
    end
    else
    begin
      // loop over destination fields and fill them in from name-matched fields
      // in the source dataset
      for i := 0 to pred(destination.fieldcount) do
      begin
        tofieldname := destination.Fields[i].FieldName;
        fromfieldname := tofieldname;
        if source.FindField(fromfieldname) <> nil then
        begin

          // CC - 20 MAR 2003 -------------------------------------------------------------------
          // Read all bigint fields in using ASBIGINT...
          if (destination is TADOTable) then
          begin
            if source.FindField(fromFieldName).IsNull then
              destination.FindField(toFieldName).Clear
            else if (destination.FindField(toFieldName).DataType = ftLargeint) then
              TLargeIntField(destination.FindField(tofieldname)).AsLargeInt := source.FieldValues[fromFieldName]
            // PW - 07 Nov 2008 -----------------------------------------------------------------
            // When converting paradox Time fields, take account of difference in epoch
            else if (source.FindField(fromFieldName).DataType = ftTime) then
              destination.FindField(toFieldName).AsFloat := Frac(VarToDateTime(source.FieldValues[fromFieldName]))+2.0
            else
              destination.FindField(toFieldName).value := source.FieldValues[fromFieldName];
          end
          else
            destination.FindField(toFieldName).value := source.FieldValues[fromFieldName];
          // end  CC - 20 MAR 2003 ----------------------------------------------------------------
        end;
        //else
        //  raise Exception.create('TADOBatchmove: some mapped fields don''t exist.');
      end;
    end;
    destination.post;
  end;

begin
  // problem count, changedcount, recordcount not implemented yet
  FMovedCount := 0;
  if (Source is TBDEDataSet) and (Destination is TTable) then
  begin
    // in this case the standard batchmove can handle the operation
    Inherited Destination :=  TTable(Destination);
    Inherited Source :=  TBDEDataSet(Source);
    Inherited Mappings.Assign(mappings);
    Inherited Mode := mode;
    inherited;
    FMovedCount := inherited movedcount;
  end
  else
  begin
    dest_primarykeypresent := false;
    // scan destination index definitions to find if a primary key is defined
    if destination is TTable then
    with destination as TTable do
    begin
      for i := 0 to pred(indexdefs.count) do
        if (ixPrimary in indexdefs[i].Options) or (ixUnique in indexdefs[i].Options) then
        begin
          dest_primarykeypresent := true;
          primarykeyindex := i;
        end;
    end;
    if destination is TADOTable then
    with destination as TADOTable do
    begin
      for i := 0 to pred(indexdefs.count) do
        if (ixPrimary in indexdefs[i].Options) or (ixUnique in indexdefs[i].Options) then
        begin
          dest_primarykeypresent := true;
          primarykeyindex := i;
        end;
    end;

    // PW bugfix.. this code included batAppend in its checks..
    if (mode in [batDelete, batUpdate, batAppendUpdate]) and
      not(dest_primarykeypresent) then
      raise Exception.Create('TADOBatchmove: Destination table must be indexed');

    // we do the batchmove ourselves
    // PW bugfix.. open source at this time so that a TQuery's fielddefs are
    // accessible (for batcopy mode only)
    sourceactive := source.active;
    destactive := destination.active;
    if mode = batCopy then
    begin
      source.active := true;
      // delete destination table
      if destination is TTable then
        if TTable(destination).exists then
          TTable(destination).DeleteTable;
      if destination is TADOTable then
        ADOTableDelete(TADOTable(destination));
      indexdefs := TIndexDefs.Create(destination);
      if source is TTable then
      begin
        TTable(source).indexdefs.Update;
        indexdefs.Assign(TTable(source).IndexDefs);
      end
      else if source is TADOTable then
      begin
        TADOTable(source).IndexDefs.Update;
        indexdefs.Assign(TADOTable(source).indexdefs);
      end;
      destination.fielddefs.Assign(source.FieldDefs);

      // CC - 20 MAR 2003 -------------------------------------------------------------------
      // BIGint made into String 20 as BDE does not have BIGints...
      if (source is TCustomADODataset) and (destination is TTable) then
      begin
        // scan source, only stop on bigints
        for i := 0 to pred(source.FieldDefs.count) do
        begin
          if source.FieldDefs[i].DataType = ftLargeint	then
          begin
            // make destination into a string 20
            destination.fielddefs[i].DataType := ftString;
            destination.fielddefs[i].Size := 20;
          end
          else if source.FieldDefs[i].DataType = ftBCD then
          begin
            // make destination into a string 20
            destination.fielddefs[i].DataType := ftCurrency;
          end
        end;
      end;
      // end  CC - 20 MAR 2003 ----------------------------------------------------------------

      if destination is TTable then
      begin
        //TTable(destination).IndexDefs.assign(indexdefs);
        TTable(destination).CreateTable;
      end
      else
      if destination is TADOTable then
        ADOTableCreate(TADOTable(destination));
    end;
    source.active := true;
    destination.Active := true;
    try
    if mode in [batAppend, batUpdate, batAppendUpdate, batCopy] then
    begin
      source.first;
      while not (source.Eof) do
      begin
        // PW: this is a very hacky fix for a problem with ADO and triggers
        // on theme modelling _REPL tables.
        // Only happens when duplicate records are present in the comms file
        try
          addrow;
        except on E:Exception do
          begin
            if pos('row cannot', lowercase(e.message)) = 0 then
              raise;
          end;
        end;
        source.next;
      end;
    end
    else
    if mode = batDelete then
    begin
      // do delete
      source.first;
      while not (source.Eof) do
      begin
        deleterow;
        source.next;
      end;
    end;
    finally
      source.active := sourceactive;
      destination.Active := destactive;
    end;
  end;
end;

procedure TADOBatchMove.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

end;

procedure TADOBatchMove.SetMappings(Value: TStrings);
begin
  FMappings.Assign(Value);
end;

procedure TADOBatchMove.SetSource(Value: TDataSet);
begin
  FSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function DataSetExists(input: TDataSet): boolean;
begin
  if input is TTable then
  begin
    result := TTable(input).exists;
  end
  else if input is TADOTable then
  begin
    result := ADOTableExists(TADOTable(input));
  end
  else
    raise Exception.create('DataSetExists: Unrecognised TDataSet descendant');
end;

procedure DataSetCreate(input: TDataSet);
begin
  if input is TTable then
    TTable(input).CreateTable
  else if input is TADOTable then
    ADOTableCreate(TADOTable(input))
  else
    raise Exception.create('DataSetCreate: Unrecognised TDataSet descendant');
end;

procedure DataSetEmpty(input: TDataSet);
begin
  if input is TTable then
  with TQuery.create(nil) do try
    databasename := TTable(input).DatabaseName;
    sql.text := format('delete from "%s"', [TTable(input).TableName]);
    execsql;
  finally
    free;
  end
  else if input is TADOTable then
  with TADOQuery.create(nil) do try
     connection := TADOTable(input).Connection;
     sql.text := format('delete from [%s]', [TADOTable(input).TableName]);
     execsql;
  finally
    free;
  end
  else
    raise Exception.create('DataSetEmpty: Unrecognised TDataSet descendant');
end;

procedure DataSetDelete(input: TDataSet);
begin
  if input is TTable then
    TTable(input).DeleteTable
  else if input is TADOTable then
    ADOTableDelete(TADOTable(input))
  else
    raise Exception.create('DataSetDelete: Unrecognised TDataSet descendant');
end;

procedure DataSetGetFieldNames(input: TDataSet; var list: TStrings);
var
  i: integer;
begin
  if input is TTable then
  with TTable(input) do
  begin
    fielddefs.update;
    for i := 0 to pred(fielddefs.count) do
      list.add(fielddefs[i].Name);
  end
  else
  if input is TADOTable then
  with TADOTable(input) do
  begin
    fielddefs.update;
    for i := 0 to pred(fielddefs.count) do
      list.add(fielddefs[i].Name);
  end
  else
    raise Exception.create('DataSetGetFieldNames: Unrecognised TDataSet descendant');
end;

procedure DataSetGetIndexNames(input: TDataSet; var list: TStrings);
var
  i: integer;
begin
  if input is TTable then
  with TTable(input) do
    for i := 0 to pred(indexdefs.count) do
      list.add(indexdefs[i].Name)
  else
  if input is TADOTable then
  with TADOTable(input) do
    for i := 0 to pred(indexdefs.count) do
      list.add(indexdefs[i].Name)
  else
    raise Exception.create('DataSetGetIndexNames: Unrecognised TDataSet descendant');
end;

function DataSetGetTableName(input: TDataSet): string;
begin
  if input is TTable then
    result := TTable(input).tablename
  else
  if input is TADOTable then
  with TADOTable(input) do
    result := TADOTable(input).tablename
  else
    raise Exception.create('DataSetGetIndexNames: Unrecognised TDataSet descendant');
end;

procedure ReadUDLDetails(UDLPath: string; var DataSource, InitialCatalog: string);
var
  unicodebuffer: TByteArray;
  utf8buffer: pchar;
  i: integer;
  UDL_items: TStringlist;
begin
  with TFileStream.Create(UDLPath, fmOpenRead) do try
    seek(0, soFromBeginning);
    utf8buffer := allocmem(size+2);
    readbuffer(unicodebuffer, size);
    UnicodetoUtf8(utf8buffer, PWideChar(@unicodebuffer), size);
    with TStringlist.create do try
      text := strpas(utf8buffer);
      for i := pred(count) downto 0 do
      begin
        // remove any blank lines, INI comments, INI sections or gibberish
        // (there always seems to be gibberish in the first line of a UDL..
        // e.g. FF FE in unicode, translated to EF BB BF in UTF..?!?)
        if trim(strings[i]) = '' then delete(i)
        else if trim(strings[i])[1] = ';' then delete(i)
        else if trim(strings[i])[1] = '[' then delete(i)
        else if trim(strings[i])[1] > chr(127) then delete(i)
      end;
      UDL_items := TStringlist.create;
      useful.SeparateList(text, ';', TStrings(UDL_items));
      datasource := trim(udl_items.Values['Data Source']);
      initialcatalog := trim(udl_items.Values['Initial Catalog']);
    finally
      free;
    end;
    freemem(utf8buffer);
  finally
    free;
  end;
end;

end.
