// Mike Palmer, 2004
// (c) Zonal Retail Data Systems Ltd
// Backup Extension {Date}.zip
// Backup Files Are In WinZip Format


unit     uArchiveFiles;

interface

uses Classes, DateUtils;

type
  IArchiveFile = interface
    function ArchiveFiles: Boolean;
    function ArchiveFilesToFolder(ZipFileFolder: String): Boolean;
  end;

function MakeArchiveFileInterface(const ArchiveTime : TDateTime; const AFileNames: TStringList; const ALogFilePrefix: string;
  const ANumberOfBackUps: Integer = 30): IArchiveFile;

implementation

uses
  uZIP32, SysUtils, Dialogs, Windows;

function QueryRegString(RootKey: cardinal; Key: string): string;
//TODO: Refactor to raise an ERegistryAccessError exception if value not found.
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

function GetProgramFilesDir: string;
begin
  result := QueryRegString(HKEY_LOCAL_MACHINE,
    'SOFTWARE\Microsoft\Windows\CurrentVersion\ProgramFilesDir');
end;

function EnsureTrailingSlash(path: string): string;
begin
  if (path <> '') and (path[length(path)] <> '\') then
    result := path + '\'
  else
    result := path;
end;

type
  TArchiveFile = class(TInterfacedObject, IArchiveFile)
    constructor Create(const ArchiveTime : TDateTime; const AFileNames: TStringList; const ALogFilePrefix: string;
      const ANumberOfBackUps: Integer);
    function     ArchiveFiles: Boolean;
    function ArchiveFilesToFolder(ZipFileFolder: String): Boolean;
  private
    FArchiveTime     : TDateTime;
    FFileNames       : TStringList;
    FLogFilePrefix   : string;
    FNumberOfBackups : Integer;

    function GetBackupDateFromFileName(const ALogFileName: string): TDateTime;
    procedure RemoveOldFiles;
    procedure RemoveOldFilesFromFolder(ZipFileFolder: String);
    function  ZIP32ArchiveFiles: Boolean;
    function  ZIP32ArchiveFilesToFolder(ZipFileFolder: String): Boolean;
    procedure DeleteSourceFiles;
  end;

// Interface Call

function MakeArchiveFileInterface(const ArchiveTime : TDateTime; const AFileNames: TStringList; const ALogFilePrefix: string;
  const ANumberOfBackUps: Integer): IArchiveFile;
begin
  Result := TArchiveFile.Create(ArchiveTime, AFileNames, ALogFilePrefix, ANumberOfBackUps);
end;

// TArchvieFile

function TArchiveFile.ZIP32ArchiveFiles: boolean;
var
  CurDirectoryBuffer: TByteArray;
  Zip : TZip32;
begin
  GetCurrentDirectory (Pred(SizeOf(CurDirectoryBuffer)), @CurDirectoryBuffer);

  Zip := TZip32.Create(nil);
  Zip.UnAttended  := TRUE;
  Zip.OnMessage   := Nil;
  Zip.Verbose     := TRUE;
  Zip.Handle      := 0;
  Zip.ErrCode     := 0;
  Zip.FSpecArgs.Assign(FFileNames);
  Zip.ZipFileName := EnsureTrailingSlash(GetProgramFilesDir) + 'zonal\aztec\' + FLogFilePrefix +
      formatDateTime('yyyymmdd_hhnnss', FArchiveTime) + '.zip';
  Zip.Add;

  Result := (Zip.ErrCode = 0);

  FreeAndNil(Zip);

  SetCurrentDirectory(@CurDirectoryBuffer);
end;


function TArchiveFile.ZIP32ArchiveFilesToFolder(ZipFileFolder: String): Boolean;
var
  CurDirectoryBuffer: TByteArray;
  Zip : TZip32;
begin
  GetCurrentDirectory (Pred(SizeOf(CurDirectoryBuffer)), @CurDirectoryBuffer);

  Zip := TZip32.Create(nil);
  Zip.UnAttended  := TRUE;
  Zip.OnMessage   := Nil;
  Zip.Verbose     := TRUE;
  Zip.Handle      := 0;
  Zip.ErrCode     := 0;
  Zip.FSpecArgs.Assign(FFileNames);
  Zip.ZipFileName := ZipFileFolder + FLogFilePrefix +
      formatDateTime('yyyymmdd_hhnnss', FArchiveTime) + '.zip';
  Zip.Add;

  Result := (Zip.ErrCode = 0);

  FreeAndNil(Zip);

  SetCurrentDirectory(@CurDirectoryBuffer);
end;

constructor  TArchiveFile.Create(const ArchiveTime : TDateTime; const AFileNames: TStringList; const ALogFilePrefix: string;
  const ANumberOfBackUps: Integer);
begin
  FArchiveTime     := ArchiveTime;
  FFileNames       := AFileNames;
  FLogFilePrefix   := ALogFilePrefix;
  FNumberOfBackups := ANumberOfBackups;
end;

function TArchiveFile.ArchiveFiles;
// Archives The Files And Peforms The Ripple
begin
  ZIP32ArchiveFiles;
  DeleteSourceFiles;
  RemoveOldFiles;

  Result := TRUE;
end;

function TArchiveFile.ArchiveFilesToFolder(ZipFileFolder: String): Boolean;
begin
  ZIP32ArchiveFilesToFolder(ZipFileFolder);
  DeleteSourceFiles;
  RemoveOldFilesFromFolder(ZipFileFolder);
  Result := True;
end;

function TArchiveFile.GetBackupDateFromFileName(const ALogFileName: string): TDateTime;
var
  Year, Month, Day: Word;
  Hour, Min, Sec : Word;
begin
  try
     Year  := StrToInt(Copy(ALogFileName, length(FLogFilePrefix) + 1, 4));
     Month := StrToInt(Copy(ALogFileName, length(FLogFilePrefix) + 5, 2));
     Day   := StrToInt(Copy(ALogFileName, length(FLogFilePrefix) + 7, 2));

     Hour   := StrToInt(Copy(ALogFileName, length(FLogFilePrefix) + 10, 2));
     Min   := StrToInt(Copy(ALogFileName, length(FLogFilePrefix) + 12, 2));
     Sec   := StrToInt(Copy(ALogFileName, length(FLogFilePrefix) + 14, 2));

     Result := EncodeDateTime(Year, Month, Day, Hour, Min, Sec, 0);
  except
    // somethink is wrong in formating - manual cleaning
    // we will return current date
    Result := Now;
  end
end;

procedure TArchiveFile.RemoveOldFiles;
var
  FoundFile  : TSearchRec;
  FindResult : integer;
  AztecDir: String;
begin
  AztecDir := EnsureTrailingSlash(GetProgramFilesDir) + 'zonal\aztec\';

  FindResult := FindFirst(AztecDir + FLogFilePrefix + '*.zip',
    faAnyFile and not faDirectory, FoundFile);

  while FindResult = 0 do
  begin
    if GetBackupDateFromFileName(FoundFile.Name) < (Date - FNumberOfBackups) then
      DeleteFile(PChar(AztecDir + FoundFile.Name));

    FindResult := FindNext(FoundFile);
  end;

  SysUtils.FindClose(FoundFile);
end;

procedure TArchiveFile.RemoveOldFilesFromFolder(ZipFileFolder: String);
var
  FoundFile  : TSearchRec;
  FindResult : integer;
begin
  FindResult := FindFirst(ZipFileFolder + FLogFilePrefix + '*.zip',
    faAnyFile and not faDirectory, FoundFile);

  while FindResult = 0 do
  begin
    if GetBackupDateFromFileName(FoundFile.Name) < (Date - FNumberOfBackups) then
      DeleteFile(PChar(ZipFileFolder + FoundFile.Name));

    FindResult := FindNext(FoundFile);
  end;

  SysUtils.FindClose(FoundFile);
end;

procedure TArchiveFile.DeleteSourceFiles;
var
  i: integer;
begin
  for i := 0 to FFileNames.Count - 1 do
    SysUtils.DeleteFile(FFileNames.Strings[i]);
end;

End.



