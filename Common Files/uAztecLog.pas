unit uAztecLog;

interface

uses stdctrls, DB;

procedure InitialiseLog (LogFileName : string);
procedure Log(LogText : string); overload;
procedure Log(Module, LogText : string); overload;
procedure LogDataset(dataset: TDataset; formatString: string; formatParamCount: integer);
procedure ButtonClicked(button : TObject);
procedure SetLogUserName(UserName : String);

implementation

uses uLogFile{$ifdef BH028},uEPosUpgrade{$endif};

var
  LogFile : ILogFile;

procedure InitialiseLog(LogFileName : string);
begin
  LogFile := MakeLogFileInterface (LogFileName);
end;

procedure Log(LogText : string);
begin
try
  {$ifndef BH028}
  LogFile.Write(LogText);
  {$endif}
except
end;
  {$ifdef BH028}
  AddLogMessage(LogText);
  {$endif}
end;

procedure Log(Module, LogText : string);
begin
  Log(Module + ';' + LogText);
end;

procedure LogDataset(dataset: TDataset; formatString: string; formatParamCount: integer);
begin
  LogFile.WriteDataset(dataset, formatString, formatParamCount);
end;

procedure ButtonClicked(button : TObject);
begin
  if Button is TButton then
    Log(TButton(Button).Caption + ' Clicked');
end;

procedure SetLogUserName(UserName : String);
begin
  LogFile.SetLogUserName(UserName);
end;

end.
 