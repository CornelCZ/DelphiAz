unit uSwipeCardExceptionValue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Clipbrd;

type
  TSwipeCardExceptionValue = class(TForm)
    btnCancel: TButton;
    btnOK: TButton;
    Label1: TLabel;
    edtException: TMemo;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtExceptionKeyPress(Sender: TObject; var Key: Char);
  private
    StartValue, EndValue : String;
    FIsPromotional: Boolean;
    { Private declarations }
  public
    newExceptionList : TStringList;
    FExceptionList : TStringList;
    property ExStartValue : String write StartValue;
    property ExEndValue : String write EndValue;
    property IsPromotional: Boolean read FIsPromotional write FIsPromotional;
    { Public declarations }
  end;

implementation

uses useful;

{$R *.dfm}

procedure TSwipeCardExceptionValue.btnOKClick(Sender: TObject);
var
  dupException: String;
  InvalidRanges: TStringList;

  {TO DO: this is splitting up comma seperated text - does this need it's own procedure rather than setting CommaText?}
  procedure ParseExceptionList;
  var
    Str : String;
    ilCount : Integer;
  begin
    Str := Trim(edtException.Text);
    ilCount := Pos(',', Str);
    while ilCount > 0 do
    begin
      if Trim(Copy(Str, 1, ilCount - 1)) <> '' then
         newExceptionList.Add(Trim(Copy(Str, 1, ilCount - 1)));
      Str := Trim(Copy(Str, ilCount + 1, Length(Str)));
      ilCount := Pos(',', Str);
    end;
    if Str <> '' then
       newExceptionList.Add(Str);
  end;

  procedure addRange(RangeStart, RangeEnd : String; List: TStringList);
  var nRange : String;
  begin
    nRange := RangeStart;
    while StringGreaterThan(RangeEnd, nRange) do
    begin
      List.Add(nRange);
      nRange := IncString(nRange);
    end;

    if nRange = RangeEnd then
      List.Add(nRange);
  end;

  procedure RemoveDuplicateExceptions(List: TStringList);
  var
    i: Integer;
  begin
    for i := Pred(List.Count) downto 1 do
      if List[i]=List[i-1] then
        List.Delete(i);
  end;

  {TO DO: This code needs a BIG re-factor.  Notable problems:
    * The ranges can be overlapping - this means we end up generating duplicates
    that need removal after the insertion as relying on a sorted list with duplicates
    set to dupIgnore is slooooooooooooooooow. Perhaps some intelligent range collapsing
    work instead?
    * Large ranges, i.e. in the order of millions, perform really slowly.
  }
  procedure CheckForRanges;
  var i,ilCount : integer;
      Str : String;
      ScratchList: TStringList;
      RangeStart, RangeEnd: String;
  begin
    ScratchList := TStringList.Create;
    ScratchList.Sorted := False;
    try
      for i := Pred(newExceptionList.Count) downto 0 do
        if (pos('-', newExceptionList[i]) > 0) then
        begin
          Str := Trim(newExceptionList[i]);
          ilCount := Pos('-', newExceptionList[i]);
          RangeStart := Trim(Copy(Str, 1, ilCount - 1));
          RangeEnd := Trim(Copy(Str, ilCount + 1, Length(Str)));
          if (RangeStart <> '') and (RangeEnd <> '')
          and (Pos('-', RangeStart) = 0) and (Pos('-', RangeEnd) = 0)
          and (Pos(' ', RangeStart) = 0) and (Pos(' ', RangeEnd) = 0) then
            addRange(RangeStart, RangeEnd, ScratchList)
          else begin
            InvalidRanges.Add(Str);
          end;
          newExceptionList.Delete(i);
        end;

      //ScratchList contains the new exceptions discovered in the ranges (including
      //duplicates) so now add anything from newExceptionList that is not a range, i.e. a singleton
      ScratchList.AddStrings(newExceptionList);

      //Lets get rid of duplicates - leave the ScratchList.Sorted setting here
      //rather than put it in RemoveDuplicateExceptions to match the explicit
      //setting to false above.
      ScratchList.Sorted := True;
      RemoveDuplicateExceptions(ScratchList);

      //Now Assign the clean, duplicate free list back to newExceptionList
      newExceptionList.Capacity := ScratchList.Capacity; 
      newExceptionList.Assign(ScratchList);
    finally
      ScratchList.Free;
    end;
  end;

  function exceptionExists : boolean;
  var i, p : integer;
  begin
    Result := False;
    for i := 0 to Pred(newExceptionList.Count) do
       begin
         for p := 0 to Pred(FExceptionList.Count) do
             if newExceptionList[i] = FExceptionList[p] then
                begin
                  dupException := newExceptionList[i];
                  Result := True;
                end;
       end;
  end;

  function exceptionOutSideRange : Boolean;
  var i : integer;
  begin
    Result := False;
    for i := 0 to Pred(newExceptionList.Count) do
       if (StringGreaterThan(newExceptionList[i], EndValue)) or
          (StringGreaterThan(StartValue, newExceptionList[i])) then
              begin
                dupException := newExceptionList[i];
                Result := True;
              end;
  end;

  function isNumeric(const S: string): Boolean;
  var
    P: PChar;
  begin
    P      := PChar(S);
    Result := False;
    while P^ <> #0 do
      begin
        if not (P^ in ['0'..'9', ',', '-', ' ']) then
           Exit;
         inc(P);
      end;
    Result := True;
  end;

begin
   Cursor := crHourGlass;
   if Trim(edtException.Text) = '' then
      Raise Exception.Create('Please enter an Exception value.')
   else
   if not isNumeric(edtException.Text) then
      raise Exception.Create('Exception value is invalid.  Please ensure values are numeric.');
   begin
     newExceptionList.Clear;

     ParseExceptionList;

     InvalidRanges := TStringList.Create;
     try
      CheckForRanges;
      if InvalidRanges.Count <> 0 then
      begin
        Raise Exception.Create('Exception: invalid ranges entered: ' + InvalidRanges.CommaText);
      end;
     finally
       InvalidRanges.Free;
     end;

     if exceptionExists then
        Raise Exception.Create('Exception ' + dupException + ' already exists within the list.')
     else
     if exceptionOutSideRange then
        Raise Exception.Create('Exception ' + dupException + ' is out with the card range.')
     else
        ModalResult := mrOk;
   end;

end;

procedure TSwipeCardExceptionValue.FormShow(Sender: TObject);
begin
  if FIsPromotional then
    HelpContext := 7106
  else
    HelpContext := 5071;

  newExceptionList := TStringList.Create;
  newExceptionList.Sorted := True;
  newExceptionList.Duplicates := dupIgnore;
end;

procedure TSwipeCardExceptionValue.edtExceptionKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not((Ord(Key) >= Ord('0')) and (Ord(Key) <= Ord('9'))) and (Key <> #8)
     and (Key <> #3) and (Key <> #23) and (Key <> #24) and (Ord(Key) <> Ord(' ')) and (Ord(Key) <> Ord('-'))
     and (Ord(Key) <> Ord(',')) and (Key <> #22) and (Key <> #1) and (Key <> #2)  and (Key <> #3) then
    Abort;
  if (Key = '0') and ((Length(TEdit(Sender).Text) = 0) or (TEdit(Sender).SelStart = 0)) then
    Abort;
end;

end.
