unit WmiRegistry;

interface
{$I ..\Common\define.inc}

{$NOINCLUDE WbemScripting_TLB}
{$HPPEMIT '#include <wbemdisp.h>'}
{$HPPEMIT '#include <oaidl.h>'}
{$HPPEMIT '#include "wbem_script_support.h"'}

uses
  Windows, Messages, SysUtils, Classes, WmiAbstract, WmiComponent, WmiUtil,
  WbemScripting_TLB,
  {$IFDEF Delphi6} Variants, {$ENDIF}
  WmiErr, NTStringTokenizer;

const
  // this constant is missing in Windows.pas
  REG_QWORD = 11;
  {$EXTERNALSYM REG_QWORD}


type
  TWmiRegistry = class(TWmiComponent)
  private
    { Private declarations }
    FRegistryProvider: OleVariant;
    FRootKey: DWORD;
    FCurrentPath: WideString;
    FSubKeys: TStrings;
    FValueNames: TStrings;
    FValueName: WideString;
    function  GetRegistryProvider: OleVariant;
    procedure SetRootKey(const Value: DWORD);
    procedure SetCurrentPath(const Value: WideString);
    procedure SetSubKeys(const Value: TStrings);
    function  GetSubKeys: TStrings;
    procedure ReadError(AMessage: string);
    function  GetKeyAccess: DWORD;
    procedure SetKeyAccess(const Value: DWORD);
    function  GetValues: TStrings;
    procedure SetValues(const Value: TStrings);
    function  GetValue: Variant;
    procedure SetValue(const Value: Variant);
    procedure SetValueName(const Value: WideString);
    procedure Set_ValueType(const Value: DWORD);
    function  Get_ValueType: DWORD;
  protected
    { Protected declarations }

    procedure CredentialsOrTargetChanged; override;
    property  RegistryProvider: OleVariant read GetRegistryProvider;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   ListSubKeys(AList: TStrings); overload;
    procedure   ListSubKeys(ARootKey: DWORD; AKey: string; AList: TStrings); overload;
    procedure   ListValues(AValues: TStrings);
    procedure   ListValuesAndTypes(AValues: TStrings);

    function    GetValueType(const Name: String): DWORD;
    function    CheckAccess(Access: DWORD): boolean;

    function    ReadBinaryData(const Name: String; var Buffer; BufSize: Integer): Integer;
    function    ReadBool(const Name: String): Boolean;
    function    ReadCurrency(const Name: String): Currency;
    function    ReadDate(const Name: String): TDateTime;
    function    ReadDateTime(const Name: String): TDateTime;
    function    ReadFloat(const Name: String): Double;
    function    ReadInteger(const Name: String): Integer;
    function    ReadString(const Name: String): String;
    function    ReadStringW(const Name: String): widestring;
    function    ReadMultiString(const Name: string): Variant;
    function    ReadTime(const Name: String): TDateTime;
    function    ReadValue(const Name: String): OleVariant;

    function    CreateKey(const Key: String): Boolean;
    function    DeleteKey(const Key: String): Boolean;
    function    DeleteValue(const Name: string): Boolean;
    function    ValueExists(const Name: String): Boolean;
    function    KeyExists(const Key: String): Boolean;
    function    GetParentKey(const Key: String): string;
    function    RegRootToString(AValue: DWORD): string;

    procedure   WriteBinaryData(const Name: String; var Buffer; BufSize: Integer);
    procedure   WriteBool(const Name: String; Value: Boolean);
    procedure   WriteCurrency(const Name: String; Value: Currency);
    procedure   WriteDate(const Name: String; Value: TDateTime);
    procedure   WriteDateTime(const Name: String; Value: TDateTime);
    procedure   WriteExpandString(const Name, Value: String);
    procedure   WriteFloat(const Name: String; Value: Double);
    procedure   WriteInteger(const Name: String; Value: Integer);
    procedure   WriteString(const Name, Value: String);
    procedure   WriteStringW(const Name: String; const Value: widestring);
    procedure   WriteMultiString(const Name: String; const Value: variant);
    procedure   WriteTime(const Name: String; Value: TDateTime);

  published
    property    Active;
    property    Credentials;
    property    MachineName;
    property    SystemInfo;

    property    RootKey:  DWORD  read FRootKey  write SetRootKey default HKEY_LOCAL_MACHINE;
    property    CurrentPath: WideString read FCurrentPath write SetCurrentPath;
    property    SubKeys: TStrings read GetSubKeys write SetSubKeys stored false;
    property    Values: TStrings read GetValues write SetValues stored false;
    property    KeyAccess: DWORD read GetKeyAccess write SetKeyAccess stored false;
    property    ValueName: WideString read FValueName write SetValueName;
    property    ValueType: DWORD read Get_ValueType write Set_ValueType;
    property    Value: Variant read GetValue write SetValue;
  end;


implementation

resourcestring
  ERROR_BUFFER_IS_TOO_SMALL = 'Buffer is too small';
  ERROR_INVALID_VALUE_TYPE = 'Invalid value type';


{ TWmiRegistry }

constructor TWmiRegistry.Create(AOwner: TComponent);
begin
  inherited;
  NameSpace   := NAMESPACE_DEFAULT;
  FRootKey    := HKEY_LOCAL_MACHINE;
  FSubKeys    := TStringList.Create;
  FValueNames := TStringList.Create;
end;

destructor TWmiRegistry.Destroy;
begin
  FSubKeys.Free;
  FValueNames.Free;
  inherited;
end;

function TWmiRegistry.RegRootToString(AValue: DWORD): string;
begin
  if AValue = HKEY_CLASSES_ROOT     then Result := 'HKEY_CLASSES_ROOT' else
  if AValue = HKEY_CURRENT_USER     then Result := 'HKEY_CURRENT_USER' else
  if AValue = HKEY_LOCAL_MACHINE    then Result := 'HKEY_LOCAL_MACHINE' else
  if AValue = HKEY_USERS            then Result := 'HKEY_USERS' else
  if AValue = HKEY_PERFORMANCE_DATA then Result := 'HKEY_PERFORMANCE_DATA' else
  if AValue = HKEY_CURRENT_CONFIG   then Result := 'HKEY_CURRENT_CONFIG' else
  if AValue = HKEY_DYN_DATA         then Result := 'HKEY_DYN_DATA' else
    Result := IntToStr(AValue);
end;

procedure TWmiRegistry.CredentialsOrTargetChanged;
begin
  inherited;
  FRegistryProvider := Unassigned;
end;

function TWmiRegistry.GetRegistryProvider: OleVariant;
var
  vObject: ISWbemObject;
begin
  if Active then
  begin
    if VarIsEmpty(FRegistryProvider) then
    begin
      WmiCheck(WmiServices.Get('StdRegProv', 0, nil, vObject));
      FRegistryProvider := vObject;
    end;
  end else
  begin
    FRegistryProvider := Unassigned;
  end;
  Result := FRegistryProvider;
end;

procedure TWmiRegistry.ListSubKeys(ARootKey: DWORD; AKey: string; AList: TStrings);
var
  vVar: OleVariant;
  vLow, vHigh, i: integer;
begin
  if VarIsEmpty(RegistryProvider) then Exit;
  WmiCheck(RegistryProvider.EnumKey(ARootKey, AKey, vVar));
  if (not VarIsEmpty(vVar)) and VarIsArray(vVar) then
  begin
    vLow  := VarArrayLowBound(vVar, 1);
    vHigh := VarArrayHighBound(vVar, 1);
    for i := vLow to vHigh do AList.Add(vVar[i]);
  end;
end;

procedure TWmiRegistry.ListSubKeys(AList: TStrings);
begin
  ListSubKeys(RootKey, CurrentPath, AList);
end;

procedure TWmiRegistry.ListValues(AValues: TStrings);
var
  vList: TStrings;
  i: integer;
begin
  vList := TStringList.Create;
  try
    ListValuesAndTypes(vList);
    for i := 0 to vList.Count - 1 do
    begin
      AValues.Add(vList.Names[i]);
    end;
  finally
    vList.Free;
  end;
end;

procedure TWmiRegistry.ListValuesAndTypes(AValues: TStrings);
var
  vNames, vTypes: OleVariant;
  s: string;
  vLow, vHigh, i: integer;
  vDefaultValueFound: boolean;
begin
  if VarIsEmpty(RegistryProvider) then Exit;
  vDefaultValueFound := false;
  WmiCheck(RegistryProvider.EnumValues(RootKey, CurrentPath, vNames, vTypes));
  if (not VarIsEmpty(vNames)) and VarIsArray(vNames) then
  begin
    vLow  := VarArrayLowBound(vNames, 1);
    vHigh := VarArrayHighBound(vNames, 1);
    for i := vLow to vHigh do
    begin
      s := vNames[i];
      if s = '' then vDefaultValueFound := true;
      s := s + '=';
      s := s + IntToStr(vTypes[i]);
      AValues.Add(s);
    end;
  end;
  if not vDefaultValueFound then AValues.Add('='+IntToStr(REG_SZ)); // add default value
end;

procedure TWmiRegistry.SetCurrentPath(const Value: WideString);
begin
  if FCurrentPath <> Value then
  begin
    FCurrentPath := Value;
    FSubKeys.Clear;
    FValueNames.Clear;
  end;
end;

procedure TWmiRegistry.SetRootKey(const Value: DWORD);
begin
  if FRootKey <> Value then
  begin
    FRootKey := Value;
    FSubKeys.Clear;
    FValueNames.Clear;
  end;
end;

procedure TWmiRegistry.SetSubKeys(const Value: TStrings); begin end;
procedure TWmiRegistry.SetKeyAccess(const Value: DWORD);begin end;

function TWmiRegistry.GetSubKeys: TStrings;
begin
  if FSubKeys.Count = 0 then
  begin
    ListSubKeys(FSubKeys);
  end;
  Result := FSubKeys;
end;

function TWmiRegistry.ReadBinaryData(const Name: String; var Buffer;
  BufSize: Integer): Integer;
var
  vVar: OleVariant;
  vLow, vHigh, i: integer;
  vByte: byte;
begin
  Result := 0;
  if VarIsEmpty(RegistryProvider) then RaiseNotActiveException;
  RegistryProvider.GetBinaryValue(RootKey, CurrentPath, Name, vVar);
  if (not VarIsEmpty(vVar) and VarIsArray(vVar)) then
  begin
    vLow  := VarArrayLowBound(vVar, 1);
    vHigh := VarArrayHighBound(vVar, 1);
    Result := vHigh - vLow + 1;
    if Result > BufSize then raise TWmiException.Create(ERROR_BUFFER_IS_TOO_SMALL);

    for i := vLow to vHigh do
    begin
      vByte := vVar[i];
      TByteArray(Buffer)[i-vLow] := vByte;
    end;
  end;
end;

function TWmiRegistry.ReadBool(const Name: String): Boolean;
begin
  Result := ReadInteger(Name) <> 0;
end;

function TWmiRegistry.ReadCurrency(const Name: String): Currency;
begin
  if GetValueType(Name) <> REG_BINARY then
    ReadError(ERROR_INVALID_VALUE_TYPE);
  if ReadBinaryData(Name, result, SizeOf(Result)) <> SizeOf(Result) then
    ReadError(ERROR_INVALID_VALUE_TYPE);
end;

procedure TWmiRegistry.ReadError(AMessage: string);
begin
  raise TWmiException.Create(AMessage);
end;

function TWmiRegistry.ReadDate(const Name: String): TDateTime;
begin
  Result := ReadDateTime(Name);
end;

function TWmiRegistry.ReadDateTime(const Name: String): TDateTime;
begin
  if GetValueType(Name) <> REG_BINARY then
    ReadError(ERROR_INVALID_VALUE_TYPE);
  if ReadBinaryData(Name, result, SizeOf(Result)) <> SizeOf(Result) then
    ReadError(ERROR_INVALID_VALUE_TYPE);
end;

function TWmiRegistry.ReadFloat(const Name: String): Double;
begin
  if GetValueType(Name) <> REG_BINARY then
    ReadError(ERROR_INVALID_VALUE_TYPE);
  if ReadBinaryData(Name, result, SizeOf(Result)) <> SizeOf(Result) then
    ReadError(ERROR_INVALID_VALUE_TYPE);
end;

function TWmiRegistry.ReadInteger(const Name: String): Integer;
var
  vVar: OleVariant;  
begin
  Result := 0;
  if VarIsEmpty(RegistryProvider) then RaiseNotActiveException;
  WmiCheck(RegistryProvider.GetDWORDValue(RootKey, CurrentPath, Name, vVar));
  if not VarIsEmpty(vVar) then Result := vVar;
end;

function TWmiRegistry.ReadString(const Name: String): String;
var
  vVar: OleVariant;  
begin
  Result := '';
  if VarIsEmpty(RegistryProvider) then RaiseNotActiveException;
  WmiCheck(RegistryProvider.GetStringValue(RootKey, CurrentPath, Name, vVar));
  if not (VarIsEmpty(vVar) or VarIsNull(vVar)) then Result := vVar;
end;

function TWmiRegistry.ReadTime(const Name: String): TDateTime;
begin
  Result := ReadDateTime(Name);
end;

function TWmiRegistry.ReadValue(const Name: String): OleVariant;
begin
  Result := Unassigned;
  if VarIsEmpty(RegistryProvider) then RaiseNotActiveException;
  case GetValueType(Name) of
    REG_NONE:      Result := Null;
    REG_SZ:        WmiCheck(RegistryProvider.GetStringValue(RootKey, CurrentPath, Name, Result));
    REG_EXPAND_SZ: WmiCheck(RegistryProvider.GetExpandedStringValue(RootKey, CurrentPath, Name, Result));
    REG_BINARY:    WmiCheck(RegistryProvider.GetBinaryValue(RootKey, CurrentPath, Name, Result));
    REG_DWORD:     WmiCheck(RegistryProvider.GetDWORDValue(RootKey, CurrentPath, Name, Result));
    REG_MULTI_SZ:  WmiCheck(RegistryProvider.GetMultiStringValue(RootKey, CurrentPath, Name, Result));
    else Result := Unassigned;
  end;
end;

function TWmiRegistry.GetValueType(const Name: String): DWORD;
var
  vList: TStrings;
  vName, s: string;
  i: integer;
begin
  Result := REG_NONE;
  vList := TStringList.Create;
  try
    ListValuesAndTypes(vList);
    vName := UpperCase(Name);
    for i := 0 to vList.Count - 1 do
    begin
      if vName = UpperCase(vList.Names[i]) then
      begin
        s := vList.Values[vList.Names[i]];
        Result := StrToIntDef(s, REG_NONE);
        Exit;
      end;
    end;
  finally
    vList.Free;
  end;
end;

function TWmiRegistry.CheckAccess(Access: DWORD): boolean;
var
  vVar: OleVariant;
begin
  Result := false;
  if VarIsEmpty(RegistryProvider) then Exit;
  RegistryProvider.CheckAccess(RootKey, CurrentPath, Access, vVar);
  if not VarIsEmpty(vVar) then Result := vVar;
end;

function TWmiRegistry.GetKeyAccess: DWORD;
begin
  result := 0;
  if CheckAccess(KEY_QUERY_VALUE) then Result := Result or KEY_QUERY_VALUE;
  if CheckAccess(KEY_SET_VALUE) then Result := Result or KEY_SET_VALUE;
  if CheckAccess(KEY_CREATE_SUB_KEY) then Result := Result or KEY_CREATE_SUB_KEY;
  if CheckAccess(KEY_ENUMERATE_SUB_KEYS) then Result := Result or KEY_ENUMERATE_SUB_KEYS;
  if CheckAccess(KEY_NOTIFY) then Result := Result or KEY_NOTIFY;
  if CheckAccess(KEY_CREATE_LINK) then Result := Result or KEY_CREATE_LINK;
  if CheckAccess(_DELETE) then Result := Result or _DELETE;
  if CheckAccess(READ_CONTROL) then Result := Result or READ_CONTROL;
  if CheckAccess(WRITE_DAC) then Result := Result or WRITE_DAC;
  if CheckAccess(WRITE_OWNER) then Result := Result or WRITE_OWNER;
end;

function TWmiRegistry.GetValues: TStrings;
begin
  if FValueNames.Count = 0 then
  begin
    ListValues(FValueNames);
  end;
  Result := FValueNames;
end;

procedure TWmiRegistry.SetValues(const Value: TStrings);  begin end;

function TWmiRegistry.GetValue: Variant;
begin
   Result := Unassigned;
   if VarIsEmpty(RegistryProvider) then Exit;
   Result := ReadValue(ValueName);
   if IsDesignTime then Result := VariantToString(Result);
end;

procedure TWmiRegistry.SetValue(const Value: Variant);
begin
   // fixme: implement changing values.
end;

procedure TWmiRegistry.SetValueName(const Value: WideString);
begin
  if FValueName <> Value then
  begin
    FValueName := Value;
  end;
end;

procedure TWmiRegistry.Set_ValueType(const Value: DWORD);begin end;

function TWmiRegistry.Get_ValueType: DWORD;
begin
  Result := GetValueType(ValueName);
end;

function TWmiRegistry.CreateKey(const Key: String): Boolean;
var
  vKey: string;
  vRes: HRESULT;
begin
  if ((Length(Key) > 0) and (Key[1] = '\')) then
  begin
    vKey := Copy(Key, 2, Length(Key) - 1);
  end else
  begin
    if CurrentPath <> '' then vKey := CurrentPath + '\' + Key
      else vKey := Key;
  end;

  vRes := RegistryProvider.CreateKey(RootKey, vKey);
  WmiCheck(vRes);
  Result := vRes = S_OK;
end;

function TWmiRegistry.DeleteKey(const Key: String): Boolean;
var
  vKey: string;
  vRes: HRESULT;
begin
  if ((Length(Key) > 0) and (Key[1] = '\')) then vKey := Copy(Key, 2, Length(Key) - 1)
    else vKey := Key;

  vRes := RegistryProvider.DeleteKey(RootKey, vKey);
  WmiCheck(vRes);
  Result := vRes = S_OK;
end;

procedure TWmiRegistry.WriteBinaryData(const Name: String; var Buffer; BufSize: Integer);
var
  vVar: OleVariant;
  i: integer;
begin
  if VarIsEmpty(RegistryProvider) then RaiseNotActiveException;
  vVar := VarArrayCreate([0, BufSize - 1], varByte);
  for i := 0 to BufSize - 1 do vVar[i] := TByteArray(Buffer)[i];
  WmiCheck(RegistryProvider.SetBinaryValue(RootKey, CurrentPath, Name, vVar));
end;

procedure TWmiRegistry.WriteBool(const Name: String; Value: Boolean);
begin
  WriteInteger(Name, Ord(Value));
end;

procedure TWmiRegistry.WriteCurrency(const Name: String; Value: Currency);
begin
  WriteBinaryData(Name, Value, SizeOf(Currency));
end;

procedure TWmiRegistry.WriteDate(const Name: String; Value: TDateTime);
begin
  WriteDateTime(Name, Value);
end;

procedure TWmiRegistry.WriteDateTime(const Name: String; Value: TDateTime);
begin
  WriteBinaryData(Name, Value, SizeOf(TDateTime));
end;

procedure TWmiRegistry.WriteExpandString(const Name, Value: String);
begin
  WmiCheck(RegistryProvider.SetExpandedStringValue(RootKey, CurrentPath, Name, Value));
end;

procedure TWmiRegistry.WriteFloat(const Name: String; Value: Double);
begin
  WriteBinaryData(Name, Value, SizeOf(Double));
end;

procedure TWmiRegistry.WriteInteger(const Name: String; Value: Integer);
begin
  WmiCheck(RegistryProvider.SetDWORDValue(RootKey, CurrentPath, Name, Value));
end;

procedure TWmiRegistry.WriteString(const Name, Value: String);
begin
  WmiCheck(RegistryProvider.SetStringValue(RootKey, CurrentPath, Name, Value));
end;

procedure TWmiRegistry.WriteTime(const Name: String; Value: TDateTime);
begin
  WriteDateTime(Name, Value);
end;

function TWmiRegistry.DeleteValue(const Name: string): Boolean;
var
  vRes: HRESULT;
begin
  vRes := RegistryProvider.DeleteValue(RootKey, CurrentPath, Name);
  WmiCheck(vRes);
  result := vRes = S_OK; 
end;

function TWmiRegistry.ValueExists(const Name: String): Boolean;
var
  vName: string;
  vList: TStrings;
  i: integer;
begin
  Result := false;
  vName := UpperCase(Name);
  vList := TStringList.Create;
  try
    ListValues(vList);
    for i := 0 to vList.Count - 1 do
      if UpperCase(vList[i]) = vName then
      begin
        Result := true;
        Exit;
      end;
  finally
    vList.Free;
  end;
end;

function TWmiRegistry.KeyExists(const Key: String): Boolean;
var
  vParentKey: string;
  vList: TStrings;
  vKey, tmpKey: string;
  i, vEndPos, vStartPos: integer;
  
begin
  result := false;

  vEndPos := Length(Key);
  vStartPos := 1;
  while (Key[vEndPos] = '\') and (vEndPos > 0) do Dec(vEndPos);
  while (Key[vStartPos] = '\') and (vStartPos < Length(Key)) do Inc(vStartPos);
  if (vStartPos <> 1) or (vEndPos <> Length(Key)) then
    vKey := UpperCase(Copy(Key, vStartPos, vEndPos - vStartPos + 1))
    else vKey := UpperCase(Key);

  vParentKey := GetParentKey(vKey);
  vList := TStringList.Create;
  try
    ListSubKeys(RootKey, vParentKey, vList);
    for i := 0 to vList.Count - 1 do
    begin
      if vParentKey = '' then tmpKey := vList[i]
        else tmpKey := vParentKey + '\' + vList[i];
      if UpperCase(tmpKey) = vKey then
      begin
        Result := true;
        Exit;
      end;
    end;
  finally
    vList.Free;
  end;

end;

function TWmiRegistry.GetParentKey(const Key: String): string;
var
  vEndPos: integer;
  vStartPos: integer;
begin
  Result := '';
  vEndPos := Length(Key);
  vStartPos := 1;
  while (Key[vEndPos] = '\') and (vEndPos > 0) do Dec(vEndPos);
  while (Key[vEndPos] <> '\') and (vEndPos > 0) do Dec(vEndPos);
  while (Key[vStartPos] = '\') and (vStartPos < Length(Key)) do Inc(vStartPos);

  if vEndPos > vStartPos then Result := Copy(Key, vStartPos, vEndPos - vStartPos);
end;

function TWmiRegistry.ReadStringW(const Name: String): widestring;
var
  vVar: OleVariant;
  vLow, vHigh, i: integer;
  vByte: byte;
  vLen: integer;
  vBuf: Pointer;
  vWideChar: PWideChar; 
begin
  Result := '';
  if VarIsEmpty(RegistryProvider) then RaiseNotActiveException;
  RegistryProvider.GetBinaryValue(RootKey, CurrentPath, Name, vVar);
  if (not VarIsEmpty(vVar) and VarIsArray(vVar)) then
  begin
    vLow  := VarArrayLowBound(vVar, 1);
    vHigh := VarArrayHighBound(vVar, 1);
    vLen := vHigh - vLow + 1;
    GetMem(vBuf, vLen);
    try
      for i := vLow to vHigh do
      begin
        vByte := vVar[i];
        PByteArray(vBuf)^[i-vLow] := vByte;
      end;

      vWideChar := PWideChar(vBuf);
      Result := vWideChar;
    finally
      FreeMem(vBuf);
    end;
  end;
end;

procedure TWmiRegistry.WriteStringW(const Name: String;
  const Value: widestring);
begin
  WriteBinaryData(Name, PWideChar(Value)^, Length(Value) * 2 + 2);
end;

function TWmiRegistry.ReadMultiString(const Name: string): Variant;
var
  vVar: OleVariant;  
begin
  Result := Null;
  if VarIsEmpty(RegistryProvider) then RaiseNotActiveException;
  WmiCheck(RegistryProvider.GetMultiStringValue(RootKey, CurrentPath, Name, vVar));
  if not (VarIsEmpty(vVar) or VarIsNull(vVar)) then Result := vVar;
end;

procedure TWmiRegistry.WriteMultiString(const Name: String;
  const Value: variant);
begin
  WmiCheck(RegistryProvider.SetMultiStringValue(RootKey, CurrentPath, Name, Value));
end;

initialization

finalization

end.
