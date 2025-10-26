unit uDiagnosticlog;


interface

  type TDiagnosticLog = class(TObject)
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
  diagLog: TDiagnosticLog;

implementation


uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, useful, uZip32;

Procedure TDiagnosticLog.SetUser(username:string);
begin
  diagLog.User := UserName;
end;

Procedure TDiagnosticLog.SetModule(modulename:string);
begin
  diagLog.module:=modulename;
end;

Procedure TDiagnosticLog.setup(PrivateDirectory,FilePrefix:string;nobackups,backupatsize:integer);
begin
  if (length(PrivateDirectory) > 0) and (not ((PrivateDirectory[length(PrivateDirectory)])='\')) then
    PrivateDirectory:=PrivateDirectory+'\';
  diagLog.PrivDir:= ExtractFilePath(Application.ExeName) + PrivateDirectory;
  diagLog.Prefix:=FilePrefix;
  diagLog.backups:=nobackups;
  diagLog.size:=backupatsize;
end;

procedure TDiagnosticLog.Event(tolog:string);
var
  FileSize: integer;
  LogFile: textfile;
  ActFileName, LogDir: string;
  ToArchive: TStringList;
begin
  try
    // set a few of the settings
    logdir:= diagLog.PrivDir;

    if not DirectoryExists(LogDir) then               // CC - 21/01/02
      ForceDirectories(RemoveTrailingSlash(LogDir));  // fix err message on setup...

    // assign the file
    ActFileName := LogDir + diagLog.Prefix + '.log';
    AssignFile(LogFile, ActFileName);

    if FileExists(ActFileName) then
      Append(LogFile)
    else
      ReWrite(LogFile);

    // remove returns
//    ToLog := StringReplace(ToLog, #13, ' ', [rfReplaceAll]);
//    ToLog := StringReplace(ToLog, #10, ' ', [rfReplaceAll]);

    if diagLog.module = '' then
      WriteLn(LogFile, DateToStr(Now) + ';' + TimeToStr(Now) + ';' + diagLog.User +
              ';' + ToLog)
    else
      WriteLn(LogFile, DateToStr(Now) + ';' + TimeToStr(Now) + ';' + diagLog.User +
              ';' + diagLog.Module + ';' + ToLog);

    Flush(LogFile);
    CloseFile(LogFile);

    FileSize := GetSizeOfFile(ActFileName);
    if FileSize >= (diagLog.Size * 1024) then
    begin
      ToArchive := TStringList.Create;
      ToArchive.Add(ActFileName);
      ArchiveFiles(ToArchive, LogDir + diagLog.Prefix + '.zip', nil);
      DoRipple(Logdir + diagLog.Prefix + '.zip', (diagLog.Size), diagLog.Backups);;
      DeleteFile(ActFileName);
      ToArchive.Free;
    end;
  except
    ShowMessage('Cannot access log');
  end;
end;

initialization
diagLog := TDiagnosticLog.create;

finalization
diagLog.free;
end.
