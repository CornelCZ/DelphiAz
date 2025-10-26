unit dADOAbstract;

interface

uses
  Windows, SysUtils, Classes, DB, ADODB, Forms;

type
  TdmADOAbstract = class(TDataModule)
    AztecConn: TADOConnection;
    adocRun: TADOCommand;
    adoqRun: TADOQuery;
    adoTRun: TADOTable;
    AztecConnSysAdmin: TADOConnection;
    procedure DataModuleCreate(Sender: TObject); virtual;
    function EmptySQLTable(tableName : string): Boolean;
    function DumpTemp(tableName : string): Boolean;
    function DelSQLTable(tableName: string): Boolean;
    function SQLTableExists(TableName : string): Boolean;
    function IsEmptyTable (tableToCheck : String) : boolean;
    procedure DataModuleDestroy(Sender: TObject);
    procedure AztecConnAfterConnect(Sender: TObject);
    procedure AztecConnWillExecute(Connection: TADOConnection;
      var CommandText: WideString; var CursorType: TCursorType;
      var LockType: TADOLockType; var CommandType: TCommandType;
      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
      const Command: _Command; const Recordset: _Recordset);
  private
    function getSPID: Integer;
  protected
    FTablesToRename : Array of String;
    FAztecConnSPID : Integer;
    procedure CreateTempTables; virtual;
    procedure DefineTablesToRenameList(arrayOfTableNames : Array of String);
    procedure LogError(Error: string); virtual;
    function InsertSPIDToGlobalTableNames(const SQL: WideString) : WideString;
    function ReplaceSessionTempsWithGlobalTemps(SQL : WideString) : WideString;
  public
    procedure BeginTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;
    function InTransaction : boolean;

    function IsAposDatabaseInstalled : Boolean;
    function SafeExecSQL : integer;
    function getDBID : String;
    property AztecConnSPID: integer read FAztecConnSPID;

    class function ADOUpdatesPending (ADODataSet: TCustomADODataSet): integer;
    class function FormatDateForSQL(date : TDateTime) : string;
    class function FormatDateTimeForSQL(date : TDateTime) : string;
  end;

const
  DEBUG_MODE : integer = 0;

implementation

{$R *.dfm}

uses Dialogs, uAztecDatabaseUtils, comobj;

procedure TdmADOAbstract.DataModuleCreate(Sender: TObject);
var
  ConnectedOK : boolean;
  ErrorMessage : string;
begin
  ConnectedOK := FALSE;
  ErrorMessage := '';

  try
    SetupAztecADOConnection(AztecConn);
    SetUpSysAdminAztecADOConnection(AztecConnSysAdmin);
    AztecConn.Open;
    AztecConnSysAdmin.Open;
    ConnectedOK := AztecConn.Connected and AztecConnSysAdmin.Connected;
  except
    on E:exception do
    begin
      ErrorMessage := E.Message;
    end;
  end;

  if ConnectedOK then
  begin
    if AztecConn.DefaultDatabase <> 'Aztec' then
      logError('Connected OK to ' + AztecConn.DefaultDatabase + ' database')
    else
      logError('Connected OK to Aztec database');
    CreateTempTables;
  end
  else
  begin
    logError('FATAL ERROR: Cannot connect to Aztec Database: ' + ErrorMessage);
    MessageDlg('Cannot connect to Aztec Database. Aborting Application.'#13#10#13#10+
               'Error: '+ ErrorMessage, mtError, [mbOk], 0);
    Halt;
  end;
end;

procedure TdmADOAbstract.DataModuleDestroy(Sender: TObject);
begin
  AztecConn.Close;
  AztecConnSysAdmin.Close;
end;

function TdmADOAbstract.DumpTemp(tableName: string): Boolean;
begin
  Result := False;
  try
    adocRun.CommandText := 'if exists ' + #13 +
      '(select * from dbo.sysobjects ' + #13 +
      '  where id = object_id(N''[zonalaccess].[00_' + tableName + ']'') ' + #13 +
      '  and OBJECTPROPERTY(id, N''IsUserTable'') = 1)' + #13 +
      'drop table [zonalaccess].[00_' + tableName + ']' + #13 +
      '' + #13 +
      'select * into [00_' + tableName + '] from [' + tableName + ']';
    adocRun.Execute;
    Result := True;
  except
  end;
end;

function TdmADOAbstract.EmptySQLTable(tableName: string): Boolean;
begin
  Result := False;
  try
    adocRun.CommandText := 'truncate table [' + tableName + ']';
    adocRun.Execute;
    Result := True;
  except
  end;
end;

function TdmADOAbstract.DelSQLTable(tableName: string): Boolean;
begin
  Result := False;
  try
    adocRun.CommandText := 'drop table [' + tableName + ']';
    adocRun.Execute;
    Result := True;
  except
  end;
end;

function TdmADOAbstract.SQLTableExists(TableName : string): Boolean;
var
 queryStr : String;
begin
  if TableName[1] = '#' then
    { Temporary table name. Look for table in tempDB database }
    queryStr := 'SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID(''tempdb..'+TableName+''')'
  else
    { Not a temporary table name. Look for table in Aztec database }
    queryStr := 'SELECT Table_Name FROM INFORMATION_SCHEMA.TABLES WHERE UPPER(Table_Name) = ''' + UpperCase(TableName) + '''';

  with adoqRun do
  begin
    Close;
    Sql.Clear;
    Sql.Add(queryStr);
    Open;
    Result := (RecordCount > 0);
    Close;
  end;
end;

function TdmADOAbstract.IsEmptyTable (tableToCheck : String) : boolean;
begin
  with adoTRun do
    begin
      close;
      TableName := tableToCheck;
      open;
      Result := IsEmpty;
      close;
    end;
end;

procedure TdmADOAbstract.CreateTempTables;
begin
  // Method to be overridden in descendant classes to create any temp tables required.
end;

procedure TdmADOAbstract.LogError(Error: string);
begin
  // Method to be overridden in descendant classes to perform any logging required.
end;

procedure TdmADOAbstract.BeginTransaction;
begin
  Assert(not AztecConn.InTransaction, 'TdmADOAbstract.BeginTransaction called when a transaction already exists');
  AztecConn.BeginTrans;
end;

procedure TdmADOAbstract.CommitTransaction;
begin
  AztecConn.CommitTrans;
end;

procedure TdmADOAbstract.RollbackTransaction;
begin
  AztecConn.RollbackTrans;
end;

function TdmADOAbstract.InTransaction : boolean;
begin
  Result := AztecConn.InTransaction;
end;

class function TdmADOAbstract.FormatDateForSQL(date : TDateTime) : string;
{ Returns the given datetime as a date string suitable for passing to an SQL query }
begin
  Result := '''' + formatdatetime('yyyymmdd', date) + '''';
end;

class function TdmADOAbstract.FormatDateTimeForSQL(date : TDateTime) : string;
{ Returns the given datetime as a date & time string suitable for passing to an SQL query }
begin
  Result := '''' + formatdatetime('yyyymmdd hh:nn:ss', date) + '''';
end;

function TdmADOAbstract.IsAposDatabaseInstalled : Boolean;
begin
  with ADOQrun do
  try
    Close;
    SQL.Text := 'SELECT COUNT(*) AS [Result] FROM Master..SysDatabases WHERE [Name] = ''APOS''';
    Open;
    Result := (FieldByName('Result').AsInteger > 0);
  finally
    close;
  end;
end;

{ Returns the number of changed records in an ADODataset which have not yet been saved back to
  the underlying table. The ADODataset must be in LockType=ltBatchOptimistic mode. }
class function TdmADOAbstract.ADOUpdatesPending (ADODataSet: TCustomADODataSet): integer;
var
  Clone : TADODataSet;
begin
  Clone := TADODataSet.Create(nil);

  try
    Clone.Clone(ADODataSet);
    Clone.FilterGroup := fgPendingRecords;
    Clone.Filtered := TRUE;

    Result := Clone.RecordCount;

    Clone.Close;
  finally
    FreeAndNil(Clone);
  end;
end;

function TdmADOAbstract.SafeExecSQL: integer;
var
  tmpstr: string;
  i, NumberOfSQLErrors: integer;
begin
  Result := -1;
  try
    adoqrun.execsql;
  except
  end;

  tmpstr := '';
  NumberOfSQLErrors := AztecConn.Errors.Count;
  for i := 0 to pred(NumberOfSQLErrors) do
    tmpstr := tmpstr + AztecConn.Errors.Item[i].Description +#13+#10;
  if NumberOfSQLErrors > 0 then
    raise EOLEException.Create(tmpstr, 1, 'EXECSqlError', 'N/a', 0);
end;


// uses the fn_getGlobalTempTablePrefix to return the DB_ID property of the current database as a 3 character
// string
function TdmADOAbstract.getDBID: String;
begin
  with adoqRun do
  begin
    close;
    sql.clear;
    sql.Add('select dbo.fn_getGlobalTempTablePrefix() as id');
    open;
    result := Fields.FieldByName('id').AsString;
  end;
end;

procedure TdmADOAbstract.AztecConnAfterConnect(Sender: TObject);
begin
  FAztecConnSPID := getSPID;
end;

function TdmADOAbstract.getSPID : Integer;
begin
  with adoqRun do
  begin
    SQL.text := 'select @@SPID as SPID';
    Open;
    result := FieldByName('SPID').AsInteger;
    Close;
  end;
end;

//KLUDGE!!!!!!
//In the style of the promotions module the global tables created
//to model the product/estate structure are renamed  to incorporate the
//server process id to guarantee uniqueness.  However, it transpires that
//ADO.Net does not play well with named parameters and consequently this
//code is broken when used with master-detail linkages, e.g. dsThemes -> dsPanelDesigns.
//The problem does not arise if the CommandText is not modified in these cases:
//the act of assigning the unchanged commandtext back to itself caused the problem.
//Since no use of the global table is ever part of a parameterised query we will
//keep this 'fix'/kludge until such time as a better solution is found and we
//will just ensure that unmodified queries do not unnecessarily get reassigned
//back to themselves.
procedure TdmADOAbstract.AztecConnWillExecute(Connection: TADOConnection;
  var CommandText: WideString; var CursorType: TCursorType;
  var LockType: TADOLockType; var CommandType: TCommandType;
  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
  const Command: _Command; const Recordset: _Recordset);
var
  NewSQL: WideString;
begin
  if pos('##', CommandText) <> 0 then
  begin
    NewSQL := InsertSPIDToGlobalTableNames(CommandText);
    if CommandText <> NewSQL then
      CommandText := NewSQL;
  end;
  if DEBUG_MODE = 1 then
  begin
    CommandText := ReplaceSessionTempsWithGlobalTemps(CommandText);
  end;
end;


// ensures unique names for global tables in the event that more than one aztec database is in use on a server at
// one time.
function TdmADOAbstract.InsertSPIDToGlobalTableNames(const SQL: WideString) : WideString;

  function DoRename(const SQL : WideString; TableList: array of string) : WideString;
  var
    i : integer;
    renamedString : WideString;
  begin
    renamedString := SQL;
    for i := low(TableList) to high(TableList) do
    begin
      if pos(lowercase('##'+TableList[i]), lowercase(renamedString)) <> 0 then
      begin
        renamedString := StringReplace(renamedString, '##'+TableList[i], '##'+IntToStr(FAztecConnSPID)+TableList[i], [rfReplaceAll, rfIgnoreCase]);
      end;
    end;
    result := renamedString;
  end;

begin
  result := DoRename(SQL, FTablesToRename);
end;

{$HINTS OFF}
function TdmADOAbstract.ReplaceSessionTempsWithGlobalTemps (sql : WideString) : WideString;
var
  i: integer;
const
  WhitespaceChars : WideString = ' .(,[{';
begin
  Result := sql;
  for i:=1 to Length (Result) do
  begin
    // First find a #
    if Result[i] = '#' then
    begin
      // if its the first char on the line or it has a space before it then it be a temp tablename
      if (i = 0) or (Pos(Result[i - 1], WhitespaceChars) <> 0) then begin
        if (Length (Result) > i) and ((char(Result[i + 1]) in ['a'..'z']) or (char(Result[i + 1]) in ['A'..'Z'])) then begin
          Insert ('#', Result, i);
        end;
      end;
    end;
  end;
end;
{$HINTS ON}

procedure TdmADOAbstract.DefineTablesToRenameList(
  arrayOfTableNames: array of String);
var
  i : integer;
begin
  SetLength(FTablesToRename, Length(arrayOfTableNames));
  For i := Low(arrayOfTableNames) to High(arrayOfTableNames) do
  begin
    FTablesToRename[i] := arrayOfTableNames[i];
  end;
end;

end.
