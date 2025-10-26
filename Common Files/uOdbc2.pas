unit uOdbc2;

interface

uses Classes;

type
  SQLSMALLINT = SmallInt;
  SQLRETURN = SQLSMALLINT;
  SQLHANDLE = Pointer;
  BCPRETURN = SmallInt;

  TOdbcEnv = class(TComponent)
  private
    Fhandle : SQLHANDLE;
    FconnectionCount : Integer;
    procedure Check(odbcResult : SQLRETURN; operation : string);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TOdbcConnection = class(TComponent)
  private
    Fenv : TOdbcEnv;
    Fhandle : SQLHANDLE;
    FconnectionString : string;
    Fconnected : boolean;
    procedure SetConnectionString(connectionString : string);
    procedure SetAdoConnectionString(adoConn : string);
    procedure SetConnected(connected : boolean);
    procedure Check(odbcResult : SQLRETURN; operation : string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Open;
    procedure Close;
    property Connected : boolean read Fconnected write SetConnected;
    property OdbcConnectionString : string read FconnectionString write SetConnectionString;
    property AdoConnectionString : string write SetAdoConnectionString;
  end;

  TOdbcBulkCopyMode = (bcmBinary, bcmClipExport);

  TOdbcBulkCopy = class(TComponent)
  private
    FoutputFile : string;
    Fquery : string;
    Fconnection : TOdbcConnection;
    procedure Check(bcpResult : BCPRETURN; operation : string); overload;
  public
    BulkCopyMode: TOdbcBulkCopyMode;
    property Connection : TOdbcConnection read Fconnection write Fconnection;
    property OutputFile : string read FoutputFile write FoutputFile;
    property Query : string read Fquery write Fquery;
    function ExecuteOut(ErrorFile: PChar) : Integer;
    function ExecuteIn(ErrorFile: PChar) : Integer;
  end;

implementation

uses SysUtils, StrUtils;

//
// ODBC library definitions
//
type
  ULONG = LongInt;
  SQLINTEGER = LongInt;
  SQLHENV = Pointer;
  SQLHDBC = Pointer;
  SQLHSTMT = Pointer;
  SQLPOINTER = Pointer;
  SQLHWND = LongWord;
  SQLUSMALLINT = Word;
  PSQLCHAR = PAnsiChar;

const
  SQL_SUCCESS = 0;
  SQL_SUCCESS_WITH_INFO = 1;

  ODBC32DLL = 'odbc32.dll';

  SQL_HANDLE_ENV = 1;
  SQL_HANDLE_DBC = 2;
  SQL_HANDLE_STMT = 3;
  SQL_HANDLE_DESC = 4;

  SQL_NULL_HANDLE = SQLHANDLE(0);

  SQL_IS_INTEGER = (-6);

  SQL_ATTR_ODBC_VERSION = 200;

  SQL_OV_ODBC3 = ULONG(3);

  SQL_DRIVER_NOPROMPT = 0;

function SQLGetDiagRec(
  HandleType: SQLSMALLINT;
  Handle: SQLHANDLE;
  RecNumber: SQLSMALLINT;
  Sqlstate: PAnsiChar; // pointer to 5 character buffer
  var NativeError: SQLINTEGER;
  MessageText: PAnsiChar;
  BufferLength: SQLSMALLINT;
  var TextLength: SQLSMALLINT
  ): SQLRETURN; stdcall; external ODBC32DLL;


function SQLAllocHandle(
  HandleType: SQLSMALLINT;
  InputHandle: SQLHANDLE;
  var OutputHandle: SQLHANDLE
  ): SQLRETURN; stdcall; external ODBC32DLL;

function SQLSetEnvAttr(
  EnvironmentHandle: SQLHENV;
  Attribute: SQLINTEGER;
  ValuePtr: pointer;
  StringLength: SQLINTEGER
  ): SQLRETURN; stdcall; external ODBC32DLL;

function SQLFreeHandle(
  HandleType: SQLSMALLINT;
  Handle: SQLHANDLE
  ): SQLRETURN; stdcall; external ODBC32DLL;

function SQLSetConnectAttr(
  ConnectionHandle: SQLHDBC;
  Attribute: SQLINTEGER;
  ValuePtr: SQLPOINTER;
  StringLength: SQLINTEGER
  ): SQLRETURN; stdcall; external ODBC32DLL;

function SQLDriverConnect(
  hdbc: SQLHDBC;
  hwnd: SQLHWND;
  szConnStrIn: PAnsiChar;
  cbConnStrIn: SQLSMALLINT;
  szConnStrOut: PAnsiChar;
  cbConnStrOutMax: SQLSMALLINT;
  var pcbConnStrOut: SQLSMALLINT;
  fDriverCompletion: SQLUSMALLINT
  ): SQLRETURN; stdcall; external ODBC32DLL;

function SQLDisconnect(
  ConnectionHandle: SQLHDBC
  ): SQLRETURN; stdcall; external ODBC32DLL;

function SQLExecDirect(
  StatementHandle: SQLHSTMT;
  StatementText: PSQLCHAR;
  TextLength: SQLINTEGER
):SQLRETURN; stdcall; external ODBC32DLL;

function SQLNumResultCols(
  StatementHandle: SQLHSTMT;
  var ColumnCount: SQLSMALLINT
):SQLRETURN; stdcall; external ODBC32DLL;

function SQLSetStmtAttr(
  StatementHandle: SQLHSTMT;
  Attribute: SQLINTEGER;
  Value: SQLPOINTER;
  StringLength: SQLINTEGER
):SQLRETURN; stdcall; external ODBC32DLL;



//
// BCP library defintions
//

const
  SQL_COPT_SS_BASE = 1200;
  SQL_COPT_SS_BCP = SQL_COPT_SS_BASE+19; // Allow BCP usage on connection

  SQL_BCP_ON = 1;

  SQL_VARLEN_DATA = -10;


  // bcp_control  option
  BCPMAXERRS = 1; // Sets max errors allowed
  BCPFIRST = 2; // Sets first row to be copied out
  BCPLAST = 3; // Sets number of rows to be copied out
  BCPBATCH = 4; // Sets input batch size
  BCPKEEPNULLS = 5; // Sets to insert NULLs for empty input values
  BCPABORT = 6; // Sets to have bcpexec return SUCCEED_ABORT
  BCPODBC = 7; // Sets ODBC canonical character output
  BCPKEEPIDENTITY = 8; // Sets IDENTITY_INSERT on
  BCP6xFILEFMT = 9; // DEPRECATED: Sets 6x file format on
  BCPHINTSA = 10; // Sets server BCP hints (ANSI string)
  BCPHINTSW = 11; // Sets server BCP hints (UNICODE string)
  BCPFILECP = 12; // Sets clients code page for the file
  BCPUNICODEFILE = 13; // Sets that the file contains unicodeheader
  BCPTEXTFILE = 14; // Sets BCP mode to expect a text file and to detect Unicode or ANSI automatically
  BCPFILEFMT = 15; // Sets file format version

  // SQL Server Data Type Tokens. Returned by SQLColAttributes/SQL_CA_SS_COLUMN_SSTYPE.
  SQLTEXT             = $23;
  SQLVARBINARY        = $25;
  SQLINTN             = $26;
  SQLVARCHAR          = $27;
  SQLBINARY           = $2d;
  SQLIMAGE            = $22;
  SQLCHARACTER        = $2f;
  SQLINT1             = $30;
  SQLBIT              = $32;
  SQLINT2             = $34;
  SQLINT4             = $38;
  SQLMONEY            = $3c;
  SQLDATETIME         = $3d;
  SQLFLT8             = $3e;
  SQLFLTN             = $6d;
  SQLMONEYN           = $6e;
  SQLDATETIMN         = $6f;
  SQLFLT4             = $3b;
  SQLMONEY4           = $7a;
  SQLDATETIM4         = $3a;
  SQLDECIMAL          = $37;
  SQLDECIMALN         = $6a;
  SQLNUMERIC          = $3f;
  SQLNUMERICN         = $6c;



  // BCPFILECP values
  // Any valid code page that is installed on the client can be passed plus:
  BCPFILECP_ACP = 0; // Data in file is in Windows code page
  BCPFILECP_OEMCP = 1; // Data in file is in OEM code page (default)
  BCPFILECP_RAW = (-1);// Data in file is in Server code page(no conversion)

  DB_IN = 1;
  DB_OUT = 2;

  BCP_DLL = 'Odbcbcp.dll';

const
  FAIL=0;
  SUCCEED=1;
  SUCCEED_ABORT=2;
  SUCCEED_ASYNC=3;

function bcp_init(
  ConnectionHandle : SQLHANDLE;
  Table : PAnsiChar;
  DataFile : PAnsiChar;
  ErrorFile : PAnsiChar;
  Direction : Integer) : BCPRETURN; stdcall; external BCP_DLL name 'bcp_initA';

function bcp_control(
  ConnectionHandle : SQLHANDLE;
  BcpOption : Integer;
  iValue : Pointer) : BCPRETURN; stdcall; external BCP_DLL;

function bcp_exec (
  ConnectionHandle : SQLHANDLE;
  out RowsProcessed : Integer) : BCPRETURN; stdcall; external BCP_DLL;

function bcp_columns (
  ConnectionHandle: SQLHANDLE;
  NumColumns: integer
): BCPRETURN; stdcall; external BCP_DLL;

function bcp_colfmt (
  ConnectionHandle: SQLHANDLE;
  ColumnIndex: integer; // First column is 1
  DataType: byte;
  Indicator: integer;
  DataLength: integer;
  DataTerminator : PAnsiChar;
  DataTerminatorLength: integer;
  ServerColumnIndex: integer // First server column is 1
): BCPRETURN; stdcall; external BCP_DLL;

//
// Class implementation
//
var
  env : TOdbcEnv;

function GetLastOdbcError(handleType : Integer; handle : SQLHANDLE) : string;
var
  recNo : Integer;
  sqlState : string;
  nativeError : Integer;
  messageText : string;
  messageTextLength : smallint;
  diagRecResult : SQLRETURN;
begin
  Result := '';
  recNo := 1;
  SetLength(sqlState,5);
  SetLength(messageText,4096);
  while true do
  begin
    diagRecResult := SQLGetDiagRec(
      handleType, handle, recNo, PChar(sqlState), nativeError,
      PChar(messageText), Length(messageText), messageTextLength);

    if diagRecResult <> SQL_SUCCESS then
      break;
    SetLength(messageText, messageTextLength);
    Result := Result + messageText + ' ('+sqlState+')';
    Inc(recNo);
  end;
end;

procedure OdbcCheck(odbcResult : SQLRETURN; handleType : Integer; handle : SQLHANDLE; operation : string);
begin
  if (odbcResult <> SQL_SUCCESS) and (odbcResult <> SQL_SUCCESS_WITH_INFO) then
    raise Exception.Create('ODBC error '+operation+': '+GetLastOdbcError(handleType, handle));
end;

procedure BcpCheck(bcpResult : BCPRETURN; handleType : Integer; handle : SQLHANDLE; operation : string);
begin
  if (bcpResult <> SUCCEED) then
    raise Exception.Create('Could not import data!');
end;

function GetOdbcEnvironment : TOdbcEnv;
begin
  if not Assigned(env) then
    env := TOdbcEnv.Create(nil);
  Inc(env.FconnectionCount);
  Result := env;
end;

procedure ReleaseOdbcEnvironment;
begin
  if Assigned(env) then
  begin
    Dec(env.FconnectionCount);
    if env.FconnectionCount <= 0 then
      FreeAndNil(env);
  end;
end;

{ TOdbcEnv }

procedure TOdbcEnv.Check(odbcResult: SQLRETURN; operation: string);
begin
  OdbcCheck(odbcResult, SQL_HANDLE_ENV, Fhandle, operation);
end;

constructor TOdbcEnv.Create(AOwner: TComponent);
begin
  inherited;

  Check(SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, Fhandle), 'allocating environment handle');
  Check(SQLSetEnvAttr(Fhandle, SQL_ATTR_ODBC_VERSION, Pointer(SQL_OV_ODBC3), 0), 'setting ODBC version');
end;

destructor TOdbcEnv.Destroy;
begin
  SQLFreeHandle(SQL_HANDLE_ENV, Fhandle);
  inherited;
end;

{ TOdbcConnection }

constructor TOdbcConnection.Create(AOwner: TComponent);
begin
  inherited;

  Fenv := GetOdbcEnvironment;

  Check(SQLAllocHandle(SQL_HANDLE_DBC, Fenv.Fhandle, Fhandle), 'allocating connection handle');
end;

destructor TOdbcConnection.Destroy;
begin
  Connected := false;
  SQLFreeHandle(SQL_HANDLE_DBC, Fhandle);
  ReleaseOdbcEnvironment;

  inherited;
end;

procedure TOdbcConnection.Open;
var
  actualConnectionString : string;
  actualConnectionStringLength : SmallInt;
begin
  if Fconnected then
    Exit;

  Check(SQLSetConnectAttr(Fhandle, SQL_COPT_SS_BCP, Pointer(SQL_BCP_ON), SQL_IS_INTEGER), 'configuring connection for bcp');

  SetLength(actualConnectionString, 8192);
  Check(SQLDriverConnect(Fhandle, 0,
    PChar(FconnectionString), Length(FconnectionString),
    PChar(actualConnectionString), Length(actualConnectionString), actualConnectionStringLength,
    SQL_DRIVER_NOPROMPT), 'connecting');
  Fconnected := true;
  SetLength(actualConnectionString, actualConnectionStringLength);
  FconnectionString := actualConnectionString;
end;

procedure TOdbcConnection.Close;
begin
  if not Fconnected then
    Exit;

  Fconnected := false;
  Check(SQLDisconnect(Fhandle), 'disconnecting');
end;

procedure TOdbcConnection.SetConnected(connected: boolean);
begin
  if connected <> Fconnected then
    if connected then
      Open
    else
      Close;
end;

procedure TOdbcConnection.SetConnectionString(connectionString: string);
begin
  FconnectionString := connectionString;
end;

procedure TOdbcConnection.Check(odbcResult: SQLRETURN; operation: string);
begin
  OdbcCheck(odbcResult, SQL_HANDLE_DBC, Fhandle, operation);
end;

procedure TOdbcConnection.SetAdoConnectionString(adoConn: string);
var
  startPos, pos : Integer;
  odbcConn : string;
  name, value : string;
begin
  odbcConn := 'DRIVER=SQL Server';

  pos := 1;

  while true do
  begin
    startPos := pos;
    while (pos <= Length(adoConn)) and (adoConn[pos] <> '=') do
      Inc(pos);
    if (pos > Length(adoConn)) then
      Break;
    name := MidStr(adoConn, startPos, pos-startPos);

    Inc(pos);
    startPos := pos;
    while (pos <= Length(adoConn)) and (adoConn[pos] <> ';') do
      Inc(pos);
    value := MidStr(adoConn, startPos, pos-startPos);
    Inc(pos);

    if AnsiSameText(name, 'User ID') then
      odbcConn := odbcConn + ';UID=' + value
    else if AnsiSameText(name, 'Password') then
      odbcConn := odbcConn + ';PWD=' + value
    else if AnsiSameText(name, 'Data Source') then
      odbcConn := odbcConn + ';SERVER=' + value
    else if AnsiSameText(name, 'Application Name') then
      odbcConn := odbcConn + ';APP=' + value
    else if AnsiSameText(name, 'Database') or AnsiSameText(name, 'Initial Catalog') then
      odbcConn := odbcConn + ';Database=' + value
    else if AnsiSameText(name, 'Trusted_Connection') or AnsiSameText(name, 'Integrated Security') then
      odbcConn := odbcConn + ';Trusted_Connection=' + value;
  end;
  OdbcConnectionString := odbcConn;
end;

{ TOdbcBulkCopy }

procedure TOdbcBulkCopy.Check(bcpResult: BCPRETURN; operation: string);
begin
  BcpCheck(bcpResult, SQL_HANDLE_DBC, Fconnection.Fhandle, operation);
end;

function TOdbcBulkCopy.ExecuteIn(ErrorFile: PChar): Integer;
var
  rowsProcessed : Integer;
  i: integer;
  SQLColumnCount: smallint;
  termch: string;
  HStmt: SQLHSTMT;
  SelectColumnsQuery: string;
begin
  if Fconnection = nil then
    raise Exception.Create('Connection for BCP has not been set');

  SelectColumnsQuery := Format('select top 0 * from %s', [Fquery]);

  Check(bcp_init(Fconnection.Fhandle, PChar(Fquery), PChar(FoutputFile), ErrorFile, DB_IN), 'initialising BCP');
  //Check(bcp_control(Fconnection.Fhandle, BCPHINTSA, PChar(Fquery)), 'setting BCP query');

  if BulkCopyMode = bcmClipExport then
  begin
    Check(bcp_control(Fconnection.Fhandle, BCPMAXERRS, PChar('10000')), 'setting max error count');
    // execute query to get number of SQL columns
    OdbcCheck(SQLAllocHandle(SQL_HANDLE_STMT, Fconnection.Fhandle, HStmt), SQL_HANDLE_STMT, HStmt, 'allocate handle');
    // todo set opions to not fetch any rows
    OdbcCheck(SQLExecDirect(HStmt, PChar(SelectColumnsQuery), Length(SelectColumnsQuery)), SQL_HANDLE_STMT, HStmt, 'exec query');
    OdbcCheck(SQLNumResultCols(HStmt, SQLColumnCount), SQL_HANDLE_STMT, HStmt, 'get column count');
    OdbcCheck(SQLFreeHandle(SQL_HANDLE_STMT, HStmt), SQL_HANDLE_STMT, HStmt, 'free handle');

    // set autodetection of char type
    Check(bcp_control(Fconnection.Fhandle, BCPFILECP , pointer(BCPFILECP_ACP)), 'setting BCP text mode');
    // set all column formats to delimited SQLCHARs
    Check(bcp_columns(Fconnection.Fhandle, SQLColumnCount), 'Setting output column count');
    // set terminators, no null markers etc. (equivalent to -c mode of BCP.exe)
    for i := 1 to SQLColumnCount do
    begin
      if i = SQLColumnCount then
        termch := #13#10
      else
        termch := #9;
      Check(bcp_colfmt(Fconnection.Fhandle, i, SQLCHARACTER, 0, SQL_VARLEN_DATA, pchar(termch), length(termch), i), 'Setting output column count');
    end;

  end;
  Check(bcp_exec(Fconnection.Fhandle, rowsProcessed), 'performing bulk copy');

  Result := rowsProcessed;
end;


function TOdbcBulkCopy.ExecuteOut(ErrorFile: PChar) : Integer;
var
  rowsProcessed : Integer;
  i: integer;
  SQLColumnCount: smallint;
  termch: string;
  HStmt: SQLHSTMT;
  SelectColumnsQuery: string;
begin
  if Fconnection = nil then
    raise Exception.Create('Connection for BCP has not been set');

  Check(bcp_init(Fconnection.Fhandle, nil, PChar(FoutputFile), ErrorFile, DB_OUT), 'initialising BCP');
  Check(bcp_control(Fconnection.Fhandle, BCPHINTSA, PChar(Fquery)), 'setting BCP query');

  if BulkCopyMode = bcmClipExport then
  begin
    SelectColumnsQuery := TrimLeft(Fquery);
    Insert(' top 0', SelectColumnsQuery, 7);
    // execute query to get number of SQL columns
    OdbcCheck(SQLAllocHandle(SQL_HANDLE_STMT, Fconnection.Fhandle, HStmt), SQL_HANDLE_STMT, HStmt, 'allocate handle');
    // todo set opions to not fetch any rows
    OdbcCheck(SQLExecDirect(HStmt, PChar(SelectColumnsQuery), Length(SelectColumnsQuery)), SQL_HANDLE_STMT, HStmt, 'exec query');
    OdbcCheck(SQLNumResultCols(HStmt, SQLColumnCount), SQL_HANDLE_STMT, HStmt, 'get column count');
    OdbcCheck(SQLFreeHandle(SQL_HANDLE_STMT, HStmt), SQL_HANDLE_STMT, HStmt, 'free handle');

    // set autodetection of char type
    Check(bcp_control(Fconnection.Fhandle, BCPFILECP , pointer(BCPFILECP_ACP)), 'setting BCP text mode');
    // set all column formats to delimited SQLCHARs
    Check(bcp_columns(Fconnection.Fhandle, SQLColumnCount), 'Setting output column count');
    // set terminators, no null markers etc. (equivalent to -c mode of BCP.exe)
    for i := 1 to SQLColumnCount do
    begin
      if i = SQLColumnCount then
        termch := #13#10
      else
        termch := #9;
      Check(bcp_colfmt(Fconnection.Fhandle, i, SQLCHARACTER, 0, SQL_VARLEN_DATA, pchar(termch), length(termch), i), 'Setting output column count');
    end;

  end;
  Check(bcp_exec(Fconnection.Fhandle, rowsProcessed), 'performing bulk copy');

  Result := rowsProcessed;
end;

end.

