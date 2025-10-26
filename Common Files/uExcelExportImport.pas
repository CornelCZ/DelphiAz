unit uExcelExportImport;

interface

uses Classes, Adodb, Dialogs, SysUtils, ULogFile;

type

  // todo: open/close Odbc connections along with import object
  // todo: diagnostics callback passed to excelexportimport for detailed logging of progress etc.
  // todo: should we remove the bcp call code?
  // todo: this will probably fail with failover partnering!

  Integerset = set of Byte;

  EImportFailed = class (Exception);
  // Peter Wishart, 24 April 2007.
  //
  // Helper class to automate copying/pasting an entire table to/from the
  // clipboard. Clipboard format is BCP/Excel standard with 0x09 field separator
  // and 0x13 0x10 row delimiter. Field headers are included.
  // For applications that use "modified" fields in a temp table to track edits
  // prior to saving, the "ConstantFields" parameter can be used to set these
  // during the paste operation.
  // Requires BCP to be installed and on the path - this is tested in the "TestBCP" method


  TExcelExportImport = class(TObject)
  private
    procedure Log(text:string);
    procedure ProcessQueriesToClipboard(Query : TADOQuery; HeaderQuery, DataQuery: string);
    function IsSourceTemp(SourceTableName: String): Boolean;
    function GetTempTableName(SourceTableName: String): String;
  public
    // Key fields - the logical "key" fields of the data, must be unique and non null
    // Fixed fields - fields included in export/import data but not actually changed on import
    // Data fields - the fields that are set in the import
    // ModifiedFields - the "Modified flag" fields and their "dependent" fields. "Modified flag" fields are set to 1 if
    //                  their "dependents" change value.
    //                  The format is "Mod1{Dep1,...,Depn};.....;Modm{Dep1,...,Depn}
    //                  See procedure GetSetClauseForModifiedField for more details.
    // Constant fields - fields set to a constant value for each updated row
    // Constant values - the values to set in each constant field.

    // Example:
    // ExcelExpImp.CopyToClipBoard(tabname, 'ProductId, PortionTypeID', 'ProductName, ProductDesc, PortionName, A_Price, B_Price');
    // ExcelExpImp.PasteFromClipboard(tabname, 'ProductId, PortionTypeID', 'ProductName, ProductDesc, PortionName', 'A_Price, B_Price', 'A_Price_Mod, B_Price_Mod', '1, 1');

    HandleLogging: procedure(text:string);

    procedure CopyToClipBoard(Conn: TADOConnection; FullyQualifiedTableName: string); overload;
    procedure CopyToClipBoard(Conn: TADOConnection; FullyQualifiedTableName: string;
      KeyFields: string; DataFields: string; DataOrder: string;
      DisplayHeaderFields: string = ''); overload;
    function PasteFromClipBoard(Conn: TADOConnection; FullyQualifiedTableName: string;
      KeyFields: string; FixedFields: string; DataFields: string; DependentFields: string;
      var ErrorList : TStringList; CurrencyFieldsToValidate : integerSet = [];
      NullableFields: string = ''; DisplayHeaderFields: string = ''): integer;
  end;

implementation

uses windows, useful, uAztecDatabaseUtils, clipbrd, uImportErrorLog, DB,
  uOdbc2;

const
  //SMcC - BCP needs the -m maxerrors flag as it defaults to 10 errors before it exits
  BCPQueryOutParams = '"%s" queryout %s -c -C ACP -S%s -U%s -P%s';
  // PW - added -q parameter which is required if field names clash with reserved words
  BCPInParams = '"%s" in %s -c -C ACP -S%s -U%s -P%s -e%s -m10000 -q';

function GetRenamedField(FieldName: string; GetDest: boolean): string;
var
  Index: integer;
begin
  Index := Pos('as', lowercase(FieldName));
  if Index <> 0 then
  begin
    if GetDest then
      Result := Trim(Copy(FieldName, 1, Index-1))
    else
      Result := Trim(Copy(FieldName, Index+2, Length(FieldName)));
  end
  else
    Result := FieldName;
end;

procedure CopyStreamExceptNulls(InputStream, OutputStream: TStream; InputBytes: integer);
var
  buffer: array[0..4095] of char;
  BytesProcessed: integer;
  BytesRead: integer;
  i: integer;
begin
  BytesProcessed := 0;
  while BytesProcessed < InputBytes do
  begin
    BytesRead := InputStream.Read(Buffer, 4096);
    for i := 0 to pred(BytesRead) do
      if Buffer[i] = #0 then
        Buffer[i] := '@';

    OutputStream.WriteBuffer(Buffer, BytesRead);
    BytesProcessed := BytesProcessed + BytesRead;
  end;
end;

function AddColumnBrackets(Input:string):string;
var
  slTemp: TStringlist;
  i: integer;
begin
  // Add brackets to any columns for export that are reserved words
  // This problem mainly caused by the column headers (and therefore field names)
  // required for the Pricing Price Matrix export.

  //NB Note the non-use of the TStringList.DelimitedText property: the delimiting occurs
  //on the Delimiter char and on any space characters thus making multi-word
  //column names unusable.
  slTemp := TStringList.Create;
  try
    useful.SeparateList(Input, ',', slTemp);
    result := '';
    for i := 0 to pred(slTemp.count) do
    begin
      slTemp[i] := Trim(slTemp[i]);
      if (lowercase(slTemp[i]) = 'as')
        or (lowercase(slTemp[i]) = 'by')
        or (lowercase(slTemp[i]) = 'if')
        or (lowercase(slTemp[i]) = 'in')
        or (lowercase(slTemp[i]) = 'is')
        or (lowercase(slTemp[i]) = 'of')
        or (lowercase(slTemp[i]) = 'on')
        or (lowercase(slTemp[i]) = 'or')
        or (lowercase(slTemp[i]) = 'to')
        or isnumeric(copy(slTemp[i], 1, 1)) then
        slTemp[i] := '['+slTemp[i]+']';
      result := result + slTemp[i];

      if i < sltemp.Count - 1 then
        result := result + ',';
    end;
  finally
    slTemp.Free;
  end;
end;

procedure TExcelExportImport.CopyToClipBoard(Conn: TADOConnection; FullyQualifiedTableName: string);
var
  TempTableName: string;
  ClipboardData: TStringStream;
  HeaderQuery, DataQuery: string;
  AztecQry: TADOQuery;
  SourceIsTemp: boolean;
begin
  ClipboardData := nil;
  SourceIsTemp := IsSourceTemp(FullyQualifiedTableName);
  TempTableName := GetTempTableName(FullyQualifiedTableName);
  AztecQry := TADOQuery.Create(nil);
  AztecQry.Connection := Conn;

  if SourceIsTemp then
  begin
    AztecQry.SQL.Text := Format('SELECT * INTO %s FROM %s', [TempTableName, FullyQualifiedTableName]);
    AztecQry.ExecSQL;
  end;

  try
    HeaderQuery := Format('SELECT TOP 0 * FROM %s', [TempTableName]);
    DataQuery := Format('SELECT * FROM %s', [TempTableName]);
    
    ProcessQueriesToClipboard(AztecQry, HeaderQuery, DataQuery);
  finally
    if SourceIsTemp then
    begin
      AztecQry.SQL.Text := 'drop table '+TempTableName;
      AztecQry.ExecSQL;
    end;

    if Assigned(ClipBoardData) then
      ClipBoardData.Free;
    AztecQry.Free;
  end;
end;

procedure TExcelExportImport.CopyToClipBoard(Conn: TADOConnection; FullyQualifiedTableName: string;
                                             KeyFields: string; DataFields: string; DataOrder: string;
                                             DisplayHeaderFields: string);
var
  TempTableName: string;
  ClipboardData: TStringStream;
  HeaderQuery, DataQuery: string;
  AztecQry: TADOQuery;
  SourceIsTemp: boolean;
begin
  ClipboardData := nil;
  SourceIsTemp := IsSourceTemp(FullyQualifiedTableName);
  TempTableName := GetTempTableName(FullyQualifiedTableName);
  AztecQry := TADOQuery.Create(nil);
  AztecQry.Connection := Conn;

  if SourceIsTemp then
  begin
    if DisplayHeaderFields <> '' then
      AztecQry.SQL.Text := Format('SELECT %s, %s INTO %s FROM %s', [KeyFields, AddColumnBrackets(DisplayHeaderFields), TempTableName, FullyQualifiedTableName])
    else
      AztecQry.SQL.Text := Format('SELECT %s, %s INTO %s FROM %s', [KeyFields, AddColumnBrackets(DataFields), TempTableName, FullyQualifiedTableName]);
      AztecQry.ExecSQL;
  end;

  try
    HeaderQuery := Format('SELECT TOP 0 %s, %s FROM %s', [KeyFields, AddColumnBrackets(DataFields), TempTableName]);
    if DataOrder <> '' then
      DataQuery := Format('SELECT %s, %s FROM %s ORDER BY %s', [KeyFields, AddColumnBrackets(DataFields), TempTableName, DataOrder])
    else
      DataQuery := Format('SELECT %s, %s FROM %s', [KeyFields, AddColumnBrackets(DataFields), TempTableName]);

    ProcessQueriesToClipboard(AztecQry, HeaderQuery, DataQuery);
  finally
    if SourceIsTemp then
    begin
      AztecQry.SQL.Text := 'drop table '+TempTableName;
      AztecQry.ExecSQL;
    end;

    if Assigned(ClipBoardData) then
      ClipBoardData.Free;
    AztecQry.Free;
  end;
end;

function TExcelExportImport.IsSourceTemp(SourceTableName : String) : Boolean;
begin
  result := (pos('#', SourceTableName) <> 0) and (pos('##', SourceTableName) = 0);
end;

function TExcelExportImport.GetTempTableName(SourceTableName : String) : String;
var
  TempQuery : TADOQuery;
begin
  if IsSourceTemp(SourceTableName) then
  begin
    TempQuery := TADOQuery.Create(nil);
    TempQuery.Connection := GetAztecADOConnection;
    try
      TempQuery.SQL.Text := 'select @@spid';
      TempQuery.Open;
      result := '##AztecPasteExport_'+inttostr(GetTickCount)+'_'+TempQuery.Fields[0].AsString;
    finally
      TempQuery.Free;
    end;
  end
  else
    result := SourceTableName;
end;

procedure TExcelExportImport.ProcessQueriesToClipboard(Query : TADOQuery; HeaderQuery, DataQuery : string);
var
  TempFileName, DataHeader: string;
  ClipboardData: TStringStream;
  FileData: TFileStream;
  DatabaseMachine, DatabaseName, UserName, Password: string;
  i: integer;
begin
  TempFileName := useful.GetTempDir + 'AztecClipCopy_'+inttostr(GetTickCount);
  Log(Format('CopyToClipboard: Temp clipboard data path [%s]', [TempFileName]));
  Query.SQL.Text := HeaderQuery;
  Query.Open;
  for i := 0 to Pred(Query.FieldDefs.Count) do
    DataHeader := DataHeader + Query.FieldDefs[i].Name+#9;
  SetLength(DataHeader, Length(DataHeader)-1);
  DataHeader := DataHeader + #13#10;

  uAztecDatabaseUtils.GetAztecDatabaseParameters(DatabaseMachine, DatabaseName);
  UserName := 'ZonalSysAdmin';
  Password := uAztecDatabaseUtils.ZONAL_SYSADMIN_PASSWORD;

  if FileExists(TempFileName) then
    SysUtils.DeleteFile(TempFileName);

  with TOdbcBulkCopy.Create(nil) do try
    Connection := TOdbcConnection.Create(nil);
      connection.AdoConnectionString := uAztecDatabaseUtils.GetAztecDBConnectionString;
    Connection.Open;
    BulkCopyMode := bcmClipExport;
    Query := DataQuery;
    OutputFile := TempFileName;
    ExecuteOut(nil);
  finally
    Connection.Close;
    Connection.Free;
    Free;
  end;

    {BCPParams := Format(BCPQueryOutParams, [
      DataQuery, TempFileName, DatabaseMachine, UserName, Password
    ]);
    if not useful.ExecuteBatchFileAndWait(GetBCPPath, PChar(BCPParams), '', SW_HIDE) then
      raise Exception.Create('ExcelImportExport.CopyToClipBoard: BCP out failed');}

  Clipboard.AsText := '';
  ClipBoardData := TStringStream.Create(DataHeader);
  FileData := TFileStream.Create(TempFileName, fmOpenRead or fmShareDenyNone);
  FileData.Seek(0, soFromBeginning);
  ClipBoardData.Seek(0, soFromEnd);

  ClipBoardData.CopyFrom(FileData, FileData.Size);

  if LStrLen(PChar(ClipBoardData.DataString)) <> ClipBoardData.Size then
  begin
    // Nulls passed to clipboard this way will truncate the clipboard!
    // So rewrite the data a slower way..
    FileData.Seek(0, soFromBeginning);
    ClipBoardData.Seek(0, soFromEnd);
    ClipBoardData.Size := 0;
    ClipBoardData.WriteString(DataHeader);
    CopyStreamExceptNulls(FileData, ClipBoardData, FileData.Size)
  end;

  FileData.Free;
  try
    ClipBoard.AsText := '';
    Clipboard.AsText := ClipBoardData.DataString;
    FreeAndNil(ClipboardData);
  except
    on e:exception do
    begin
      raise Exception.Create('Failed to copy to clipboard: ' + e.message);
    end;
  end;
end;

function FieldListsEqual(List1: string; Separator1: char; List2: string; Separator2:char): boolean;
var
  FieldList1, FieldList2: TStrings;
  i: integer;
  procedure CleanList(List:TStrings);
  var
    j: integer;
    TmpStr: string;
  begin
    for j := Pred(List.Count) downto 0 do
    begin
      TmpStr := List[j];
      TmpStr := StringReplace(TmpStr, '[', '', [rfReplaceAll]);
      TmpStr := StringReplace(TmpStr, ']', '', [rfReplaceAll]);
      TmpStr := Trim(TmpStr);
      if Length(Tmpstr) = 0 then
        List.Delete(j)
      else
        List[j] := TmpStr;
    end;
  end;
begin
  FieldList1 := TStringList.Create;
  FieldList2 := TStringList.Create;
  try
    useful.SeparateList(List1, Separator1, FieldList1);
    useful.SeparateList(List2, Separator2, FieldList2);

    for i := 0 to pred(FieldList1.Count) do
      FieldList1[i] := GetRenamedField(FieldList1[i], false);
    for i := 0 to pred(FieldList2.Count) do
      FieldList2[i] := GetRenamedField(FieldList2[i], false);

    CleanList(FieldList1);
    CleanList(FieldList2);
    // Field list must match exactly
    Result := FieldList1.Text = FieldList2.Text;
  finally
    FieldList1.Free;
    FieldList2.Free;
  end;
end;

procedure TExcelExportImport.Log(text: string);
begin
  if Assigned(HandleLogging) then
    HandleLogging(text);
end;

function TExcelExportImport.PasteFromClipBoard(
  Conn: TADOConnection;
  FullyQualifiedTableName: string;
  KeyFields: string;
  FixedFields: string;
  DataFields: string;
  DependentFields: string;
  var ErrorList : TStringList;
  CurrencyFieldsToValidate : integerSet = [];
  NullableFields: string = '';
  DisplayHeaderFields: string = ''): integer;
var
  TempErrCount: integer;
  TempFileName, TempTableName: string;
  FixedFields_Source: string;
  DataHeader: string;
  ClipboardData: TStringStream;
  FileData: TFileStream;
  DatabaseMachine, DatabaseName, UserName, Password: string;
  BCPParams: string;
  i: integer;
  AztecQry: TADOQuery;
  AztecQry2: TADOQuery;
  ErrorFile : string;
  fImportErrorLog: TfImportErrorLog;
  RowsToUpdate : Integer;
  RowsUpdated : Integer;
  ExceptionMessage: String;
  TmpErrors: TStringList;
  TempStr: String;


  function GetSizeOfFile(const FileName: string): LongInt;
  var
    SearchRec: TSearchRec;
  begin
    if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then begin
      Result := SearchRec.Size;
      SysUtils.FindClose(SearchRec);
    end else begin
      Result := -1;
    end;
  end;

  function DelimitFieldNameIfNecessary(const fieldName: string): string;
  begin
    if fieldName[1] = '[' then
      Result := fieldName
    else
      Result := '[' + fieldName + ']';
  end;


  function GetDiscardNullDataSQL: string;
  var
    FieldsList: TStringList;
    NullableList: TStringList;
    TmpFieldList: string;
    i,j: integer;
  begin
    // Removes rows from the pasted data where non-nullable columns have
    // been given null values.
    FieldsList := TStringlist.Create;
    FieldsList.Sorted := True;
    NullableList :=  TStringList.Create;
    NullableList.Sorted := True;

    try
      TmpFieldList := StringReplace(DataFields, ', ', ',', [rfReplaceAll]);
      useful.SeparateList(TmpFieldList,',', FieldsList);

      TmpFieldList := StringReplace(NullableFields, ', ', ',', [rfReplaceAll]);
      useful.SeparateList(TmpFieldList,',', NullableList);

      for i := 0 to NullableList.Count - 1 do
        FieldsList.Delete(FieldsList.IndexOf(NullableList[i]));

      if FieldsList.Count <= 0  then
        Result := ''
      else begin
        Result := 'DELETE '+TempTableName+' WHERE ';
        for j := 0 to pred(FieldsList.Count) do
        begin
          Result := Result + Format('%s IS NULL ', [DelimitFieldNameIfNecessary(FieldsList[j])]);
          if j < Pred(FieldsList.count) then
            Result := Result + 'AND ';
        end;
      end;
    finally
      FieldsList.Free;
      NullableList.Free;
    end;
  end;

  // Given a dependentFieldConstruct string of the format:
  //    DependentField:Value{DataField1,...,DataFieldn}
  //    e.g. RecModified:1{FutureMatrix, DateOfChangeStr}

  // this returns in setClause a string of the format :
  //    DependentField = CASE WHEN a.DataField1 = b.DataField1 OR ... a.DataFieldn = b.DataFieldn THEN DependentField ELSE Value END
  //    e.g. RecModified = CASE WHEN a.FutureMatrix = b.FutureMatrix AND a.DateOfChangeStr = b.DateOfChangeStr THEN RecModified ELSE 1 END
  //
  // In other words it creates the SQL SET clause necessary to set the given flag field to the given value if any of its dependent
  // data fields are changed.
  function GetSetClauseForDependentField(dependentFieldConstruct: string) : string;
  var openingBracketPos, closingBracketPos, colonPos: integer;
      dependentField: string;
      dependentValue: string;
      dataFields: TStringList;
      setClause: string;
      i: integer;
  begin
    Result := '';
    dependentFieldConstruct := trim(dependentFieldConstruct);
    dataFields := TStringList.Create();
    colonPos := pos(':', dependentFieldConstruct);
    openingBracketPos :=  pos('{', dependentFieldConstruct);
    closingBracketPos :=  pos('}', dependentFieldConstruct);

    if (colonPos = 0) or (openingBracketPos = 0) or (closingBracketPos <> length(dependentFieldConstruct)) then
      Exit;  // The dependentFieldConstruct is not correctly formed.

    dependentField := copy(dependentFieldConstruct, 1, colonPos - 1);
    dependentValue := trim(copy(dependentFieldConstruct, colonPos + 1, openingBracketPos - colonPos - 1));

    useful.SeparateList(copy(dependentFieldConstruct, openingBracketPos + 1, length(dependentFieldConstruct) - openingBracketPos - 1), ',', dataFields);
    datafields.CommaText := AddColumnBrackets(datafields.CommaText);

    setClause := dependentField + ' = CASE WHEN ';

    for i := 0 to dataFields.Count - 1 do
    begin
      setClause := setClause + 'ISNULL(a.' + trim(dataFields[i]) + ', -1) = ISNULL(b.' + trim(dataFields[i]) + ', -1)';
      if i < dataFields.Count - 1 then
        setClause := setClause + ' AND ';
    end;

    setClause := setClause +  ' THEN ' + dependentField + ' ELSE ' + dependentValue + ' END';

    Result := setClause;
    dataFields.Free;
  end;

  function GetUpdateSQL: string;
  var
    SetStmt, setClause, JoinStmt: string;
    TmpFieldList: string;
    FieldsList, dependentFieldConstructs : TStrings;
    j: integer;
  begin
    FieldsList := TStringlist.Create;
    TmpFieldList := StringReplace(KeyFields, ', ', ',', [rfReplaceAll]);
    useful.SeparateList(TmpFieldList,',', FieldsList);
    FieldsList.CommaText := AddColumnBrackets(FieldsList.CommaText);
    JoinStmt := 'JOIN '+TempTableName+' b ON ';
    for j := 0 to Pred(FieldsList.count) do
    begin
      JoinStmt := JoinStmt + Format('a.%s = b.%s ', [
        GetRenamedField(FieldsList[j], true),
        GetRenamedField(FieldsList[j], false)
      ]);
      if j < Pred(FieldsList.count) then
        JoinStmt := JoinStmt + 'AND ';
    end;

    FieldsList.Clear;
    TmpFieldList := StringReplace(DataFields, ', ', ',', [rfReplaceAll]);
    useful.SeparateList(TmpFieldList,',', FieldsList);
    SetStmt := '';
    for j := 0 to Pred(FieldsList.count) do
    begin
      SetStmt := SetStmt + Format('%0:s = b.%0:s ', [DelimitFieldNameIfNecessary(FieldsList[j])]);
      if j < Pred(FieldsList.count) then
        SetStmt := SetStmt + ', ';
    end;

    if DependentFields <> '' then
    begin
      dependentFieldConstructs := TStringList.Create();

      try
        useful.SeparateList(DependentFields, ';', dependentFieldConstructs);

        for j := 0 to dependentFieldConstructs.Count - 1 do
        begin
          setClause := GetSetClauseForDependentField(dependentFieldConstructs[j]);

          if setClause = '' then
            raise Exception.Create('Software error: "' + dependentFieldConstructs[j] +
                                   '" is not a valid dependent field description')
          else
            SetStmt := SetStmt + ', ' + setClause;
        end;
      finally
        dependentFieldConstructs.Free;
      end;
    end;

    FieldsList.Free;
    Result := 'UPDATE '+FullyQualifiedTableName+' SET '+SetStmt+' FROM '+FullyQualifiedTableName+' a ' + JoinStmt;
  end;

  function GetSkippedRowsSQL: string;
  var
    JoinStmt, WhereStmt: string;
    TmpFieldList: string;
    FieldsList: TStrings;
    j: integer;
  begin
    FieldsList := TStringlist.Create;
    TmpFieldList := StringReplace(KeyFields, ', ', ',', [rfReplaceAll]);
    useful.SeparateList(TmpFieldList,',', FieldsList);
    JoinStmt := 'LEFT OUTER JOIN '+FullyQualifiedTableName+' b ON ';
    WhereStmt := ' WHERE ';
    for j := 0 to Pred(FieldsList.count) do
    begin
      JoinStmt := JoinStmt + Format('a.%s = b.%s ', [
        GetRenamedField(FieldsList[j], false),
        GetRenamedField(FieldsList[j], true)
      ]);
      WhereStmt := WhereStmt + Format('b.%s is null ', [
        GetRenamedField(FieldsList[j], true)
      ]);
      if j < Pred(FieldsList.count) then
      begin
        JoinStmt := JoinStmt + 'AND ';
        WhereStmt := WhereStmt + 'AND ';
      end;
    end;
    Result := 'SELECT a.* FROM '+TempTableName+' a ' + JoinStmt + WhereStmt;
    FieldsList.Free;
  end;

  function CheckFixedFields: string;
  var
    TmpFieldList: string;
    FixedFieldList: TStringlist;
    i: integer;
    function FieldExists(TableName, FieldName: string): boolean;
    begin
      with TADOQuery.Create(nil) do try
        Connection := Conn;
        if pos('##', TableName) = 1 then
          SQL.Text := Format('select count(*) from tempdb.information_schema.columns where table_name = %s and column_name = %s',
            [QuotedStr(TableName), QuotedStr(FieldName)])
        else
        if pos('#', TableName) = 1 then
          SQL.Text := Format('select count(*) from tempdb..syscolumns where id = object_id(%s) and name = %s',
            [QuotedStr('TempDB..'+TableName), QuotedStr(FieldName)])
        else
          SQL.Text := Format('select count(*) from information_schema.columns where table_name = %s and column_name = %s',
            [QuotedStr(TableName), QuotedStr(FieldName)]);
        Open;
        Result := Fields[0].AsInteger > 0;
        Close;
      finally
        Free;
      end;
    end;
  begin
    // Input is a list of fixed fields that are in exported data
    // e.g SiteRef, SiteName.
    // If we can't get datatype info for any of these fields from the target
    // table (i.e. they are fields derived from other fields in the target table
    // then replace them with dummy projector e.g.
    //   "cast('' as varchar(200)) as FixedFieldName"
    // this way we still get a temporary table with a compatible structure to the
    // exported data.
    Result := '';
    FixedFieldList := TStringlist.Create;
    try
      TmpFieldList := StringReplace(FixedFields, ', ', ',', [rfReplaceAll]);
      useful.SeparateList(TmpFieldList,',', FixedFieldList);
      for i := 0 to pred(FixedFieldList.Count) do
      begin
        if FieldExists(FullyQualifiedTableName, FixedFieldList[i]) then
          Result := Result + FixedFieldList[i]
        else
          Result := Result + 'cast('''' as varchar(50)) as '+FixedFieldList[i];
        if i < pred(FixedFieldList.Count) then
           Result := Result + ',';
      end;
    finally
      FixedFieldList.Free;
    end;
  end;

  function ValidatePrices(TmpTableName: String; CurrencyFieldsToValidate : integerSet;ErrorList : TStringList) : boolean;
  var
    i : integer;
    ADOQuery: TADOQuery;
    ErrRow: TStringList;
    TestQuery: String;
    FieldList: TStringlist;
    TempField: String;
  begin
    //Build the test condition we are interested in
    TestQuery := '';
    FieldList := TStringList.Create;
    try
      ExtractStrings([','], [' '], PChar(KeyFields + ',' + FixedFields + ',' + DataFields), FieldList);
      for i := 0 to FieldList.Count - 1 do
      begin
        if i in CurrencyFieldsToValidate then
        begin
          TempField := FieldList[i];

          if (lowercase(TempField) = 'as')
            or (lowercase(TempField) = 'by')
            or (lowercase(TempField) = 'if')
            or (lowercase(TempField) = 'in')
            or (lowercase(TempField) = 'is')
            or (lowercase(TempField) = 'of')
            or (lowercase(TempField) = 'on')
            or (lowercase(TempField) = 'or')
            or (lowercase(TempField) = 'to')
            or isnumeric(copy(TempField, 1, 1)) then
            TempField := '['+TempField+']';

          if TestQuery <> '' then
            TestQuery := TestQuery + ' OR ';
          TestQuery := TestQuery + '([' + FieldList[i] + '] < 0)';
        end;
      end;
    finally
      FieldList.Free;
    end;

    Result := True;
    if TestQuery <> '' then
    begin
      //Report all import records that break the pricing condition of >=0
      ADOQuery := TADOQuery.Create(nil);
      try
        ADOQuery.Connection := conn;
        with ADOQuery do
        begin
          SQL.Add('SELECT * FROM ' + TmpTablename + ' WHERE ' + TestQuery);
          Open;
          while not EOF do
          begin
            Result := False;
            ErrRow := TStringList.Create;
            try
              for i := 0 to Fields.Count - 1 do
              begin
                ErrRow.Add(Fields[i].AsString);
              end;
              ErrorList.Add(ErrRow.CommaText);
              break;
            finally
              ErrRow.Free;
            end;
          end;
          Close;
        end;
      finally
        ADOQuery.Free;
      end;
    end;
  end;

begin
  Result := 0;
  if Trim(DataFields) = '' then
    exit;

  if DisplayHeaderFields = '' then
    DisplayHeaderFields := DataFields;

  Result := -1;
  TempFileName := useful.GetTempDir + 'AztecClipCopy_'+inttostr(GetTickCount);

  Log(Format('PasteFromClipboard: Temp clipboard data path [%s]', [TempFileName]));

  // prepare temp table for the pasted data

  // Check if fixed fields exist. If not, this is fine, but we must create dummy
  // field definitions in order to import these as strings from the clipboard data
  FixedFields_Source := CheckFixedFields;

  AztecQry := TADOQuery.Create(nil);
  AztecQry.Connection := Conn;
  AztecQry.CommandTimeout := 0;

  AztecQry2 := TADOQuery.Create(nil);
  AztecQry2.Connection := Conn;
  AztecQry2.CommandTimeout := 0;

  try
    AztecQry.SQL.Text := 'select @@spid';
    AztecQry.Open;
    TempTableName := '##AztecPasteImport_'+inttostr(GetTickCount)+'_'+AztecQry.Fields[0].AsString;
    // Allow for case when no fixed fields
    if FixedFields_Source <> '' then
      FixedFields_Source := FixedFields_Source + ', ';
    AztecQry.SQL.Text := 'select top 0 '+KeyFields+', '+FixedFields_Source+AddColumnBrackets(DataFields)+' into '+TempTableName+' from '+FullyQualifiedTableName;
    AztecQry.ExecSQL;

    ClipBoardData := TStringStream.Create(ClipBoard.AsText);
    Clipboard.AsText := '';
    try
      ClipBoardData.Seek(0, soFromBeginning);

      for i := 1 to Length(ClipBoardData.DataString) do
        if ClipBoardData.DataString[i] in [#10, #13] then
          break;
      while (i>0) and (ClipBoardData.DataString[i] in [#10, #13]) do
        inc(i);

      ClipBoardData.Seek(0, soFromBeginning);
      DataHeader := ClipBoardData.ReadString(i-1);

      if not FieldListsEqual(DataHeader, #9, KeyFields+', '+FixedFields+', '+DisplayHeaderFields, ',') then
        raise Exception.Create('Could not import data: Column lists do not match!' + #10#13 +
                               'Possible reasons:' + #10#13 +
                                       '1. Clipboard is empty' + #10#13 +
                                       '2. Clipboard data is not in a correct excel format' + #10#13 +
                                       '3. You have not selected all necessary columns in your excel sheet'
                                );

      FileData := TFileStream.Create(TempFileName, fmCreate or fmShareDenyNone);

      if (ClipBoardData.Size - (i-1)) > 0 then
      try
        FileData.CopyFrom(ClipBoardData, ClipBoardData.Size - (i-1));
        FreeAndNil(FileData);

        // BCP paste data to temp table
        uAztecDatabaseUtils.GetAztecDatabaseParameters(DatabaseMachine, DatabaseName);
        UserName := 'ZonalSysAdmin';
        Password := uAztecDatabaseUtils.ZONAL_SYSADMIN_PASSWORD;
        ErrorFile := useful.GetTempDir + 'AztecClipCopy_ErrorLog_'+inttostr(GetTickCount);

        BCPParams := Format(BCPInParams, [
          TempTableName, TempFileName, DatabaseMachine, UserName, Password, ErrorFile
        ]);

        with TOdbcBulkCopy.Create(nil) do try
          Connection := TOdbcConnection.Create(nil);
          connection.AdoConnectionString := uAztecDatabaseUtils.GetSysAdminAztecDBConnectionString;
          Connection.Open;
          BulkCopyMode := bcmClipExport;
          Query := TempTableName;
          OutputFile := TempFileName;
          ExecuteIn(pchar(ErrorFile));
        finally
          Connection.Close;
          Connection.Free;
          Free;
        end;



        {if not useful.ExecuteBatchFileAndWait(GetBCPPath, PChar(BCPParams), '', SW_HIDE) then
        begin
          Log(Format('BCP params: %s', [BCPParams]));
          ErrorList.Add('ExcelImportExport.PasteFromClipBoard: BCP in failed');
          raise Exception.Create('ExcelImportExport.PasteFromClipBoard: BCP in failed');
        end;}

        if (CurrencyFieldsToValidate <> []) then
        begin
          // Now, lets validate each line in the stringlist to ensure that threr are no negative prices
          if not ValidatePrices(TempTableName, CurrencyFieldsToValidate, ErrorList) then
          begin
            fImportErrorLog := TfImportErrorLog.Create(nil);
            fImportErrorLog.Label1.Caption := 'Data import failed due to negative prices.';
            TmpErrors := TStringList.create;
            TmpErrors.Assign(ErrorList);
            fImportErrorLog.ErrorList := TmpErrors;
            fImportErrorLog.showmodal;
            fImportErrorLog.free;
            Exit;
          end;
        end;

        //Add a row-numbering *after* BCP has done it's thing: adding it before
        //would cause errors since the target won't match the source.
        AztecQry.Close;
        AztecQry.SQL.Clear;
        AztecQry.SQL.Add('ALTER TABLE ' + TempTableName + ' ADD BCP_ID INT IDENTITY (1,1)');
        AztecQry.ExecSQL;

        // SMcC - Now we need to check if bcp produced any errors and if so display them to the user
        // so see if the error file exists and what size it is
        if FileExists(ErrorFile) And (GetSizeOfFile (ErrorFile) > 0) then
        begin
          ErrorList.LoadFromFile(ErrorFile);
          fImportErrorLog := TfImportErrorLog.Create(nil);
          fImportErrorLog.ErrorList := ErrorList;
          fImportErrorLog.Show;
        end
        else
        begin
          // Discard rows with no values in the data fields
          AztecQry.SQL.Text := GetDiscardNullDataSQL;
          if AztecQry.SQL.Text <> '' then
            AztecQry.ExecSQL;
          // apply changes
          // all rows are assumed to exist i.e. in pricing, the same data is loaded
          // as when the data  was copied
          AztecQry.Connection.BeginTrans;
          Try
            AztecQry.SQL.Text := GetUpdateSQL;
            Result := AztecQry.ExecSQL;
            RowsUpdated := AztecQry.RowsAffected;
            AztecQry.SQL.Clear;
            AztecQry.SQL.Add('SELECT COUNT (*) AS COUNT FROM '+TempTableName);
            AztecQry.Open;
            RowsToUpdate := AztecQry.FieldByName ('COUNT').AsInteger;
            if RowsToUpdate > RowsUpdated  then
            begin
              AztecQry2.SQL.Text := GetSkippedRowsSQL;
              AztecQry2.Open;
              if not AztecQry2.EOF then
              begin
                TempErrCount := 0;

                TmpErrors := TStringList.Create;
                try
                
                  while not AztecQry2.Eof do
                  begin
                    Inc(TempErrCount);
                    TempStr:= AztecQry2.Fields.Fields[0].AsString;
                    for i := 1 to AztecQry2.FieldCount - 1 do
                      if AztecQry2.Fields.Fields[i].FieldName <> 'BCP_ID' then
                        TempStr:= TempStr + ', ' + AztecQry2.Fields.Fields[i].AsString;
                    TmpErrors.Add('@ Row ' + InttoStr(AztecQry2.FieldByName('BCP_ID').AsInteger + 1) + ': Unable to import record');
                    TmpErrors.Add(TempStr);
                    AztecQry2.Next;

                    if TmpErrors.Count > 100 then
                    begin
                      TmpErrors.Add(Format('And %d more errors...', [AztecQry2.RecordCount - TempErrCount]));
                      AztecQry2.Last;
                    end;
                  end;

                  fImportErrorLog := TfImportErrorLog.Create(nil);
                  try
                    fImportErrorLog.Label1.Caption := 'Data import failed: unable to match 1 or more records.';
                    fImportErrorLog.ErrorList := TmpErrors;
                    fImportErrorLog.Showmodal;
                  finally
                    fImportErrorLog.Free;
                  end;

                finally
                  TmpErrors.Free;
                end;

                AztecQry.Connection.RollbackTrans;
                Result := 0;
              end
              else
                raise EImportFailed.Create('The data you are importing is larger than expected');
            end
            else
            if RowsToUpdate < RowsUpdated then
            begin
              raise EImportFailed.Create('Error updating import data');
            end
            else
              AztecQry.Connection.CommitTrans;
          except
            on E:Exception do begin
              //ExceptionMessage := Format ('Data Import failed - %s', [E.Message]); E.Message - generates and displays 'Access violation of address .....'
              ExceptionMessage := 'Data Import failed! Clipboard data does not correspond to the selected banding.';
              MessageDlg (ExceptionMessage, mtError, [mbOK], 0);
              ErrorList.Add(ExceptionMessage);
              AztecQry.Connection.RollbackTrans;
              Result := 0;
            end;
          end;
        end;
      finally
        if FileExists(TempFileName) then
          SysUtils.DeleteFile(TempFileName);
        if FileExists(ErrorFile) then
          SysUtils.DeleteFile (ErrorFile);
      end;
    finally
      if Assigned(FileData) then
        FileData.Free;
      ClipBoardData.Free;
    end;
  finally
    AztecQry.SQL.Text := 'drop table '+TempTableName;
    try
      AztecQry.ExecSql;
    except
    end;
    AztecQry.Free;
    AztecQry2.Free;
  end;
end;

end.
