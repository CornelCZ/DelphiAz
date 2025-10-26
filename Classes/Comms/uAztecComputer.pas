{ Mike Palmer
  (c) Copyright Zonal Retail Data Systems Ltd. All Rights Reserved }

unit uAztecComputer;

interface

uses Classes, Sysutils, WMIConnection, uCommon,uLogFile;

type
  TAztecComputerIsCancelledFunc = function : boolean of object;

  TAztecComputer=class(TObject)
  public
    constructor Create(const AIPAddr,AMachineName:string; const AUserName,APassword,ADomain:string);
    destructor Destroy; override;
    function ConnectShare(const AShare:string):boolean;
//  function Authenticate:boolean;
    procedure WriteToLogFile(const AMessage:string);
    procedure Disconnect; // Cleanup shares, WMI connection, log file
  private
    FIPAddress:string;
    FMachineName:string;
    FConnected:boolean;
    FShares:TStringList;
    FPassword:string;
    FUsername:string;
    FDomain:string;
    FLogFile:string;
    FWMIConnection:TWMIConnection;
    FProgress:TAztecProgress;
    FIsCancelledFunc:TAztecComputerIsCancelledFunc;
    LogFile:ILogFile;
    procedure SetUserName(const AUserName:string);
    procedure SetPassword(const APassword:string);
    procedure SetDomain(const ADomain:string);
    procedure SetIpAddress(const AIpAddress:string);
    function DisconnectShare(const AShare:string):boolean;
    property IpAddress:string read FIPAddress write SetIpAddress;
    property MachineName:string read FMachineName write FMachineName;
    property Domain:string read FDomain write SetDomain;
    property Username:string read FUsername write SetUserName;
    property Password:string read FPassword write SetPassword;
    procedure NoopProgressFunc(const AMessage:string;const AProgress:integer);
  published
//    property Authenticated:boolean read FConnected write FConnected default FALSE;
    property Progress:TAztecProgress read FProgress write FProgress default nil;
    property IsCancelledFunc:TAztecComputerIsCancelledFunc read FIsCancelledFunc write FIsCancelledFunc;
    property LogFileName:string read FLogFile write FLogFile;
    property WMIConnection:TWMIConnection read FWMIConnection;
  end;

implementation

uses Dialogs, ADODB, Windows;

{ TAztecComputer }

function TAztecComputer.ConnectShare(const AShare:string):boolean;
var
  FFullUserName:string;
begin
  if FShares.IndexOf(AShare) <> -1 then
  begin
    Result := true;
  end
  else
  begin
    FFullUserName:=FUserName;
    if FDomain<>'' then
       FFullUserName:=FDomain+'\'+FFullUserName;
    Result:=ConnectToNetworkResource('\\'+FIpAddress+'\'+AShare,FPassword,FFullUsername);
    if Result then
       FShares.Add(AShare);
  end;
end;

function TAztecComputer.DisconnectShare(const AShare:string):boolean;
begin
  Result:=DisconnectNetworkResource('\\'+FIpAddress+'\'+AShare);
  try
    FShares.Delete(FShares.IndexOf(AShare));
  except
  end;
end;

procedure TAztecComputer.Disconnect;
begin
  while FShares.Count > 0 do
    DisconnectShare(FShares[0]);
  LogFile := nil;
  FWMIConnection.Connected := false;
end;

constructor TAztecComputer.Create(const AIPAddr,AMachineName:string; const AUsername,APassword,ADomain:string);
begin
  FShares:=TStringList.Create;
  FShares.CaseSensitive := false;
  FWMIConnection:=TWMIConnection.Create(nil);
  IpAddress:=AIPAddr;
  MachineName:=AMachineName;
  Password:=APassword;
  Username:=AUsername;
  Domain:=ADomain;
  FConnected:=FALSE;
  FProgress:=NoopProgressFunc;
end;

destructor  TAztecComputer.Destroy;
begin
  Disconnect;
  FreeAndNil(FShares);
  FreeAndNil(FWMIConnection);
  inherited;
end;


procedure TAztecComputer.SetUserName(const AUserName:string);
var
  FFullUserName:string;
begin
  FUserName:=AUserName;
  FFullUserName:=FUserName;
  if FDomain<>'' then
     FFullUserName:=FDomain+'\'+FFullUserName;
  FWMIConnection.Connected:=FALSE;
  FWMIConnection.Credentials.UserName:=FFullUserName;
end;

procedure TAztecComputer.SetDomain(const ADomain: string);
var
  FFullUserName:string;
begin
  FDomain:=ADomain;
  FFullUserName:=FUserName;
  if FDomain<>'' then
     Insert(FDomain+'\',FFullUserName,1);
  FWMIConnection.Connected:=FALSE;
  FWMIConnection.Credentials.UserName:=FFullUserName;
end;

procedure TAztecComputer.SetIpAddress(const AIpAddress: string);
begin
  FIpAddress:=AIpAddress;
  FWMIConnection.Connected:=FALSE;
  FWMIConnection.MachineName:=FIpAddress;
end;

procedure TAztecComputer.SetPassword(const APassword: string);
begin
  FPassword:=APassword;
  FWMIConnection.Connected:=FALSE;
  FWMIConnection.Credentials.Password:=FPassword;
end;

procedure TAztecComputer.WriteToLogFile(const AMessage: string);
begin
  if LogFile = nil then
    LogFile:=MakeLogFileInterface(FLogFile,FALSE,'',FALSE);
  LogFile.Write(FMachineName+','+FIpAddress+','+AMessage);
end;

procedure TAztecComputer.NoopProgressFunc(const AMessage:string;const AProgress:integer);
begin
end;

end.

