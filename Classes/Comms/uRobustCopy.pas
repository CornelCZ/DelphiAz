unit uRobustCopy;

interface

uses uCommon;

type
  TRobustFileCopyOverwriteMode = (
    owmDontOverwrite,
    owmOverwriteIfNewer,
    owmOverwriteIfNewerBackup,
    owmOverwriteIfSizeDifferent,
    owmOverwriteIfSizeDifferentBackup,
    owmAlwaysOverwrite,
    owmAlwaysOverwriteBackup );

  TRobustFileCopyTimeouts = record
    transferChunkSize : Cardinal; // Size of chunks read from src and written to dest.  Capped at 65536
    maxUnflushedDestBytes : Cardinal; // Number of bytes written to dest before flushing.
    initialErrorRecoverTimeMs : Cardinal; // Time waited when error is encountered
    errorBackoffTimeMs : Cardinal; // Each time error occurs without progress, backoff by this much more
    maxInitialErrors : Cardinal; // Max errors initially opening file
    maxErrors : Cardinal; // Max total errors before we give up
    maxErrorsNoProgress : Cardinal; // Max consecutive midstream errors before we give up
  end;

  PRobustFileCopyTimeouts = ^TRobustFileCopyTimeouts;

  TRobustFileCopyIsCancelledFunc = function : boolean of object;

// Copy SrcPath file to DestPath.  Algorithm will retry if either the source or destination
// becomes unavailable temporarily.
//
// If DestPath already exists, then OverwriteMode determines
// what happens.  Function frequently polls isCancelledFunc, if this returns true, then the
// transfer is aborted.  If timeoutsOrNil is set, then the provided timeouts are used,
// otherwise, default timeouts are used.
function RobustCopyFile(
  const SrcPath,DestPath:string;
  Progress:TAztecProgress;
  OverwriteMode:TRobustFileCopyOverwriteMode;
  timeoutsOrNil:PRobustFileCopyTimeouts;
  isCancelledFunc : TRobustFileCopyIsCancelledFunc; // Set to true to cancel the file copy
  var resultString : string) : boolean;


implementation

uses StrUtils, SysUtils, Windows;

const
  DefTimeouts : TRobustFileCopyTimeouts = (
    transferChunkSize:65536;
    maxUnflushedDestBytes:131072;
    initialErrorRecoverTimeMs:5000;
    errorBackoffTimeMs:1000;
    maxInitialErrors:5;
    maxErrors:500;
    maxErrorsNoProgress:30
  );

function IsFatalInitialError(errCode : Cardinal) : boolean;
begin
  // Always have a few goes at opening the file
  Result := false;
end;

function IsFatalMidstreamError(errCode : Cardinal) : boolean;
begin
  // Most errors are retried if we have previously opened the file
  if (errCode = ERROR_DISK_FULL) then
    Result := true
  else
    Result := false;
end;

function IsRemotePath(str : String) : boolean;
var
  driveRoot : string;
begin
  if AnsiStartsText('\\',str) then
    // Any path beginning \\ is remote
    Result := true
  else
  begin
    // Drive paths may or may not be remote
    if (Length(str) >= 3) and (str[2] = ':') and (str[3] = '\') then
    begin
      driveRoot := LeftStr(str,3);
      Result := GetDriveType(PChar(driveRoot)) = DRIVE_REMOTE;
    end
    else
      Result := false;
  end;
end;

function SourceFileIsNewerThanDestinationFile(const ASourceFile,ADestinationFile:string ):boolean;
var
  srcAttr : WIN32_FILE_ATTRIBUTE_DATA;
  destAttrs : WIN32_FILE_ATTRIBUTE_DATA;
begin
  try
    if not GetFileAttributesEx(PChar(ASourceFile),GetFileExInfoStandard, @srcAttr) then
      Result := false
    else if not GetFileAttributesEx(PChar(ADestinationFile),GetFileExInfoStandard, @destAttrs) then
      Result := true
    else
      Result := CompareFileTime(srcAttr.ftCreationTime,destAttrs.ftCreationTime) > 0;
  except
    Result:=FALSE;
  end;
end;

function SetFilePointer(hFile : Cardinal; pos : Int64) : boolean;
begin
  Result := (Windows.SetFilePointer(hFile, pos, 4+PChar(@pos), FILE_BEGIN) <> INVALID_FILE_SIZE);
  if (not Result) and (GetLastError = NO_ERROR) then
    Result := true;
end;

function GetFileSize(hFile : Cardinal; var fileSize : Int64) : boolean; overload;
var
  hi : Cardinal;
begin
  fileSize := Windows.GetFileSize(hFile, @hi);
  if (fileSize = INVALID_FILE_SIZE) and (GetLastError <> NO_ERROR) then
    Result := false
  else
  begin
    fileSize := fileSize + (hi shl 32);
    Result := true;
  end;
end;

function GetFileSize(path : String; var fileSize : Int64) : boolean; overload;
var
  attr : WIN32_FILE_ATTRIBUTE_DATA;
begin
  if not GetFileAttributesEx(PChar(path),GetFileExInfoStandard, @attr) then
  begin
    Result := false;
  end
  else
  begin
    fileSize := (Int64(attr.nFileSizeHigh) shl 32) or (Cardinal(attr.nFileSizeLow));
    Result := true;
  end;
end;

function RobustCopyFile(
  const SrcPath,DestPath:string;
  Progress:TAztecProgress;
  OverwriteMode:TRobustFileCopyOverwriteMode;
  timeoutsOrNil:PRobustFileCopyTimeouts;
  isCancelledFunc : TRobustFileCopyIsCancelledFunc;
  var resultString : string) : boolean;
const
  MAX_BUFF_SIZE = 65536;
var
  fileSize : Int64;
  destFileSize : Int64;
  IsSrcRemote, IsDestRemote : boolean;
  destCreateDisposition : Cardinal;
  buffer : array [0..MAX_BUFF_SIZE-1] of char;
  haveBufferData : boolean;
  SrcFile, DestFile : Cardinal;
  bytesRead, bytesWritten : Cardinal;
  inputEof : boolean;
  totalErrorCount : Cardinal;
  errorCountSinceProgress : Cardinal;
  errorBackoffTime : Cardinal;
  srcPos : Int64;
  destPos : Int64;
  goodDestPos : Int64;
  progressPos : Cardinal;
  errCode : Cardinal;
  ok : boolean;
  activity : string;
  haveOpenedSrc, haveOpenedDest : boolean;

  procedure CheckCancelFlag;
  begin
    if isCancelledFunc then
      Abort;
  end;

  function IncErrorCountsExceeded( errCode : Cardinal; remoteFile : boolean; haveOpenedFile : boolean; errMsg : string ) : boolean;
  var
    i : Cardinal;
    maxConsecErrs : Cardinal;
  begin
    if not remoteFile then
    begin
      resultString := errMsg + ' (local file): '+SysErrorMessage(errCode);
      Result := true;
      Exit;
    end;

    if (not haveOpenedFile) and IsFatalInitialError(errCode) then
    begin
      resultString := errMsg + ' (fatal open error): '+SysErrorMessage(errCode);
      Result := true;
      Exit;
    end;

    if haveOpenedFile and IsFatalMidstreamError(errCode) then
    begin
      resultString := errMsg + ' (fatal transfer error): '+SysErrorMessage(errCode);
      Result := true;
      Exit;
    end;

    Inc(totalErrorCount);
    Inc(errorCountSinceProgress);
    if not haveOpenedFile then
      maxConsecErrs := timeoutsOrNil.maxInitialErrors
    else
      maxConsecErrs := timeoutsOrNil.maxErrorsNoProgress;

    if (totalErrorCount > timeoutsOrNil.maxErrors) then
    begin
      resultString := errMsg + ' (gave up after '+IntToStr(totalErrorCount)+' errors): '+SysErrorMessage(errCode);
      Result := true;
      Exit;
    end;

    if (errorCountSinceProgress > maxConsecErrs) then
    begin
      resultString := errMsg + ' (gave up after '+IntToStr(errorCountSinceProgress)+' consecutive errors): '+SysErrorMessage(errCode);
      Result := true;
      Exit;
    end;

    // We have decided this error isn't fatal

    Progress(errMsg+';  retry '+IntToStr(errorCountSinceProgress)+
             '/'+IntToStr(maxConsecErrs)+'...', progressPos);

    i := 0;
    while i < errorBackoffTime do
    begin
      CheckCancelFlag;
      Sleep(500);
      i := i + 500;
    end;
    errorBackoffTime := errorBackoffTime + timeoutsOrNil.errorBackoffTimeMs;
    Result := false;
  end;

  procedure MadeProgress;
  begin
    errorBackoffTime := timeoutsOrNil.initialErrorRecoverTimeMs;
    errorCountSinceProgress := 0;
    destCreateDisposition := OPEN_EXISTING;
    if IsDestRemote then
      progressPos := goodDestPos * 100 div fileSize
    else
      progressPos := destPos * 100 div fileSize;
    Progress('Copying data...',progressPos);
  end;

begin
  Result := false;

  if timeoutsOrNil = nil then
    timeoutsOrNil := @DefTimeouts;
  if timeoutsOrNil.transferChunkSize > MAX_BUFF_SIZE then
    timeoutsOrNil.transferChunkSize := MAX_BUFF_SIZE;

  if not GetFileSize(SrcPath, fileSize) then
  begin
    resultString := 'Failed,Could not read file size of '+SrcPath;
    Exit;
  end;

  if FileExists(DestPath) then
  begin
    // Figure out whether to overwrite (and whether to backup)
    case OverwriteMode of
      owmDontOverwrite:
        begin
          resultString := 'Skipped,Destination file already present';
          Exit;
        end;

      owmOverwriteIfSizeDifferentBackup,
      owmOverwriteIfSizeDifferent:
        begin
          if not GetFileSize(DestPath, destFileSize) then
          begin
            resultString := 'Failed,Could not read size of destination file';
            Exit;
          end;
          if destFileSize = fileSize then
          begin
            resultString := 'Skipped,Destination file is same size as source ('+IntToStr(destFileSize)+' bytes)';
            Exit;
          end;
        end;

      owmOverwriteIfNewer,
      owmOverwriteIfNewerBackup:
        begin
          if not SourceFileIsNewerThanDestinationFile(SrcPath, DestPath) then
          begin
            resultString := 'Skipped,Source file is not newer than destination file';
            Exit;
          end;
        end;
    end;

    if OverwriteMode in [owmOverwriteIfNewerBackup,owmAlwaysOverwriteBackup,owmOverwriteIfSizeDifferentBackup] then
    begin
      if not RenameFile(DestPath, DestPath + '.old') then
      begin
        resultString := 'Failed,Could not backup destination file to '+DestPath + '.old: '+SysErrorMessage(GetLastError);       Exit;
      end;
    end;
  end;

  // Now perform the actual copy
  IsSrcRemote := IsRemotePath(SrcPath);
  IsDestRemote := IsRemotePath(DestPath);

  Progress('Opening files...',0);
  progressPos := 0;
  destCreateDisposition := CREATE_ALWAYS;
  SrcFile := INVALID_HANDLE_VALUE;
  haveOpenedSrc := false;
  DestFile := INVALID_HANDLE_VALUE;
  haveOpenedDest := false;
  srcPos := 0;
  destPos := 0;
  goodDestPos := 0;
  totalErrorCount := 0;
  errorBackoffTime := timeoutsOrNil.initialErrorRecoverTimeMs;
  errorCountSinceProgress := 0;
  haveBufferData := false;
  inputEof := false;

  try
    try
      repeat
        CheckCancelFlag;

        // Open source file
        while SrcFile = INVALID_HANDLE_VALUE do
        begin
          SrcFile := CreateFile(
            PChar(SrcPath),GENERIC_READ,FILE_SHARE_READ,
            nil,OPEN_EXISTING,FILE_FLAG_SEQUENTIAL_SCAN,0);

          if SrcFile = INVALID_HANDLE_VALUE then
          begin
            errCode := GetLastError;
            if IncErrorCountsExceeded(errCode, IsSrcRemote, haveOpenedSrc, 'Failed,Could not open source file') then
              Exit;
          end
          else
          begin
            // Opened file OK - move to the right position in the file
            if not SetFilePointer(SrcFile, srcPos) then
            begin
              errCode := GetLastError;
              CloseHandle(SrcFile);
              SrcFile := INVALID_HANDLE_VALUE;
              if IncErrorCountsExceeded(errCode, IsSrcRemote, haveOpenedSrc, 'Failed,Could not set source position') then
                Exit;
            end
            else
            begin
             haveOpenedSrc := true;
            end;
          end;
        end;

        // Open dest file
        while DestFile = INVALID_HANDLE_VALUE do
        begin
          DestFile := CreateFile(
            PChar(DestPath),GENERIC_READ or GENERIC_WRITE,0,
            nil,destCreateDisposition,FILE_ATTRIBUTE_NORMAL or FILE_FLAG_WRITE_THROUGH or FILE_FLAG_SEQUENTIAL_SCAN,0);

          if DestFile = INVALID_HANDLE_VALUE then
          begin
            errCode := GetLastError;
            if IncErrorCountsExceeded(errCode, IsDestRemote, haveOpenedDest, 'Failed,Could not to open dest file') then
              Exit;
          end
          else
          begin
            // Reposition dest pointer at the last checkpoint
            activity := 'get dest file size';
            ok := GetFileSize(DestFile, destFileSize);
            if ok then begin
              activity := 'position dest file';
              ok := SetFilePointer(DestFile, goodDestPos);
            end;
            if ok then begin
              activity := 'truncate dest file';
              ok := SetEndOfFile(DestFile);
            end;
            if not ok then
            begin
              errCode := GetLastError;
              CloseHandle(DestFile);
              DestFile := INVALID_HANDLE_VALUE;
              if IncErrorCountsExceeded(errCode, IsDestRemote, haveOpenedDest, 'Failed, could not '+activity) then
                Exit;
            end
            else
            begin
              haveOpenedDest := true;

              if destFileSize < goodDestPos then
              begin
                resultString := 'Failed,Data lost from dest file '+DestPath+': expected file size '+IntToStr(goodDestPos)+', got '+IntToStr(destFileSize);
                Exit;
              end;

              if destPos <> goodDestPos then
              begin
                destPos := goodDestPos;
                srcPos := destPos;
                haveBufferData := false;
                inputEof := false;

                // Rewind the source file to the right location
                if not SetFilePointer(SrcFile, srcPos) then
                begin
                  errCode := GetLastError;
                  CloseHandle(SrcFile);
                  SrcFile := INVALID_HANDLE_VALUE;
                  if IncErrorCountsExceeded(errCode, IsSrcRemote, haveOpenedSrc, 'Failed,Could not rewind source') then
                    Exit;
                end;
              end;
            end;
          end;
        end;

        CheckCancelFlag;

        // Read some data from the input
        if (not inputEof) and (not haveBufferData) then
        begin
          if ReadFile(SrcFile,buffer,timeoutsOrNil.transferChunkSize,bytesRead,nil) then
          begin
            // Read succeeded
            if bytesRead >0 then
            begin
              srcPos := srcPos + bytesRead;
              haveBufferData := true;
            end
            else
            begin
              inputEof := true;
            end;
          end
          else
          begin
            // Read failed
            errCode := GetLastError;
            CloseHandle(SrcFile);
            SrcFile := INVALID_HANDLE_VALUE;
            if IncErrorCountsExceeded(errCode, IsSrcRemote, true, 'Failed,Error reading source') then
              Exit;
          end;
        end;

        CheckCancelFlag;

        // Write data to the output
        if haveBufferData then
        begin
          if WriteFile(DestFile,buffer,bytesRead,bytesWritten,nil) then
          begin
            // Wrote at least some bytes
            if bytesWritten = 0 then
            begin
              resultString := 'Failed,Invalid return from WriteFile(): wrote 0 bytes, no error to '+DestPath;
              Exit;
            end;

            destPos := destPos + bytesWritten;
            if not IsDestRemote then
              MadeProgress;

            if bytesWritten < bytesRead then
            begin
              // This really shouldn't happen for a file, but we will allow it for now
              Move(buffer[bytesWritten],buffer[0],bytesRead - bytesWritten);
              bytesRead := bytesRead - bytesWritten;
            end
            else
            begin
              haveBufferData := false;
            end;
          end
          else
          begin
            errCode := GetLastError;
            CloseHandle(DestFile);
            DestFile := INVALID_HANDLE_VALUE;
            if IncErrorCountsExceeded(errCode, IsDestRemote, true, 'Failed,Error writing dest') then
              Exit;
          end;
        end;

        // Flush data to dest file
        if ((not haveBufferData) and inputEof) or (IsDestRemote and (destPos - goodDestPos > timeoutsOrNil.maxUnflushedDestBytes)) then
        begin
          if FlushFileBuffers(DestFile) then
          begin
            goodDestPos := destPos;
            MadeProgress;
          end
          else
          begin
            errCode := GetLastError;
            CloseHandle(DestFile);
            DestFile := INVALID_HANDLE_VALUE;
            if IncErrorCountsExceeded(errCode, IsDestRemote, true, 'Failed,Error flushing dest') then
              Exit;
          end;
        end;

      until (not haveBufferData) and inputEof and (goodDestPos = destPos) and (DestFile <> INVALID_HANDLE_VALUE);

    finally
      if SrcFile <> INVALID_HANDLE_VALUE then
        CloseHandle(SrcFile);
      if DestFile <> INVALID_HANDLE_VALUE then
        CloseHandle(DestFile);
    end;
  except
    on EAbort do
    begin
      resultString := 'Cancelled,After '+IntToStr(totalErrorCount)+' errors';
      Result := false;
      Exit;
    end;
  end;

  resultString := 'Success,'+IntToStr(totalErrorCount)+' transient errors';
  Progress('Copy complete',100);

  Result := true;
end;

end.
