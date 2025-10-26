{ Mike Palmer
  (c) Copyright Zonal Retail Data Systems Ltd. All Rights Reserved }

unit uCommon;

interface

uses Graphics,SysUtils,WinTypes,ShellAPI,Classes,Forms,StdCtrls,Dialogs;

const
  NULL_STRING='';
  NETAPI32='NETAPI32.DLL';
  MAX_PID_ARRAY=1024;
  SV_TYPE_DOMAIN_ENUM=$80000000;
  SV_TYPE_WORKSTATION=$00000001;
  SV_TYPE_NT=$00001000;

type
  TAztecProgress=procedure(const AMessage:string;const AProgress:integer) of object;

{ Zonal Specific Routines }
function GetRemotePRIZMDirectory(const AUsername,APassword,AMachine:string):string;
function GetRemotePRIZMDataDirectory(const AUsername,APassword,AMachine:string):string;
function GetRemotePRIZMPrivateDirectory(const AUsername,APassword,AMachine:string):string;
function GetRemoteAPOSDataDirectory(const AUsername,APassword,AMachine:string):string;
function GetRemoteWindowsDirectory(const AUsername,APassword,AMachine:string):string;
function GetRemoteWindowsSystemDirectory(const AUsername,APassword,AMachine:string):string;
function GetRemoteProgramFilesDirectory(const AUsername,APassword,AMachine:string):string;
function GetRemoteAztecDirectory(const AUsername,APassword,AMachine:string):string;
function GetRemoteAPOSDirectory(const AUsername,APassword,AMachine:string):string;
{ End Zonal Specific Routines }

{ File Routines }
function GetFileVersionDetails(const AFilename:string):string;
function GetFileCreateDateTime(const AFilename:string):string;
function GetFileModifiedDateTime(const AFilename:string):string;
function GetFileAccessedDateTime(const AFilename:string):string;
function GetSizeOfFile(const AFilePath:string):int64;
function GetAssociatedIcon(const AFilename:string):TIcon;
function ZonalCopyFile(const ASourceFile,ADestinationFile:string;AProgress:TAztecProgress;const AOverwriteIfNewer,AForceOverwrite:boolean):boolean;
function GetFileVersion(const AFileName:string):string;
{ End File Routines }

{ Network Routines }
function ConnectToNetworkResource(const AMap,APassword,AUserName:string):boolean;
function DisconnectNetworkResource(const AMap:string):boolean;
procedure GetListOfServers(uFlags:DWORD;DomainList:TStrings);
function ValidateLogin(const AUsername,ADomain,APassword:string):boolean;
function GetLocalMachineName:string;
{ End Network Routines }

{ Graphical Routines }
procedure DrawGradient(ACanvas:TCanvas;ARect:TRect;Colors:array of TColor);
{ End Graphical Routines }

{ 2000/XP Routines }
function IsWinXP:boolean;
procedure SetDropShadowStatus(AEnabled:boolean);
procedure SetFlatMenuStatus(AEnabled:boolean);
function IsWin2K:boolean;
function GetDropShadowStatus:boolean;
function GetFlatMenuStatus:boolean;
function CreateUserBasedProcess(const AUsername,APassword,ADomain,ACommand,AApplication:widestring):cardinal;
{ End 2000/XP Routines }

{ RPSU Routines }
procedure ConvertFromCustomerReference(const ACustomerReference:string;var AIPAddress,ASiteCode:string);
procedure ConvertFromIPAddress(const AIPAddress:string;var ACustomerReference,ASiteCode:string);
procedure ConvertFromSiteCode(const ASiteCode:string;var ACustomerReference,AIPAddress:string);
procedure OpenRPSUQuery;
procedure CloseRPSUQuery;
{ End RPSU Routines }

{ Conversion Routines }
function BooleanToString(const ABooleanValue:boolean):string;
function RemoveQuotes(var AString:string):string;
function ConvertHTMLToDOC(const AFileName, AOutputFile : string):boolean;
{ End Conversion Routines }

{ Dialog Routines }
Function CreateMessageDialog(const aCaption: String; const Msg: string; DlgType: TMsgDlgType;
                       Buttons: TMsgDlgButtons; DefButton: Integer; HelpCtx: Longint): Integer;
{ End Dialog Routines }

var
  OperationCancelled:boolean;

implementation

uses DateUtils,DBTables,Variants,DB,uAztecConstants,WMIOS,WMIRegistry,Word2000,ComObj;

type
  PSERVER_INFO_101=^SERVER_INFO_101;
  SERVER_INFO_101=
  record
    dwPlatformId:integer;
    lpszServerName:LPWSTR;
    dwVersionMajor:integer;
    dwVersionMinor:integer;
    dwType:integer;
    lpszComment:LPWSTR;
  end;

{ External Routines }
function CreateProcessWithLogonW(const AlpUsername,AlpDomain,AlpPassword:pwidechar;AdwLogonFlags:DWORD;
  const AlpApplicationName,AlpCommandLine:pwidechar;AdwCreationFlags:DWORD;AlpEnvironment:pointer;
  const AlpCurrentDirectory:pwidechar;AlpStartupInfo:pstartupinfo;
  AlpProcessInfo:pprocessinformation):boolean;stdcall;external 'advapi32.dll';
{ End External Roytines }

var
  qryRPSU:TQuery;

{ RPSU Routines }
procedure OpenRPSUQuery;
begin
  qryRPSU:=TQuery.Create(nil);
  with qryRPSU do
  begin
    Session.NetFileDir:='o:\HelpDesk';
    DatabaseName:='RPSU';
    SQL.Clear;
    SQL.Add('select m."SiteCode",m."CustRef",s."SitePCLastKnownIP"');
    SQL.Add('from "RUMain" m,"SiteIP" s');
    SQL.Add('where m."SiteCode" = s."SiteCode"');
    Open;
 end;
end;

procedure CloseRPSUQuery;
begin
  try
    qryRPSU.Close;
  finally
    FreeAndNil(qryRPSU);
  end;
end;

procedure ConvertFromCustomerReference(const ACustomerReference:string;var AIPAddress,ASiteCode:string);
begin
  if qryRPSU.Locate('CustRef',ACustomerReference,[]) then
  begin
    ASiteCode:=qryRPSU.FieldByName('SiteCode').Asstring;
    AIPAddress:=qryRPSU.FieldByName('SitePCLastKnownIP').AsString;
  end
  else begin
         ASiteCode:='Error';
         AIPAddress:='Error';
       end;
end;

procedure ConvertFromIPAddress(const AIPAddress:string;var ACustomerReference,ASiteCode:string);
begin
  if qryRPSU.Locate('SitePCLastKnownIP',AIPAddress,[]) then
  begin
    ASiteCode:=qryRPSU.FieldByName('SiteCode').Asstring;
    ACustomerReference:=qryRPSU.FieldByName('CustRef').AsString;
  end
  else begin
         ASiteCode:='Error';
         ACustomerReference:='Error';
       end;
end;

procedure ConvertFromSiteCode(const ASiteCode:string;var ACustomerReference,AIPAddress:string);
begin
  if qryRPSU.Locate('SiteCode',ASiteCode,[]) then
  begin
    ACustomerReference:=qryRPSU.FieldByName('CustRef').Asstring;
    AIPAddress:=qryRPSU.FieldByName('SitePCLastKnownIP').AsString;
  end
  else begin
         AIPAddress:='Error';
         ACustomerReference:='Error';
       end;
end;
{ End RPSU Routines }

{ 2000/XP Routines }
function GetDropShadowStatus:boolean;
begin
  if IsWin2k or IsWinXP then
     SystemParametersInfoW(SPI_GETDROPSHADOW,0,@Result,0);
end;

function GetFlatMenuStatus:boolean;
begin
  if IsWin2k or IsWinXP then
     SystemParametersInfoW(SPI_GETFLATMENU,0,@Result,0);
end;

function IsWinXP:boolean;
begin
  Result:=(Win32Platform=VER_PLATFORM_WIN32_NT) and
          (Win32MajorVersion>=5) and (Win32MinorVersion>=1);
end;

function IsWin2K:boolean;
begin
  Result:=(Win32Platform=VER_PLATFORM_WIN32_NT) and
          (Win32MajorVersion=5) and (Win32MinorVersion>=0);
end;

procedure SetDropShadowStatus(AEnabled:boolean);
var
  CurrentStatus:boolean;
begin
  CurrentStatus:=AEnabled;
  if IsWin2k or IsWinXP then
     if not AEnabled then
        SystemParametersInfoW(SPI_SETDROPSHADOW,0,nil,0)
     else
        SystemParametersInfoW(SPI_SETDROPSHADOW,0,@CurrentStatus,0);
end;

procedure SetFlatMenuStatus(AEnabled:boolean);
var
  CurrentStatus:boolean;
begin
  CurrentStatus:=AEnabled;
  if IsWin2k or IsWinXP then
    if not AEnabled then
       SystemParametersInfoW(SPI_SETFLATMENU,0,nil,0)
    else
       SystemParametersInfoW(SPI_SETFLATMENU,0,@CurrentStatus,0);
end;

function CreateUserBasedProcess(const AUsername,APassword,ADomain,ACommand,AApplication:widestring):cardinal;
var
  StartUpInfo:TStartUpInfo;
  ProcessInfo:PROCESS_INFORMATION;
begin
  if ((ACommand<>'') and (AApplication<>'')) or ((ACommand='') and (AApplication='')) then
  begin
    Result:=0;
    exit;
  end;
  FillChar(StartUpInfo,SizeOf(TStartUpInfo),0);
  StartUpInfo.cb:=SizeOf(TStartUpInfo);
  if ACommand='' then
  begin
    if CreateProcessWithLogonW(pwidechar(AUserName),pwidechar(ADomain),pwidechar(APassword),
        0,pwidechar(AApplication),nil,0,nil,nil,@StartUpInfo,@ProcessInfo) then
       Result:=ProcessInfo.dwProcessId
    else
       Result:=0;
  end
  else
  begin
    if CreateProcessWithLogonW(pwidechar(AUserName),pwidechar(ADomain),pwidechar(APassword),
         0,nil,pwidechar(ACommand),0,nil,nil,@StartUpInfo,@ProcessInfo) then
       Result:=ProcessInfo.dwProcessId
    else
       Result:=0;
  end;
end;
{ End 2000/XP Routines }

{ Graphical Routines }
procedure DrawGradient(ACanvas:TCanvas;ARect:TRect;Colors:array of TColor);
type
  TRGBArray = array[0..2] of Byte;
var
  x,y,z,Offset,MaxColors,ColorDifference,
  ColorShift,ColorMass:integer;
  ColorFactor:double;
  RGBSingle:TRGBArray;
  RGBArray:array of TRGBArray;
  PenWidth:integer;
  PenStyle:TPenStyle;
  PenColor:TColor;
begin
  MaxColors:=High(Colors);
  if MaxColors > 0 then
  begin
    ColorMass:=ARect.Right - ARect.Left;
    SetLength(RGBArray,MaxColors+1);
    for x:= 0 to MaxColors do
    begin
      Colors[x]:=ColorToRGB(Colors[x]);
      RGBArray[x][0]:=GetRValue(Colors[x]);
      RGBArray[x][1]:=GetGValue(Colors[x]);
      RGBArray[x][2]:=GetBValue(Colors[x]);
    end;
    PenWidth:=ACanvas.Pen.Width;
    PenStyle:=ACanvas.Pen.Style;
    PenColor:=ACanvas.Pen.Color;
    ACanvas.Pen.Width:=1;
    ACanvas.Pen.Style:=psSolid;
    ColorShift:=Round(ColorMass/MaxColors);
    for y:=0 to MaxColors - 1 do
    begin
      if y=MaxColors - 1 then
         ColorDifference:=ColorMass-y*ColorShift- 1
      else
         ColorDifference:=ColorShift;
      for x:= 0 to ColorDifference do
      begin
        Offset:=x+y*ColorShift;
        ColorFactor:=x/ColorDifference;
        for z:=0 to 3 do
          RGBSingle[z]:=Trunc(RGBArray[y][z]+((RGBArray[y+1][z]-RGBArray[y][z])*ColorFactor));
        ACanvas.Pen.Color:=RGB(RGBSingle[0],RGBSingle[1],RGBSingle[2]);
        ACanvas.MoveTo(ARect.Left+Offset,ARect.Top);
        ACanvas.LineTo(ARect.Left+Offset,ARect.Bottom);
      end;
    end;
    RGBArray:=nil;
    ACanvas.Pen.Width:=PenWidth;
    ACanvas.Pen.Style:=PenStyle;
    ACanvas.Pen.Color:=PenColor;
  end
end;
{ End Graphical Routines }

{ Network Routines }
function GetLocalMachineName:string;
var
  MachineName:array[0..MAX_COMPUTERNAME_LENGTH] of char;
  MachineNameSize:cardinal;
begin
  MachineNameSize:=SizeOf(MachineName);
  GetComputerName(@MachineName,MachineNameSize);
  Result:=StrPas(MachineName);
end;

procedure GetListOfServers(uFlags:DWORD;DomainList:TStrings);
Var
  wServerName:widestring;
  wDomain:widestring;
  pwDomain:pwidechar;
  EnumResult:DWORD;
  pServerInfo:PSERVER_INFO_101;
  Buffer:pointer;
  Count,EntriesRead,TotalEntries,
  MAX_PREFERRED_LENGTH,
  NIL_HANDLE:integer;
  ServerName:string;
  NetAPI:THandle;
  _NetServerEnum:function (AServerName:pwidechar;ALevel:integer;var ABufPtr:pointer;
     APrefMaxLen:integer;var AEntriesRead,ATotalEntries:integer;AServerType:integer;ADomain:pwidechar;
     var AResumeHandle:integer):integer;stdcall;
  _NetApiBufferFree:function (ABufPtr:pointer):integer;stdcall;
begin
  DomainList.Clear;
  ServerName:=NULL_STRING;
  wServerName:=ServerName;
  MAX_PREFERRED_LENGTH:=-1;
  wDomain:=NULL_STRING;
  pwDomain:=nil;
  NetAPI:=SafeLoadLibrary(NETAPI32);
  if NetAPI <> 0 then
  begin
    @_NetServerEnum:=GetProcAddress(NetAPI,'NetServerEnum');
    @_NetAPIBufferFree:=GetProcAddress(NetAPI,'NetApiBufferFree');
  end
  else
  Exit;
  EnumResult:=_NetServerEnum (pwidechar(wServerName),101,Buffer,MAX_PREFERRED_LENGTH,
                EntriesRead,TotalEntries,uFlags,pwDomain,NIL_HANDLE);
  if EnumResult = ERROR_SUCCESS then
  begin
    try
      pServerInfo:=PSERVER_INFO_101(Buffer);
      for Count:=0 to EntriesRead - 1 do
      begin
        DomainList.AddObject(pServerInfo^.lpszServerName,TObject(pServerInfo^.dwPlatformId));
        Inc (pServerInfo);
      end;
    finally
      _NetAPIBufferFree(Buffer);
    end;
  end
  else
  raise Exception.CreateRes(EnumResult);
end;

function ValidateLogin(const AUsername,ADomain,APassword:string):boolean;
var
  NTToken:cardinal;
begin
  try
    LogonUser(PChar(AUserName),PChar(ADomain),PChar(APassword),
              LOGON32_LOGON_INTERACTIVE,LOGON32_PROVIDER_DEFAULT,NTToken);
    Result:=NTToken > 0;
  finally
    CloseHandle(NTToken);
  end;
end;

function DisconnectNetworkResource(const AMap:string):boolean;
begin
  result:=WNetCancelConnection2(PChar(AMap),CONNECT_UPDATE_PROFILE,TRUE)=NO_ERROR;
end;


function ConnectToNetworkResource(const AMap,APassword,AUserName:string):boolean;
var
 Resource:TNetResource;
begin
  Resource.dwType:=RESOURCETYPE_ANY;
  Resource.lpRemoteName:=PChar(AMap);
  Resource.lpLocalName:=nil;
  Resource.lpProvider:=nil;
  Result:=WNetAddConnection2(Resource,PChar(APassword),PChar(AUserName),0)=NO_ERROR;
end;
{ End Graphical Routines }

{ File Routines }
function GetFileVersionDetails(const AFilename:string):string;
type
  TVersion=packed record
    case integer of
      0:(Build:byte;MinorVersion: byte;MajorVersion: byte;ProductVersion: byte);
      1:(VersionLong: cardinal);
  end;
var
  ABuffer:TByteArray;
  ASize,AVersionLength,ADump:cardinal;
  AVersionPointer:PVSFixedFileInfo;
  Version:TVersion;
begin
  ASize:=GetFileVersionInfoSize(PChar(AFilename),ADump);
  GetFileVersionInfo(PChar(AFilename),0,ASize,@ABuffer);
  if VerQueryValue(@ABuffer,PChar('\\'),pointer(AVersionPointer),AVersionLength) then
  begin
    if (AVersionLength>1) then
    begin
      Version.ProductVersion:=(AVersionPointer.dwFileVersionMS shr 16);
      Version.MajorVersion:=(AVersionPointer.dwFileVersionMS and 65535);
      Version.MinorVersion:=(AVersionPointer.dwFileVersionLS shr 16);
      Version.Build:=(AVersionPointer.dwFileVersionLS and 65535);
    end;
    Result:=IntToStr(Version.ProductVersion)+'.'+IntToStr(Version.MajorVersion)+'.'+
      IntToStr(Version.MinorVersion)+'.'+IntToStr(Version.Build);
  end
  else
    Result:='';
end;


function SourceFileIsNewerThanDestinationFile(const ASourceFile,ADestinationFile:string ):boolean;
begin
  if (not FileExists(ADestinationFile)) then
  begin
    Result:=TRUE;
    exit;
  end;
  try
    Result:=CompareDateTime(StrToDateTime(GetFileCreateDateTime(ASourceFile)),StrToDateTime(GetFileCreateDateTime(ADestinationFile))) = 1;
  except
    Result:=FALSE;
  end;
end;

function ZonalCopyFile(const ASourceFile,ADestinationFile:string;AProgress:TAztecProgress;
            const AOverwriteIfNewer,AForceOverwrite :boolean):boolean;
var
  SHFileInfo: TSHFileOpStruct;
begin
  if FileExists(ADestinationFile) then
  begin
    if AOverwriteIfNewer then
    begin
      if not SourceFileIsNewerThanDestinationFile(ASourceFile, ADestinationFile) then
      begin
        Result := FALSE;
        Exit;
      end;
    end;

    if AForceOverwrite then
    begin
      if not RenameFile(ADestinationFile, ADestinationFile + '.old') then
      begin
        Result := FALSE;
        Exit;
      end;
    end;
  end;

  with SHFileInfo do
  begin
    lpszProgressTitle := PChar('Zonal Aztec Estate Management Copy');

    Wnd    := 0;
    wFunc  := FO_COPY; { This Parameter Could Also Be FO_DELETE, FO_MOVE or FO_RENAME }
    pFrom  := PChar(ASourceFile);
    pTo    := PChar(ADestinationFile);
    fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION or {FOF_SILENT} FOF_SIMPLEPROGRESS;

    fAnyOperationsAborted := FALSE;
  end;

  Result := (SHFileOperation(SHFileInfo) = 0) and (not SHFileInfo.fAnyOperationsAborted);
end;

function GetFileCreateDateTime(const AFilename:string):string;
var
  FileHandle:THandle;
  FileDateTime:TFileTime;
  SystemTimeStruct:SYSTEMTIME;
  TimeZoneInfo:TTimeZoneInformation;
  Bias:Double;
begin
  Bias:=0;
  FileHandle:=FileOpen(AFileName,fmOpenRead or fmShareDenyNone);
  if FileHandle > 0 then
  begin
    try
      if GetTimeZoneInformation(TimeZoneInfo) <> $FFFFFFFF then
         Bias:=TimeZoneInfo.Bias/1440;
      GetFileTime(FileHandle,@FileDateTime,nil,nil);
      if FileTimeToSystemTime(FileDateTime,SystemTimeStruct) then
         Result:=FormatDateTime('dd/mm/yyyy hh:mm:ss',SystemTimeToDateTime(SystemTimeStruct)-Bias);
    finally
      FileClose(FileHandle);
    end;
  end;
end;


function GetFileAccessedDateTime(const AFilename:string):string;
var
  FileHandle:THandle;
  FileDateTime:TFileTime;
  SystemTimeStruct:SYSTEMTIME;
  TimeZoneInfo:TTimeZoneInformation;
  Bias:Double;
begin
    Bias:=0;
  FileHandle:=FileOpen(AFileName,fmOpenRead or fmShareDenyNone);
  if FileHandle > 0 then
  begin
    try
      if GetTimeZoneInformation(TimeZoneInfo) <> $FFFFFFFF then
         Bias:=TimeZoneInfo.Bias / 1440;
      GetFileTime(FileHandle,nil,@FileDateTime,nil);
      if FileTimeToSystemTime(FileDateTime,SystemTimeStruct) then
         Result:=FormatDateTime('dd/mm/yyyy hh:mm:ss',SystemTimeToDateTime(SystemTimeStruct)-Bias);
    finally
      FileClose(FileHandle);
    end;
  end;
end;

function GetFileModifiedDateTime(const AFilename:string):string;
var
  FileHandle:THandle;
  FileDateTime:TFileTime;
  SystemTimeStruct:SYSTEMTIME;
  TimeZoneInfo:TTimeZoneInformation;
  Bias:Double;
begin
    Bias:=0;
  FileHandle:=FileOpen(AFileName,fmOpenRead or fmShareDenyNone);
  if FileHandle > 0 then
  begin
    try
      if GetTimeZoneInformation(TimeZoneInfo) <> $FFFFFFFF then
         Bias:=TimeZoneInfo.Bias / 1440;
      GetFileTime(FileHandle,nil,nil,@FileDateTime);
      if FileTimeToSystemTime(FileDateTime,SystemTimeStruct) then
         Result:=FormatDateTime('dd/mm/yyyy hh:mm:ss',SystemTimeToDateTime(SystemTimeStruct)-Bias);
    finally
      FileClose(FileHandle);
    end;
  end;
end;

function GetSizeOfFile(const AFilePath:string):int64;
var
  attrData:WIN32_FILE_ATTRIBUTE_DATA;
begin
  if not GetFileAttributesEx(pchar(AFilePath),GetFileExInfoStandard,
                          pointer(@attrData) ) then
    raise Exception.create('GetSizeOfFile:Opening file "'+AFilePath +
      '" failed.');

  Result:=int64(attrData.nFileSizeHigh shl 32)+int64(attrData.nFileSizeLow);
end;

function GetAssociatedIcon(const AFilename:string):TIcon;
var
  Info:TSHFileInfo;
  Flags:Cardinal;
  AExtension:string;
begin
  result:=TIcon.Create;
  AExtension:=copy(AFilename,length(AFilename)-3,4);
  Flags:=SHGFI_ICON or SHGFI_LARGEICON or SHGFI_USEFILEATTRIBUTES;
  SHGetFileInfo(PChar(AExtension),FILE_ATTRIBUTE_NORMAL,Info,SizeOf(TSHFileInfo),Flags);
  Result.Handle:=Info.hIcon;
end;

function GetFileVersion(const AFileName:string):string;
var
  BufferSize:DWORD;
  Dummy:DWORD;
  Buffer:pointer;
  FileInfo:pointer;
  Version:array [1..4] of word;
begin
  Result:='';
  BufferSize:=GetFileVersionInfoSize(PChar(AFileName),Dummy);
  if (BufferSize > 0) then
  begin
    GetMem(Buffer,BufferSize);
    try
      GetFileVersionInfo(PChar(AFileName),0,BufferSize,Buffer);
      VerQueryValue(Buffer,'\',FileInfo,Dummy);
      Version[1]:=HiWord(PVSFixedFileInfo(FileInfo)^.dwFileVersionMS);
      Version[2]:=LoWord(PVSFixedFileInfo(FileInfo)^.dwFileVersionMS);
      Version[3]:=HiWord(PVSFixedFileInfo(FileInfo)^.dwFileVersionLS);
      Version[4]:=LoWord(PVSFixedFileInfo(FileInfo)^.dwFileVersionLS);
    finally
      FreeMem(Buffer);
    end;
    Result:=Format('%d.%d.%d.%d',[Version[1],Version[2],Version[3],Version[4]]);
  end;
end;
{ End File Routines }

{ Zonal Specific Routines }
procedure ChangeCurrentPathCaseInsensitive(AWMIRegistry: TWMIRegistry; AChangePath: string);
var
  Count             : integer;
  CurrentSearchNode : string;
  PendingAdditionStuff : string;
  BackSlashPosition : integer;
begin
  PendingAdditionStuff := '';

  while AChangePath <> '' do
  begin
    BackSlashPosition := pos('\', AChangePath);

    if BackSlashPosition = 0 then
    begin
      CurrentSearchNode := AChangePath;
      AChangePath := '';
    end
    else
    begin
      CurrentSearchNode := copy(AChangePath, 1, BackSlashPosition - 1);
      Delete(AChangePath, 1, BackSlashPosition);
    end;

    for Count := 0 to AWMIRegistry.SubKeys.Count - 1 do
    begin
      if UpperCase(AWMIRegistry.SubKeys.Strings[Count]) = UpperCase(CurrentSearchNode) then
      begin
        AWMIRegistry.CurrentPath := AWMIRegistry.CurrentPath + PendingAdditionStuff + AWMIRegistry.SubKeys.Strings[Count];

        if BackSlashPosition <> 0 then
          PendingAdditionStuff := '\';

        Break;
      end;
    end;
  end;
end;

function GetRemotePRIZMDirectory(const AUsername,APassword,AMachine:string):string;
var
  WMIRegistry: TWMIRegistry;
begin
  WMIRegistry := TWMIRegistry.Create(nil);

  try
    Result := 'Error';

    WMIRegistry.Credentials.Username := AUsername;
    WMIRegistry.Credentials.Password := APassword;
    WMIRegistry.MachineName:=AMachine;
    WMIRegistry.RootKey:=HKEY_LOCAL_MACHINE;
    WMIRegistry.Active:=TRUE;

    ChangeCurrentPathCaseInsensitive(WMIRegistry, 'Software\Zonal\PRIZMExecutive\Configs');

    Result := ExtractFilePath(WMIRegistry.ReadString('IntiDir'));
    Result := Copy(Result, 1, Length(Result) - 1);
    Result := StringReplace(Result, ':', '$', []);

    WMIRegistry.Active := FALSE;
  finally
    FreeAndNil(WMIRegistry);
  end;
end;

function GetRemotePRIZMDataDirectory(const AUsername,APassword,AMachine:string):string;
var
  i              : integer;
  PrizmSystemDir : string;
begin
  PrizmSystemDir := GetRemotePRIZMDirectory(AUserName, APassword, AMachine);

  with TStringList.Create do
  try
    LoadFromFile('\\' + AMachine + '\' + PrizmSystemDir + '\initdirs.sc');

    for i := 0 to Count - 1 do
    begin
      if trim(LowerCase(Names[i])) = 'data_dir' then
      begin
        Result := StringReplace(trim(Values[Names[i]]), '\\', '\', [rfReplaceAll]);
        Result := StringReplace(Result, '"', '', [rfReplaceAll]);
        Break;
      end;
    end;

    if Result[Length(Result)] = '\' then
      Result := Copy(Result, 1, Length(Result) - 1);
  finally
    Free;
  end;

  Result := StringReplace(Result, ':', '$', []);
end;

function GetRemotePRIZMPrivateDirectory(const AUsername,APassword,AMachine:string):string;
var
  i              : integer;
  PrizmSystemDir : string;
begin
  PrizmSystemDir := GetRemotePRIZMDirectory(AUserName, APassword, AMachine);

  with TStringList.Create do
  try
    LoadFromFile('\\' + AMachine + '\' + PrizmSystemDir + '\initdirs.sc');

    for i := 0 to Count - 1 do
    begin
      if trim(LowerCase(Names[i])) = 'priv_dir' then
      begin
        Result := StringReplace(trim(Values[Names[i]]), '\\', '\', [rfReplaceAll]);
        Result := StringReplace(Result, '"', '', [rfReplaceAll]);
        Break;
      end;
    end;

    if Result[Length(Result)] = '\' then
      Result := Copy(Result, 1, Length(Result) - 1);
  finally
    Free;
  end;

  Result := StringReplace(Result, ':', '$', []);
end;

function GetRemoteWindowsDirectory(const AUsername,APassword,AMachine:string):string;
var
  WMIOS:TWMIOS;
begin
  WMIOS:=TWMIOS.Create(nil);
  try
    Result:='Error';
    WMIOS.Credentials.UserName:=AUsername;
    WMIOS.Credentials.Password:=APassword;
    WMIOS.MachineName:=AMachine;
    WMIOS.Active:=TRUE;
    Result:=WMIOS.WindowsDirectory;
  finally
    FreeAndNil(WMIOS);
  end;

  Result := StringReplace(Result, ':', '$', []);
end;

function GetRemoteWindowsSystemDirectory(const AUsername,APassword,AMachine:string):string;
var
  WMIOS:TWMIOS;
begin
  WMIOS:=TWMIOS.Create(nil);
  try
    Result:='Error';
    WMIOS.Credentials.UserName:=AUsername;
    WMIOS.Credentials.Password:=APassword;
    WMIOS.MachineName:=AMachine;
    WMIOS.Active:=TRUE;
    Result:=WMIOS.SystemDirectory;
  finally
    FreeAndNil(WMIOS);
  end;

  Result := StringReplace(Result, ':', '$', []);
end;

function GetRemoteProgramFilesDirectory(const AUsername,APassword,AMachine:string):string;
var
  WMIRegistry:TWMIRegistry;
begin
  WMIRegistry:=TWMIRegistry.Create(nil);
  try
    Result:='Error';
    WMIRegistry.Credentials.Username:=AUsername;
    WMIRegistry.Credentials.Password:=APassword;
    WMIRegistry.MachineName:=AMachine;
    WMIRegistry.RootKey:=HKEY_LOCAL_MACHINE;
    WMIRegistry.Active:=TRUE;
    ChangeCurrentPathCaseInsensitive(WMIRegistry, 'SOFTWARE\Microsoft\Windows\CurrentVersion');
    Result:=WMIRegistry.ReadString('ProgramFilesDir');
    WMIRegistry.Active:=FALSE;
  finally
    FreeAndNil(WMIRegistry);
  end;

  Result := StringReplace(Result, ':', '$', []);
end;

function GetRemoteAztecDirectory(const AUsername,APassword,AMachine:string):string;
begin
  Result:=GetRemoteProgramFilesDirectory(AUsername,APassword,AMachine)+'\Zonal\Aztec';
  Result := StringReplace(Result, ':', '$', []);
end;

function GetRemoteAPOSDirectory(const AUsername,APassword,AMachine:string):string;
begin
  Result:=GetRemoteProgramFilesDirectory(AUsername,APassword,AMachine)+'\Zonal\APOS';
  Result := StringReplace(Result, ':', '$', []);
end;

function GetRemoteAPOSDataDirectory(const AUsername,APassword,AMachine:string):string;
begin
  Result := GetRemotePRIZMDataDirectory(AUserName, APassword, AMachine) + '\APOSData';
  Result := StringReplace(Result, ':', '$', []);
end;
{ Zonal Specific Routines }


{ Conversion Routines }
function BooleanToString(const ABooleanValue:boolean):string;
begin
  case ABooleanValue of
    TRUE:Result:='Successful';
    FALSE:Result:='Unsuccessful';
  end;
end;

function RemoveQuotes(var AString:string):string;
begin
  while Pos('"',AString)> 0 do
    Delete(AString,Pos('"',AString),1);
  Result:=AString;
end;

function ConvertHTMLToDOC(const AFileName, AOutputFile : string) : boolean;
const
  wdDO_NOT_SAVE_CHANGES=0;
  wdDO_SAVE_CHANGES=-1;
var
  OLEWord,OLEDocument:OLEVariant;
begin
  Result := TRUE;

  try
    try
      OLEWord:=GetActiveOleObject('Word.Application');
    except
      OLEWord:=CreateOleObject('Word.Application');
    end;
    OLEWord.Documents.Open(AFileName);
    OLEWord.Visible:=FALSE;
    OLEDocument:=OLEWord.ActiveDocument;
    OLEDocument.ActiveWindow.View.Type:=wdPrintView;
    OLEDocument.SaveAs(AOutputFile);
    OLEWord.ActiveDocument.Close(wdDO_NOT_SAVE_CHANGES,EmptyParam,EmptyParam);
    OLEWord.Quit(EmptyParam, EmptyParam, EmptyParam);
    OLEDocument:=VarNull;
    OLEWord:=VarNull;
  except
    Result:=FALSE;
  end;
end;
{ End Conversion Routines }

{ Dialog Routines }
function CreateMessageDialog(const aCaption: String;
                       const Msg: string;
                       DlgType: TMsgDlgType;
                       Buttons: TMsgDlgButtons;
                       DefButton: Integer;
                       HelpCtx: Longint): Integer;
var
  ButtonCount: Integer;
  ThisButton: TButton;
begin
  with Dialogs.CreateMessageDialog(Msg, DlgType, Buttons) Do
  try
    Caption := aCaption;
    HelpContext := HelpCtx;
    for ButtonCount := 0 To ComponentCount-1 Do
    begin
      if Components[ButtonCount] is TButton then
      begin
        ThisButton := TButton(Components[ButtonCount]);
        ThisButton.Default := ThisButton.ModalResult = DefButton;
        if ThisButton.Default then
          ActiveControl := ThisButton;
      end;
    end; { For }
    Result := ShowModal;
  finally
    Free;
  end;
end;
{ Dialog Routines }

end.


