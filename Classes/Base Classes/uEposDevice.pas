unit uEposDevice;

interface

uses
  SysUtils, Contnrs, ADODB, ActiveX;
  
type
  TEPoSDeviceType = (edtServer, edtTerminal);
  TEPoSHardwareType = (ehtZ500 = 0, ehtZ400 = 1, ehtZ300 = 2, ehtHandHeld = 3, ehtConqueror = 5,
                       ehtHotelSystem = 6, ehti700 = 7, ehtKiosk = 8, ehtXPPos = 9, ehtMobileOrdering = 10,
                       ehtBookingsAPI = 11, ehtMOAOrderPad = 12, ehtMOAPayAtTable = 13, ehtiZoneTables = 14, ehtIBMSurePOS500 = 15,
                       ehtIBMSurePOS514P126 = 16, ehtIBMSurePOS532P126 = 17, ehtSharpUPV5500 = 18, ehtSharpRZX750 = 19,
                       ehtToshibaTECSTA10 = 20, ehtToshibaTECSTA12 = 21, ehtIBMSurePOS532P1238 = 22, ehtIBMSurePOS514P1238 = 23,
                       ehtToshibaTECSTA20 = 24, ehtAzOne = 25, ehtAzTab = 26, ehtZonalToshibaA12 = 27, ehtZonalToshibaA20 = 28,
                       ehtZonalToshibaA30 = 29, ehtZonalToshibaA10 = 30, ehtZonalSuperPOSServer = 31, ehtZonalPOSIoTServer = 32,
                       ehtZonalZ9 = 33, ehtQueueBuster = 34 );
  TEPoSMultiDrawerMode = (emdmSingle, emdmMultiple);

  TEposDevice = class(TObject)
  private
    FTerminalID  : integer;
    FHardwareType: TEPoSHardwareType;
    FDeviceType  : TEPoSDeviceType;
    FPOSCode     : integer;
    FDeviceName  : string;
    FIPAddress   : string;

    function AuditErrorsExist: boolean;

    function GetDeviceType: TEPOSDeviceType;
    function GetDeviceName: string;
    function GetPOSCode: integer;
    function GetIPAddress: string;
    function GetLastReadDate: TDateTime;
    function GetLastReadTxnID: Int64;
    function GetErrorOnLastAuditRead: boolean;
    function GetLastAuditReadError: string;
    function GetStockMode: boolean;
  public
    constructor Create(ATerminalID: integer);

    property DeviceType   : TEPOSDeviceType read FDeviceType;
    property HardwareType : TEPOSHardwareType read FHardwareType;
    property POSCode: integer read FPOSCode;
    property DeviceName: string read FDeviceName;
    property DeviceID: integer read FTerminalID;
    property IPAddress: string read FIPAddress;
    property LastReadDate: TDateTime read GetLastReadDate;
    property LastReadTxnID: Int64 read GetLastReadTxnID;
    property ErrorOnLastAuditRead: boolean read GetErrorOnLastAuditRead;
    property StockMode: boolean read GetStockMode;
    property LastAuditReadError: string read GetLastAuditReadError;

    class function GetTerminalID(APosCode: integer): integer;
    class function GetHardwareType(ATerminalID: integer): TEPOSHardwareType;
    class function isAztecTerminal(ATerminalID: Integer): Boolean;
  end;

  TEposDeviceList = class(TObjectList)
  private
    AztecDBConn: TADOConnection;
    procedure GetSiteEposDevices;
  public
    constructor Create;
    destructor Destroy; override;

    function GetDevice (Index: Integer): TEposDevice;
  end;

implementation

uses Windows, DB, DateUtils, Math, uAztecDatabaseUtils;

{ TEposDevice }

constructor TEposDevice.Create(ATerminalID: integer);
begin
  inherited Create;

  FTerminalID   := ATerminalID;
  FHardwareType := GetHardwareType(FTerminalID);
  FDeviceType   := GetDeviceType;
  FPOSCode      := GetPOSCode;
  FDeviceName   := GetDeviceName;
  FIPAddress    := GetIPAddress;
end;

function TEposDevice.GetDeviceName: string;
var
  dsDeviceProperties: TADODataSet;
begin
  dsDeviceProperties := TADODataSet.Create(nil);

  try
    with dsDeviceProperties do
    begin
      ConnectionString := GetAztecDBConnectionString;
      CommandType := cmdText;
      CommandText := 'select [Name] from ThemeEPOSDevice where EPOSDeviceID = ' + inttostr(FTerminalID);
      Open;

      Result := FieldByName('Name').AsString;

      Close;
    end;
  finally
    FreeAndNil(dsDeviceProperties);
  end;
end;

function TEposDevice.GetPOSCode: integer;
var
  dsDeviceProperties: TADODataSet;
begin
  dsDeviceProperties := TADODataSet.Create(nil);

  try
    with dsDeviceProperties do
    begin
      ConnectionString := GetAztecDBConnectionString;
      CommandType := cmdText;
      CommandText := 'select POSCode from ThemeEPOSDevice where EPOSDeviceID = ' + inttostr(FTerminalID);
      Open;

      Result := FieldByName('POSCode').AsInteger;

      Close;
    end;
  finally
    FreeAndNil(dsDeviceProperties);
  end;
end;

class function TEposDevice.GetTerminalID(APosCode: integer): integer;
var
  dsDeviceProperties: TADODataSet;
begin
  dsDeviceProperties := TADODataSet.Create(nil);

  try
    with dsDeviceProperties do
    begin
      ConnectionString := GetAztecDBConnectionString;
      CommandType := cmdText;
      CommandText := 'select EPoSDeviceID from ThemeEPOSDevice where PosCode = ' + inttostr(APosCode);
      Open;

      Result := FieldByName('EPoSDeviceID').AsInteger;

      Close;
    end;
  finally
    FreeAndNil(dsDeviceProperties);
  end;
end;

function TEposDevice.GetIPAddress: string;
var
  dsDeviceProperties: TADODataSet;
begin
  dsDeviceProperties := TADODataSet.Create(nil);

  try
    with dsDeviceProperties do
    begin
      ConnectionString := GetAztecDBConnectionString;
      CommandType := cmdText;
      CommandText := 'select IPAddress from ThemeEPOSDevice where EPOSDeviceID = ' + inttostr(FTerminalID);
      Open;

      Result := FieldByName('IPAddress').AsString;

      Close;
    end;
  finally
    FreeAndNil(dsDeviceProperties);
  end;
end;

function TEposDevice.GetDeviceType: TEPOSDeviceType;
var
  dsDeviceProperties: TADODataSet;
begin
  dsDeviceProperties := TADODataset.Create(nil);

  try
    with dsDeviceProperties do
    begin
      ConnectionString := GetAztecDBConnectionString;
      CommandType := cmdText;
      CommandText := 'select IsServer from ThemeEPOSDevice where EPOSDeviceID = ' + inttostr(FTerminalID);
      Open;

      if FieldByName('IsServer').AsBoolean then
        Result := edtServer
      else
        Result := edtTerminal;

      Close;
    end;
  finally
    FreeAndNil(dsDeviceProperties);
  end;
end;

class function TEposDevice.GetHardwareType(ATerminalID: integer): TEPOSHardwareType;
var
  dsDeviceProperties: TADODataSet;
begin
  dsDeviceProperties := TADODataset.Create(nil);

  try
    with dsDeviceProperties do
    begin
      ConnectionString := GetAztecDBConnectionString;
      CommandType := cmdText;
      CommandText := 'select HardwareType from ThemeEPoSDevice where EPOSDeviceID = ' + inttostr(ATerminalID);
      Open;

      case FieldByName('HardwareType').AsInteger of
        ord(ehtZ300)            : Result := ehtZ300;
        ord(ehtZ400)            : Result := ehtZ400;
        ord(ehtZ500)            : Result := ehtZ500;
        ord(ehtConqueror)       : Result := ehtConqueror;
        ord(ehtHandHeld)        : Result := ehtHandHeld;
        ord(ehtHotelSystem)     : Result := ehtHotelSystem;
        ord(ehti700)            : Result := ehti700;
        ord(ehtKiosk)           : Result := ehtKiosk;
        ord(ehtMobileOrdering)  : Result := ehtMobileOrdering;
        ord(ehtXPPos)           : Result := ehtXPPos;
        ord(ehtMOAOrderPad)     : Result := ehtMOAOrderPad;
        ord(ehtMOAPayAtTable)   : Result := ehtMOAPayAtTable;
        ord(ehtiZoneTables)     : Result := ehtiZoneTables;
        ord(ehtZonalZ9)         : Result := ehtZonalZ9;
        ord(ehtQueueBuster)     : Result := ehtQueueBuster;
      else
        Result := ehtZ500;
      end;

      Close;
    end;
  finally
    FreeAndNil(dsDeviceProperties);
  end;
end;

class function TEposDevice.isAztecTerminal(ATerminalID: Integer): Boolean;
begin
  Result := not(GetHardwareType(ATerminalID) in [ehtConqueror, ehtHotelSystem, ehtQueueBuster]);
end;


function TEposDevice.GetLastReadDate: TDateTime;
var
  dsDeviceProperties: TADODataSet;
begin
  dsDeviceProperties := TADODataSet.Create(nil);

  try
    with dsDeviceProperties do
    begin
      ConnectionString := GetAztecDBConnectionString;
      CommandType := cmdText;
      CommandText := 'select LRDT from AztecPOS where [TerminalID] = ' + inttostr(FTerminalID);
      Open;

      Result := FieldByName('LRDT').AsDateTime;

      Close;
    end;
  finally
    FreeAndNil(dsDeviceProperties);
  end;
end;

function TEposDevice.GetLastReadTxnID: Int64;
var
  dsDeviceProperties: TADODataSet;
begin
  dsDeviceProperties := TADODataSet.Create(nil);

  try
    with dsDeviceProperties do
    begin
      ConnectionString := GetAztecDBConnectionString;
      CommandType := cmdText;
      CommandText := 'select [Last TXID] from AztecPOS where [TerminalID] = ' + inttostr(FTerminalID);
      Open;

      if FieldByName('Last TXID').isNull then
        Result := -1
      else
        Result := TLargeIntField(FieldByName('Last TXID')).AsLargeInt;

      Close;
    end;
  finally
    FreeAndNil(dsDeviceProperties);
  end;
end;

{-------------------------------}
{       TEposDeviceList         }
{-------------------------------}

constructor TEposDeviceList.Create;
begin
  inherited Create;

  CoInitialize(nil);

  AztecDBConn := GetAztecADOConnection;
  GetSiteEposDevices;
end;

destructor TEposDeviceList.Destroy;
begin
  inherited;

  FreeAndNil(AztecDBConn);

  CoUnInitialize;
end;

procedure TEposDeviceList.GetSiteEposDevices;
//Populate EposDeviceList with details of all Epos terminals in ThemeEposDevice table.
var
  EposDevice: TEposDevice;
begin
  //Query AztecPos and Pos for the list of Epos devices and add our internal list.
  with TADODataSet.Create(nil) do
  try
    Connection := AztecDBConn;
    CommandType := cmdText;
    CommandText :=  //Job 326740: Introduced join with Config table.
      'SELECT EPOSDeviceID ' +
      'FROM ThemeEPOSDevice t LEFT OUTER JOIN Config c ' +
      '  ON t.[PosCode] = c.[Pos Code] ' +
      'WHERE (c.[Deleted] is Null) or (c.[Deleted] <> ''Y'') ';
    Open;

    while not(eof) do
    begin
      EposDevice := TEposDevice.Create(FieldByName('EPOSDeviceID').AsInteger);
      Add(EposDevice);

      Next;
    end;

    Close;
  finally
    Free;
  end;
end;

function TEposDeviceList.GetDevice (Index: Integer): TEposDevice;
begin
  Result := inherited GetItem (Index) as TEposDevice;
end;

function TEposDevice.GetErrorOnLastAuditRead: boolean;
var
  dsDeviceProperties: TADODataSet;
begin
  dsDeviceProperties := TADODataSet.Create(nil);

  try
    with dsDeviceProperties do
    begin
      ConnectionString := GetAztecDBConnectionString;
      CommandType := cmdText;
      CommandText := 'select ErrorOnLastRead from AztecPOS where [TerminalID] = ' + inttostr(FTerminalID);
      Open;

      Result := FieldByName('ErrorOnLastRead').AsBoolean or AuditErrorsExist;

      Close;
    end;
  finally
    FreeAndNil(dsDeviceProperties);
  end;
end;

function TEposDevice.GetLastAuditReadError: string;
var
  dsErrorStatus: TADODataSet;
begin
  Result := '';

  if AuditErrorsExist then
    Result := 'Audit Errors detected';

  dsErrorStatus := TADODataSet.Create(nil);

  try
    with dsErrorStatus do
    begin
      ConnectionString := GetAztecDBConnectionString;
      CommandType := cmdText;
      CommandText := 'select ErrorOnLastRead, ErrorReason from AztecPOS where [TerminalID] = ' + inttostr(FTerminalID);
      Open;

      if FieldByName('ErrorOnLastRead').AsBoolean then
      begin
        if Result <> '' then
          Result := Result + #13#10;
          
        Result := Result + FieldByName('ErrorReason').AsString;
      end;

      Close;
    end;
  finally
    FreeAndNil(dsErrorStatus);
  end;
end;

function TEposDevice.AuditErrorsExist: boolean;
var
  dsAuditErrors: TADODataSet;
begin
  dsAuditErrors := TADODataSet.Create(nil);

  try
    with dsAuditErrors do
    begin
      ConnectionString := GetAztecDBConnectionString;
      CommandType := cmdText;
      CommandText := 'select * from AuditErrors where [TerminalID] = ' + inttostr(FTerminalID);
      Open;

      Result := RecordCount > 0;

      Close;
    end;
  finally
    FreeAndNil(dsAuditErrors);
  end;
end;

function TEposDevice.GetStockMode: boolean;
begin
  Result := FALSE;
end;

end.







