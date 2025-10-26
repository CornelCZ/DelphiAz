unit uFutureDate;

interface

uses
  Classes, Sysutils;

const
  CURRENT_ITEM = 'Current';

type
  TAztecDateWrapper = class(TObject)
    private
      FDate: TDateTime;
    public
      constructor Create(Date: TDateTime);
      destructor Destroy; override;
      function GetAsISODateFormat: String;
       property Date: TDateTime read FDate write FDate;
      property AsISODateFormat: String read GetAsISODateFormat;
  end;

  TAztecDateList = class(TObject)
    private
      FDateList: TStringList;
      FFormatString: String;
      function GetText: String;
      function GetAztecDate(Index: Integer): TAztecDateWrapper;
      function GetAztecDisplayDate(Index: Integer): String;
      function Find(TargetDate: TDateTime;
        var InsertionPoint: Integer): Boolean;
    public
      constructor Create(DateFormatStr: String);
      destructor Destroy; override;
      function AddDate(NewDate: TDateTime;
        out InsertionPoint: Integer): Boolean;
      procedure Clear;
      property Text: String read GetText;
      property AztecDisplayDate[Index: Integer]: String read GetAztecDisplayDate;
      property AztecDate[Index: Integer]: TAztecDateWrapper read GetAztecDate; default;
  end;

implementation


{ TAztecDateWrapper }
constructor TAztecDateWrapper.Create(Date: TDateTime);
begin
  inherited Create;
  FDate := Date;
end;

destructor TAztecDateWrapper.Destroy;
begin
  inherited;
end;

function TAztecDateWrapper.GetAsISODateFormat: String;
begin
  Result := FormatDateTime('yyyymmdd',FDate);
end;

{ TAztecDateList }
function TAztecDateList.AddDate(NewDate: TDateTime;
  out InsertionPoint: Integer): Boolean;
var
  DateWrapper: TAztecDateWrapper;
  InsertionIndex: Integer;
begin
  DateWrapper := TAztecDateWrapper.Create(NewDate);

  Result := False;
  if not Find(NewDate, InsertionIndex) then
  begin
    FDateList.InsertObject(InsertionIndex,FormatDateTime(FFormatString,NewDate),
      DateWrapper);
    InsertionPoint := InsertionIndex;
    Result := True;
  end;
end;

procedure TAztecDateList.Clear;
var
  Index: Integer;
begin
  for Index := 0 to FDateList.Count - 1 do
  begin
    FDateList.Objects[index].Free;                        
  end;
  FDateList.Clear;
end;

constructor TAztecDateList.Create(DateFormatStr: String);
begin
  inherited Create;
  FFormatString := DateFormatStr;
  FDateList := TStringList.Create;
  FDateList.Sorted := False;
end;

destructor TAztecDateList.Destroy;
begin
  FDateList.Free;
  inherited;
end;

function TAztecDateList.Find(TargetDate: TDateTime;
  var InsertionPoint: Integer): Boolean;

  function CompareDates(Date1,Date2: TDateTime): Integer;
  begin
    if Date1 > Date2 then
      Result := 1
    else if Date1 < Date2 then
      Result := -1
    else
      Result := 0;
  end;

var
  x,y,z: Integer;
  ComparisonResult: Integer;
begin
  Result:= False;
  InsertionPoint:= -1;

  x:= 0;
  y:= FDateList.Count - 1;

  while( x <= y) do // x = y when found; x > y if not found
  begin
    z:= (y + x) shr 1; // Get the mid-point

    ComparisonResult := CompareDates( GetAztecDate(z).Date,
                                      TargetDate);
    if( ComparisonResult < 0) then // Search upper half
    begin
      x := z + 1;
    end
    else begin// Search lower half
      y := z - 1;
      if( ComparisonResult = 0) then // jackpot
        Result := True;
    end;
  end;
  InsertionPoint := x;
end;

function TAztecDateList.GetAztecDate(Index: Integer): TAztecDateWrapper;
begin
  Result := nil;
  if (Index >= 0) and (Index <= FDateList.Count - 1) then
    Result := TAztecDateWrapper(FDateList.Objects[Index]);
end;

function TAztecDateList.GetAztecDisplayDate(Index: Integer): String;
var
  AztecDateWrapper: TAztecDateWrapper;
begin
  Result := '';
  AztecDateWrapper := GetAztecDate(Index);
  if Assigned(AztecDateWrapper) then
    Result := FormatDateTime(FFormatString,AztecDateWrapper.Date);
end;

function TAztecDateList.GetText: String;
begin
  Result := FDateList.Text;
end;

end.
