(* $Id: MercControl.pas,v 1.9 2000/10/19 14:44:52 yuv Exp $ [MISCCSID] *)
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

unit MercControl;

interface
uses
 Windows,Messages, SysUtils,TypInfo, Controls,Forms,Graphics;
const
   MAX_PARAM=10;
   ERR_INT=-999;
   MAX_CUST_UNIT=10;



type
TMercControl = class (TControl)
  private
         function  IsBitOn (Value: Integer; Bit: Byte): Boolean;
         function  GetSetVal(obj:TObject;PropInfo: PPropInfo;setName :String):String;
         function  GetSetNames(obj:TObject;PropName:String):String;
         procedure GetParamFromProperty(var propname:string);
         function  GetColor :string ;
         procedure SetColor(Value: string);
         function  GetFixedColor :string ;
         procedure SetFixedColor(Value: string);
         function  GetCursor :string ;
         procedure SetCursor(Value: string);
         function  GetDragCursor :string ;
         procedure SetDragCursor(Value: string);
  public
        FObject:  TObject;
        FSubKind:  TTypeKind;
        FSubName:  string;
        FParam: array[1..MAX_PARAM] of string;

        procedure Init(obj: TObject);
        function  MyStrToint(S:string):Longint;
        function  GetMessageParm( var Msg: TMessage): bool;
        function  SetSubObject(SubObjStr:string):ByteBool;
        function  GetNotSupportObjectEx(obj:TObject;propname:string): TObject; virtual;
        function  GetNotSupportObject(obj:TObject;propname:string): TObject;
        function  GetObjectProperty(obj:TObject;propname:string): string;
        function  SetObjectProperty(obj:TObject;propname,value:string): string;
        function  IsTControlProperty(propname:string):bool;
        function  GetProperty(propname:string): string; virtual;
        function  SetProperty(propname,value:string): string; virtual;
        function  GetPropertyType(propname:string): string; virtual;
        function  GetObjectPropertyType(obj:TObject;propname:string): string;
        function  GetObjectAllPropertyName(obj:TObject;var Count: Integer): AnsiString;
        function  GetAllPropertyName: string;
        function  GetAdditionalAllPropertyNameEx(var Count: Integer): string; virtual;
        function  GetMercTag :string ; virtual;

  published
        property MercTag: string  read GetMercTag;
        property Color: string  read GetColor write SetColor;
        property FixedColor: string  read GetFixedColor write SetFixedColor;
        property Cursor: string  read GetCursor write SetCursor;
        property DragCursor: string  read GetDragCursor write SetDragCursor;


  end;

TCreateMercObject = procedure(obj:TObject;var MercObject :TMercControl);

TMercUnitManger = class
  private
         FUnitNumber:Integer;
         FCreateMercFuncs:array[1..MAX_CUST_UNIT] of  TCreateMercObject;
  public
        constructor Create;
        destructor Destroy; override;
        procedure AddUnit(p:pointer);
        function  InheritsFrom(Obj:TObject;AClass: String): WordBool;
        procedure CreateMercObject(obj:TObject;var MercObject :TMercControl);
  end;

var
 MercUnitManger:TMercUnitManger;


implementation

procedure InitMercControl;
begin
 MercUnitManger:= TMercUnitManger.Create();
end;

procedure DoneMercControl;
begin
     MercUnitManger.Free;
end;

////////////////////////////////////////////////////////////////
// TMercUnitManger 
////////////////////////////////////////////////////////////////
constructor TMercUnitManger.Create;
begin
  inherited Create;
  FUnitNumber:=0;
end;

destructor TMercUnitManger.Destroy;
begin
  inherited Destroy;
end;

procedure TMercUnitManger.AddUnit(p:pointer);
begin
   inc(FUnitNumber);
   FCreateMercFuncs[FUnitNumber]:=p;
end;

function TMercUnitManger.InheritsFrom(Obj:TObject;AClass: String): WordBool;
var
  P: TClass;
begin
  Result := true;
  P := Obj.ClassType;
  repeat
    if (CompareText(P.ClassName, AClass) = 0) then exit;
    P := P.ClassParent;
  until (P = nil);
  Result := false;
end;

procedure TMercUnitManger.CreateMercObject(obj:TObject;var MercObject :TMercControl);
var
i:Integer;
begin
     MercObject:=nil;
     for i:=1 to  FUnitNumber do
     begin
        FCreateMercFuncs[i](obj,MercObject);
        if (MercObject<>nil) then exit;
     end;
     MercObject:=TMercControl.Create(Application);
end;
////////////////////////////////////////////////////////////////
// TMercControl  Base Object
////////////////////////////////////////////////////////////////
procedure TMercControl.Init(obj: TObject);
begin
     FObject:=obj;
     FSubKind:=tkUnknown;
     FSubName:='';
end;

function  TMercControl.MyStrToint(S:string):Longint;
begin
     Result :=ERR_INT;
     try
        Result :=strtoint(S);
      except
      end;
end;

function TMercControl.GetMessageParm( var Msg: TMessage): bool;
begin
Result := False;
//  hwnd:=mystrtoint(FParam[1]);
//  if (hWnd=ERR_INT) then exit;
  Msg.Msg:=mystrtoint(FParam[2]);
//  if (Msg.Msg<0) then exit;
  Msg.wParam:=mystrtoint(FParam[3]);
  if (Msg.wParam=ERR_INT) then exit;
  Msg.lParam:=mystrtoint(FParam[4]);
  if (Msg.lParam=ERR_INT) then exit;
  Result := True;
end;



function  TMercControl.SetSubObject(SubObjStr:string):ByteBool;
var
PropInfo: PPropInfo;
idx:Integer;
PropSubName:string;
begin
    Result := FALSE;
    idx:=pos('.',SubObjStr);
    if (idx>0) then
    begin
       PropSubName:=Copy(SubObjStr,idx+1,Length(SubObjStr));
       Delete(SubObjStr,idx,Length(SubObjStr));
       SetSubObject(SubObjStr);
       SubObjStr:=PropSubName;
    end;
     PropInfo:=GetPropInfo(FObject.ClassInfo,SubObjStr);
     if (PropInfo= nil) then
        exit;

    FSubKind:= PropInfo^.PropType^.Kind;
    FSubName:= SubObjStr;
    if (FSubKind=tkClass)then
       begin
         FObject:=TObject(GetOrdProp(FObject, PropInfo));
         if (FObject=nil) then exit;
       end;

    Result := TRUE;
end;
procedure TMercControl.GetParamFromProperty(var propname:string);
var
 idx,i:Integer;
 S:string;
begin
   i:=1;
   idx:=pos(';',propname);
   if (idx=0) then
      exit;

   s:=Copy(propname,idx+1,Length(propname));
   Delete(propname,idx,Length(propname));

   idx:=pos(';',s);
   while (idx>0) do
   begin
     FParam[i]:=Copy(s,0,idx-1);
     s:=Copy(s,idx+1,Length(s));
     inc(i);
     idx:=pos(';',s);
   end;
   FParam[i]:=s;

end;

function TMercControl.IsBitOn (Value: Integer; Bit: Byte): Boolean;
begin
  Result := (Value and (1 shl Bit)) <> 0;
end;

function TMercControl.GetSetVal(obj:TObject;PropInfo: PPropInfo;setName :String):String;
var
TypeInfo: PTypeInfo;
{$ifdef ver90}
TypeData: PTypeData;
{$endif}
W: Cardinal;
i:integer;
begin
    {$ifdef ver90}
    TypeData := GetTypeData(PropInfo^.PropType);
    TypeInfo := TypeData^.CompType;
    {$else}
    TypeInfo := GetTypeData(PropInfo.PropType^).CompType^;
    {$endif}
   W := GetOrdProp(obj, PropInfo);
   Result :='Err';
   i := GetTypeData (TypeInfo).MinValue-1;
      while i<=GetTypeData (TypeInfo).MaxValue do
      begin
      inc(i);
       if (CompareText(GetEnumName (TypeInfo, i),setName)=0) then
          if IsBitOn (W, i) then
             Result :='True'
          else
             Result :='False';
      end;
end;

function TMercControl.GetSetNames(obj:TObject;PropName:String):String;
var
TypeInfo: PTypeInfo;
PropInfo: PPropInfo;
{$ifdef ver90}
TypeData: PTypeData;
{$endif}
//W: Cardinal;
i,count:integer;
begin
    PropInfo:=GetPropInfo(obj.ClassInfo,PropName);
  //  Result := GetSetVal(obj,PropInfo,PropSubName);
    {$ifdef ver90}
    TypeData := GetTypeData(PropInfo^.PropType);
    TypeInfo := TypeData^.CompType;
    {$else}
    TypeInfo := GetTypeData(PropInfo.PropType^).CompType^;
    {$endif}
  // W := GetOrdProp(obj, PropInfo);



   count:=GetTypeData (TypeInfo).MaxValue-GetTypeData (TypeInfo).MinValue+1;
   Result :=inttostr(count)+';';
     for i:=0 to count-1 do
      begin
       Result :=Result+GetEnumName (TypeInfo, i)+';';
      end;
      Result := Result+';';
end;

function  TMercControl.GetNotSupportObjectEx(obj:TObject;propname:string): TObject;
begin
Result := nil;
end;

function  TMercControl.GetNotSupportObject(obj:TObject;propname:string): TObject;
var
idx,idx2,n:Integer;
s:string;
begin
Result := GetNotSupportObjectEx(obj,propname);
if (Result<> nil ) then exit;
n:=-1;
idx:=pos('[',propname);
 if (idx>0) then
 begin
  idx2:=pos(']',propname);
  s:=Copy(propname,idx+1,idx2-idx-1);
  Delete(propname,idx,Length(propname));
  n:=mystrtoint(s);
 end;
 try
 begin
  if (UpperCase(propname)='PARENT') then Result:=TWinControl(Obj).parent
  else if ((UpperCase(propname)='CONTROL') and (n>=0)) then Result:=TWinControl(Obj).Controls[n]
  else Result := nil;
 end;
 except
 Result := nil;
 end;

end;

function  TMercControl.GetObjectProperty(obj:TObject;propname:string): string;
var
PropInfo: PPropInfo;
ObjSub:TObject;
idx:Integer;
PropSubName:string;
begin
    Result := '';
    idx:=pos('.',propname);
    if (idx>0) then
    begin
       PropSubName:=Copy(propname,idx+1,Length(propname));
       Delete(propname,idx,Length(propname));
    end;
     PropInfo:=GetPropInfo(obj.ClassInfo,PropName);
     if (PropInfo= nil) then
        begin
             ObjSub:=GetNotSupportObject(obj,propname);
             if (ObjSub=nil) then exit;
             Result :=GetObjectProperty(ObjSub,PropSubName);
             exit;
        end;

    case PropInfo^.PropType^.Kind of
          tkInteger:
          Result := inttostr (GetOrdProp(Obj, PropInfo));
          tkEnumeration:
            Result :=
            {$ifdef ver90}
            GetEnumName(PropInfo^.PropType,GetOrdProp(Obj, PropInfo));
            {$else}
            GetEnumName((PTypeinfo(PropInfo^.Proptype^)),GetOrdProp(Obj, PropInfo));
            {$endif}
          tkFloat:
            Result := FloatToStr (GetFloatProp(Obj, PropInfo));
          tkString:
            Result :=  GetStrProp(Obj, PropInfo);
          tkLString:
            Result :=  GetStrProp(Obj, PropInfo);
          tkSet:
            Result := GetSetVal(obj,PropInfo,PropSubName);
          tkClass:
            begin
             FObject:=TObject(GetOrdProp(Obj, PropInfo));
             Result := GetProperty(PropSubName);
            end;
          end;
end;

function TMercControl.IsTControlProperty(propname:string):bool;
begin
Result := True;
if (propname='Left') then exit;
if (propname='Top') then exit;
if (propname='Width') then exit;
if (propname='Height') then exit;
if (propname='Hint') then exit;
if  (pos('[',propname)>0) then exit;

Result := False;
end;

function TMercControl.GetProperty(propname:string): string;
begin
GetParamFromProperty(propname);
Result:='';
if (not IsTControlProperty(propname)) then
   Result :=GetObjectProperty(self,propname);
if (Result='') then
   Result :=GetObjectProperty(FObject,propname);

end;

function  TMercControl.SetObjectProperty(obj:TObject;propname,value:string): string;
var
PropInfo: PPropInfo;
idx:Integer;
PropSubName:string;
LongValue: Longint;
begin
    Result := '';
    idx:=pos('.',propname);
    if (idx>0) then
    begin
       PropSubName:=Copy(propname,idx+1,Length(propname));
       Delete(propname,idx,Length(propname));
    end;
     PropInfo:=GetPropInfo(obj.ClassInfo,PropName);
     if (PropInfo= nil) then
        begin
            { ObjSub:=GetNotSupportObject(obj,propname);
             if (ObjSub=nil) then exit;
             Result :=GetObjectProperty(ObjSub,PropSubName);}
             exit;
        end;

    case PropInfo^.PropType^.Kind of
         tkString:  SetStrProp(obj,PropInfo,value);
         tkLString: SetStrProp(obj,PropInfo,value);
         tkWString: SetStrProp(obj,PropInfo,value);
         tkInteger,tkEnumeration:
                  begin
                  LongValue:=mystrtoint(value);
                  if (LongValue=ERR_INT) then exit;
                  SetOrdProp(Obj, PropInfo,LongValue);
                  end;

          end;
end;

function TMercControl.SetProperty(propname,value:string): string;
begin
      GetParamFromProperty(propname);

      Result :=SetObjectProperty(self,propname,value);
      if (Result='') then
          Result :=SetObjectProperty(FObject,propname,value);

end;
function TMercControl.GetPropertyType(propname:string): string;
begin
     Result :=GetObjectPropertyType(FObject,propname);
end;

function TMercControl.GetObjectPropertyType(obj:TObject;propname:string): string;
var
PropInfo: PPropInfo;
ObjSub:TObject;
idx:Integer;
PropSubName:string;
begin
   Result := '';
   idx:=pos('.',propname);
    if (idx>0) then
    begin
       PropSubName:=Copy(propname,idx+1,Length(propname));
       Delete(propname,idx,Length(propname));
       PropInfo:=GetPropInfo(obj.ClassInfo,propname);
       if (PropInfo= nil) then  exit;
       if  (PropInfo^.PropType^.Kind<>tkClass) then exit;
       ObjSub:=TObject(GetOrdProp(Obj, PropInfo));
       Result := GetObjectPropertyType(ObjSub,PropSubName);
       exit;
    end;
     PropInfo:=GetPropInfo(obj.ClassInfo,PropName);
     if (PropInfo= nil) then
        exit;
       case PropInfo^.PropType^.Kind of
          tkInteger:
            Result:='tkInteger';
          tkEnumeration:
            Result:='tkEnumeration';
          tkFloat:
            Result:='tkFloat';
          tkString:
            Result:='tkString';
          tkLString:
            Result:='tkLString';
          tkSet:
            Result:='tkSet';
          tkClass:
           Result:='tkClass';
       else
          Result:='tkUnknown';
       end;
end;

function TMercControl.GetAllPropertyName(): AnsiString;
var
Count1,Count2: Integer;
s1,s2:AnsiString;
begin
s2:='';
Count2:=0;

     if (FSubKind=tkSet)then
     begin
         Result:=GetSetNames(FObject,FSubName);
         exit;
     end;
     s1:=GetObjectAllPropertyName(FObject,Count1);
     if (Length(FSubName)=0) then
        s2:=GetAdditionalAllPropertyNameEx(Count2);
     Result :=inttostr(Count1+Count2)+';'+s1+s2+';';

end;

function  TMercControl.GetObjectAllPropertyName(obj:TObject;var Count: Integer): AnsiString;
var
  I: Integer;
  PropInfo: PPropInfo;
  TempList: PPropList;
  TypeInfo: PTypeInfo;
begin
  Result := '';
  TypeInfo:=obj.ClassInfo;
  Count := GetTypeData(TypeInfo)^.PropCount;
  if Count > 0 then
  begin
    GetMem(TempList, Count * SizeOf(Pointer));
    try
      GetPropInfos(TypeInfo, TempList);
      for I := 0 to Count - 1 do
      begin
        PropInfo := TempList^[I];
        Result:=Result+PropInfo.name+';';
      end;
    finally
      FreeMem(TempList, Count * SizeOf(Pointer));
    end;
  end;
end;

function  TMercControl.GetAdditionalAllPropertyNameEx(var Count: Integer): AnsiString;
begin
 Result := '';
 Count:=0;
end;

function  TMercControl.GetMercTag() :string ;
begin
  Result :=GetObjectProperty(FObject,'Caption');
  if (Result='') then  Result :=GetObjectProperty(FObject,'name');
end;
function  TMercControl.GetColor() :string ;
var
   Color: TColor;
begin
     Color:= strtoint(GetObjectProperty(FObject,'Color'));
     Result := ColorToString(Color);
end;

procedure TMercControl.SetColor(Value: string);
begin

end;

function  TMercControl.GetFixedColor() :string ;
var
   Color: TColor;
begin
     Color:= strtoint(GetObjectProperty(FObject,'FixedColor'));
     Result := ColorToString(Color);
end;

procedure TMercControl.SetFixedColor(Value: string);
begin

end;

function  TMercControl.GetCursor() :string ;
var
   Cursor: TCursor;
begin
     Cursor:= strtoint(GetObjectProperty(FObject,'Cursor'));
     Result := CursorToString(Cursor);
end;

procedure TMercControl.SetCursor(Value: string);
begin

end;

function  TMercControl.GetDragCursor() :string ;
var
   Cursor: TCursor;
begin
     Cursor:= strtoint(GetObjectProperty(FObject,'DragCursor'));
     Result := CursorToString(Cursor);
end;

procedure TMercControl.SetDragCursor(Value: string);
begin
end;

initialization
  InitMercControl();
finalization
  DoneMercControl();
end.
