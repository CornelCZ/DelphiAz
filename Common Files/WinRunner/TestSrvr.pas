(* $Id: TestSrvr.pas,v 1.23 2002/11/04 10:26:42 taiga Exp $ [MISCCSID] *)
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

uses Windows, Messages, SysUtils, MercControl, MercCustControl,
     Forms, Controls;

 const
 // TestSrvr2 Messages
 // also Define at dlph_ext.h
 MY_WM_USER                             = WM_USER+300;
 DLPH_GET_PROPERTY                      = (MY_WM_USER+1);
 DLPH_GET_ALL_PROPERTY_NAME             = (MY_WM_USER+2);
 DLPH_GET_PROPERTY_TYPE                 = (MY_WM_USER+3);
 DLPH_SET_PROPERTY                      = (MY_WM_USER+4);
 DLPH_PARAM_MAX_SIZE                    = 4096;
 // end define at dlph_ext.h

 {$INCLUDE MercAgentVersion.pas}
 szMercAgentSignature = 'Mercury_WinRunner_DLPH_Agent_Ver_' + szMercAgentVersion;

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
        procedure MappedFilePutString(str:AnsiString; bRes: BOOL);
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


function _str(value: longint): String;
var res:string;
begin
    str(value, res);
    Result:= res;
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
  begin
	    CloseHandle(in_out_file);
        in_out_file:= 0; 
  end;

end;

procedure TFormTstSrvr2.CloseMappedFile();
begin
 if  (pInOut <>  nil) then
 	UnmapViewOfFile(pInOut);

 pInOut:= nil;

 if (in_out_file <> 0 ) then
     CloseHandle(in_out_file);
     
 in_out_file:= 0;
end;


procedure TFormTstSrvr2.MappedFilePutString(str:AnsiString; bRes: BOOL);
var map_str: PChar;
	str_len: integer;
begin
     OpenMappedFile();
     if (pInOut<>Nil) then
     begin
        map_str := Pchar(pInOut);

        if (bRes) then
            map_str[DLPH_PARAM_MAX_SIZE - 1]:= #1
        else
            map_str[DLPH_PARAM_MAX_SIZE - 1]:= #0;

        if (Length(str)>0) then
        begin
        	if(Length(str) < (DLPH_PARAM_MAX_SIZE - 2)) then
               	str_len:= Length(str)
            else
            	begin
            		str_len:= DLPH_PARAM_MAX_SIZE - 2;
	                map_str[DLPH_PARAM_MAX_SIZE - 2] := #0
	            end;

            StrLCopy(map_str, Pchar(str), str_len);
        end
        else
            map_str[0]:=#0;
     end;
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
  PropValue: String;
  bRes: BOOL;

begin
  PropName := '';
  PropValue:= '';
  
  bRes := FALSE;

  msg.Result:=0;
  PropName:=MappedFileGetString();
  if (Length(PropName) = 0 ) then
     exit;

  {$ifdef MERC_DEBUG}
  OutputDebugString(PCHAR('DLPH Agent: GetPropertyMessage: '+ PropName + ' HWND: ' + _str(msg.WParam)));
  {$endif}

  if (PropName = 'MercuryDLPHAgentVersion') then
  begin
 	PropValue:= szMercAgentVersion;
    bRes := TRUE;
    msg.Result:=1;
    MappedFileClear();
    MappedFilePutString(PropValue, bRes);
    exit;
  end;

  CreateMercObjectFromHandle(integer(msg.WParam),MercObject);
  if (MercObject = nil) then
     exit;
  PropValue := MercObject.GetProperty(PropName, bRes);

  msg.Result:=1;
  MappedFileClear();
  MappedFilePutString(PropValue, bRes);
  MercObject.Free;
  
  {$ifdef MERC_DEBUG}
  OutputDebugString('Passed');
  {$endif}
end;

procedure TFormTstSrvr2.GetPropertyTypeMessage(var msg : Tmessage);
var
  PropName: String;
  MercObject :TMercControl ;

begin
  PropName := '';

  PropName:=MappedFileGetString();
  msg.Result:=0;
  if (Length(PropName) = 0 ) then
     exit;

  {$ifdef MERC_DEBUG}
  OutputDebugString(PCHAR('DLPH Agent: GetPropertyTypeMessage: '+ PropName + ' HWND: ' + string(_str(msg.WParam))));
  {$endif}

  CreateMercObjectFromHandle(integer(msg.WParam),MercObject);
  if (MercObject = nil) then
       exit;

  

  MappedFileClear();
  msg.Result:=1;
  MappedFilePutString(MercObject.GetPropertyType(PropName), TRUE);
  MercObject.Free;

  {$ifdef MERC_DEBUG}
  OutputDebugString('Passed');
  {$endif}
end;

procedure TFormTstSrvr2.GetAllPropertyNameMessage(var msg : Tmessage);
 var
  MercObject :TMercControl ;
  SubObj:string;

  begin

  {$ifdef MERC_DEBUG}
  OutputDebugString(PCHAR('DLPH Agent: GetAllPropertyNameMessage: HWND: ' + _str(msg.WParam)));
  {$endif}

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

    MappedFilePutString(MercObject.GetAllPropertyName(), TRUE);
    MercObject.Free;

  {$ifdef MERC_DEBUG}
  OutputDebugString('Passed');
  {$endif}
end;

procedure TFormTstSrvr2.SetPropertyMessage(var msg : Tmessage);
var
  PropName, val, Res: String;
  MercObject: TMercControl ;
  idx:Integer;
begin
  msg.Result:=0;
  PropName:=MappedFileGetString();
  if (Length(PropName) = 0 ) then
     exit;

  {$ifdef MERC_DEBUG}
  OutputDebugString(PCHAR('DLPH Agent: SetPropertyMessage: '+ PropName + ' HWND: ' + _str(msg.WParam)));
  {$endif}

  idx:=pos(#9,propname);
  if (idx=0) then exit;

   val:=Copy(propname,idx+1,Length(propname));
   Delete(propname,idx,Length(propname));

  msg.Result:=1;
  MappedFileClear();

  CreateMercObjectFromHandle(integer(msg.WParam),MercObject);
  if (MercObject = nil) then
         exit;
  
  Res := MercObject.SetProperty(PropName, val);

  if (Res = val) then
  	MappedFilePutString('Succeeded', TRUE);

  MercObject.Free;

  {$ifdef MERC_DEBUG}
  OutputDebugString('Passed');
  {$endif}
end;

initialization
 FormTstSrvr2.CreateSpyWindow();
finalization
 FormTstSrvr2.DestroySpyWindow();
end.




