unit uSystemConfiguration;

interface

uses ADODB, SysUtils, ActiveX;

type
  TSystemConfiguration = class(TObject)
  protected
    ADOConnection : TADOConnection;
    SystemSettingsQuery: TADOQuery;

    // Retreive and Set integer valuse in the SystemConfiguration table
    procedure UpdateDatabaseIntegerConfiguration(SystemConfigurationOption: string;
      NewValue: integer);
    function GetDatabaseIntegerConfiguration(SystemConfigurationOption: string): integer;

    // Retreive and Set string valuse in the SystemConfiguration table
    procedure UpdateDatabaseStringConfiguration(SystemConfigurationOption: string;
      NewValue: string);
    function GetDatabaseStringConfiguration(SystemConfigurationOption: string): string;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

  TAuditReaderConfiguration = class(TSystemConfiguration)
  private
    FAuditReaderPollInterval: integer;
    FAuditTrailRetentionPeriod: integer;
    FXMLChunkSize: integer;

    procedure SetAuditReaderPollInterval(const Value: integer);
    function GetAuditReaderPollInterval: integer;
    procedure SetAuditTrailRetentionPeriod(const Value: integer);
    function GetAuditTrailRetentionPeriod: integer;
    function GetXMLChunkSize: integer;
    procedure SetXMLChunkSize(const Value: integer);
  public
    property AuditReaderPollInterval: integer read GetAuditReaderPollInterval
      write SetAuditReaderPollInterval;
    { This is the period of time for which the tills will keep audit trail data }
    property AuditTrailRetentionPeriod: integer read GetAuditTrailRetentionPeriod
      write SetAuditTrailRetentionPeriod;

    property XMLChunkSize: integer read GetXMLChunkSize write SetXMLChunkSize;

    constructor Create; override;
  end;

  TEPOSManagerConfiguration = Class(TSystemConfiguration)
  private
    FTerminalReadDLLName      : string;
    FTerminalReadFunctionName : string;
    function GetTerminalReadDLLName: string;
    function GetTerminalReadFunctionName: string;
    procedure SetTerminalReadDLLName(const Value: string);
    procedure SetTerminalReadFunctionName(const Value: string);
  public
    property TerminalReadDLLName: string read GetTerminalReadDLLName write SetTerminalReadDLLName;
    property TerminalReadFunctionName: string read GetTerminalReadFunctionName
      write SetTerminalReadFunctionName;

    constructor Create; override;
  end;

implementation

uses uAztecDatabaseUtils, uSystemConfigurationConstants;

{ TSystemConfiguration }

constructor TSystemConfiguration.Create;
begin
  CoInitialize(nil);

  ADOConnection := GetAztecADOConnection;
  SystemSettingsQuery := TADOQuery.Create(nil);
  SystemSettingsQuery.Connection := ADOConnection;
end;

destructor TSystemConfiguration.Destroy;
begin
  FreeAndNil(SystemSettingsQuery);
  FreeAndNil(ADOConnection);

  CoUninitialize;
end;

function TSystemConfiguration.GetDatabaseIntegerConfiguration(SystemConfigurationOption: string): integer;
begin
  try
    with SystemSettingsQuery do
    begin
      SQL.Clear;
      SQL.Add('select IntegerValue from SystemConfiguration');
      SQL.Add('where KeyName = ' + QuotedStr(SystemConfigurationOption));
      Open;

      Result := FieldByName('IntegerValue').AsInteger;

      Close;
    end;
  except
    Result := 0;
  end;
end;

function TSystemConfiguration.GetDatabaseStringConfiguration(
  SystemConfigurationOption: string): string;
begin
  try
    with SystemSettingsQuery do
    begin
      SQL.Clear;
      SQL.Add('select StringValue from SystemConfiguration');
      SQL.Add('where KeyName = ' + QuotedStr(SystemConfigurationOption));
      Open;

      Result := FieldByName('StringValue').AsString;

      Close;
    end;
  except
    Result := '';
  end;
end;

procedure TSystemConfiguration.UpdateDatabaseIntegerConfiguration(
  SystemConfigurationOption: string; NewValue: integer);
begin
  try
    with SystemSettingsQuery do
    begin
      SQL.Clear;
      SQL.Add('select * from SystemConfiguration');
      SQL.Add('where KeyName = ' + QuotedStr(SystemConfigurationOption));
      Open;

      if RecordCount = 0 then
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert SystemConfiguration(KeyName, IntegerValue)');
        SQL.Add('values(' + QuotedStr(SystemConfigurationOption) + ', ' +
          inttostr(NewValue) + ')');
      end
      else
      begin
        Close;
        SQL.Clear;
        SQL.Add('update SystemConfiguration');
        SQL.Add('set IntegerValue = ' + inttostr(NewValue));
        SQL.Add('where KeyName = ' + QuotedStr(SystemConfigurationOption));
      end;

      ExecSQL;
    end;
  except
  end;
end;

procedure TSystemConfiguration.UpdateDatabaseStringConfiguration(
  SystemConfigurationOption, NewValue: string);
begin
  try
    with SystemSettingsQuery do
    begin
      SQL.Clear;
      SQL.Add('select * from SystemConfiguration');
      SQL.Add('where KeyName = ' + QuotedStr(SystemConfigurationOption));
      Open;

      if RecordCount = 0 then
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert SystemConfiguration(KeyName, StringValue)');
        SQL.Add('values(' + QuotedStr(SystemConfigurationOption) + ', ' +
          QuotedStr(NewValue) + ')');
      end
      else
      begin
        Close;
        SQL.Clear;
        SQL.Add('update SystemConfiguration');
        SQL.Add('set StringValue = ' + QuotedStr(NewValue));
        SQL.Add('where KeyName = ' + QuotedStr(SystemConfigurationOption));
      end;

      ExecSQL;
    end;
  except
  end;
end;

{ TAuditReaderConfiguration }

constructor TAuditReaderConfiguration.Create;
begin
  inherited;

  FAuditReaderPollInterval   := 0;
  FAuditTrailRetentionPeriod := 0;
  FXMLChunkSize              := 0;
end;

function TAuditReaderConfiguration.GetAuditReaderPollInterval: integer;
begin
  if FAuditReaderPollInterval = 0 then
    FAuditReaderPollInterval := GetDatabaseIntegerConfiguration(AUDITREADER_POLL_INTERVAL);

  Result := FAuditReaderPollInterval;
end;

procedure TAuditReaderConfiguration.SetAuditReaderPollInterval(const Value: integer);
begin
  FAuditReaderPollInterval := Value;
  UpdateDatabaseIntegerConfiguration(AUDITREADER_POLL_INTERVAL, Value);
end;

function TAuditReaderConfiguration.GetAuditTrailRetentionPeriod: integer;
begin
  if FAuditTrailRetentionPeriod = 0 then
    FAuditTrailRetentionPeriod := GetDatabaseIntegerConfiguration(AUDIT_TRAIL_RETENTION_PERIOD);

  Result := FAuditTrailRetentionPeriod;
end;

procedure TAuditReaderConfiguration.SetAuditTrailRetentionPeriod(const Value: integer);
begin
  FAuditTrailRetentionPeriod := Value;
  UpdateDatabaseIntegerConfiguration(AUDIT_TRAIL_RETENTION_PERIOD, Value);
end;

function TAuditReaderConfiguration.GetXMLChunkSize: integer;
begin
  if FXMLChunkSize = 0 then
    FXMLChunkSize := GetDatabaseIntegerConfiguration(AUDITREADER_XML_CHUNK_SIZE);

  Result := FXMLChunkSize;
end;

procedure TAuditReaderConfiguration.SetXMLChunkSize(const Value: integer);
begin
  FXMLChunkSize := Value;
  UpdateDatabaseIntegerConfiguration(AUDITREADER_XML_CHUNK_SIZE, Value);
end;

{ TEPOSManagerConfiguration }

constructor TEPOSManagerConfiguration.Create;
begin
  inherited;

  FTerminalReadDLLName      := '';
  FTerminalReadFunctionName := '';
end;

function TEPOSManagerConfiguration.GetTerminalReadDLLName: string;
begin
  if FTerminalReadDLLName = '' then
    FTerminalReadDLLName := GetDatabaseStringConfiguration(EPOSMANAGER_TERMINAL_READ_DLL);

  Result := FTerminalReadDLLName;
end;

function TEPOSManagerConfiguration.GetTerminalReadFunctionName: string;
begin
  if FTerminalReadFunctionName = '' then
    FTerminalReadFunctionName := GetDatabaseStringConfiguration(EPOSMANAGER_TERMINAL_READ_FUNCTION);

  Result := FTerminalReadFunctionName;
end;

procedure TEPOSManagerConfiguration.SetTerminalReadDLLName(
  const Value: string);
begin
  FTerminalReadDLLName := Value;
  UpdateDatabaseStringConfiguration(EPOSMANAGER_TERMINAL_READ_DLL, Value);
end;

procedure TEPOSManagerConfiguration.SetTerminalReadFunctionName(
  const Value: string);
begin
  FTerminalReadFunctionName := Value;
  UpdateDatabaseStringConfiguration(EPOSMANAGER_TERMINAL_READ_FUNCTION, Value);
end;

end.
