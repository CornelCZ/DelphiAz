Unit ULogFile;

interface

uses DB;

type
  ILogFile = interface
    function   Write   (const DataString : String) : Boolean;
    procedure  WriteDataset(dataset: TDataset; formatString: string; formatParamCount: integer);
    function   Delete  : Boolean;
    procedure  SetLogUserName(UserName : String);
  end;

function MakeLogFileInterface(const FileName : String;
                              const DeleteIfExists : Boolean = FALSE;
                              const FileCreationText : string = 'Log File Created';
                              const IncludeTimeStamp : boolean = TRUE) : ILogFile;

implementation

uses
  SysUtils, Windows, Dialogs;

Type
  TLogFile = class (TInterfacedObject, ILogFile)
    constructor Create (const FileName   : string; DeleteIfExists : Boolean;
                        const FileCreationText : string; const IncludeTimeStamp : boolean );
    function Write  (const DataString : string) : Boolean;
    procedure WriteDataset(dataset: TDataset; formatString: string; formatParamCount: integer);
    function Delete  : Boolean;
    procedure SetLogUserName(UserName : string);
  private
    FFileName : String;
    FIncludeTimeStamp : Boolean;
    FIncludeUserName : Boolean;
    FUserName : String;
  end;

// Interface Calls

Function MakeLogFileInterface (const FileName : String;
                               const DeleteIfExists : Boolean = FALSE;
                               const FileCreationText : string = 'Log File Created';
                               const IncludeTimeStamp : boolean = TRUE) : ILogFile;
// Instantiates an ILogFile Object
begin
  Result := TLogFile.Create(FileName, DeleteIfExists, FileCreationText, IncludeTimeStamp);
end;

// TLogFile

constructor TLogFile.Create( const FileName   : string; DeleteIfExists : Boolean;
                             const FileCreationText : string;
                             const IncludeTimeStamp : boolean );
// Creates A Log File, If The Log File Exists, It Leaves It Alone
var
  LogFile: TextFile;
begin
  FFileName := FileName;
  FIncludeTimeStamp := IncludeTimeStamp;
  FIncludeUserName := FALSE;

  if DeleteIfExists and FileExists(FFileName) then
  try
    Delete;
  except on EInOutError do
  end;

  if not FileExists(FFileName) then
  begin
    ForceDirectories(ExtractFileDir(FileName));
    AssignFile(LogFile, FFileName);
    Rewrite(LogFile);
    CloseFile(LogFile);

    Write(FileCreationText);
  end;
end;

function TLogFile.Write;
// Writes Data To The Log File, Prefixed With The Date And Time Of The Event
var
  LogFile : TextFile;
begin
  Result := TRUE;
  Try
    AssignFile (LogFile, FFileName);

    if FileExists (FFileName) then
      Append(LogFile)
    else
      ReWrite(LogFile);

    if FIncludeTimeStamp then
    begin
      if FIncludeUserName then
        WriteLn(LogFile, FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' ' + FUserName + ' - ' + DataString)
      else
        WriteLn(LogFile, FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' - ' + DataString);
    end
    else
    begin
      if FIncludeUserName then
        WriteLn(LogFile, '; ' + FUserName + ' - ' + DataString)
      else
        WriteLn(LogFile, DataString);
    end;

    Flush(LogFile);
    CloseFile(LogFile);
  except On EInOutError Do
    Result := FALSE;
  end;
end;


procedure TlogFile.WriteDataset(dataset: TDataset; formatString: string; formatParamCount: integer);
var
  LogFile : TextFile;
  args: array of TVarRec;
  argStrings: array of AnsiString;
  i: integer;
begin
  if dataset.IsEmpty then
    Exit;

  SetLength(args, formatParamCount);
  SetLength(argStrings, formatParamCount);

  AssignFile (LogFile, FFileName);
  if FileExists (FFileName) then
    Append(LogFile)
  else
    ReWrite(LogFile);

  try
    with dataset do
    begin
      First;
      while not(Eof) do
      begin
        for i := 0 to formatParamCount - 1 do
        begin
          argStrings[i] := Fields[i].AsString;
          args[i].VType :=  vtAnsiString;
          args[i].VAnsiString := PAnsiString(argStrings[i]);
        end;

        writeLn(LogFile, FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' - ' + format(formatString, args));

        Next;
      end;
    end;
  finally
    Flush(LogFile);
    CloseFile(LogFile);
  end;

end;


function TLogFile.Delete;
// Deletes The Log File When It No Longer Required
begin
  try
    Result := SysUtils.DeleteFile ( FFileName );
  except
    Result := FALSE;
  end;
end;

procedure TLogFile.SetLogUserName(UserName : String);
begin
  if (UserName <> '') then
  begin
    FIncludeUserName := TRUE;
    FUserName := UserName;
  end;
end;

end.
