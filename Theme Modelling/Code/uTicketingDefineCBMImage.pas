unit uTicketingDefineCBMImage;

interface

uses windows, graphics;

function DefineImageData(Images: array of TBitmap; PrintProofs: boolean): string;


implementation

uses math, sysutils;

function DefineSingleImageData(image: TBitmap): string;
var
  prnX, prnY: integer;
  dims: array[0..3] of char;
  cmdstring: string;
  byteidx, i,j: integer;
begin
  prnX := math.Ceil(image.Height/8.0);
  prnY := math.Ceil(image.Width/8.0);
  image.width := prnY * 8;
  image.height := prnX * 8;

  dims[0] := char(prnX and $ff);
  dims[1] := char(prnX shr 8);
  dims[2] := char(prnY and $ff);
  dims[3] := char(prnY shr 8);

  cmdstring := dims[0]+dims[1]+dims[2]+dims[3];

  setlength(cmdstring, 4+(prnY * prnX * 8));

  for i := 0 to pred(prnY * prnX * 8) do
    cmdstring[5+i] := #0;


  for i := 0 to pred(image.width) do
    for j := 0 to pred(image.height) do
    begin
      if cardinal(image.Canvas.Pixels[i,pred(image.height)-j]) < RGB(128, 128, 128) then
      begin
        byteidx := 5+(i div 8) + (j*prnY);
        cmdstring[byteidx] := char(byte(cmdstring[byteidx]) or
          (1 shl (7-(i mod 8))));
      end;
    end;

  result := cmdstring;

end;
function DefineImageData(Images: array of TBitmap; PrintProofs: boolean): string;
var
  i: integer;
begin
  result := #$1c#$71+chr(Length(Images));
  for i := low(Images) to high(Images) do
  begin
    result := result + DefineSingleImageData(Images[i]);
  end;
  if PrintProofs then
  begin
    result := result + '*** Theme Ticket Images Downloaded ***'+#13;
    for i := low(Images) to high(Images) do
    begin
      result := result + format('Image #%d'#13, [i+1]);
      result := result + #$1c#$70+chr(i+1)+#0;
    end;
    result := result + #13#13#13#13#13#$1B#$69#$00;
  end;
end;

end.
