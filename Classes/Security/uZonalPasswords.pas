unit uZonalPasswords;

interface

  function ZonalDevPass: String;Overload;
  function ZonalQAPass: String;Overload;
  function ZonalHCPass: String;Overload;

  function ZonalDevPass(ForDate:TDatetime): String;Overload;
  function ZonalQAPass(ForDate:TDatetime): String;Overload;
  function ZonalHCPass(ForDate:TDatetime): String;Overload;

implementation

uses Math, SysUtils;

function MapToString(ANumber: Integer): String;
const
  CharArray: Array [0..9] Of Char = ('E', 'P', 'S', 'B', 'A', 'L', 'O', 'Y', 'E', 'W');
var
  I: integer;
  NumberList: string;
begin
  Result := '';
  NumberList := inttostr(ANumber);

  for I := 1 to Length(NumberList) do
  begin
    Result := Result + CharArray[StrToInt(Copy(NumberList, I, 1))];
  end;
end;

function ZonalDevPass(ForDate:TDateTime):String;
var
  Number: Integer;
begin
  try
    Number := ((Floor(ForDate) * 7) + 56830) * 13;
    Number := Number mod 12590161;

    Result := MapToString(Number);
  except
    Result := '';
  end;
end;

function ZonalQAPass(ForDate:TDateTime):String;
var
  Number: Integer;
begin
  try
    Number := ((Floor(ForDate) * 9) + 55) * 74;
    Number := Number mod 42590861;

    Result := MapToString(Number);
  except
    Result := '';
  end;
end;

function ZonalHCPass(ForDate:TDateTime): String;
var
  Number: integer;
begin
  try
    Number := ((Floor(ForDate) * 13) + 58741) * 49;
    Number := Number mod 92570851;

    Result := MapToString(Number);
  except
    Result := '';
  end;
end;

function ZonalDevPass: string;
begin
  Result:= ZonalDevPass(Date);
end;

function ZonalQAPass: string;
begin
  Result:= ZonalQAPass (Date);
end;

function ZonalHCPass: string;
begin
  Result:= ZonalHCPass (Date);
end;

end.
