unit uWidestringUtils;

interface

uses sysutils, classes;

procedure WriteWidestringToFile(const input: widestring; const filename: string);
function ReadWidestringFromFile(const filename:string): widestring;

implementation

function min(vala, valb: integer): integer;
begin
  if vala < valb then
    result := vala
  else
    result := valb;
end;

procedure WriteWidestringToFile(const input: widestring; const filename: string);
var
  i: integer;
  charswritten, charstowrite: integer;
  pc : pwidechar;
  buffer: array[0..4095] of widechar;
begin
  with TFileStream.create(filename, fmCreate) do try
    // write unicode header
    writebuffer(#255#254, 2);
    charswritten := 0;
    while charswritten < length(input) do
    begin
      charstowrite := min(4096, (length(input) - charswritten));
      pc := @(input[charswritten+1]);
      for i := 0 to pred(charstowrite) do
        buffer[i] := pc[i];
      writebuffer(buffer, charstowrite * 2);
      inc(charswritten, charstowrite);
    end;
  finally
    free;
  end;
end;

function ReadWidestringFromFile(const filename:string): widestring;
var
  wb: widechar;
  i: integer;
  charsread, charstoread: integer;
  pc : pwidechar;
  buffer: array[0..4095] of widechar;
  outputsize: integer;
begin
  with TFileStream.create(filename, fmOpenRead) do try
    // read (potential) unicode header  - assumes file has more than 2 bytes in it
    readbuffer(wb, 2);
    // if we don't detect the #255#254 header, seek to start of stream to
    // prevent stripping of characters we want to keep
    if ord(wb) <> 65279 then
    begin
      seek(0, soFromBeginning);
      outputsize := size div 2;
    end
    else
      outputsize := (size-2) div 2;
    setlength(result, outputsize);

    charsread := 0;
    while charsread < outputsize do
    begin
      charstoread := min(4096, (outputsize - charsread));
      readbuffer(buffer, charstoread * 2);
      pc := @(result[charsread+1]);
      for i := 0 to pred(charstoread) do
        pc[i] := buffer[i];

      inc(charsread, charstoread);
    end;
  finally
    free;
  end;
end;

end.


