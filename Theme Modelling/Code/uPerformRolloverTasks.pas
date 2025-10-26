unit uPerformRolloverTasks;

interface

procedure PerformRolloverTasks;

implementation

uses udmThemeData, ZOEDLL;

procedure PerformRolloverTasks;
type TServerInfo = packed record IpAddress: widestring; EPOSDeviceID: integer end;
var
  dmThemeData: TdmThemeData;
  ServersToReset: array of TServerInfo;
  ServerIndex: integer;
  ServerIPAddress: array [0..255] of WideChar;
  ReturnMessageBuffer: array[0..512] of WideChar;
  NextAccountNumber: array[0..2] of WideChar;
  ReturnCode: integer;
begin
  dmThemeData := TdmThemeData.Create(nil);
  dmThemeData.adoqRun.SQL.Text := 'select IPAddress, EPoSDeviceID '+
    'from ThemeEposDevice '+
    'where SiteCode = dbo.fnGetSiteCode() and IsServer = 1 and ResetAccountNumber = 1';
  dmThemeData.adoqRun.Open;
  SetLength(ServersToReset, dmThemeData.adoqRun.RecordCount);
  dmThemeData.adoqRun.First;
  ServerIndex := 0;
  while not dmThemeData.adoqRun.Eof do
  begin
    ServersToReset[ServerIndex].IpAddress := dmThemeData.adoqRun.FieldByName('IPAddress').AsString;
    ServersToReset[ServerIndex].EPOSDeviceID := dmThemeData.adoqRun.FieldByName('EPOSDeviceID').AsInteger;
    inc(ServerIndex);
    dmThemeData.adoqRun.Next;
  end;
  dmThemeData.adoqRun.Close;
  dmThemeData.AztecConn.Close;
  NextAccountNumber[0] := '1';
  NextAccountNumber[1] := #0;
  LoadDLL;
  try
    for ServerIndex := low(ServersToReset) to high(ServersToReset) do
      with ServersToReset[ServerIndex] do
      begin

        FillChar(ReturnMessageBuffer,SizeOf(ReturnMessageBuffer),#0);
        FillChar(ServerIPAddress, SizeOf(ServerIPAddress),#0);
        StringToWideChar(IPAddress,@ServerIPAddress,255);

        Zoe_EPoSDeviceProxy_setNextAccountNumber(@ServerIPAddress, EposDeviceID, @NextAccountNumber, @ReturnMessageBuffer, ReturnCode);
      end;
  finally
    clearmem;
  end;
end;

end.
