unit uTextReader;

interface

uses classes;

type

  TTextReader = class(TObject)
  public
    constructor CreateNew(filename: string);
    destructor Destroy; override;
    function AtEOF: boolean;
    function GetNextLine: string;
  private
    FileStream: TFileStream;
    buffer: array[0..1023] of char; // max 1024 characters per line
    startidx, length: integer;
    got_A: boolean; // fix up in case a CRLF spans a block
  end;

implementation

uses sysutils;

{ TTextReader }



constructor TTextReader.CreateNew(filename: string);
begin
  inherited create;
  FileStream := TFileStream.Create(filename, fmOpenRead{ or fmShareExclusive});
  length := 0;
  startidx := 0;
end;

destructor TTextReader.Destroy;
begin
  fileStream.free;
  inherited;
end;

function TTextReader.AtEOF: boolean;
begin
  result := (filestream.Position = filestream.Size);
end;

function TTextReader.GetNextLine: string;
var
  i: integer;
begin
  got_A := false;
  result := '';
  begin
    startidx := 0;
    length := filestream.Read(buffer, 1024)
  end;
  for i := startidx to (startidx + length) do
  begin
    if got_A and (buffer[i] = #10) then
    begin
      filestream.seek(-((startidx + length - 1) - i), soFromCurrent);
      exit;
    end;
    if buffer[i] = #13 then got_A := true;
    if (buffer[i] <> #10) and (buffer[i] <> #13) then
    begin
      result := result + buffer[i];
    end;
  end;
  if not AtEOF then raise exception.create('TTextReader: line length limit of 1024 bytes exceeded');
end;

end.
