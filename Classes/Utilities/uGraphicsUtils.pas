unit uGraphicsUtils;

interface
uses Graphics, WinTypes, SysUtils;


function IsBitmapCompressed(Bitmap: Graphics.TBitmap): Boolean;
function GetColourDepth(Bitmap: Graphics.TBitmap): Integer;



implementation

function  IsBitmapCompressed(Bitmap: Graphics.TBitmap): Boolean;

var
  Header, Bits: Pointer;
  HeaderSize: Cardinal;
  BitsSize : Cardinal;
begin

  GetDIBSizes(Bitmap.Handle, HeaderSize, BitsSize);
  Header := AllocMem(HeaderSize);
  Bits := AllocMem(BitsSize);
  try
    GetDIB(Bitmap.Handle, Bitmap.Palette, Header^, Bits^);
    case PBITMAPINFOHEADER(Header)^.biCompression of
      BI_RGB : Result := FALSE;
      else
        Result := TRUE;
    end;
  finally
    FreeMem(Header, HeaderSize);
    FreeMem(Bits, BitsSize);
  end;
end;

function  GetColourDepth(Bitmap: Graphics.TBitmap): Integer;

var
  Header, Bits: Pointer;
  HeaderSize: Cardinal;
  BitsSize : Cardinal;
begin

  GetDIBSizes(Bitmap.Handle, HeaderSize, BitsSize);
  Header := AllocMem(HeaderSize);
  Bits := AllocMem(BitsSize);
  try
    GetDIB(Bitmap.Handle, Bitmap.Palette, Header^, Bits^);
    result:=PBITMAPINFOHEADER(Header)^.biBitCount;
  finally
    FreeMem(Header, HeaderSize);
    FreeMem(Bits, BitsSize);
  end;
end;

end.
 
