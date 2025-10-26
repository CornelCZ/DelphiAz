unit ulog;


interface

  type TLog = class(TObject)
    private
      module:string;
      user:String;
      PrivDir:string;
      Prefix:string;
      backups:integer;
      size:integer;
    public
      procedure setup(PrivateDirectory,FilePrefix:string;nobackups,backupatsize:integer);
      procedure Event(tolog:string);
      procedure Setuser(username:string);
      Procedure SetModule(modulename:string);
    end;

var
  log: TLog;

implementation


uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, useful, uZip32;

Procedure TLog.SetUser(username:string);
begin
  Log.User := UserName;
end;

Procedure Tlog.SetModule(modulename:string);
begin
  log.module:=modulename;
end;

Procedure Tlog.setup(PrivateDirectory,FilePrefix:string;nobackups,backupatsize:integer);
begin
  if (length(PrivateDirectory) > 0) and (not ((PrivateDirectory[length(PrivateDirectory)])='\')) then
    PrivateDirectory:=PrivateDirectory+'\';
  log.PrivDir:= ExtractFilePath(Application.ExeName) + PrivateDirectory;
  log.Prefix:=FilePrefix;
  log.backups:=nobackups;
  log.size:=backupatsize;
end;

procedure Tlog.Event(tolog:string);
var
  FileSize: integer;
  LogFile: textfile;
  ActFileName, LogDir: string;
  ToArchive: TStringList;
  LogEntry: String;
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

    if ToLog = '' then
      LogEntry := ''
    else if Log.module = '' then
      LogEntry := DateToStr(Now) + ';' + TimeToStr(Now) + ';' + Log.User + '; ' + ToLog
    else
      LogEntry := DateToStr(Now) + ';' + TimeToStr(Now) + ';' + Log.User + ';' + Log.Module + '; ' + ToLog;

    WriteLn(LogFile, LogEntry);

    Flush(LogFile);
    CloseFile(LogFile);

    FileSize := GetSizeOfFile(ActFileName);
    if FileSize >= (Log.Size * 1024) then
    begin
      ToArchive := TStringList.Create;
      ToArchive.Add(ActFileName);
      ArchiveFiles(ToArchive, LogDir + Log.Prefix + '.zip', nil);
      DoRipple(Logdir + Log.Prefix + '.zip', (Log.Size), Log.Backups);;
      DeleteFile(ActFileName);
      ToArchive.Free;
    end;
  except
    ShowMessage('Cannot access log');
  end;
end;

initialization
log := Tlog.create;

finalization
log.free;
end.
