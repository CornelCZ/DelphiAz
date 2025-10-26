unit uAztecStringUtils;

interface

uses Classes, StdCtrls, Controls;

// Find the nth position of a sub string in a string.
function FindNthPosition(ASource, ASubString: string; const AOccurance: integer): integer;

// Return a block of XML up to a specified point, removing the block from
// the source string.
function GetClosedXMLTag(Var ASource: string; const AXMLTag: string; const ANoOfTransactions: integer): string;

// Make sure the given directory path has a backslash character at the end
function EnsureTrailingSlash(path: string): string;

function EscapeJsonParam(s: string): string;

// Parse delimited list into a TStrings
procedure SeparateList(AList: string; ASeparator: char; out AOutput: TStrings);

procedure PreventInvalidCharacters(Sender: TCustomEdit; InvalidCharacters: Array of String);

// Returns TRUE if the given string is a valid date in dd/mm/yyyy format. As a side-effect
// the corresponding TDate value is returned in the out parameter.
function IsValidUKDateStr(const DateStr : string; out DateValue: TDate): boolean; overload;

// Returns TRUE if the given string is a valid date in dd/mm/yyyy format.
function IsValidUKDateStr(const DateStr : string): boolean; overload;

// Returns the TDate value corresponding to the date in the given string which must be in
// dd/mm/yyyy format. If DateStr is not a valid date an exception is raised.
function StrToDateUK (const DateStr : string): TDate;

function GetCommaSeparatedValues(s: string): TStringList;

implementation

uses
  SysUtils, StrUtils;

function FindNthPosition(ASource, ASubString: string; const AOccurance: integer): integer;
var
  i          : integer;
  CurrentPos : integer;
begin
  i      := 0;
  Result := 0;

  while i < AOccurance do
  begin
    CurrentPos := pos(lowercase(ASubString),lowercase(ASource));

    Result := Result + CurrentPos;
    Delete(ASource, 1, CurrentPos);

    inc(i);
  end;
end;

function GetClosedXMLTag(Var ASource: string; const AXMLTag: string; const ANoOfTransactions: integer): string;
var
  ClosingTagPosition: integer;
begin
  ClosingTagPosition := FindNthPosition(ASource, AXMLtag, ANoOfTransactions);

  if ClosingTagPosition > 0 then
    ClosingTagPosition := ClosingTagPosition + Length(AXMLTag) - 1;

  Result := Copy(ASource, 1, ClosingTagPosition);
  Delete(ASource, 1, ClosingTagPosition);
end;

function EnsureTrailingSlash(path: string): string;
begin
  if (path <> '') and (path[length(path)] <> '\') then
    result := path + '\'
  else
    result := path;
end;

procedure SeparateList(AList: string; ASeparator: char; out AOutput: TStrings);
// parse delimited list into a TStrings
var
  scanpos, nextpos: integer;
begin
  scanpos :=1;
  while scanpos <= length(AList) do
  begin
    nextpos := pos(ASeparator, copy(AList, scanpos, length(AList)));
    if nextpos = 0 then
      nextpos := length(AList)+1;
    AOutput.Add(copy(AList, scanpos, pred(nextpos)));
    scanpos := scanpos + nextpos;
  end;
end;

procedure PreventInvalidCharacters(Sender: TCustomEdit; InvalidCharacters: Array of String);
var
  Index, EditPosition, OriginalLength: Integer;
begin
  for Index := Low(InvalidCharacters) to High(InvalidCharacters) do
  begin
    if Pos(InvalidCharacters[Index], Sender.Text) > 0 then
    begin
      OriginalLength := Length(Sender.Text);
      EditPosition := Sender.SelStart;
      Sender.Undo;
      Sender.SelStart := EditPosition - OriginalLength + Length(Sender.Text);

      break;
    end;
  end;

  Sender.ClearUndo;
end;

function IsValidUKDateStr(const DateStr : string; out DateValue: TDate): boolean; overload;
begin
  ShortDateFormat := 'dd/mm/yyyy';
  try
    DateValue := StrToDate(DateStr);
    Result := TRUE;
  except
    on ECOnvertError do
      Result := FALSE;
  end;
end;

function IsValidUKDateStr(const DateStr : string): boolean; overload;
var d: TDate;
begin
  Result := IsValidUKDateStr(DateStr, d);
end;

function StrToDateUK (const DateStr : string): TDate;
begin
  if not IsValidUKDateStr(DateStr, Result) then
    raise Exception.Create(DateStr + ' is not a valid dd/mm/yyyyy format date');
end;

function GetCommaSeparatedValues(s: string): TStringList;
var commaIndex: integer;
begin
  Result := TStringList.Create;

  if length(trim(s)) = 0 then
    exit;

  while true do
  begin
    commaIndex := Pos(',', s);
    if commaIndex > 0 then
    begin
       Result.Add(AnsiReplaceStr(trim(copy(s, 0, commaIndex-1)), '"', '')); //Remove spaces and double quotes.
       s := copy(s, commaIndex+1, length(s) - commaIndex);
    end
    else
    begin
      Result.Add(AnsiReplaceStr(trim(s), '"', ''));
      break;
    end;
  end;
end;

function EscapeJsonParam(s: string): string;
begin
  Result := StringReplace(s,'"','\"', [rfReplaceAll]);
end;

end.

