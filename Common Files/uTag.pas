unit uTag;

interface

uses
  Classes;

type
  TTagContext = (tcSite, tcProduct);

  TTag = class(TObject)
    private
      FParentTagName: String;
      FTagName: String;
      FTagID: Integer;
    public
      constructor Create(_ParentTagName: String; _TagName: String; _TagID: Integer);
      function Clone: TTag;
      property ParentTagName: String read FParentTagName;
      property TagName: String read FTagName;
      property TagID: Integer read FTagID;
  end;

  TTagList = class(TObject)
    private
      FTags: TList;
      FSorted: Boolean;
      procedure ClearTags;
      function GetTagListCount: Integer;
      function GetTag(Index: Integer): TTag;
      function GetCommaText: String;
    public
      constructor Create; reintroduce;
      destructor Destroy; override;
      procedure AddTag(ParentTagName: String; TagName: String; TagID: Integer);
      procedure Sort;
      procedure Clear;
      function FindTag(TagID: Integer; var ItemIndex: Integer): Boolean;
      function Clone: TTagList;
      property Count: Integer read GetTagListCount;
      property Tag[Index: Integer]: TTag read GetTag; default;
      property CommaText: String read GetCommaText;
  end;



implementation

{ TTag }
function TTag.Clone: TTag;
begin
  Result := TTag.Create(FParentTagName,FTagName,FTagID);
end;

constructor TTag.Create(_ParentTagName: String; _TagName: String; _TagID: Integer);
begin
  inherited Create;

  FParentTagName := _ParentTagName;
  FTagName := _TagName;
  FTagID := _TagID;
end;

{ TTagList }

function CompareTags(Item1, Item2: Pointer): Integer;
var
  Tag1, Tag2: TTag;
begin
  Tag1 := TTag(Item1);
  Tag2 := TTag(Item2);
  if (Tag1.TagID > Tag2.TagID) then result := 1
  else if (Tag1.TagID < Tag2.TagID) then result := -1
  else result := 0;
end;

procedure TTagList.AddTag(ParentTagName: String; TagName: String; TagID: Integer);
begin
  FTags.Add(TTag.Create(ParentTagName, TagName, TagID));
  FSorted := False;
end;

procedure TTagList.Clear;
var
  i: Integer;
begin
  for i := 0 to FTags.Count - 1 do
  begin
    TTag(FTags[i]).Free;
  end;
  FTags.Clear;
end;

procedure TTagList.ClearTags;
var
  i: Integer;
begin
  for i := 0 to FTags.Count - 1 do
    TTag(FTags[i]).Free;
  FTags.Clear;
end;

function TTagList.Clone: TTagList;
var
  i: Integer;
begin
  Result := TTagList.Create;
  for i := 0 to FTags.Count - 1 do
    Result.FTags.Add(TTag(FTags[i]).Clone);
end;

constructor TTagList.Create;
begin
  inherited Create;
  FTags := TList.Create;
  FSorted := False;
end;

destructor TTagList.Destroy;
begin
  ClearTags;
  FTags.Free;
  inherited;
end;


function TTagList.FindTag(TagID: Integer; var ItemIndex: Integer): Boolean;
var
  x,y,z: Integer;
  ComparisonResult: Integer;
  DummyTag: TTag;
begin
  Sort;

  Result:= False;
  ItemIndex:= -1;

  x:= 0;
  y:= Ftags.Count - 1;
  DummyTag := TTag.Create('','',TagID);
  try
    while( x <= y) do // x = y when found; x > y if not found
    begin
      z:= (y + x) shr 1; // Get the mid-point

      ComparisonResult := CompareTags(TTag(FTags[z]), DummyTag);
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
    ItemIndex := x;
  finally
    DummyTag.Free;
  end;
end;

function TTagList.GetCommaText: String;
var
  i: Integer;
begin
  if FTags.Count = 0 then
    Result := ''
  else begin
    if Tag[0].ParentTagName <> '' then
      Result := Tag[0].ParentTagName + ':' + Tag[0].TagName
    else
      Result := Tag[0].TagName;
    for i := 1 to FTags.Count - 1 do
    begin
      if Tag[i].ParentTagName <> '' then
        Result := Result + ', ' + Tag[i].ParentTagName + ':' + Tag[i].TagName
      else
        Result := Result + ', ' + Tag[i].TagName;
    end;
  end;
end;

function TTagList.GetTag(Index: Integer): TTag;
begin
  Result := TTag(FTags[Index]);
end;

function TTagList.GetTagListCount: Integer;
begin
  Result := FTags.Count;
end;

procedure TTagList.Sort;
begin
  if not FSorted then
  begin
    FTags.Sort(CompareTags);
    FSorted := True;
  end
end;


end.
 