{ Mike Palmer, David Johnstone
  (c) Copyright Zonal Retail Data Systems Ltd. All Rights Reserved.}

unit uAztecFiles;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses Graphics,Classes, StdCtrls, uCommon, uAztecAction, uAztecComputer, WMIConnection, WMIProcessControl, uRobustCopy;

type
  TPathType = (ptTransfer, ptCustom, ptAPOS, ptAPOSData, ptPRIZM, ptPRIZMData, ptPRIZMPrivate,
               ptProgramFiles, ptWindows, ptWindowsSystem, ptAztec, ptTemp);

const REMOTE_PATH_ARRAY:array [low(TPathType)..high(TPathType)] of string =
      ('[Transfer Directory]','[Custom Path]','[APOS Directory]','[APOS Data Directory]','[PRIZM Directory]','[PRIZM Data Directory]',
       '[PRIZM Private Directory]','[Program Files Directory]','[Windows Directory]',
       '[Windows System Directory]','[Aztec Directory]','[Temp Directory]');

type
  TAztecFile = class(TAztecAction)
  public
    constructor Create(const AFile:string); reintroduce; virtual;
    destructor Destroy; override;
  private
    FRemotePath:string;
    FRemotePathType:TPathType;
    FFilename:string;
    FCreateDateTime:string;
    FModifiedDateTime:string;
    FAccessedDateTime:string;
    FAssociatedIcon:TIcon;
    FLocalPath:string;
    function GetUncRemotePath(Computer : TAztecComputer): string;
  published
    property LocalPath:string read FLocalPath write FLocalPath;
    property RemotePath     : string read FRemotePath write FRemotePath;
    property RemotePathType : TPathType read FRemotePathType write FRemotePathType;
    property CreateDateTime : string read FCreateDateTime;
    property ModifiedDateTime:string read FModifiedDateTime;
    property AccessedDateTime:string read FAccessedDateTime;
    property Icon           : TIcon read FAssociatedIcon;
    property Filename       : string read FFilename write FFilename;
  end;

  TAztecDeleteFile=class(TAztecFile)
  public
    constructor Create(const AFile:string); override;
    function Execute(Computer : TAztecComputer; var AResultString:string):boolean; override;
  private
    FForceDelete:boolean;
  public
    property ForceDelete:boolean read FForceDelete write FForceDelete default FALSE;
  end;

  TAztecGetFileDetails=class(TAztecFile)
  private
    FVersion:string;
    FFileSize:Int64;
    function GetFileDetails(Computer : TAztecComputer; fullFileName : string):boolean;
  public
    constructor Create(const AFile:string); override;
    function Execute(Computer : TAztecComputer; var AResultString:string):boolean; override;
  published
    property Size:Int64 read FFileSize default 0;
    property CreateDateTime;
    property Version:string read FVersion;
  end;

  TAztecUploadFile=class(TAztecFile)
  public
    constructor Create(const AFile:string); override;
    function Execute(Computer : TAztecComputer; var AResultString:string):boolean;override;
  private
    FOverwriteMode:TRobustFileCopyOverwriteMode;
  published
    property OverwriteMode : TRobustFileCopyOverwriteMode read FOverwriteMode write FOverwriteMode default owmAlwaysOverwriteBackup;
  end;

  TAztecDownloadFile=class(TAztecUploadFile)
  public
    constructor Create(const AFile:string); override;
    function Execute(Computer : TAztecComputer; var AResultString:string):boolean; override;
  private
    FPrefix:string;
  published
    property Prefix:string read FPrefix write FPrefix;
  end;

  TAztecExtractFile=class(TAztecFile)
  public
    constructor Create(const AFile:string); override;
    function Execute(Computer : TAztecComputer; var AResultString:string):boolean; override;
  end;

procedure BuildRemotePathList(AList:TStrings);
function GetResolvedRemotePath(Computer : TAztecComputer; PathType:TPathType; RemotePath:string; ConnectPath : boolean): string;

implementation

uses Windows,uZip32,SysUtils, Forms,Dialogs,uAztecProcess,StrUtils;

{ Routines }
procedure BuildRemotePathList(AList:TStrings);
var
  Index:integer;
begin
  AList.Clear;
  for Index:=ord(low(TPathType)) to ord(high(TPathType)) do
    AList.Add(REMOTE_PATH_ARRAY[TPathType(Index)]);
end;

function MkPath(a, b : string) : string;
begin
  if Length(a) = 0 then
    Result := b
  else if a[Length(a)] = '\' then
    Result := a + b
  else
    Result := a + '\' + b;
end;
{ End Routines }

{ TAztecFile }

constructor TAztecFile.Create(const AFile:string);
begin
  inherited Create;
  FAssociatedIcon:=TIcon.Create;
  FRemotePath:= '';
  FRemotePathType:=ptTransfer;
  FFilename:=AFile;
  FAssociatedIcon:=GetAssociatedIcon(AFile);
  if FileExists(AFile) then
     FCreateDateTime:=GetFileCreateDateTime(AFile);
end;

destructor TAztecFile.Destroy;
begin
  FreeAndNil(FAssociatedIcon);
  Inherited Destroy;
end;

function TAztecFile.GetUncRemotePath(Computer: TAztecComputer): string;
begin
  Result := GetResolvedRemotePath(Computer, FRemotePathType, FRemotePath, true);
end;

function GetResolvedRemotePath(Computer : TAztecComputer; PathType:TPathType; RemotePath:string; ConnectPath:boolean): string;
var
  UserName, Password, MachineName: string;
  i : Integer;
  ShareName : string;
begin
  UserName := Computer.WMIConnection.Credentials.UserName;
  Password := Computer.WMIConnection.Credentials.Password;
  MachineName := Computer.WMIConnection.MachineName;
  case PathType of
    ptTransfer      : Result := 'c$\Transfer';
    ptCustom        : begin
                        Result:=RemotePath;
                        Result:=StringReplace(Result, ':', '$', []);
                      end;
    ptAPOS          : Result := GetRemoteAPOSDirectory(UserName, Password, MachineName);
    ptAPOSData      : Result := GetRemoteAPOSDataDirectory(UserName, Password, MachineName);
    ptPRIZM         : Result := GetRemotePRIZMDirectory(UserName, Password, MachineName);
    ptPRIZMData     : Result := GetRemotePRIZMDataDirectory(UserName, Password, MachineName);
    ptPRIZMPrivate  : Result := GetRemotePRIZMPrivateDirectory(UserName, Password, MachineName);
    ptProgramFiles  : Result := GetRemoteProgramFilesDirectory(UserName, Password, MachineName);
    ptWindows       : Result := GetRemoteWindowsDirectory(UserName, Password, MachineName);
    ptWindowsSystem : Result := GetRemoteWindowsSystemDirectory(UserName, Password, MachineName);
    ptAztec         : Result := GetRemoteAztecDirectory(UserName, Password, MachineName);
    ptTemp          : Result := 'c$\Temp';
  end;

  // Connect to the remote share
  i := Pos('$', Result);
  if (i <> 0) and (ConnectPath) then
  begin
    ShareName := LeftStr(Result,i);
    Computer.ConnectShare(ShareName);
  end;

  // Prepend \\machine\
  Result := '\\'+Computer.WMIConnection.MachineName+'\'+Result;
end;


{ TAztecGetFileDetails }

constructor TAztecGetFileDetails.Create(const AFile:string);
begin
  inherited;
  FActionDescription:='Get File Details';
end;

function TAztecGetFileDetails.Execute(Computer : TAztecComputer; var AResultString:string):boolean;
begin
  RemoveQuotes(FFilename);
  Result:=GetFileDetails(Computer, MkPath(GetUncRemotePath(Computer), FFileName));
  AResultString:=FActionDescription+','+ExtractFileName(FFilename)+','+BooleanToString(Result)+
   ',Size:'+FormatFloat('############ bytes',FFileSize)+',Created:'+FCreateDateTime+
   ',Modified:'+FModifiedDateTime+',Accessed:'+FAccessedDateTime+
   ',Version:'+
   FVersion;
end;

function TAztecGetFileDetails.GetFileDetails(Computer : TAztecComputer; fullFileName : string):boolean;
begin
  Computer.Progress('Getting File Details',20);
  if FileExists(FullFileName) then
  begin
   FFileSize:=GetSizeOfFile(FullFileName);
   Computer.Progress('Size Of File Retrieved',40);
   FCreateDateTime:=GetFileCreateDateTime(FullFileName);
   FModifiedDateTime:=GetFileModifiedDateTime(FullFileName);
   FAccessedDateTime:=GetFileAccessedDateTime(FullFileName);
   Computer.Progress('File Date Retrieved',60);
   FVersion:=GetFileVersion(FullFileName);
   Computer.Progress('File Version Retrieved',80);
   Result:=TRUE;
  end else Result:=FALSE;
  Computer.Progress('Complete',100);
end;

{ TAztecUploadFile }

constructor TAztecUploadFile.Create(const AFile:string);
begin
  inherited;
  FActionDescription:='Upload File';
  FOverwriteMode:=owmOverwriteIfSizeDifferent;
end;

function TAztecUploadFile.Execute(Computer : TAztecComputer; var AResultString:string):boolean;
var
  remotePath : string;
begin
  Computer.Progress('Uploading File',0);
  RemoveQuotes(FFilename);
  remotePath := GetUncRemotePath(Computer);
  if not ForceDirectories(remotePath) then
  begin
    Result := false;
    AResultString := FActionDescription+','+ExtractFileName(FFilename)+',Could not create remote directory: '+SysErrorMessage(GetLastError);
  end
  else
  begin
    Result:=RobustCopyFile(FFilename,
      MkPath(remotePath, ExtractFileName(FFilename)),
      Computer.Progress, FOverwriteMode, nil, Computer.IsCancelledFunc, AResultString);
    AResultString:=FActionDescription+','+ExtractFileName(FFilename)+','+AResultString;
  end;
  Computer.Progress('Complete',0);
end;

{ TAztecDownloadFile }

constructor TAztecDownloadFile.Create(const AFile: string);
begin
  inherited;
  FActionDescription:='Download File';
  FOverwriteMode:=owmAlwaysOverwrite;
  FPrefix:='';
end;

function TAztecDownloadFile.Execute(Computer : TAztecComputer; var AResultString:string):boolean;
var
  DestinationFile:string;
begin
  Computer.Progress('Downloading File',0);
  RemoveQuotes(FFilename);
  DestinationFile:=MkPath(LocalPath, Computer.WMIConnection.MachineName+'-'+FFileName);
  Result:=RobustCopyFile(
    MkPath(GetUncRemotePath(Computer), ExtractFileName(FFilename)),
    DestinationFile, Computer.Progress, owmAlwaysOverwrite, nil, Computer.IsCancelledFunc, AResultString);
  AResultString:=FActionDescription+','+ExtractFileName(FFilename)+','+AResultString;
  Computer.Progress('Complete',100);
end;

{ TAztecDeleteFile }

constructor TAztecDeleteFile.Create(const AFile: string);
begin
  inherited;
  FForceDelete:=FALSE;
  FActionDescription:='Delete File';
end;

function TAztecDeleteFile.Execute(Computer : TAztecComputer; var AResultString:string):boolean;
var
  FullFileName: string;
  CurrentAttributes: integer;
begin
  FullFileName := MkPath(GetUncRemotePath(Computer), FFileName);
  RemoveQuotes(FullFileName);
  Computer.Progress('Deleting File',0);
  CurrentAttributes:=FileGetAttr(FullFileName);
  if (CurrentAttributes and faReadOnly) > 0 then
      FileSetAttr(FullFilename,CurrentAttributes and (not faReadOnly));
  Result:=DeleteFile(FullFileName);
  if (not Result) and (FForceDelete) then
     Result:=RenameFile(FullFileName,FullFileName+'.old');
  AResultString:=FActionDescription+','+ExtractFileName(FFilename)+','+BooleanToString(Result);
  Computer.Progress('Complete',100);
end;


constructor TAztecExtractFile.Create(const AFile: string);
begin
  inherited;
  FActionDescription:='Extract File';
  //FLocked:=FALSE;
end;

function TAztecExtractFile.Execute(Computer : TAztecComputer; var AResultString:string): boolean;
var
  AZIPFile:TZIP32;
begin
  Computer.Progress('Extracting File',0);
  ForceDirectories('\\'+Computer.WMIConnection.MachineName+'\c$\Temp\AEM');
  RemoveQuotes(FFilename);
  AZIPFile:=TZIP32.Create(nil);
  AZIPFile.ZIPFileName:=MkPath(GetUncRemotePath(Computer), ExtractFileName(FFilename));
  AZipFile.ExtrBaseDir:='\\'+Computer.WMIConnection.MachineName+'\c$\Temp\AEM';
  AZIPFile.DLLDirectory:=ExtractFilePath(Application.ExeName);
  AZIPFile.Extract;
  AZIPFile.Free;
  Result:=TRUE;
  AResultString:=FActionDescription+','+ExtractFileName(FFilename)+','+BooleanToString(Result);
  Computer.Progress('Complete',100);
end;



end.
