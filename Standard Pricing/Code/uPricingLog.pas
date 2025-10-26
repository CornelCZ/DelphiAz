unit uPricingLog;


interface

  type TLog = class(TObject)
  private
    PrivDir, Prefix: string;
    Backups, Size: integer;
  public
    procedure Setup(PrivateDirectory, FilePrefix: string; NoBackups, BackupAtSize: integer);
    procedure Event(ModuleName, ToLog: string);
  end;

var
  Log: TLog;

implementation


uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, useful, uZip32, uGlobals;

Procedure Tlog.Setup(PrivateDirectory, FilePrefix: string; NoBackups, BackupAtSize: integer);
begin
  if (length(PrivateDirectory) > 0) and (not ((PrivateDirectory[length(PrivateDirectory)])='\')) then
    PrivateDirectory := PrivateDirectory + '\';

  PrivDir := ExtractFilePath(Application.ExeName) + PrivateDirectory;
  Prefix := FilePrefix;
  Backups := NoBackups;
  Size := BackupAtSize;
end;

procedure Tlog.Event(ModuleName, ToLog: string);
var
  FileSize: integer;
  LogFile: textfile;
  ActFileName, LogDir: string;
  ToArchive: TStringList;
begin
  try
    // set a few of the settings
    logdir:= log.PrivDir;

    if not DirectoryExists(LogDir) then               // CC - 21/01/02
      ForceDirectories(RemoveTrailingSlash(LogDir));  // fix err message on setup...

    // assign the file
    ActFileName := LogDir + Log.Prefix + '.log';
    AssignFile(LogFile, ActFileName);

    if FileExists(ActFileName) then
      Append(LogFile)
    else
      ReWrite(LogFile);

    // remove returns
    ToLog := StringReplace(ToLog, #13, ' ', [rfReplaceAll]);
    ToLog := StringReplace(ToLog, #10, ' ', [rfReplaceAll]);

    WriteLn(LogFile, DateToStr(Now) + ';' + TimeToStr(Now) + ';' + CurrentUser.UserName +
      ';' + ModuleName + ';' + ToLog);

    Flush(LogFile);
    CloseFile(LogFile);

    FileSize := GetSizeOfFile(ActFileName);
    if FileSize >= (Log.Size * 1024) then
    begin
      ToArchive := TStringList.Create;
      ToArchive.Add(ActFileName);
      ArchiveFiles(ToArchive, LogDir + Log.Prefix + '.zip', nil);
      DoRipple(Logdir + Log.Prefix + '.zip', (Log.Size), Log.Backups);
      DeleteFile(ActFileName);
      ToArchive.Free;
    end;
  except
    ShowMessage('Cannot access log');
  end;
end;

initialization

Log := Tlog.Create;

finalization

Log.Free;

end.
 