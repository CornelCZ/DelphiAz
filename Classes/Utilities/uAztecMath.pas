unit uAztecMath;

interface

uses Contnrs;

type
  TInteger = class(TObject)
    Value: Integer;
    constructor create (const Value : integer);
  end;

  TFloat = class(TObject)
    Value: real;
    constructor create (const Value : real);
  end;

  TLargeInt = class(TObject)
    Value: Int64;
    constructor create (const Value : Int64);
  end;


  TIntegerList = class(TObjectList)
  protected
    function GetItem(Index: Integer): Integer;
  public
    function Add(AValue: Integer): Integer;
    property Items[Index: Integer]: Integer read GetItem; default;
    function AsCommaDelimitedString : string;
  end;

  TLargeIntList = class(TObjectList)
  protected
    function GetItem(Index: Integer): Int64;
  public
    function Add(AValue: Int64): Integer;
    property Items[Index: Integer]: Int64 read GetItem; default;
  end;

implementation

uses SysUtils;

{ TInteger }

constructor TInteger.Create(const Value : integer);
begin
  inherited Create;
  self.Value := Value;
end;

{ TFloat }

constructor TFloat.Create(const Value : real);
begin
  inherited Create;
  self.Value := Value;
end;

{ TLargeInt }

constructor TLargeInt.Create(const Value : Int64);
begin
  inherited Create;
  self.Value := Value;
end;

{ TIntegerList }

function TIntegerList.GetItem(Index: Integer): Integer;
begin
  Result := TInteger(inherited Items[Index]).Value;
end;

function TIntegerList.Add(AValue: Integer): Integer;
begin
  Result := inherited Add(TInteger.Create(AValue));
end;

function TIntegerList.AsCommaDelimitedString : string;
var i : integer;
begin
  Result := '';

  for i := 0 to Count-1 do
  begin
    if i <> 0 then Result := Result + ',';
    Result := Result + IntToStr(Items[i]);
  end;
end;

{ TLargeIntList }

function TLargeIntList.GetItem(Index: Integer): Int64;
begin
  Result := TLargeInt(inherited Items[Index]).Value;
end;

function TLargeIntList.Add(AValue: Int64): Integer;
begin
  Result := inherited Add(TLargeInt.Create(AValue));
end;

end.
