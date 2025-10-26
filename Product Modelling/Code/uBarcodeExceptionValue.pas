unit uBarcodeExceptionValue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TBarcodeExceptionValue = class(TForm)
    btnCancel: TButton;
    btnOK: TButton;
    Label1: TLabel;
    edtException: TMemo;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    StartValue, EndValue : String;
    { Private declarations }
  public
    newExceptionList : TStringList;
    FExceptionList : TStringList;
    property ExStartValue : String write StartValue;
    property ExEndValue : String write EndValue;
    { Public declarations }
  end;

implementation

uses useful;

{$R *.dfm}

procedure TBarcodeExceptionValue.btnOKClick(Sender: TObject);
var
  dupException : String;

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

  procedure addRange(RangeStart, RangeEnd : String);
  var nRange : String;
  begin
     nRange := RangeStart;

     while StringGreaterThan(RangeEnd, nRange) do
     begin
       newExceptionList.Add(nRange);
       nRange := IncString(nRange);
     end;

     if nRange = RangeEnd then
        newExceptionList.Add(nRange);
  end;

  procedure CheckForRanges;
  var i,ilCount : integer;
      Str : String;
  begin
    for i := 0 to Pred(newExceptionList.Count) do
       if (pos('-', newExceptionList[i]) > 0) then
          begin
            Str := Trim(newExceptionList[i]);
            ilCount := Pos('-', newExceptionList[i]);
            addRange(Trim(Copy(Str, 1, ilCount - 1)), Trim(Copy(Str, ilCount + 1, Length(Str))));
            newExceptionList.Delete(i);
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

     CheckForRanges;

     if exceptionExists then
        Raise Exception.Create('Exception ' + dupException + ' already exists within the list.')
     else
     if exceptionOutSideRange then
        Raise Exception.Create('Exception ' + dupException + ' is outwith the barcode range.')
     else
        ModalResult := mrOk;
   end;

end;

procedure TBarcodeExceptionValue.FormShow(Sender: TObject);
begin
  newExceptionList := TStringList.Create;
  newExceptionList.Sorted := True;
  newExceptionList.Duplicates := dupIgnore;
end;

end.
