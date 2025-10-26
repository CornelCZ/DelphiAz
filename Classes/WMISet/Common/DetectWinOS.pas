unit DetectWinOS;
{$I DEFINE.INC}
interface

Uses Windows, SysUtils;

// returns true if operating system is Windows 2000
function IsWindows2000: boolean;

// returns true if operating system is Windows 2000 or higher
function IsWindows2000orHigher: boolean;

// returns true if operating system is Windows NT
function IsWindowsNt: boolean;

// returns true if operating system is Windows XP or higher
function IsWindowsXPOrHigher: boolean;


implementation

{$IFNDEF Delphi6}
procedure RaiseLastOSError;
var
  LastError: Integer;
  Error: Exception;
begin
  LastError := GetLastError;
  if LastError <> 0 then
  begin
    Error := Exception.Create('System error ' + IntToStr(LastError) +
                              ': ' + SysErrorMessage(LastError));
    raise Error;
  end;
end;
{$ENDIF}

procedure GetPlatformVersion(var APlatform, AVersion, AMinorVersion: DWORD);
var
  lpVersionInformation: TOSVersionInfo;
begin
  FillChar(lpVersionInformation, SizeOf(lpVersionInformation), 0);
  lpVersionInformation.dwOSVersionInfoSize := SizeOf(lpVersionInformation);
  SetLastError(0);
  if not GetVersionEx(lpVersionInformation) then RaiseLastOSError;
  APlatform := lpVersionInformation.dwPlatformId;
  AVersion  := lpVersionInformation.dwMajorVersion;
  AMinorVersion := lpVersionInformation.dwMinorVersion;
end;

function IsWindows2000orHigher: boolean;
var
  vPlatform, vVersion, vMinorVersion: DWORD;
begin
  GetPlatformVersion(vPlatform, vVersion, vMinorVersion);
  Result := (vPlatform = VER_PLATFORM_WIN32_NT) and (vVersion >= 5);
end;

(*
function IsWindowsXP: boolean;
var
  vPlatform, vVersion, vMinorVersion: DWORD;
begin
  GetPlatformVersion(vPlatform, vVersion, vMinorVersion);
  Result := (vPlatform = VER_PLATFORM_WIN32_NT)
            and (vVersion = 5)
            and (vMinorVersion = 1);
end;
*)

function IsWindowsXPOrHigher: boolean;
var
  vPlatform, vVersion, vMinorVersion: DWORD;
begin
  GetPlatformVersion(vPlatform, vVersion, vMinorVersion);
  Result := (vPlatform = VER_PLATFORM_WIN32_NT) and
            (
            ((vVersion >= 5) and (vMinorVersion >= 1)) or
            (vVersion >= 6)
            );
end;

function IsWindows2000: boolean;
var
  vPlatform, vVersion, vMinorVersion: DWORD;
begin
  GetPlatformVersion(vPlatform, vVersion, vMinorVersion);
  Result := (vPlatform = VER_PLATFORM_WIN32_NT) and (vVersion = 5);
end;

function IsWindowsNt: boolean;
var
  lpVersionInformation: TOSVersionInfo;
begin
  FillChar(lpVersionInformation, SizeOf(lpVersionInformation), 0);
  lpVersionInformation.dwOSVersionInfoSize := SizeOf(lpVersionInformation);
  SetLastError(0);
  if not GetVersionEx(lpVersionInformation) then RaiseLastOSError;
  Result := lpVersionInformation.dwPlatformId = VER_PLATFORM_WIN32_NT;
end;

end.
