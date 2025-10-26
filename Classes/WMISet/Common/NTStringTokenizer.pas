unit NTStringTokenizer;

interface

Uses Classes;

  type
    TNTStringTokenizer = class
     private
       FString     : String;
       FDelimeters : String;
       FPosition   : integer;
       procedure SetString(const Value: String);
       function GetEndOfString: boolean;
       function GetPreviousDelimiter: Char;
     public
      constructor Create(AString: string; ADelimeters: string = ',');
      function NextToken : string;
      property PreviousDelimiter : Char read GetPreviousDelimiter;
      procedure Reset;
      property Position : integer read FPosition write FPosition;
      procedure AddToken(AToken: string; Delimeter: string = '');
      property FullString : string read FString write SetString;
      property Delimeters : string read FDelimeters write FDelimeters;
      property EndOfString : boolean read GetEndOfString;
      procedure AddToStrings(Strings : TStrings; AddEmptyTokens : boolean = true);
      procedure SkipTokens(Count : integer);
     end;

implementation

{ TNTStringTokenizer }
constructor TNTStringTokenizer.Create(AString, ADelimeters: string);
begin
   inherited Create;
   FString     := aString;
   FDelimeters := aDelimeters;
   FPosition   := 0;
end;

procedure TNTStringTokenizer.AddToken(aToken, Delimeter: string);
begin
  if FString = '' then Delimeter := ''
  else
  if Delimeter = '' then Delimeter := Delimeters[1];
  FString := FString + Delimeter+aToken;
end;

function TNTStringTokenizer.NextToken : string;
var
  i : integer;
begin
  inc(FPosition);
  if FString = '' then
  begin
    result := '';
    exit;
  end;
  for i := FPosition to Length(FString) do
  begin
    if Pos(FString[i],FDelimeters) > 0 then Break;
  end;
  if FPosition < i then
  begin
    result := Copy(FString,FPosition, i-FPosition);
    FPosition := i;
  end
  else
    result := '';
end;

procedure TNTStringTokenizer.SkipTokens(Count: integer);
var
  i: integer;
  vTokenCount: integer;
begin
  vTokenCount := 0;
  inc(FPosition);
  for i := FPosition to Length(FString) do
  begin
    if Pos(FString[i],FDelimeters) > 0 then
    begin
      inc(vTokenCount);
      if vTokenCount >= Count then
        Break;
    end;
  end;
end;

procedure TNTStringTokenizer.Reset;
begin
  FPosition := 0;
end;

procedure TNTStringTokenizer.SetString(const Value: string);
begin
  FString := Value;
  Reset;
end;

function TNTStringTokenizer.GetEndOfString: boolean;
begin
  result := (FString = '') or (FPosition > Length(FString));
end;

function TNTStringTokenizer.GetPreviousDelimiter: Char;
begin
   if (FPosition > 0) and (FPosition <= Length(FString)) and
    (Pos(FString[FPosition],FDelimeters)>0) then
   result := FString[FPosition]
   else
   result := Char(0);
end;

procedure TNTStringTokenizer.AddToStrings(Strings: TStrings;
                    AddEmptyTokens : boolean = true);
var
  vToken : string;
begin
  Strings.BeginUpdate;
  try
    while not EndOfString do
    begin
     vToken := NextToken;
     if AddEmptyTokens or (vToken <> '') then
       Strings.Add(vToken);
    end;
  finally
    Strings.EndUpdate;
  end;    
end;


end.
