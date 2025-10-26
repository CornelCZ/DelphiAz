unit uAuditReadControl;

interface

uses ADODB;

type
  TAuditReadControl = class
  public
    constructor Create(Connection: TADOConnection);
    procedure Pause;
    procedure Resume;
  private
    AuditReadRequestPort: integer;
    SitePCIPAddress: String;
    procedure SendReadRequestMessage(MessageText: string);
 end;

implementation

uses sysutils, ScktComp;

{ TAuditReadControl }

constructor TAuditReadControl.Create(Connection: TADOConnection);
var
  Query: TADOQuery;
begin
  Query := TADOQuery.create(nil);
  Query.Connection := Connection;
  Query.SQL.Add('declare @SiteCode int');
  Query.SQL.Add('declare @AuditReadRequestPort int');
  Query.SQL.Add('declare @IPAddress varchar(15)');
  Query.SQL.Add('set @SiteCode = dbo.fnGetSiteCode()');
  Query.SQL.Add(Format('exec sp_GetConfigurationResult @SiteCode,%s, @AuditReadRequestPort OUTPUT', [QuotedStr('ctAuditReadRequestPort')]));
  Query.SQL.Add('select @IPAddress = IPAddress from ThemeOutletConfigs where SiteCode = @SiteCode');
  Query.SQL.Add('Select @AuditReadRequestPort as AuditReadRequestPort, IsNull(@IPAddress, ''localhost'') as IPAddress');
  Query.Open;
  AuditReadRequestPort := StrToIntDef(Query.FieldByName('AuditReadRequestPort').AsString, 15000);
  SitePCIPAddress := Query.FieldByName('IPAddress').AsString;
  Query.Close;
  Query.Free;
end;

procedure TAuditReadControl.Pause;
begin
  SendReadRequestMessage('<SetAuditReadStatus Status="Disabled"/>');
end;

procedure TAuditReadControl.Resume;
begin
  SendReadRequestMessage('<SetAuditReadStatus Status="Enabled"/>');
end;

procedure TAuditReadControl.SendReadRequestMessage(MessageText: string);
var
  MessageStream: TWinSocketStream;
  csAuditReadClient: TClientSocket;
  ReceiveBuffer: array[0..1023] of Char;
begin
  csAuditReadClient := TClientSocket.Create(nil);
  try
    csAuditReadClient.ClientType := ctBlocking;
    csAuditReadClient.Host := SitePCIPAddress;
    csAuditReadClient.Port := AuditReadRequestPort;

    csAuditReadClient.Open;
    MessageStream := TWinSocketStream.Create(csAuditReadClient.Socket, 10000);
    try
      MessageStream.Write(MessageText[1], Length(MessageText));
      MessageStream.Read(ReceiveBuffer, SizeOf(ReceiveBuffer));
    finally
      MessageStream.Free;
      if csAuditReadClient.Active then
        csAuditReadClient.Active := FALSE;
    end;

  finally
    FreeAndNil(csAuditReadClient);
  end;
end;

end.
