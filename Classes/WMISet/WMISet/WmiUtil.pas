unit WmiUtil;

interface
{$I ..\Common\define.inc}

{$NOINCLUDE WbemScripting_TLB}
{$HPPEMIT '#include <wbemdisp.h>'}
{$HPPEMIT '#include <oaidl.h>'}
{$HPPEMIT '#include "wbem_script_support.h"'}

Uses Windows, Classes, DB, ActiveX, WbemScripting_TLB, WmiErr,
     {$IFDEF Delphi6}
     Variants,
     {$ENDIF}
     SysUtils, InitComSecurity, NTStringTokenizer;

const
  // known namespaces.
  // one can get list of namespaces by connecting to namespace "root"
  // and executing the query: "select * from __NAMESPACE" 
  NAMESPACE_ROOT     = 'root';
  NAMESPACE_WINNT    = 'WinNT:';
  NAMESPACE_CIMV2    = 'root\cimv2';
  NAMESPACE_DEFAULT  = 'root\default';
  NAMESPACE_WMI      = 'root\WMI';
  NAMESPACE_SECURITY = 'root\security';
  NAMESPACE_DIRECTORY = 'root\directory';



type
  TErrorFunction = function(AErrorCode: integer): widestring;


type
  TWmiPrivilege = (wmiPrivilegeCreateToken,
                   wmiPrivilegePrimaryToken,
                   wmiPrivilegeLockMemory,
                   wmiPrivilegeIncreaseQuota,
                   wmiPrivilegeMachineAccount,
                   wmiPrivilegeTcb,
                   wmiPrivilegeSecurity,
                   wmiPrivilegeTakeOwnership,
                   wmiPrivilegeLoadDriver,
                   wmiPrivilegeSystemProfile,
                   wmiPrivilegeSystemtime,
                   wmiPrivilegeProfileSingleProcess,
                   wmiPrivilegeIncreaseBasePriority,
                   wmiPrivilegeCreatePagefile,
                   wmiPrivilegeCreatePermanent,
                   wmiPrivilegeBackup,
                   wmiPrivilegeRestore,
                   wmiPrivilegeShutdown,
                   wmiPrivilegeDebug,
                   wmiPrivilegeAudit,
                   wmiPrivilegeSystemEnvironment,
                   wmiPrivilegeChangeNotify,
                   wmiPrivilegeRemoteShutdown,
                   wmiPrivilegeUndock,
                   wmiPrivilegeSyncAgent,
                   wmiPrivilegeEnableDelegation);

  TWmiPrivileges = set of TWmiPrivilege;

const
  // names of priviliges: must be declared in the same order as
  // in TWmiPrivilege enumeration.
  PRIVILEGE_NAMES: array[TWmiPrivilege] of string = (
    'SeCreateTokenPrivilege',
    'SeAssignPrimaryTokenPrivilege',
    'SeLockMemoryPrivilege',
    'SeIncreaseQuotaPrivilege',
    'SeMachineAccountPrivilege',
    'SeTcbPrivilege',
    'SeSecurityPrivilege',
    'SeTakeOwnershipPrivilege',
    'SeLoadDriverPrivilege',
    'SeSystemProfilePrivilege',
    'SeSystemtimePrivilege',
    'SeProfileSingleProcessPrivilege',
    'SeIncreaseBasePriorityPrivilege',
    'SeCreatePagefilePrivilege',
    'SeCreatePermanentPrivilege',
    'SeBackupPrivilege',
    'SeRestorePrivilege',
    'SeShutdownPrivilege',
    'SeDebugPrivilege',
    'SeAuditPrivilege',
    'SeSystemEnvironmentPrivilege',
    'SeChangeNotifyPrivilege',
    'SeRemoteShutdownPrivilege',
    'SePrivilegeUndock',
    'SePrivilegeSyncAgent',
    'SePrivilegeEnableDelegation'
    );



  function  WmiPrivilegeToOleEnum(APrivilege: TWmiPrivilege): TOleEnum;
  function  WmiPrivilegeNameToOleEnum(AName: widestring): TOleEnum;
  function  WmiGetObjectProperties(AObject: ISWbemObject): IEnumVariant;
  function  WmiGetMethodQualifiers(AMethod: ISWbemMethod): IEnumVariant;
  function  WmiGetObjectMethods(AObject: ISWbemObject): IEnumVariant; 
  function  WmiGetMethodParams(AMethod: ISWbemMethod): IEnumVariant; 
  function  WmiGetObjectProperty(AObject: ISWbemObject; APropertyName: widestring): ISWbemProperty;
  function  WmiGetObjectMethod(AObject: ISWbemObject; AMethodName: widestring): ISWbemMethod;
  function  WmiGetObjectMethodSafe(AObject: ISWbemObject; AMethodName: widestring): ISWbemMethod;
  function  WmiGetPropertyValueByName(const AProperties: ISWbemPropertySet; const APropertyName: widestring): OleVariant;
  function  WmiGetPropertyValueByNameSafe(AProperties: ISWbemPropertySet; APropertyName: widestring): OleVariant;
  function  WmiGetInt64PropertyValueByName(AProperties: ISWbemPropertySet; APropertyName: widestring): int64;
  function  WmiGetInt64PropertyValueByNameSafe(AProperties: ISWbemPropertySet; APropertyName: widestring): int64;
  function  WmiGetFloatPropertyValueByName(AProperties: ISWbemPropertySet; APropertyName: widestring): double;
  function  WmiGetCardinalPropertyValueByName(AProperties: ISWbemPropertySet; APropertyName: widestring): cardinal;
  function  WmiGetCardinalPropertyValueByNameSafe(AProperties: ISWbemPropertySet; APropertyName: widestring): cardinal;
  function  WmiGetStringPropertyValueByName(AProperties: ISWbemPropertySet; APropertyName: widestring): widestring;
  function  WmiGetStringPropertyValueByNameSafe(AProperties: ISWbemPropertySet; APropertyName: widestring): widestring;
  function  WmiGetBooleanPropertyValueByName(AProperties: ISWbemPropertySet; APropertyName: widestring): boolean;
  function  WmiGetBooleanPropertyValueByNameSafe(AProperties: ISWbemPropertySet; APropertyName: widestring): boolean;
  function  WmiGetIntegerPropertyValueByName(AProperties: ISWbemPropertySet; APropertyName: widestring): integer;
  function  WmiGetIntegerPropertyValueByNameSafe(AProperties: ISWbemPropertySet; APropertyName: widestring): integer;

  function  WmiGetStringPropertyValue(AProperty: ISWbemProperty): string;
  function  WmiGetIntegerPropertyValue(AProperty: ISWbemProperty): integer;
  function  WmiGetVariantPropertyValue(AProperty: ISWbemProperty): OleVariant;
  function  WmiGetBooleanPropertyValue(AProperty: ISWbemProperty): boolean;

  function  WmiParseDateTime(ADate: string): TDateTime; overload;
  procedure WmiParseDateTime(ADate: string; var ResTime: TDateTime; var ResTimeZone: integer); overload;
  // TimeZone parameter is a number of minutes between LocalTime zone and GMT
  function  WmiEncodeDateTime(ADateTime: TDateTime; TimeZone: integer): WideString; overload;
  function  WmiEncodeDateTime(ADateTime: TDateTime): WideString; overload;
  function  WmiEncodeTime(ADateTime: TDateTime; TimeZone: integer): WideString; overload;
  function  WmiEncodeTime(ADateTime: TDateTime): WideString; overload;

  procedure WmiSetPropertyValueByName(AProperties: ISWbemPropertySet; APropertyName: widestring; AValue: OleVariant);

  procedure WmiSetObjectPropertyValue(AObject: ISWbemObject; APropertyName: widestring; APropertyValue: OleVariant);
  procedure WmiSetStringPropertyValue(AObject: ISWbemObject; APropertyName: widestring; APropertyValue: widestring);
  procedure WmiSetStringPropertyValueAndCommit(AObject: ISWbemObject; APropertyName: widestring; APropertyValue: widestring);
  procedure WmiSetBooleanPropertyValueAndCommit(AObject: ISWbemObject; APropertyName: widestring; APropertyValue: boolean);
  procedure WmiSetIntegerPropertyValue(AObject: ISWbemObject; APropertyName: widestring; APropertyValue: integer);
  procedure WmiSetIntegerPropertyValueAndCommit(AObject: ISWbemObject; APropertyName: widestring; APropertyValue: integer);
  procedure WmiSetDWORDPropertyValue(AObject: ISWbemObject; APropertyName: widestring; APropertyValue: DWORD);

  procedure WmiSetStringParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: widestring);
  procedure WmiSetObjectParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: OleVariant);
  procedure WmiSetIntegerParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: Integer);
  procedure WmiSetDWORDParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: DWORD);
  procedure WmiSetDateTimeParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: TDateTime; ATimeZone: integer); overload;
  procedure WmiSetDateTimeParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: TDateTime); overload;
  procedure WmiSetTimeParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: TDateTime; ATimeZone: integer); overload;
  procedure WmiSetTimeParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: TDateTime); overload;
  function  WmiAddParameter(Parameters: ISWbemObject; AParamName: widestring; AParamType: integer): ISWbemProperty; overload;
  function  WmiAddParameter(Parameters: ISWbemObject; AParamName: widestring): ISWbemProperty; overload;

  function  WmiExecObjectMethod(AObject: ISWbemObject; AMethodName: widestring; AErrorFunction: TErrorFunction): ISWbemObject; overload;
  function  WmiExecObjectMethod(AObject: ISWbemObject; AMethodName: widestring; InParams: ISWbemObject; AErrorFunction: TErrorFunction): ISWbemObject; overload;

  function  WmiGetClassMethod(AClass: ISWbemObject; AMethodName: widestring): ISWbemMethod;
  function  WmiCreateClassMethodParameters(AClass: ISWbemObject; AMethodName: widestring): ISWbemObject;
  function  WmiExecSelectQuery(AWmiServices: ISWbemServices; AQuery: widestring): IEnumVariant;

  // executes give select query and returns the first object from the result set.
  function  WmiSelectSingleEntity(AWmiServices: ISWbemServices; AQuery: widestring): ISWbemObject;

  // executes given select query in prototyping mode,
  // and returns the first object from the result set, which looks exactly like
  // real object, but represent no real data.
  function  WmiGetPrototypeObject(AQuery: widestring): ISWbemObject;

  // get connection to local computer
  function  WmiGetServices: ISWbemServices;

  procedure WmiSetPrivilegeEnabled(AObject:   ISWbemObject; APrivilege: WbemPrivilegeEnum; IsEnabled: boolean); overload;
  procedure WmiSetPrivilegeEnabled(AServices: ISWbemServices; APrivilege: WbemPrivilegeEnum; IsEnabled: boolean);  overload;
  procedure WmiSetPrivilegeEnabled(ASource:   ISWbemEventSource; APrivilege: WbemPrivilegeEnum; IsEnabled: boolean);  overload;

  function WmiGetPrivilegeEnabled(AObject: ISWbemObject; APrivilege: WbemPrivilegeEnum): boolean;


  function VariantToInt64(AValue: string): int64;
  function VariantToCardinal(AValue: string): cardinal;
  function VariantToFloat(AValue: string): double;
  function VariantToString(AVariant: Variant): string;
  function StringToVariantArray(AString: string): Variant;

  procedure CimTypeToFieldType(ACimType: TOleEnum;
                               AIsArray: wordbool;
                               var AType: TFieldType;
                               var ASize: word);
  procedure FieldTypeToCimType(AType: TFieldType;
                               ASize: word;
                               var ACimType: TOleEnum;
                               var IsArray: boolean);

  function  WmiGetLibVersion: widestring;

{$IFNDEF Delphi7}
function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
{$ENDIF}

{$IFNDEF Delphi6}
function AnsiStartsText(const ASubText, AText: string): Boolean;
{$ENDIF}


implementation

resourcestring
  INVALID_DATE_FORMAT = 'Invaid date format: %s';



function VariantToFloat(AValue: string): double;
begin
  if AValue <> '' then Result := StrToFloat(AValue) else
    Result := 0;
end;

function VariantToInt64(AValue: string): int64;
begin
  if AValue <> '' then Result := StrToInt64(AValue) else
    Result := 0;
end;

function VariantToCardinal(AValue: string): cardinal;
begin
  if AValue <> '' then Result := StrToInt64(AValue) else
    Result := 0;
end;

function WmiPrivilegeToOleEnum(APrivilege: TWmiPrivilege): TOleEnum;
begin
  case APrivilege of
    wmiPrivilegeCreateToken:          Result := wbemPrivilegeCreateToken;
    wmiPrivilegePrimaryToken:         Result := wbemPrivilegePrimaryToken;
    wmiPrivilegeLockMemory:           Result := wbemPrivilegeLockMemory;
    wmiPrivilegeIncreaseQuota:        Result := wbemPrivilegeIncreaseQuota;
    wmiPrivilegeMachineAccount:       Result := wbemPrivilegeMachineAccount;
    wmiPrivilegeTcb:                  Result := wbemPrivilegeTcb;
    wmiPrivilegeSecurity:             Result := wbemPrivilegeSecurity;
    wmiPrivilegeTakeOwnership:        Result := wbemPrivilegeTakeOwnership;
    wmiPrivilegeLoadDriver:           Result := wbemPrivilegeLoadDriver;
    wmiPrivilegeSystemProfile:        Result := wbemPrivilegeSystemProfile;
    wmiPrivilegeSystemtime:           Result := wbemPrivilegeSystemtime;
    wmiPrivilegeProfileSingleProcess: Result := wbemPrivilegeProfileSingleProcess;
    wmiPrivilegeIncreaseBasePriority: Result := wbemPrivilegeIncreaseBasePriority;
    wmiPrivilegeCreatePagefile:       Result := wbemPrivilegeCreatePagefile;
    wmiPrivilegeCreatePermanent:      Result := wbemPrivilegeCreatePermanent;
    wmiPrivilegeBackup:               Result := wbemPrivilegeBackup;
    wmiPrivilegeRestore:              Result := wbemPrivilegeRestore;
    wmiPrivilegeShutdown:             Result := wbemPrivilegeShutdown;
    wmiPrivilegeDebug:                Result := wbemPrivilegeDebug;
    wmiPrivilegeAudit:                Result := wbemPrivilegeAudit;
    wmiPrivilegeSystemEnvironment:    Result := wbemPrivilegeSystemEnvironment;
    wmiPrivilegeChangeNotify:         Result := wbemPrivilegeChangeNotify;
    wmiPrivilegeRemoteShutdown:       Result := wbemPrivilegeRemoteShutdown;
    wmiPrivilegeUndock:               Result := wbemPrivilegeUndock;
    wmiPrivilegeSyncAgent:            Result := wbemPrivilegeSyncAgent;
    wmiPrivilegeEnableDelegation:     Result := wbemPrivilegeEnableDelegation;
    else Result := 0;
  end;
end;


function  WmiPrivilegeNameToOleEnum(AName: widestring): TOleEnum;
var
  i: TWmiPrivilege;
begin
  Result := 0;
  for i := Low(TWmiPrivilege) to High(TWmiPrivilege) do
    if CompareText(AName, PRIVILEGE_NAMES[i]) = 0 then
    begin
      Result := WmiPrivilegeToOleEnum(i);
      Exit;
    end;  
end;

function WmiGetObjectProperties(AObject: ISWbemObject): IEnumVariant;
var
  vProperties: ISWbemPropertySet;
  vUnknown:    IUnknown;
begin
  WmiCheck(AObject.Get_Properties_(vProperties));
  WmiCheck(vProperties.Get__NewEnum(vUnknown));
  Result := vUnknown as IEnumVariant;
end;

function  WmiGetObjectMethods(AObject: ISWbemObject): IEnumVariant; 
var
  vMethods: ISWbemMethodSet;
  vUnknown:    IUnknown;
begin
  WmiCheck(AObject.Get_Methods_(vMethods));
  WmiCheck(vMethods.Get__NewEnum(vUnknown));
  Result := vUnknown as IEnumVariant;
end;

function  WmiGetMethodQualifiers(AMethod: ISWbemMethod): IEnumVariant;
var
  vQualifiers: ISWbemQualifierSet;
  vUnknown:    IUnknown;
begin
  WmiCheck(AMethod.Get_Qualifiers_(vQualifiers));
  WmiCheck(vQualifiers.Get__NewEnum(vUnknown));
  Result := vUnknown as IEnumVariant;
end;


function  WmiGetMethodParams(AMethod: ISWbemMethod): IEnumVariant;
var
  vInParams: ISWbemObject;
begin
  WmiCheck(AMethod.Get_InParameters(vInParams));
  if vInParams = nil then Result := nil
  else Result := WmiGetObjectProperties(vInParams);
end;

function  WmiGetServices: ISWbemServices; 
var
  vServices: ISWbemServices;
  vSecurity: ISWbemSecurity;
  vLocator:  ISWbemLocator;
begin
  Result := nil;
//  CoInitializeSecurity(nil, -1, nil, nil, RPC_C_AUTHN_LEVEL_DEFAULT, RPC_C_IMP_LEVEL_IMPERSONATE, nil, EOAC_NONE, nil);
  WmiCheck(CoCreateInstance(CLASS_SWbemLocator, nil, CLSCTX_INPROC_SERVER, IID_ISWbemLocator, vLocator));

  if vLocator.ConnectServer(PWideChar(nil),   NAMESPACE_CIMV2, 
                            PWideChar(nil),   PWideChar(nil),
                            PWideChar(nil),   PWideChar(nil),
                            0,    nil,        vServices) <> 0 then Exit;

  WmiCheck(vServices.Get_Security_(vSecurity));
  WmiCheck(vSecurity.Set_ImpersonationLevel(wbemImpersonationLevelImpersonate));
  result := vServices;
end;

function  WmiGetPrototypeObject(AQuery: widestring): ISWbemObject;
var
  vOleVar:          OleVariant;
  vEnum:            IEnumVariant;
  vFetchedCount:    cardinal;
  ObjectSet: SWbemObjectSet;
  vUnknown:  IUnknown;
begin
  Result := nil;
  WmiCheck(WmiGetServices.ExecQuery(AQuery,  'WQL',
                   wbemQueryFlagPrototype or wbemFlagReturnImmediately or wbemFlagForwardOnly,
                   nil, ObjectSet));
  WmiCheck(ObjectSet.Get__NewEnum(vUnknown));
  vEnum :=  vUnknown as IEnumVariant;
  WmiCheck(vEnum.Next(1, vOleVar, vFetchedCount));
  if vFetchedCount = 1 then
    Result := IUnknown(vOleVar) as SWBemObject;
  vOleVar    := Unassigned;
end;


function WmiSelectSingleEntity(AWmiServices: ISWbemServices; AQuery: widestring): ISWbemObject;
var
  vOleVar:          OleVariant;
  vEnum:            IEnumVariant;
  vFetchedCount:    cardinal;
begin
  Result := nil;
  vEnum := WmiExecSelectQuery(AWmiServices, aQuery);
  WmiCheck(vEnum.Next(1, vOleVar, vFetchedCount));
  if vFetchedCount = 1 then Result := IUnknown(vOleVar) as SWBemObject;
  vOleVar := Unassigned;
  vEnum := nil;
end;

function WmiExecSelectQuery(AWmiServices: ISWbemServices; AQuery: widestring): IEnumVariant;
var
  ObjectSet: SWbemObjectSet;
  vUnknown:  IUnknown;
begin
  WmiCheck(AWmiServices.ExecQuery(AQuery,  'WQL',
                   wbemFlagReturnImmediately or wbemFlagForwardOnly,
                   nil, ObjectSet));
  WmiCheck(ObjectSet.Get__NewEnum(vUnknown));
  Result :=  vUnknown as IEnumVariant;
  vUnknown := nil;
  ObjectSet := nil;
end;


function  WmiGetClassMethod(AClass: ISWbemObject; AMethodName: widestring): ISWbemMethod;
var
  vMethods: ISWbemMethodSet;
begin
  WmiCheck(AClass.Get_Methods_(vMethods));
  WmiCheck(vMethods.Item(AMethodName, 0, Result));
end;

function  WmiCreateClassMethodParameters(AClass: ISWbemObject; AMethodName: widestring): ISWbemObject;
var
  inParams: ISWbemObject;
  vMethod: ISWbemMethod;
begin
  Result := nil;
  vMethod := WmiGetClassMethod(AClass, AMethodName);
  WmiCheck(vMethod.Get_InParameters(inParams));
  if inParams = nil then Exit;
  WmiCheck(inParams.SpawnInstance_(0, Result));
end;

function  WmiExecObjectMethod(AObject: ISWbemObject;
                              AMethodName: widestring;
                              InParams: ISWbemObject;
                              AErrorFunction: TErrorFunction): ISWbemObject;
var
  vProperty:        ISWbemProperty;
  vValue:           OleVariant;
begin
  WmiCheck(AObject.ExecMethod_(AMethodName, InParams, 0, nil, Result));
  vProperty := WmiGetObjectProperty(Result, 'ReturnValue');
  WmiCheck(vProperty.Get_Value(vValue));
  if vValue <> 0 then raise TWmiException.Create(AErrorFunction(vValue));
end;

function  WmiGetPropertyValue(AProperty: ISWbemProperty): OleVariant;
begin
  WmiCheck(AProperty.Get_Value(Result));
end;

function  WmiGetStringPropertyValue(AProperty: ISWbemProperty): string;
var
  vResult: OleVariant;
begin
  WmiCheck(AProperty.Get_Value(vResult));
  if VarIsNull(vResult) then Result := ''
    else Result := vResult;
end;

function  WmiGetIntegerPropertyValue(AProperty: ISWbemProperty): integer;
var
  vResult: OleVariant;
begin
  WmiCheck(AProperty.Get_Value(vResult));
  if VarIsNull(vResult) then Result := 0
    else Result := vResult;
end;

function  WmiGetBooleanPropertyValue(AProperty: ISWbemProperty): boolean;
var
  vResult: OleVariant;
begin
  WmiCheck(AProperty.Get_Value(vResult));
  if VarIsNull(vResult) then Result := false
    else Result := vResult;
end;


function  WmiGetVariantPropertyValue(AProperty: ISWbemProperty): OleVariant;
begin
  WmiCheck(AProperty.Get_Value(Result));
end;

function  WmiGetCardinalPropertyValueByName(AProperties: ISWbemPropertySet; APropertyName: widestring): cardinal;
var
  vOleVar: OleVariant;
begin
  vOleVar := WmiGetPropertyValueByName(AProperties, APropertyName);
  if not VarIsNull(vOleVar) then Result := VariantToCardinal(vOleVar)
    else Result := 0;
end;

function  WmiGetCardinalPropertyValueByNameSafe(AProperties: ISWbemPropertySet; APropertyName: widestring): cardinal;
var
  vOleVar: OleVariant;
begin
  vOleVar := WmiGetPropertyValueByNameSafe(AProperties, APropertyName);
  if not VarIsNull(vOleVar) then Result := VariantToCardinal(vOleVar)
    else Result := 0;
end;


function  WmiGetStringPropertyValueByName(AProperties: ISWbemPropertySet; APropertyName: widestring): widestring;
var
  vOleVar: OleVariant;
begin
  vOleVar := WmiGetPropertyValueByName(AProperties, APropertyName);
  if not VarIsNull(vOleVar) then Result := vOleVar
    else Result := '';
end;

function  WmiGetStringPropertyValueByNameSafe(AProperties: ISWbemPropertySet; APropertyName: widestring): widestring;
var
  vOleVar: OleVariant;
begin
  vOleVar := WmiGetPropertyValueByNameSafe(AProperties, APropertyName);
  if not VarIsNull(vOleVar) then Result := vOleVar
    else Result := '';
end;

function  WmiGetBooleanPropertyValueByName(AProperties: ISWbemPropertySet; APropertyName: widestring): boolean;
var
  vOleVar: OleVariant;
begin
  vOleVar := WmiGetPropertyValueByName(AProperties, APropertyName);
  if not VarIsNull(vOleVar) then Result := vOleVar
    else Result := false;
end;

function  WmiGetBooleanPropertyValueByNameSafe(AProperties: ISWbemPropertySet; APropertyName: widestring): boolean;
var
  vOleVar: OleVariant;
begin
  vOleVar := WmiGetPropertyValueByNameSafe(AProperties, APropertyName);
  if not VarIsNull(vOleVar) then Result := vOleVar
    else Result := false;
end;

function  WmiGetIntegerPropertyValueByName(AProperties: ISWbemPropertySet; APropertyName: widestring): integer;
var
  vOleVar: OleVariant;
begin
  vOleVar := WmiGetPropertyValueByName(AProperties, APropertyName);
  if not VarIsNull(vOleVar) then Result := vOleVar
    else Result := 0;
end;

function  WmiGetIntegerPropertyValueByNameSafe(AProperties: ISWbemPropertySet; APropertyName: widestring): integer;
var
  vOleVar: OleVariant;
begin
  vOleVar := WmiGetPropertyValueByNameSafe(AProperties, APropertyName);
  if not VarIsNull(vOleVar) then Result := vOleVar
    else Result := 0;
end;



function  WmiGetFloatPropertyValueByName(AProperties: ISWbemPropertySet; APropertyName: widestring): double;
var
  vOleVar: OleVariant;
begin
  vOleVar := WmiGetPropertyValueByName(AProperties, APropertyName);
  if not VarIsNull(vOleVar) then Result := VariantToFloat(vOleVar)
    else Result := 0;
end;

function  WmiGetInt64PropertyValueByName(AProperties: ISWbemPropertySet; APropertyName: widestring): int64;
var
  vOleVar: OleVariant;
begin
  vOleVar := WmiGetPropertyValueByName(AProperties, APropertyName);
  if not VarIsNull(vOleVar) then Result := VariantToInt64(vOleVar)
    else Result := 0;
end;

function  WmiGetInt64PropertyValueByNameSafe(AProperties: ISWbemPropertySet; APropertyName: widestring): int64;
var
  vOleVar: OleVariant;
begin
  vOleVar := WmiGetPropertyValueByNameSafe(AProperties, APropertyName);
  if not VarIsNull(vOleVar) then Result := VariantToInt64(vOleVar)
    else Result := 0;
end;


function  WmiGetPropertyValueByName(const AProperties: ISWbemPropertySet; const APropertyName: widestring): OleVariant;
var
  vProperty: ISWbemProperty;
begin
  WmiCheck(AProperties.Item(APropertyName, 0, vProperty));
  WmiCheck(vProperty.Get_Value(Result));
end;

procedure  WmiSetPropertyValueByName(AProperties: ISWbemPropertySet; APropertyName: widestring; AValue: OleVariant);
var
  vProperty: ISWbemProperty;
begin
  WmiCheck(AProperties.Item(APropertyName, 0, vProperty));
  WmiCheck(vProperty.Set_Value(AValue));
end;

function  WmiGetPropertyValueByNameSafe(AProperties: ISWbemPropertySet; APropertyName: widestring): OleVariant;
var
  vProperty: ISWbemProperty;
  vRes: HRESULT;
begin
  vRes := AProperties.Item(APropertyName, 0, vProperty);
  case vRes of 
    0: Result := WmiGetPropertyValue(vProperty);
    {$WARNINGS OFF}
    WBEM_E_NOT_FOUND: Result := Null;
    {$WARNINGS ON}
    else WmiCheck(vRes);
  end;  
end;

function  WmiExecObjectMethod(AObject:     ISWbemObject;
                              AMethodName: widestring;
                              AErrorFunction: TErrorFunction): ISWbemObject;
var
  vParams: ISWbemObject;
begin
  vParams := nil;
  Result := WmiExecObjectMethod(AObject, AMethodName, vParams, AErrorFunction);
end;

function WmiAddParameter(Parameters: ISWbemObject; AParamName: widestring; AParamType: integer): ISWbemProperty;
var
  vProperties: ISWbemPropertySet;
begin
  WmiCheck(Parameters.Get_Properties_(vProperties));
  WmiCheck(vProperties.Add(AParamName, AParamType, False, 0, Result));
end;

function  WmiAddParameter(Parameters: ISWbemObject; AParamName: widestring): ISWbemProperty;
var
  vProperties: ISWbemPropertySet;
  vProperty: ISWbemProperty;
  vCimType: TOleEnum;
  vIsArray: wordbool;
begin
  WmiCheck(Parameters.Get_Properties_(vProperties));
  WmiCheck(vProperties.Item(AParamName, 0, vProperty));
  WmiCheck(vProperty.Get_CIMType(vCimType));
  WmiCheck(vProperty.Get_IsArray(vIsArray));
  WmiCheck(vProperties.Add(AParamName, vCimType, vIsArray, 0, Result));
end;


procedure WmiSetStringParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: widestring);
var
  vProperty: ISWbemProperty;
  vOleVar: OleVariant;
begin
  vProperty := WmiAddParameter(Parameters, AParamName, wbemCimtypeString);
  vOleVar := AParamValue;
  WmiCheck(vProperty.Set_Value(vOleVar));
end;

procedure WmiSetIntegerParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: integer);
var
  vProperty: ISWbemProperty;
  vOleVar: OleVariant;
begin
  vProperty := WmiAddParameter(Parameters, AParamName, wbemCimtypeSint32);
  vOleVar := AParamValue;
  WmiCheck(vProperty.Set_Value(vOleVar));
end;

procedure WmiSetDateTimeParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: TDateTime; ATimeZone: integer);
var
  vProperty: ISWbemProperty;
  vOleVar: OleVariant;
begin
  vProperty := WmiAddParameter(Parameters, AParamName, wbemCimtypeDatetime);
  vOleVar := WmiEncodeDateTime(AParamValue, ATimeZone);
  WmiCheck(vProperty.Set_Value(vOleVar));
end;

procedure WmiSetDateTimeParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: TDateTime); overload;
var
  vProperty: ISWbemProperty;
  vOleVar: OleVariant;
begin
  vProperty := WmiAddParameter(Parameters, AParamName, wbemCimtypeDatetime);
  vOleVar := WmiEncodeDateTime(AParamValue);
  WmiCheck(vProperty.Set_Value(vOleVar));
end;

procedure WmiSetTimeParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: TDateTime; ATimeZone: integer); overload;
var
  vProperty: ISWbemProperty;
  vOleVar: OleVariant;
begin
  vProperty := WmiAddParameter(Parameters, AParamName, wbemCimtypeDatetime);
  vOleVar := WmiEncodeTime(AParamValue, ATimeZone);
  WmiCheck(vProperty.Set_Value(vOleVar));
end;

procedure WmiSetTimeParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: TDateTime); overload;
var
  vProperty: ISWbemProperty;
  vOleVar: OleVariant;
begin
  vProperty := WmiAddParameter(Parameters, AParamName, wbemCimtypeDatetime);
  vOleVar := WmiEncodeTime(AParamValue);
  WmiCheck(vProperty.Set_Value(vOleVar));
end;



procedure WmiSetDWORDParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: DWORD);
var
  vProperty: ISWbemProperty;
  vOleVar: OleVariant;
begin
  vProperty := WmiAddParameter(Parameters, AParamName, wbemCimtypeUint32);
  {$WARNINGS OFF}
  vOleVar := AParamValue;
  {$WARNINGS ON}
  WmiCheck(vProperty.Set_Value(vOleVar));
end;

procedure WmiSetObjectParameter(Parameters: ISWbemObject; AParamName: widestring; AParamValue: OleVariant);
var
  vProperty: ISWbemProperty;
begin
  vProperty := WmiAddParameter(Parameters, AParamName, wbemCimtypeObject);
  WmiCheck(vProperty.Set_Value(AParamValue));
end;

function WmiGetObjectProperty(AObject: ISWbemObject; APropertyName: widestring): ISWbemProperty;
var
  vProperties: ISWbemPropertySet;
begin
  WmiCheck(AObject.Get_Properties_(vProperties));
  WmiCheck(vProperties.Item(APropertyName, 0, Result));
end;

function WmiGetObjectMethod(AObject: ISWbemObject; AMethodName: widestring): ISWbemMethod;
var
  vMethods: ISWbemMethodSet;
begin
  WmiCheck(AObject.Get_Methods_(vMethods));
  WmiCheck(vMethods.Item(AMethodName, 0, Result));
end;

function WmiGetObjectMethodSafe(AObject: ISWbemObject; AMethodName: widestring): ISWbemMethod;
var
  vMethods: ISWbemMethodSet;
begin
  if AObject.Get_Methods_(vMethods) = WBEM_S_NO_ERROR then 
    if vMethods.Item(AMethodName, 0, Result) <> WBEM_S_NO_ERROR then
      Result := nil;
end;

procedure WmiSetObjectPropertyValue(AObject: ISWbemObject; APropertyName: widestring; APropertyValue: OleVariant);
var
  vProperty: ISWbemProperty;
begin
  vProperty := WmiGetObjectProperty(AObject, APropertyName);
  WmiCheck(vProperty.Set_Value(APropertyValue))
end;

procedure WmiSetStringPropertyValue(AObject: ISWbemObject; APropertyName: widestring; APropertyValue: widestring);
begin
   WmiSetObjectPropertyValue(AObject, APropertyName, APropertyValue);
end;

procedure WmiSetStringPropertyValueAndCommit(AObject: ISWbemObject; APropertyName: widestring; APropertyValue: widestring);
var
  vOldValue: widestring;
  vProperty: ISWbemProperty;
  vPath: ISWbemObjectPath;
begin
  vProperty := WmiGetObjectProperty(AObject, APropertyName);
  vOldValue := WmiGetStringPropertyValue(vProperty);
  try
    WmiSetObjectPropertyValue(AObject, APropertyName, APropertyValue);
    WmiCheck(AObject.Put_(wbemChangeFlagUpdateOnly, nil, vPath));
  except
    WmiSetObjectPropertyValue(AObject, APropertyName, vOldValue);
    raise;
  end;  
end;

procedure WmiSetBooleanPropertyValueAndCommit(AObject: ISWbemObject; APropertyName: widestring; APropertyValue: boolean);
var
  vOldValue: boolean;
  vProperty: ISWbemProperty;
  vPath: ISWbemObjectPath;
begin
  vProperty := WmiGetObjectProperty(AObject, APropertyName);
  vOldValue := WmiGetBooleanPropertyValue(vProperty);
  try
    WmiSetObjectPropertyValue(AObject, APropertyName, APropertyValue);
    WmiCheck(AObject.Put_(wbemChangeFlagUpdateOnly, nil, vPath));
  except
    WmiSetObjectPropertyValue(AObject, APropertyName, vOldValue);
    raise;
  end;  
end;


procedure WmiSetIntegerPropertyValue(AObject: ISWbemObject; APropertyName: widestring; APropertyValue: integer);
begin
   WmiSetObjectPropertyValue(AObject, APropertyName, APropertyValue);
end;

procedure WmiSetIntegerPropertyValueAndCommit(AObject: ISWbemObject; APropertyName: widestring; APropertyValue: integer);
var
  vOldValue: integer;
  vProperty: ISWbemProperty;
  vPath: ISWbemObjectPath;
begin
  vProperty := WmiGetObjectProperty(AObject, APropertyName);
  vOldValue := WmiGetIntegerPropertyValue(vProperty);
  try
    WmiSetObjectPropertyValue(AObject, APropertyName, APropertyValue);
    WmiCheck(AObject.Put_(wbemChangeFlagUpdateOnly, nil, vPath));
  except
    WmiSetObjectPropertyValue(AObject, APropertyName, vOldValue);
    raise;
  end;  
end;

procedure WmiSetDWORDPropertyValue(AObject: ISWbemObject; APropertyName: widestring; APropertyValue: DWORD);
begin
   {$WARNINGS OFF}
   WmiSetObjectPropertyValue(AObject, APropertyName, APropertyValue);
   {$WARNINGS ON}
end;

function  WmiEncodeDateTime(ADateTime: TDateTime; TimeZone: integer): WideString;
var
  vYear, vMonth, vDay, vHour, vMin, vSec, vMSec: word;
begin
  //WMI has fixed datetime format: yyyymmddHHMMSS.mmmmmmsUUU
  DecodeDate(ADateTime, vYear, vMonth, vDay);
  DecodeTime(ADateTime, vHour, vMin, vSec, vMSec);

  Result := Format('%4.4u%2.2u%2.2u%2.2u%2.2u%2.2u.%3.3d000',
                   [vYear, vMonth, vDay, vHour, vMin, vSec, vMSec]);

  if TimeZone < 0 then
    Result := Result + Format('%3.3d', [TimeZone])
    else Result := Result + Format('+%3.3d', [TimeZone]);
end;

function  WmiEncodeDateTime(ADateTime: TDateTime): WideString;
var
  vTimeZone: integer;
  lpTimeZoneInformation: TTimeZoneInformation;
begin
  FillChar(lpTimeZoneInformation, SizeOf(lpTimeZoneInformation), 0);

  if GetTimeZoneInformation(lpTimeZoneInformation) = TIME_ZONE_ID_INVALID then
    vTimeZone := 0
    else vTimeZone := -lpTimeZoneInformation.Bias;

  Result := WmiEncodeDateTime(ADateTime, vTimeZone);
end;


function  WmiEncodeTime(ADateTime: TDateTime; TimeZone: integer): WideString; 
var
  i: integer;
begin
  Result := WmiEncodeDateTime(ADateTime, TimeZone);
  for i := 1 to 8 do Result[i] := '*';
end;

function  WmiEncodeTime(ADateTime: TDateTime): WideString;
var
  i: integer;
begin
  Result := WmiEncodeDateTime(ADateTime);
  for i := 1 to 8 do Result[i] := '*';
end;

procedure WmiParseDateTime(ADate: string; var ResTime: TDateTime; var ResTimeZone: integer);
var
  S: string;
  year, month, day, hour, minute, second: word;
  cur_year, cur_month, cur_day: word;
  microsecond: integer;
begin
  ResTimeZone := 0;
  ResTime     := 0;

  // WMI has fixed datetime format: yyyymmddHHMMSS.mmmmmmsUUU
  // Sometimes it may have asterisks in the format.
  // It is up to application how to interprete them.
  // I will tream them as 0;
  ADate := StringReplace(ADate, '*', '0', [rfReplaceAll]);
  DecodeDate(Now, cur_year, cur_month, cur_day);
  try
    if ADate <> '' then
    begin
      S := Copy(ADate, 1, 4);
      year := StrToInt(S);
      S := Copy(ADate, 5, 2);
      month := StrToInt(S);
      S := Copy(ADate, 7, 2);
      day := StrToInt(S);
      s := Copy(ADate, 9, 2);
      hour := StrToInt(S);
      s := Copy(ADate, 11, 2);
      minute := StrToInt(S);
      s := Copy(ADate, 13, 2);
      second := StrToInt(S);
      s := Copy(ADate, 16, 6);
      microsecond := StrToInt(S);
      s := Copy(ADate, 22, 4);
      ResTimeZone := StrToIntDef(s, 0);
      if year = 0 then year := cur_year;
      if month = 0 then month := cur_month;
      if day = 0 then day := cur_day;
      ResTime := EncodeDate(year, month, day) + EncodeTime(hour, minute, second, microsecond div 1000);
    end;
  except
     raise TWmiException.Create(Format(INVALID_DATE_FORMAT, [ADate]));
  end;
end;


function WmiParseDateTime(ADate: string): TDateTime;
var
  vTimeZone: integer;
begin
  WmiParseDateTime(ADate, Result, vTimeZone);
end;


{$IFNDEF Delphi7}
// this method is defined in StrUtils unit starting from Delphi 7;
function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;
{$ENDIF}

{$IFNDEF Delphi6}
function AnsiStartsText(const ASubText, AText: string): Boolean;
var
  P: PChar;
  L, L2: Integer;
begin
  P := PChar(AText);
  L := Length(ASubText);
  L2 := Length(AText);
  if L > L2 then
    Result := False
  else
    Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
      P, L, PChar(ASubText), L) = 2;
end;
{$ENDIF}

procedure WmiSetPrivilegeEnabled(AObject: ISWbemObject; APrivilege: WbemPrivilegeEnum; IsEnabled: boolean);
var
  vSecurity: ISWbemSecurity;
  vPrivileges: ISWbemPrivilegeSet;
  vPrivilege: ISWbemPrivilege;
begin
  WmiCheck(AObject.Get_Security_(vSecurity));
  WmiCheck(vSecurity.Get_Privileges(vPrivileges));
  WmiCheck(vPrivileges.Add(APrivilege, IsEnabled, vPrivilege));
end;

procedure WmiSetPrivilegeEnabled(AServices: ISWbemServices; APrivilege: WbemPrivilegeEnum; IsEnabled: boolean);
var
  vSecurity: ISWbemSecurity;
  vPrivileges: ISWbemPrivilegeSet;
  vPrivilege: ISWbemPrivilege;
begin
  WmiCheck(AServices.Get_Security_(vSecurity));
  WmiCheck(vSecurity.Get_Privileges(vPrivileges));
  WmiCheck(vPrivileges.Add(APrivilege, IsEnabled, vPrivilege));
end;

procedure WmiSetPrivilegeEnabled(ASource: ISWbemEventSource; APrivilege: WbemPrivilegeEnum; IsEnabled: boolean);
var
  vSecurity: ISWbemSecurity;
  vPrivileges: ISWbemPrivilegeSet;
  vPrivilege: ISWbemPrivilege;
begin
  WmiCheck(ASource.Get_Security_(vSecurity));
  WmiCheck(vSecurity.Get_Privileges(vPrivileges));
  WmiCheck(vPrivileges.Add(APrivilege, IsEnabled, vPrivilege));
end;

function WmiGetPrivilegeEnabled(AObject: ISWbemObject; APrivilege: WbemPrivilegeEnum): boolean;
var
  vSecurity: ISWbemSecurity;
  vPrivileges: ISWbemPrivilegeSet;
  vPrivilege: ISWbemPrivilege;
  vResult: wordbool;
begin
  WmiCheck(AObject.Get_Security_(vSecurity));
  WmiCheck(vSecurity.Get_Privileges(vPrivileges));
  WmiCheck(vPrivileges.Item(APrivilege, vPrivilege));
  WmiCheck(vPrivilege.Get_IsEnabled(vResult));
  Result := vResult;
end;

function WmiGetLibVersion: widestring;
var
  vLocator:  ISWbemLocator;
  vTypeInfo: ITypeInfo;
  vTypeLib: ITypeLib;
  vIndex: integer;
  vAttr: PTLibAttr;
begin
  Result := '';
  if CoCreateInstance(CLASS_SWbemLocator, nil,
                           CLSCTX_INPROC_SERVER,
                           IID_ISWbemLocator,
                           vLocator) <> 0 then Exit;
  if vLocator.GetTypeInfo(0, 0, vTypeInfo) <> 0 then Exit;
  if vTypeInfo.GetContainingTypeLib(vTypeLib, vIndex) <> 0 then Exit;
  if vTypeLib.GetLibAttr(vAttr) <> 0 then Exit;
  Result := IntToStr(vAttr^.wMajorVerNum) + '.' + IntToStr(vAttr^.wMinorVerNum); 
end;

function StringToVariantArray(AString: string): Variant;
var
  vList: TStringList;
  vTokenizer: TNTStringTokenizer;
  vToken: string;
  i: integer;
begin
  vList := TStringList.Create;
  vTokenizer := TNTStringTokenizer.Create(AString, ',{} ');
  try
    while not vTokenizer.EndOfString do
    begin
      vToken := vTokenizer.NextToken;
      if vToken <> '' then vList.Add(vToken);
    end;

    if vList.Count = 0 then
    begin
      Result := Null;
    end else
    begin
      Result := VarArrayCreate([0, vList.Count - 1], varVariant);
      for i := 0 to vList.Count - 1 do
        Result[i] := vList[i];
    end;
  finally
    vList.Free;
    vTokenizer.Free;
  end;

end;

function VariantToString(AVariant: Variant): string;
var
  i, vLowBound, vHighBound: integer;
  vIUnknown: IUnknown;
  vWmiObject: ISWbemObject;
  s: widestring;
  vRes: HRESULT;
begin

  if VarType(AVariant) = varDispatch then
  begin
    vIUnknown := IUnknown(AVariant);
    vRes := vIUnknown.QueryInterface(ISWbemObject, vWmiObject);
    if vRes = 0 then
    begin
      WmiCheck(vWmiObject.GetObjectText_(0, s));
      Result := s;
    end else
    begin
      Result := 'IDispatch';
    end;
  end
  else if VarIsArray(AVariant) then
  begin
    vLowBound := VarArrayLowBound(AVariant, 1);
    vHighBound := VarArrayHighBound(AVariant, 1);
    Result := '{';
    for i := vLowBound to vHighBound do
    begin
      Result := Result + VariantToString(AVariant[i]);
      if i <> vHighBound then Result := Result + ', ';
    end;
    result := result + '}';
  end else Result := VarToStr(AVariant);
end;

procedure FieldTypeToCimType(AType: TFieldType;
                             ASize: word;
                             var ACimType: TOleEnum;
                             var IsArray: boolean);
begin
  IsArray := false;
  case AType of
    ftSmallint:   ACimType := wbemCimtypeSint16;
    ftString, ftFixedChar, ftWideString:
                  ACimType := wbemCimtypeString;
    ftInteger:    ACimType := wbemCimtypeSint32;
    ftWord:       ACimType := wbemCimtypeUint16;
    ftBoolean:    ACimType := wbemCimtypeBoolean;
    ftFloat:      ACimType := wbemCimtypeReal32;
    ftDate, ftTime,
    {$IFDEF Delphi6}ftTimeStamp,{$ENDIF} ftDateTime:
                  ACimType := wbemCimtypeDatetime;
    ftBytes, ftVarBytes, ftBlob:
                  begin ACimType := wbemCimtypeUint8; IsArray := true; end;
    ftLargeint:   ACimType := wbemCimtypeSint64;
    ftVariant:    ACimType := wbemCimtypeReference;
    ftInterface, ftIDispatch:
                  ACimType := wbemCimtypeObject;

    ftUnknown, ftCurrency, ftBCD, ftAutoInc, ftMemo, ftGraphic,
    ftFmtMemo, ftParadoxOle, ftDBaseOle, ftTypedBinary, ftCursor,
    ftADT, ftArray, ftReference, ftDataSet, ftOraBlob, ftOraClob,
    {$IFDEF Delphi6}ftFMTBcd, {$ENDIF}ftGuid:
                 raise Exception.Create('Unsupported data type.');
  end

end;


procedure CimTypeToFieldType(ACimType: TOleEnum;
                             AIsArray: wordbool;
                             var AType: TFieldType;
                             var ASize: word);
(*
    ftUnknown, ftString, ftSmallint, ftInteger, ftWord,
    ftBoolean, ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime,
    ftBytes, ftVarBytes, ftAutoInc, ftBlob, ftMemo, ftGraphic, ftFmtMemo,
    ftParadoxOle, ftDBaseOle, ftTypedBinary, ftCursor, ftFixedChar, ftWideString,
    ftLargeint, ftADT, ftArray, ftReference, ftDataSet, ftOraBlob, ftOraClob,
    ftVariant, ftInterface, ftIDispatch, ftGuid, ftTimeStamp, ftFMTBcd
*)
begin
  if AIsArray then
  begin
    // Use ftVariant, since ftArray will not work.
    // By default, TDataSet does not create fileds of type ftVariant.
    AType := ftVariant;
    ASize := 0;
    Exit;
  end;

  case ACimType of
    wbemCimtypeSint8:
      begin
        AType := ftSmallint;
        ASize := 0;
      end;
    wbemCimtypeSint16:
      begin
        AType := ftSmallint;
        ASize := 0;
      end;
    wbemCimtypeUint8:
      begin
        AType := ftWord;
        ASize := 0;
      end;
    wbemCimtypeUint16:
      begin
        AType := ftWord;
        ASize := 0;
      end;
    wbemCimtypeSint32,
    wbemCimtypeUint32:
      begin
        AType := ftInteger;
        ASize := 0;
      end;
    wbemCimtypeSint64,
    wbemCimtypeUint64:
      begin
        AType := ftLargeint;
        ASize := 0;
      end;
    wbemCimtypeReal32:
      begin
        AType := ftFloat;
        ASize := 0;
      end;
    wbemCimtypeReal64:
      begin
        AType := ftFloat;
        ASize := 0;
      end;
    wbemCimtypeBoolean:
      begin
        AType := ftBoolean;
        ASize := 0;
      end;
    wbemCimtypeString:
      begin
        AType := ftWideString;
        ASize := 65535;
      end;
    wbemCimtypeDatetime:
      begin
        AType := ftDateTime;
        ASize := 0;
      end;
    wbemCimtypeReference:
      begin
        // TDataSet does not automatically creates fileds if type ftReference.
        AType := ftVariant; //ftReference;
        ASize := 0;
      end;
    wbemCimtypeChar16:
      begin
        AType := ftWideString;
        ASize := 2;
      end;
    wbemCimtypeObject:
      begin
        AType := ftInterface;
        ASize := 0;
      end;
    else raise TWmiException.Create('Unsupported CIM data type: '+IntToStr(ACimType));
  end;
end;


end.

