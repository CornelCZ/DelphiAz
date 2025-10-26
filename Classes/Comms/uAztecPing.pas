{ Mike Palmer
  (c) Copyright Zonal Retail Data Systems Ltd. All Rights Reserved }

unit     uAztecPing;

interface

uses uAztecAction,uAztecComputer,uCommon,Types,Windows,SysUtils,
     ICMPAPI;

type
  TAztecPing=class(TAztecAction)
  public
    constructor Create; reintroduce;
    function Execute(Computer : TAztecComputer; var AResultString:string):boolean; override;
  private
    FBlockSize:byte;
    FNoOfPings:smallint;
    ICMPDLLHandle:THandle;
    procedure TranslateToIPAddress(AName:string; var AIPAddress:TIPAddr; var ResolvedIP:string);
    function LoadICMPLibrary:boolean;
    function PingIPAddress(Computer : TAztecComputer; var ResolvedIP:string):boolean;
  published
    property NoOfPings:smallint read FNoOfPings write FNoOfPings default 3;
    property BlockSize:byte read FBlockSize write FBlockSize default 72;
  end;

implementation

uses
  WinSock, Dialogs;

{ TAztecPing }

function TAztecPing.LoadICMPLibrary:boolean;
begin
  ICMPDLLHandle:=LoadLibrary(ICMPDLL);
  Result:=ICMPDLLHandle>=32;
end;

constructor TAztecPing.Create;
begin
  inherited Create;
  ICMPDLLHandle:=0;
  FActionDescription:='Ping';
  FTerminate:=TRUE;
end;

procedure TAztecPing.TranslateToIPAddress(AName:string; var AIPAddress:TIPAddr; var ResolvedIP:string);
var
  HostEntry:PHostEnt;
  TempChar:PChar;
  GInitData:TWSAData;
begin
  WSAStartup($101,GInitData);
  try
    HostEntry:=GetHostByName(PChar(AName));
    TempChar:=HostEntry^.h_addr_list^;
    if Assigned(HostEntry) then
       ResolvedIP:=format('%d.%d.%d.%d',[byte(TempChar[0]),byte(TempChar[1]),
          byte(TempChar[2]),byte(TempChar[3])])
    else
       ResolvedIP:=AName;
    AIPAddress:=inet_addr(PChar(ResolvedIP));
  except
    FillChar(AIPAddress,SizeOf(AIPAddress),#0);
  end;
  WSACleanup;
end;

function TAztecPing.PingIPAddress(Computer : TAztecComputer; var ResolvedIP:string):boolean;
const
  PING_TIMEOUT=5000;
var
  PingAttempts:integer;
  SendData:PChar;
  ICMPHandle:Cardinal;
  ReplyBuffer:pointer;
  ResolvedIPAddress:TIPAddr;
begin
  try
    Result:=FALSE;
    SendData:='Aztec Estate Management ICMP Echo Request';
    GetMem(ReplyBuffer,SizeOf(TICMPEchoReply)+SizeOf(SendData));
    LoadICMPLibrary;
    ICMPHandle:=ICMPCreateFile;
    TranslateToIPAddress(Computer.WMIConnection.MachineName,ResolvedIPAddress,ResolvedIP);
    for PingAttempts:=0 to NoOfPings do
    begin
      Result:=ICMPSendEcho(ICMPHandle,ResolvedIPAddress,SendData,SizeOf(SendData),nil,ReplyBuffer,
         SizeOf(ReplyBuffer)+SizeOf(TICMPEchoReply),PING_TIMEOUT)<>0;
      if Result then
         break;
    end;
    ICMPCloseHandle(ICMPHandle);
    Computer.Progress('Complete',100);
    FreeMem(ReplyBuffer);
    FreeLibrary(ICMPDLLHandle);
  except
    Result:=FALSE;
  end;
end;

function TAztecPing.Execute(Computer : TAztecComputer; var AResultString:string):boolean;
var
  ResolvedIP:string;
begin
  Result:=PingIPAddress(Computer, ResolvedIP);
  AResultString:=FActionDescription+','+ResolvedIP+','+BooleanToString(Result);
end;


end.

