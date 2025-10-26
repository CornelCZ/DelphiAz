unit uSystemUtils;

interface

uses TLHelp32;

{ Return the location of the 'Program Files' folder on the current PC }
function GetProgramFilesDir: string;
function GetAztecInstallationFolder: string;
function GetZOEDLLPath: String;

// open registry to read a string if its there, otherwise return blank string
function QueryRegString(RootKey: cardinal; Key: string): string;

// Create an instance of a global mutex.
function CreateGlobalMutex(const MutexName: String): THandle;

function GetProcessInformation(ProcessID: Cardinal): TProcessEntry32;
function ParentProcessIs(ParentProcessNames: array of String): boolean;

implementation

uses Windows, SysUtils, uAztecStringUtils;

function GetProgramFilesDir: string;
begin
  result := EnsureTrailingSlash(
               QueryRegString(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\ProgramFilesDir'));
end;

function GetAztecInstallationFolder: string; //with back slash
begin
  result := EnsureTrailingSlash(
               QueryRegString(HKEY_LOCAL_MACHINE, 'SOFTWARE\Zonal\Aztec\ProgramLocation'));

  if result = '' then
    raise Exception.Create('Failed to find registry key: HKEY_LOCAL_MACHINE\SOFTWARE\Zonal\Aztec\ProgramLocation');
end;

function GetZOEDLLPath: string;
begin
  result := GetAztecInstallationFolder + 'EPOSTerminalNT\ZOEDLL.dll';
end;

function QueryRegString(RootKey: cardinal; Key: string): string;
var
  RegHandle: HKEY;
  DLength, DType, i: cardinal;
  Data: TByteArray;
  Retval: integer;
begin
  Result := '';
  retVal := RegOpenKeyEx(RootKey, pchar((extractfilepath(key))), 0, KEY_READ,
    RegHandle);
  if Retval <> ERROR_SUCCESS then
    exit;

  repeat
    Dlength := 32767;
    RetVal := RegQueryValueEx(RegHandle, pchar(extractfilename(key)), nil,
      @DType,
      @Data, @DLength);
    if (RetVal = ERROR_SUCCESS) or (RetVal = ERROR_MORE_DATA) then
      if DType = REG_SZ then
      begin
        if DLength > 1 then
        begin
          for i := 0 to pred(pred(Dlength)) do
            Result := Result + char(Data[i]);
        end;
      end;
  until (RETVAL <> ERROR_MORE_DATA);
  RegCloseKey(RegHandle);
end;

function CreateGlobalMutex(const MutexName: String): THandle;
var
  SecurityDescriptor: TSecurityDescriptor;
  SecurityAttributes: TSecurityAttributes;
begin
  InitializeSecurityDescriptor(@SecurityDescriptor, SECURITY_DESCRIPTOR_REVISION);
  SetSecurityDescriptorDacl(@SecurityDescriptor, TRUE, nil, FALSE);

  SecurityAttributes.nLength := SizeOf(SecurityAttributes);
  SecurityAttributes.lpSecurityDescriptor := @SecurityDescriptor;
  SecurityAttributes.bInheritHandle := FALSE;

  Result := CreateMutex(@SecurityAttributes, FALSE, PChar('Global\' + MutexName));
end;

function ParentProcessIs(ParentProcessNames: array of String): boolean;
var
  CurrentProcessInformation: TProcessEntry32;
  ExecutableName: String;
  Index: Integer;
begin
  CurrentProcessInformation := GetProcessInformation(GetCurrentProcessID);

  ExecutableName := LowerCase(GetProcessInformation(CurrentProcessInformation.th32ParentProcessID).szExeFile);

  for Index := Low(ParentProcessNames) to High(ParentProcessNames) do
  begin
    if Pos(LowerCase(ParentProcessNames[Index]), ExecutableName) > 0 then
    begin
       Result := TRUE;
       Exit;
    end;
  end;

  Result := FALSE;
end;

function GetProcessInformation(ProcessID: Cardinal): TProcessEntry32;
var
  SnapShotHandle: THandle;
  ProcessInformation: TProcessEntry32;
  GotProcess: Boolean;
begin
  SnapShotHandle := CreateToolHelp32Snapshot(TH32CS_SNAPPROCESS, 0);

  if SnapShotHandle > 0 then
  begin
    ProcessInformation.dwSize := SizeOf(ProcessInformation);

    GotProcess := Process32First(SnapShotHandle, ProcessInformation);

    while GotProcess do
    begin
      if ProcessInformation.th32ProcessID = ProcessID then
      begin
        Result := ProcessInformation;
        Exit;
      end;

      GotProcess := Process32Next(SnapShotHandle, ProcessInformation);
    end;

    CloseHandle(SnapShotHandle);
  end;
end;

end.
