{ Mike Palmer
  (c) Zonal Retail Data Systems Ltd. All Rights Reserved }

unit uRemoteRegistry;

interface

uses Windows;

{ Remote Registry Routines }
function RemoteRegistrySetString(const ARootKey:HKEY;const AName:string;const AValue:string):boolean;
function RemoteRegistrySetMultistring(const ARootKey:HKEY;const AName:string;const AValue:string):boolean;
function RemoteRegistrySetExpandstring(const ARootKey:HKEY;const AName:string;const AValue:string):boolean;
function RemoteRegistrySetDWORD(const ARootKey:HKEY;const AName:string;const AValue:cardinal):boolean;
function RemoteRegistrySetBinary(const ARootKey:HKEY;const AName:string;const AValue:array of byte):boolean;
function RemoteRegistryGetString(const ARootKey:HKEY;const AName:string;var AValue:string):boolean;
function RemoteRegistryGetMultistring(const ARootKey:HKEY;const AName:string;var AValue:string):boolean;
function RemoteRegistryGetExpandstring(const ARootKey:HKEY;const AName:string;var AValue:string):boolean;
function RemoteRegistryGetDWORD(const ARootKey:HKEY;const AName:string;var AValue:cardinal):boolean;
function RemoteRegistryGetBinary(const ARootKey:HKEY;const AName:string;var AValue:string):boolean;
function RemoteRegistryGetValueType(const ARootKey:HKEY;const AName:string;var AValue:cardinal):boolean;
function RemoteRegistryValueExists(const ARootKey:HKEY;const AName:string):boolean;
function RemoteRegistryKeyExists(const ARootKey:HKEY;const AName:string):boolean;
function RemoteRegistryDelValue(const ARootKey:HKEY;const AName:string):boolean;
function RemoteRegistryDelKey(const ARootKey:HKEY;const AName:string):boolean;
function RemoteRegistryConnect(const AMachineName:string;const ARootKey:HKEY;var ARemoteKey:HKEY):boolean;
function RemoteRegistryDisconnect(const ARemoteKey:HKEY):boolean;
function RemoteRegistryEnumKeys(const ARootKey:HKEY;const AName:string;var AKeyList:string):boolean;
function RemoteRegistryEnumValues(const ARootKey:HKEY;const AName:string;var AValueList:string):boolean;
{ End Remote Registry Routines }

implementation

{ Remote Registry Routines }

function LastPos(const ACharacter:Char;const Astring:string):integer;
begin
  for Result:=Length(Astring) downto 1 do
    if Astring[Result]=ACharacter then
      Break;
end;

function RemoteRegistryConnect(const AMachineName:string;const ARootKey:HKEY;var ARemoteKey:HKEY):boolean;
begin
  Result:=(RegConnectRegistry(PChar(AMachineName),ARootKey,ARemoteKey)=ERROR_SUCCESS);
end;

function RemoteRegistryDisconnect(const ARemoteKey:HKEY):boolean;
begin
  Result:=(RegCloseKey(ARemoteKey)=ERROR_SUCCESS);
end;

function RemoteRegistrySetValue(const ARootKey:HKEY;const AName:string;const AValType:cardinal;PVal:Pointer;const AValSize:Cardinal):boolean;
var
  SubKey:string;
  Index:integer;
  disposal:DWORD;
  TempKey:HKEY;
begin
  Result:=FALSE;
  Index:=LastPos('\',AName);
  if Index > 0 then
  begin
    SubKey:=Copy(AName,1,Index-1);
    if RegCreateKeyEx(ARootKey,PChar(SubKey),0,nil,REG_OPTION_NON_VOLATILE,KEY_WRITE,nil,TempKey,@disposal)=ERROR_SUCCESS then
    begin
      SubKey:=Copy(AName,Index+1,Length(AName)-Index);
      Result:=(RegSetValueEx(TempKey,PChar(SubKey),0,AValType,PVal,AValSize)=ERROR_SUCCESS);
      RegCloseKey(TempKey);
    end;
  end;
end;

function RemoteRegistryGetValue(const ARootKey:HKEY;const AName:string;const ValType:cardinal;var PVal:Pointer;
         var ValSize:cardinal):boolean;
var
  SubKey:string;
  Index:integer;
  MyValType:DWORD;
  TempKey:HKEY;
  Buffer:Pointer;
  BufferSize:Cardinal;
begin
  Result:=FALSE;
  Index:=LastPos('\',AName);
  if Index>0 then
  begin
    SubKey:=Copy(AName,1,Index-1);
    if RegOpenKeyEx(ARootKey,PChar(SubKey),0,KEY_READ,TempKey)=ERROR_SUCCESS then
    begin
      SubKey:=Copy(AName,Index+1,Length(AName)-Index);
      if RegQueryValueEx(TempKey,PChar(SubKey),nil,@MyValType,nil,@BufferSize)=ERROR_SUCCESS then
      begin
        GetMem(Buffer,BufferSize);
        if RegQueryValueEx(TempKey,PChar(SubKey),nil,@MyValType,Buffer,@BufferSize)=ERROR_SUCCESS then
        begin
          if ValType=MyValType then
          begin
            PVal:=Buffer;
            ValSize:=BufferSize;
            Result:=TRUE;
          end
          else FreeMem(Buffer);
        end else FreeMem(Buffer);
      end;
      RegCloseKey(TempKey);
    end;
  end;
end;

function RemoteRegistrySetstring(const ARootKey:HKEY;const AName:string;const AValue:string):boolean;
begin
  Result:=RegSetValue(ARootKey,PChar(AName),REG_SZ,PChar(AValue+#0),Length(AValue)+1)=ERROR_SUCCESS;
end;

function RemoteRegistrySetMultistring(const ARootKey:HKEY;const AName:string;const AValue:string):boolean;
begin
  Result:=RegSetValue(ARootKey,PChar(AName),REG_MULTI_SZ,PChar(AValue+#0#0),Length(AValue)+2)=ERROR_SUCCESS;
end;

function RemoteRegistrySetExpandstring(const ARootKey:HKEY;const AName:string;const AValue:string):boolean;
begin
  Result:=RegSetValue(ARootKey,PChar(AName),REG_EXPAND_SZ,PChar(AValue + #0),Length(AValue)+1)=ERROR_SUCCESS;
end;

function RemoteRegistrySetDword(const ARootKey:HKEY;const AName:string;const AValue:cardinal):boolean;
begin
  Result:=RegSetValue(ARootKey,PChar(AName),REG_DWORD,@AValue,SizeOf(cardinal))=ERROR_SUCCESS;
end;

function RemoteRegistrySetBinary(const ARootKey:HKEY;const AName:string;const AValue:array of Byte):boolean;
begin
  Result:=RegSetValue(ARootKey,PChar(AName),REG_BINARY,@AValue[Low(AValue)],length(AValue))=ERROR_SUCCESS;
end;

function RemoteRegistryGetString(const ARootKey:HKEY;const AName:string;var AValue:string):boolean;
var
  Buffer:Pointer;
  BufferSize:Cardinal;
begin
  Result:=FALSE;
  if RemoteRegistryGetValue(ARootKey,AName,REG_SZ,Buffer,BufferSize) then
  begin
    Dec(BufferSize);
    SetLength(AValue,BufferSize);
    if BufferSize > 0 then
      CopyMemory(@AValue[1],Buffer,BufferSize);
    FreeMem(Buffer);
    Result:=TRUE;
  end;
end;

function RemoteRegistryGetMultistring(const ARootKey:HKEY;const AName:string;var AValue:string):boolean;
var
  Buffer:Pointer;
  BufferSize:Cardinal;
begin
  Result:=FALSE;
  if RemoteRegistryGetValue(ARootKey,AName,REG_MULTI_SZ,Buffer,BufferSize) then
  begin
    Dec(BufferSize);
    SetLength(AValue,BufferSize);
    if BufferSize > 0 then
      CopyMemory(@AValue[1],Buffer,BufferSize);
    FreeMem(Buffer);
    Result:=TRUE;
  end;
end;

function RemoteRegistryGetExpandstring(const ARootKey:HKEY;const AName:string;var AValue:string):boolean;
var
  Buffer:Pointer;
  BufferSize:Cardinal;
begin
  Result:=FALSE;
  if RemoteRegistryGetValue(ARootKey,AName,REG_EXPAND_SZ,Buffer,BufferSize) then
  begin
    Dec(BufferSize);
    SetLength(AValue,BufferSize);
    if BufferSize > 0 then
      CopyMemory(@AValue[1],Buffer,BufferSize);
    FreeMem(Buffer);
    Result:=TRUE;
  end;
end;

function RemoteRegistryGetDWORD(const ARootKey:HKEY;const AName:string;var AValue:cardinal):boolean;
var
  Buffer:Pointer;
  BufferSize:Cardinal;
begin
  Result:=FALSE;
  if RemoteRegistryGetValue(ARootKey,AName,REG_DWORD,Buffer,BufferSize) then
  begin
    CopyMemory(@AValue,Buffer,BufferSize);
    FreeMem(Buffer);
    Result:=TRUE;
  end;
end;

function RemoteRegistryGetBinary(const ARootKey:HKEY;const AName:string;var AValue:string):boolean;
var
  Buffer:Pointer;
  BufferSize:Cardinal;
begin
  Result:=FALSE;
  if RemoteRegistryGetValue(ARootKey,AName,REG_BINARY,Buffer,BufferSize) then
  begin
    SetLength(AValue,BufferSize);
    CopyMemory(@AValue[1],Buffer,BufferSize);
    FreeMem(Buffer);
    Result:=TRUE;
  end;
end;

function RemoteRegistryValueExists(const ARootKey:HKEY;const AName:string):boolean;
var
  SubKey:string;
  Index:integer;
  TempKey:HKEY;
begin
  Result:=FALSE;
  Index:=LastPos('\',AName);
  if Index>0 then
  begin
    SubKey:=Copy(AName,1,Index-1);
    if RegOpenKeyEx(ARootKey,PChar(SubKey),0,KEY_READ,TempKey)=ERROR_SUCCESS then
    begin
      SubKey:=Copy(AName,Index+1,Length(AName)-Index);
      Result:=(RegQueryValueEx(TempKey,PChar(SubKey),nil,nil,nil,nil)=ERROR_SUCCESS);
      RegCloseKey(TempKey);
    end;
  end;
end;

function RemoteRegistryGetValueType(const ARootKey:HKEY;const AName:string;var AValue:Cardinal):boolean;
var
  SubKey:string;
  Index:integer;
  TempKey:HKEY;
  ValType:Cardinal;
begin
  Result:=FALSE;
  AValue:=REG_NONE;
  Index:=LastPos('\',AName);
  if Index>0 then
  begin
    SubKey:=Copy(AName,1,Index-1);
    if (RegOpenKeyEx(ARootKey,PChar(SubKey),0,KEY_READ,TempKey)=ERROR_SUCCESS) then
    begin
      SubKey:=Copy(AName,Index+1,Length(AName)-Index);
      Result:=(RegQueryValueEx(TempKey,PChar(SubKey),nil,@ValType,nil,nil)=ERROR_SUCCESS);
      if Result then
         AValue:=ValType;
      RegCloseKey(TempKey);
    end;
  end;
end;

function RemoteRegistryKeyExists(const ARootKey:HKEY;const AName:string):boolean;
var
  SubKey:string;
  Index:integer;
  TempKey:HKEY;
begin
  Result:=FALSE;
  Index:=LastPos('\',AName);
  if Index>0 then
  begin
    SubKey:=Copy(AName,1,Index-1);
    if RegOpenKeyEx(ARootKey,PChar(SubKey),0,KEY_READ,TempKey)=ERROR_SUCCESS then
    begin
      Result:=TRUE;
      RegCloseKey(TempKey);
    end;
  end;
end;

function RemoteRegistryDelValue(const ARootKey:HKEY;const AName:string):boolean;
var
  SubKey:string;
  Index:integer;
  TempKey:HKEY;
begin
  Result:=FALSE;
  Index:=LastPos('\',AName);
  if Index>0 then
  begin
    SubKey:=Copy(AName,1,Index-1);
    if RegOpenKeyEx(ARootKey,PChar(SubKey),0,KEY_WRITE,TempKey)=ERROR_SUCCESS then
    begin
      SubKey:=Copy(AName,Index+1,Length(AName)-Index);
      Result:=(RegDeleteValue(TempKey,PChar(SubKey))=ERROR_SUCCESS);
      RegCloseKey(TempKey);
    end;
  end;
end;

function RemoteRegistryDelKey(const ARootKey:HKEY;const AName:string):boolean;
var
  SubKey:string;
  Index:integer;
  TempKey:HKEY;
begin
  Result:=FALSE;
  Index:=LastPos('\',AName);
  if Index>0 then
  begin
    SubKey:=Copy(AName,1,Index-1);
    if RegOpenKeyEx(ARootKey,PChar(SubKey),0,KEY_WRITE,TempKey)=ERROR_SUCCESS then
    begin
      SubKey:=Copy(AName,Index+1,Length(AName)-Index);
      Result:=(RegDeleteKey(TempKey,PChar(SubKey))=ERROR_SUCCESS);
      RegCloseKey(TempKey);
    end;
  end;
end;

function RemoteRegistryEnum(const ARootKey:HKEY;const AName:string;var AResultList:string;const ADoKeys:Boolean):boolean;
var
  Index:integer;
  TempResult:integer;
  TempStr:string;
  TempKey:HKEY;
  Buffer:Pointer;
  BufferSize:Cardinal;
begin
  Result:=FALSE;
  AResultList:='';
  if RegOpenKeyEx(ARootKey,PChar(AName),0,KEY_READ,TempKey)=ERROR_SUCCESS then
  begin
    Result:=TRUE;
    BufferSize:=1024;
    GetMem(Buffer,BufferSize);
    Index:=0;
    TempResult:=ERROR_SUCCESS;
    while TempResult=ERROR_SUCCESS do
    begin
      BufferSize:=1024;
      if ADoKeys then
         TempResult:=RegEnumKeyEx(TempKey,Index,Buffer,BufferSize,nil,nil,nil,nil)
      else
         TempResult:=RegEnumValue(TempKey,Index,Buffer,BufferSize,nil,nil,nil,nil);
      if TempResult=ERROR_SUCCESS then
      begin
        SetLength(TempStr,BufferSize);
        CopyMemory(@TempStr[1],Buffer,BufferSize);
        if AResultList='' then
           AResultList:=TempStr
        else
           AResultList:=Concat(AResultList,#13#10,TempStr);
        inc(Index);
      end;
    end;
    FreeMem(Buffer);
    RegCloseKey(TempKey);
  end;
end;

function RemoteRegistryEnumValues(const ARootKey:HKEY;const AName:string;var AValueList:string):boolean;
begin
  Result:=RemoteRegistryEnum(ARootKey,AName,AValueList,FALSE);
end;

function RemoteRegistryEnumKeys(const ARootKey:HKEY;const AName:string;var AKeyList:string):boolean;
begin
  Result:=RemoteRegistryEnum(ARootKey,AName,AKeyList,TRUE);
end;

{ End Remote Registry Routines }

end.
