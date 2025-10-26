(* $Id: TestSrvr.pas,v 1.13 2000/10/19 14:40:52 yuv Exp $ [MISCCSID] *)
{
    Copyright (c) 1999 by Mercury Interactive ltd

    All rights reserved.

    This software is a property of Mercury Interactive ltd.
    It may not be used, copied, or modified unless you have a written
    permission of Mercury Interactive stating otherwise.

    Under no conditions may this copyright notice may be modified or
    deleted from the software.

		Name               Date       Modification made
		-------------------------------------------------------
		Yuval Ben-Zvi      3/1999       Create
}
unit TestSrvr;

interface

uses
 Windows, TypInfo, Forms, Classes, Messages,Dialogs,DB,Controls,
 SysUtils,DBGrids,Grids,MercControl,MercCustControl;

 const
 // TestSrvr2 Messages
 // also Define at dlph_ext.h
 MY_WM_USER                             = WM_USER+300;
 DLPH_GET_PROPERTY                      = (MY_WM_USER+1);
 DLPH_GET_ALL_PROPERTY_NAME             = (MY_WM_USER+2);
 DLPH_GET_PROPERTY_TYPE                 = (MY_WM_USER+3);
 DLPH_SET_PROPERTY                      = (MY_WM_USER+4);
 // end define at dlph_ext.h

  // Genrail Function
  function InstallHooks: Longint; stdcall;



 type
 TFormTstSrvr2 = class(TForm)


  private
        in_out_file :THandle;
        pInOut      :Pointer;

        // Widnow message Functions
        procedure GetPropertyMessage(var msg : TMessage);message DLPH_GET_PROPERTY;
        procedure GetAllPropertyNameMessage(var msg : TMessage);message DLPH_GET_ALL_PROPERTY_NAME;
        procedure GetPropertyTypeMessage(var msg : TMessage);message DLPH_GET_PROPERTY_TYPE;
        procedure SetPropertyMessage(var msg : TMessage);message DLPH_SET_PROPERTY;

        procedure DestroySpyWindow;
        procedure OpenMappedFile;
        procedure CloseMappedFile;
        procedure MappedFileClear;
        procedure MappedFilePutString(str:AnsiString);
        function  MappedFileGetString:String;
        procedure CreateMercObjectFromHandle(hwnd:Longint;var MercObject :TMercControl);
  public
       procedure CreateSpyWindow;
    	{ Public declarations }
  end;




implementation

var
FormTstSrvr2:  TFormTstSrvr2;
{Functions}
function InstallHooks: Longint;
 begin
// ShowMessage('InstallHooks yuv!');
// CreateSpyWindow();
 Result :=1;
 end;


////////////////////////////////////////////////////////////////
// Spy Windows Fucntions
////////////////////////////////////////////////////////////////

procedure TFormTstSrvr2.CreateSpyWindow();
var
ProcessId:DWORD;
s:string;
begin
  FormTstSrvr2:= TFormTstSrvr2.CreateNew(Application);
//  FormTstSrvr2.Name := 'FormTstSrvr';
  ProcessId:=GetCurrentProcessId();
  FmtStr(s, 'FormTstSrvr3_%x', [ProcessId]);
  FormTstSrvr2.Caption := s;
  FormTstSrvr2.Top := -500;
  FormTstSrvr2.Show;

  // hide this window
  SetWindowPos(FormTstSrvr2.handle, 0, 0, 0, 0, 0, SWP_HIDEWINDOW or
              SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_NOACTIVATE);

//  FormTstSrvr2.Hide;

end;

procedure TFormTstSrvr2.DestroySpyWindow();
begin

end;

procedure TFormTstSrvr2.OpenMappedFile();
begin

  in_out_file := OpenFileMapping(FILE_MAP_WRITE,FALSE,'DLPH2WR_IO_PARAM') ;
  if (in_out_file = 0 ) then exit ;

  pInOut := MapViewOfFile(in_out_file, FILE_MAP_WRITE, 0, 0, 0);
  if  (pInOut = nil) then
	    CloseHandle(in_out_file);

end;

procedure TFormTstSrvr2.CloseMappedFile();
begin
 if  (pInOut <>  nil) then  UnmapViewOfFile(pInOut);
  if (in_out_file <> 0 ) then
     CloseHandle(in_out_file);
  in_out_file:=0;
end;

procedure TFormTstSrvr2.MappedFilePutString(str:AnsiString);
begin
     OpenMappedFile();
     if (pInOut<>Nil) then
        if (Length(str)>0) then
            StrCopy(Pchar(pInOut), Pchar(str))
        else
            Pchar(pInOut)^:=#0;

     CloseMappedFile();
end;

function TFormTstSrvr2.MappedFileGetString():String;
begin
     Result := '';
     OpenMappedFile();
     if (pInOut<>Nil) then
           Result:=Pchar(pInOut);
     CloseMappedFile();
end;

procedure TFormTstSrvr2.MappedFileClear();
begin
    OpenMappedFile();
    if (pInOut<>Nil) then
           Pchar(pInOut)^:=#0;
    CloseMappedFile();
end;

procedure  TFormTstSrvr2.CreateMercObjectFromHandle(hwnd:Longint;var MercObject :TMercControl);
var
   obj:TObject;
begin
    MercObject:=nil;
    obj:= FindControl(hwnd);
    if (obj=nil) then exit;
    MercUnitManger.CreateMercObject(obj,MercObject);
    MercObject.init(obj);
end;


////////////////////////////////////////////////////////////////
// Message  Fucntions
////////////////////////////////////////////////////////////////

procedure TFormTstSrvr2.GetPropertyMessage(var msg : Tmessage);
var
  PropName: String;
  MercObject :TMercControl ;

begin
  msg.Result:=0;
  PropName:=MappedFileGetString();
  if (Length(PropName) = 0 ) then
     exit;
  CreateMercObjectFromHandle(integer(msg.WParam),MercObject);
  if (MercObject = nil) then
       exit;

  msg.Result:=1;
  MappedFileClear();
  MappedFilePutString(MercObject.GetProperty(PropName));
  MercObject.Destroy;
 end;

procedure TFormTstSrvr2.GetPropertyTypeMessage(var msg : Tmessage);
var
  PropName: String;
  MercObject :TMercControl ;

begin
  PropName:=MappedFileGetString();
  msg.Result:=0;
  if (Length(PropName) = 0 ) then
     exit;


  CreateMercObjectFromHandle(integer(msg.WParam),MercObject);
  if (MercObject = nil) then
       exit;
  MappedFileClear();
  msg.Result:=1;
  MappedFilePutString(MercObject.GetPropertyType(PropName));
  MercObject.Destroy;
end;

procedure TFormTstSrvr2.GetAllPropertyNameMessage(var msg : Tmessage);
 var
  MercObject :TMercControl ;
  SubObj:string;

  begin
  msg.Result:=0;
  SubObj:=MappedFileGetString();


  CreateMercObjectFromHandle(integer(msg.WParam),MercObject);
  if (MercObject = nil) then
       exit;
    msg.Result:=1;
    MappedFileClear();
    if (Length(SubObj) > 0 ) then
    begin
     if (not (MercObject.SetSubObject(SubObj))) then
       exit;
    end;

  MappedFilePutString(MercObject.GetAllPropertyName());
  MercObject.Destroy;
 end;

procedure TFormTstSrvr2.SetPropertyMessage(var msg : Tmessage);
var
  PropName,val: String;
  MercObject :TMercControl ;
  idx:Integer;
begin
  msg.Result:=0;
  PropName:=MappedFileGetString();
  if (Length(PropName) = 0 ) then
     exit;

  idx:=pos(#9,propname);
  if (idx=0) then exit;

   val:=Copy(propname,idx+1,Length(propname));
   Delete(propname,idx,Length(propname));


  CreateMercObjectFromHandle(integer(msg.WParam),MercObject);
  if (MercObject = nil) then
         exit;
  MappedFileClear();
  msg.Result:=1;
  MercObject.SetProperty(PropName,val);
  MercObject.Destroy;
end;

initialization
 FormTstSrvr2.CreateSpyWindow();
finalization
 FormTstSrvr2.DestroySpyWindow();
end.




