unit uValidateGraphic;

interface

Function ValidateGraphic(Pathname:String):boolean;

implementation

uses SysUtils, Dialogs, Graphics, uGraphicsUtils;

Function GetFileSize(Pathname:String):integer;
Var
  fImageFile:File Of Byte;
begin
 Assign(fImageFile,Pathname);
 FileMode := 0;
 Reset(fImageFile);
 Result:=FileSize(fImageFile);
 CloseFile(fImageFile);
end;

Function ValidateGraphic(Pathname:String):boolean;
Var
  bmImageToCheck: TBitmap;
begin
  Result:=FALSE;

  if FileExists(PathName) then
  begin
    if GetFileSize(PathName)>204800 then
    begin
      ShowMessage('The File You Have Selected Is Too Large (Limit :200K)');
    end
    else
    begin
      try
        bmImageToCheck:=TBitmap.Create;
        bmImageToCheck.loadfromfile(PathName);
        if IsBitmapCompressed(bmImageToCheck) or (GetColourDepth(bmImageToCheck) > 8) then
          ShowMessage('The Selected Bitmap Image Is Compressed Or More Than 8 Bit Colour')
        else
          Result:=TRUE;
      finally
        FreeAndNil(bmImageToCheck);
      end;
    end;
  end
  else
  begin
    ShowMessage('The File You Have Selected Can Not Be Found');
  end;
end;

end.
