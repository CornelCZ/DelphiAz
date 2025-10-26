unit uPerformAuditRead;

interface

uses
  Windows, SysUtils, Forms, AppEvnts, ADODB, uAztecDatabaseUtils, uCommon;

type
  TTerminalReadFailureInfo = record
                             TerminalID : integer;
                             LastreaddateTime : TDateTime;
                          end;

  TTerminalReadFails = array of TTerminalReadFailureInfo;

  TTerminalReadLevel = (trlTerminal, trlSalesArea, trlSite, trlServer);

  TPerformAuditRead = class(TObject)

  private
    function GenerateTerminalList(const AReadLevel: TTerminalReadLevel;
      const ARequestingTerminal: integer; var ATerminalCount: integer; const AsXML : boolean = true): string;

    function GetConfiguration(const AConfigurationName: string): string;

  public
    function ReadTerminalData(const AReadLevel: TTerminalReadLevel;
      const ARequestingTerminal: integer): boolean; overload;

    function ReadTerminalData (const AReadLevel: TTerminalReadLevel;
      const ARequestingTerminal: integer; out TerminalReadFailures : TTerminalreadFails):boolean;overload;

    function GetTerminalCount(const AReadLevel: TTerminalReadLevel; const ARequestingTerminal: integer) : integer;
  end;

implementation

uses ScktComp;

{ TPerformAuditRead }

function TPerformAuditRead.GetTerminalCount(
            const AReadLevel: TTerminalReadLevel;
            const ARequestingTerminal: integer
            ) : integer;
var
  count : integer;
begin
  count := 0;

  GenerateTerminalList(AReadLevel, ARequestingTerminal, count);

  Result := count
end;

function TPerformAuditRead.GenerateTerminalList(const AReadLevel: TTerminalReadLevel;
  const ARequestingTerminal: integer; var ATerminalCount: integer; const AsXML : boolean = true): string;
const
  REQUEST_HEADER     = '<AuditReadRequest>';
  REQUEST_FOOTER     = '</AuditReadRequest>';
  TERMINAL_CONTAINER = '<Terminal ID="%d"/>';
var
  TerminalList: string;
  qryTerminalList: TADOQuery;
begin
  TerminalList := '';

  qryTerminalList := TADOQuery.Create(nil);

  try
    with qryTerminalList do
    begin
      Connection := GetAztecADOConnection;
      CommandTimeout := 0;

      case AReadLevel of
        trlTerminal  :
          begin
            SQL.Add('select EPOSDeviceID');
            SQL.Add('from ThemeEPOSDevice TED');
            SQL.Add('where TED.EPoSDeviceID = ' + IntToStr(ARequestingTerminal));
            SQL.Add('and TED.IsServer = 0');
          end;
        trlSalesArea :
          begin
            SQL.Add('select EPOSDeviceID');
            SQL.Add('from ThemeEPOSDevice TED, (select * from Config where Deleted is null) c');
            SQL.Add('where c.[Sales Area Code] in (');
            SQL.Add('        select c.[Sales Area Code]');
            SQL.Add('        from ThemeEPOSDevice TED, (select * from Config where Deleted is null) c');
            SQL.Add('        where TED.POSCode = c.[POS Code]');
            SQL.Add('        and TED.EPoSDeviceID = ' + IntToStr(ARequestingTerminal) + ')');
            SQL.Add('and TED.IsServer = 0');
            SQL.Add('and TED.POSCode = c.[POS Code]');
            SQL.Add('and TED.HardwareType <> 11');

          end;
        trlServer :
          begin
            SQL.Add('select EPOSDeviceID');
            SQL.Add('from ThemeEPOSDevice TED');
            SQL.Add('where TED.IsServer = 0');
            SQL.Add('and TED.ServerId = (SELECT ServerId FROM ThemeEPOSDevice t WHERE EPOSDeviceId = ' + IntToStr(ARequestingTerminal) + ')');
            SQL.Add('and TED.HardwareType <> 11');
          end;
        trlSite      :
          begin
            SQL.Add('select EPoSDeviceID');
            SQL.Add('from ThemeEPOSDevice');
            SQL.Add('where SiteCode in (');
            SQL.Add('	select top 1 [Site Code]');
            SQL.Add('	from SiteAztec');
            SQL.Add('	where Deleted is NULL)');
            SQL.Add('and IsServer = 0');
            SQL.Add('and HardwareType <> 11');
          end;
      end;

      Open;

      ATerminalCount := RecordCount;

      while not EOF do
      begin
        if asXML then
        begin
          TerminalList := TerminalList +
            Format(TERMINAL_CONTAINER, [FieldByName('EPoSDeviceID').AsInteger]);

        end
        else
        begin
          TerminalList := TerminalList + ', ' + FieldByName('EPoSDeviceID').AsString;
        end;
        Next;
      end;

      Close;
    end;
  finally
    FreeAndNil(qryTerminalList);
  end;

  if asXML then
  begin
    Result := REQUEST_HEADER + TerminalList + REQUEST_FOOTER;
  end
  else
  begin
    Delete(TerminalList, 1,2);
    Result := TerminalList;
  end;
end;

function TPerformAuditRead.GetConfiguration(const AConfigurationName: string): string;
var
  qryConfigurationSettings: TADOQuery;
begin
  qryConfigurationSettings := TADOQuery.Create(nil);

  try
    with qryConfigurationSettings do
    begin
      Connection := GetAztecADOConnection;
      CommandTimeout := 0;

      SQL.Add('sp_GetConfiguration ' + QuotedStr(AConfigurationName));
      Open;

      Result := FieldByName('Setting').AsString;

      Close;
    end;
  finally
    FreeAndNil(qryConfigurationSettings);
  end;
end;

function TPerformAuditRead.ReadTerminalData(const AReadLevel: TTerminalReadLevel;
  const ARequestingTerminal: integer): boolean;
var
  csAuditReadClient: TClientSocket;
  MessageStream: TWinSocketStream;
  RequestString: string;
  ReceiveBuffer: array[0..1023] of Char;
  TerminalCount: integer;

  ServerPort: integer;
  TerminalTimeout: integer;
begin
  try
    ServerPort := StrToInt(GetConfiguration('ctAuditReadRequestPort'));
  except
    ServerPort := 15000;
  end;

  try
    TerminalTimeout := StrToInt(GetConfiguration('ctTerminalAuditReadTimeoutSeconds')) * 1000;
  except
    TerminalTimeout := 5000;
  end;

  csAuditReadClient := TClientSocket.Create(nil);

  try
    csAuditReadClient.ClientType := ctBlocking;
    csAuditReadClient.Host := GetLocalMachineName;
    csAuditReadClient.Port := ServerPort;

    try
      csAuditReadClient.Open;

      RequestString := GenerateTerminalList(AReadLevel, ARequestingTerminal, TerminalCount);

      MessageStream := TWinSocketStream.Create(csAuditReadClient.Socket, TerminalCount * TerminalTimeout);

      try
        // Send the HTTP request
        MessageStream.Write(RequestString[1], Length(RequestString));

        // Test for a response from the server
        Result := MessageStream.Read(ReceiveBuffer, SizeOf(ReceiveBuffer)) <> 0;
      finally
        MessageStream.Free;

        if csAuditReadClient.Active then
          csAuditReadClient.Active := FALSE;
      end;
    except
      Result := FALSE;
    end;
  finally
    FreeAndNil(csAuditReadClient);
  end;
end;

function TPerformAuditRead.ReadTerminalData(const AReadLevel: TTerminalReadLevel;
  const ARequestingTerminal: integer; out TerminalReadFailures: TTerminalReadFails): boolean;
var
  TerminalFailQuery : TADOQuery;
  Index, TerminalCount, UnreadTerminals : integer;
  TerminalList : string;
  RunSQL : string;


begin
  Result := ReadTerminalData(AReadLevel, ARequestingTerminal);
  if Result then
  begin
    Index := 0;

    TerminalList := GenerateTerminalList(AReadLevel, ARequestingTerminal, TerminalCount, false);

    try
      TerminalFailQuery := TADOQuery.Create(nil);

      try
        with TerminalFailQuery do
        begin
          ConnectionString := GetAztecDBConnectionString;
          SQL.Clear;
          RunSQL := 'SELECT [TerminalID], [LRDT] FROM AztecPos ' +
                    'INNER JOIN ThemeEposDevice ON [TerminalID] = [EposDeviceID] ' +
                    'WHERE ([ErrorOnLastRead] = 1 OR TerminalID IN ' +
                    '(select distinct TerminalID from AuditErrors)) ' +
                    'AND [IsPos] = 1 AND [TerminalID] IN ('+ TerminalList +')';

          SQL.Add(RunSQL);
          Open;

          UnreadTerminals := RecordCount;
          Setlength(TerminalReadFailures, RecordCount);

          while not Eof do
          begin
            TerminalReadFailures[Index].TerminalID := FieldByName('TerminalID').AsInteger;
            TerminalReadFailures[Index].LastreaddateTime := fieldByName('LRDT').AsDateTime;

            Next;
            inc(Index);
          end;

          Close;
        end;
        result := (UnreadTerminals = 0);
      finally
        FreeAndNil(TerminalFailQuery);
      end;
    except
      Result := FALSE;
    end;
  end;
end;

end.






