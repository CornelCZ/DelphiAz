unit uBandParser;

interface

uses Classes, SysUtils, ADODB, uADO;


function ParseBands(BandList: string; out ExplodedList: TStringList; MatrixID: Integer): Boolean;
function ValidBandNameForMatrix(BandID: string; MatrixID: Integer): Boolean;
function ValidBandNameForSite(BandID: string; SiteID: Integer): Boolean;


implementation

function TranslatedBandNameForSite(BandID: string; SiteID: Integer): String;
begin
  with TADOQuery.Create(nil) do
  try
    try
      Connection := dmADO.AztecConn;
      SQL.Append('Select Band from PriceBandNames pbn ' +
                 'join SiteMatrix sm ' +
                 'on sm.CurrentMatrix = pbn.MatrixID ' +
                 'where pbn.DisplayName = ' + Quotedstr(BandID) + ' ' +
                 'and sm.SiteCode = ' + IntToStr(SiteID));
      Prepared := TRUE;
      Open;
      if RecordCount > 0 then
        TranslatedBandNameForSite := Fields[0].AsString
      else
        TranslatedBandNameForSite := Trim(BandID);
    except
      TranslatedBandNameForSite := BandID;
    end;
  finally
    Free;
  end;
end;

function TranslatedBandNameForMatrix(BandID: string; MatrixID: Integer): String;
begin
  with TADOQuery.Create(nil) do
  try
    try
      Connection := dmADO.AztecConn;
      SQL.Text := Format(
        'SELECT Band from PriceBandNames WHERE Displayname = ''%s'' AND MatrixID = %d',
        [Trim(BandID), MatrixID]);
      Prepared := TRUE;
      Open;
      if RecordCount > 0 then
        Result := Fields[0].AsString
      else
        Result := Trim(BandID);
    except
      Result := BandID;
    end;
  finally
    Free;
  end;
end;

function ValidBandNameForSite(BandID: string; SiteID: Integer): Boolean;
var
  BandName:string;
begin
  BandName := TranslatedBandNameForSite(BandID, SiteID);

  case Length(BandName) of
  1: if BandName[1] in ['A'..'Z'] then
       Result := True
     else
       Result := False;
  2: if (BandName[1] in ['A'..'Z']) and
       (BandName[2] in ['A'..'Z']) then
       Result := True
     else
       Result := False;
  else
    Result := False;
  end;
end;

function ValidBandNameForMatrix(BandID: string; MatrixID: Integer): Boolean;
var
  BandName:string;
begin
  BandName := TranslatedBandNameForMatrix(BandID, MatrixID);

  case Length(BandName) of
  1: if BandName[1] in ['A'..'Z'] then
       Result := True
     else
       Result := False;
  2: if (BandName[1] in ['A'..'Z']) and
       (BandName[2] in ['A'..'Z']) then
       Result := True
     else
       Result := False;
  else
    Result := False;
  end;
end;

function ValidBandName(BandID: string): Boolean;
begin
  case Length(BandID) of
  1: if BandID[1] in ['A'..'Z'] then
       Result := True
     else
       Result := False;
  2: if (BandID[1] in ['A'..'Z']) and
       (BandID[2] in ['A'..'Z']) then
       Result := True
     else
       Result := False;
  else
    Result := False;
  end;
end;

function IsLessThan(ID1, ID2: string): Boolean;
begin
  if Length(ID1) = Length(ID2) then
    Result := ID1 <= ID2
  else
    Result := Length(ID1) < Length(ID2);
end;

//Normal Delphi stringlist parsing treats spaces as delimiters so use this custom version.
procedure ParseDelimited(const sl : TStrings; const value : string; const delimiter : string) ;
var
  delimiterPos : integer;
  nextString : string;
  txt : string;
  delta : integer;
begin
  delta := Length(delimiter) ;
  txt := value + delimiter;
  sl.BeginUpdate;
  sl.Clear;
  try
    while Length(txt) > 0 do
    begin
      DelimiterPos := Pos(delimiter, txt) ;
      NextString := Copy(txt,0,delimiterPos-1) ;
      sl.Add(nextString) ;
      txt := Copy(txt,delimiterPos+delta,MaxInt) ;
    end;
  finally
    sl.EndUpdate;
  end;
end;

procedure Increment(var AID: string);
begin
  if Length(AID) = 1 then
  begin
    if AID = 'Z' then
      AID := 'AA'
    else
      AID := chr(Ord(AID[1]) + 1);
  end
  else
  begin
    if Copy(AID, 2, 1) = 'Z' then
      AID := chr(Ord(AID[1]) + 1) + 'A'
    else
      AID := Copy(AID, 1, 1) + chr(Ord(AID[2]) + 1);
  end;
end;

//Returns the expanded range of bands from the given start and end band e.g. ('A', 'D') => 'A,B,C,D'
procedure ExpandRange(band1, band2: string; var targetList: TStringList);
var tempBand: string;
begin
  if not IsLessThan(band1, band2) then
  begin
    tempBand := band1;
    band1 := band2;
    band2 := tempBand;
  end;

  targetList.Add(band1);
  if band1 <> band2 then
  begin
    Increment(band1);

    while band1 <> band2 do
    begin
      targetList.Add(band1);
      Increment(band1);
    end;

    targetList.Add(band2);
  end;
end;

function SortProc(List: TStringList; Index1,
  Index2: Integer): Integer;
var
  ID1, ID2: string;
begin
  ID1 := List.Strings[Index1];
  ID2 := List.Strings[Index2];

  if Length(ID1) = Length(ID2) then
  begin
    if ID1 < ID2 then
      Result := -1
    else if ID1 > ID2 then
      Result := 1
    else
      Result := 0;
  end
  else
  begin
    if Length(ID1) < Length(ID2) then
      Result := -1
    else
      Result := 1;
  end;
end;

//This function returns the position (1 = first character) of the xth hypen (counting from left) in the given string.
//Returns 0 if there is no xth hypen.
function HyphenPOS(x: integer; s: string): Integer;
var
  foundCount, i: integer;
begin
  Assert(x > 0, 'Paramater x of HyphenPOS must be > 0');

  Result := 0;
  foundCount := 0;
  i := 1;

  while i < Length(s) do
  begin
    if s[i] = '-' then
    begin
      foundCount := foundCount + 1;
      if foundCount = x then
      begin
        Result := i;
        Break;
      end;
    end;

    i := i + 1;
  end;

end;


function ParseBands(BandList: string; out ExplodedList: TStringList; MatrixID: Integer): Boolean;
var
  BandData: TStringList;
  band, leftBand, rightBand: string;
  hyphenNumber: integer;
  gotBandRange: boolean;
  i, p: integer;
  errorsFound: boolean;
begin
  errorsFound := False;
  ExplodedList.Clear;
  BandList := UpperCase(StringReplace(BandList, '..', '-', [rfReplaceAll]));
  BandData := TStringList.Create;

  try
    ParseDelimited(BandData,BandList,',');

    for i := 0 to BandData.Count - 1 do
    begin
      band := TranslatedBandNameForMatrix(BandData.Strings[i], MatrixID);

      if validBandName(band) then
      begin
        // We have a single band name.
        ExplodedList.Add(band);
      end
      else
      begin
        // We have a band range(leftBand-rightBand), or an invalid expression. Parsing this expression is made difficult by the
        // fact that the leftBand and/or rightBand can contain one or more hypens(-), the same character used to
        // separate them! The algorithm used to find the leftBand and rightBand is take each hypen in turn, working
        // from the left, and stop once the strings to the left and right are both either a valid band (e.g. 'A', 'Z', 'AA', 'AZ')
        // or one of the band names entered by the user.
        gotBandRange := False;
        hyphenNumber := 1;
        repeat
           p := hyphenPOS(hyphenNumber, BandData.Strings[i]);

           if p <> 0 then
           begin
             leftBand := TranslatedBandNameForMatrix(Copy(BandData.Strings[i], 1, p - 1), MatrixID);
             rightBand := TranslatedBandNameForMatrix(Copy(BandData.Strings[i], p+1, Length(BandData.Strings[i]) - p), MatrixID);

             if ValidBandName(leftBand) and ValidBandName(rightBand) then
             begin
               gotBandRange := True;
               ExpandRange(leftBand, rightBand, ExplodedList);
             end
             else
             begin
               hyphenNumber := hyphenNumber + 1;
             end;
           end;
        until (p = 0) or gotBandRange;

        if not(gotBandRange) then
        begin
          errorsFound := True;
          Break
        end;
      end;
    end;

    if errorsFound then
      ExplodedList.Clear
    else
      ExplodedList.CustomSort(SortProc);
  finally
    BandData.Free;
  end;

  Result := not(errorsFound);
end;

end.
