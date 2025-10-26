unit ActiveDS;

{$HPPEMIT ''}
{$HPPEMIT '#include "oaidl.h"'}
{$HPPEMIT ''}


interface
{$I ..\Common\define.inc}

(*
++  ADsBuildEnumerator
+  ADsBuildVarArrayInt
+  ADsBuildVarArrayStr
ADsDecodeBinaryData      - obsolete
+  ADsEncodeBinaryData
++  ADsEnumerateNext
++  ADsFreeEnumerator
+  ADsGetLastError
++  ADsGetObject
+  ADsOpenObject
+  ADsSetLastError
AdsFreeAdsValues         - obsolete
AdsTypeToPropVariant     - obsolete
AdsTypeToPropVariant2    - not found in platform SDK
+  AllocADsMem
+  AllocADsStr
ConvertSecDescriptorToVariant    - not found in platform SDK
ConvertSecurityDescriptorToSecDes - not found in platform SDK
+  FreeADsMem
+  FreeADsStr
PropVariantToAdsType    - obsolete
PropVariantToAdsType2   - not found in platform SDK
+ ReallocADsMem
+ ReallocADsStr
*)

Uses Windows, ActiveDSTLB, ActiveX, AdsErr;

type
  TADsGetObject = function(
                     lpszPathName: PWideChar;
                     const IID: TGUID;
                     var Obj): HRESULT; stdcall;
  function ADsGetObject(
                     lpszPathName: PWideChar;
                     const IID: TGUID;
                     var Obj): HRESULT; stdcall;

type
  TADsOpenObject = function(
          lpszPathName: PWideChar; 
          lpszUserName: PWideChar; 
          lpszPassword: PWideChar;
          dwReserved:   DWORD;
          const riid:         TGUID;
          var  Obj): HRESULT; stdcall;

  function ADsOpenObject(
          lpszPathName: PWideChar;
          lpszUserName: PWideChar;
          lpszPassword: PWideChar;
          dwReserved:   DWORD;
          const riid:         TGUID;
          var  Obj): HRESULT; stdcall;

type
  TADsBuildEnumerator = function(
                ADsContainer: IADsContainer;
                var EnumVariant: IEnumVARIANT): HRESULT; stdcall;

  function ADsBuildEnumerator(
                ADsContainer: IADsContainer;
                var EnumVariant: IEnumVARIANT): HRESULT; stdcall;


type
  TADsBuildVarArrayInt = function(
               lpdwObjectTypes : PDWORD;
               dwObjectTypes: DWORD;
               var pVar: variant): HRESULT; stdcall;

  function ADsBuildVarArrayInt(
               lpdwObjectTypes : PDWORD;
               dwObjectTypes: DWORD;
               var pVar: variant): HRESULT; stdcall;

type
  TADsBuildVarArrayStr = function(
             lppPathNames:  Pointer; // PPWideChar - pointer to an array of PWideChar
             dwPathNames:   DWORD;
             var pVar: OleVariant): HRESULT; stdcall;

  function ADsBuildVarArrayStr(
             lppPathNames:  Pointer;
             dwPathNames:   DWORD;
             var pVar: OleVariant): HRESULT; stdcall;

type
  TADsEncodeBinaryData = function(
             pbSrcData:    PBYTE;
             dwSrcLen:     DWORD;
             var ppszDestData: PWideChar): HRESULT; stdcall;

  function ADsEncodeBinaryData(
             pbSrcData:    PBYTE;
             dwSrcLen:     DWORD;
             var ppszDestData: PWideChar): HRESULT; stdcall;

type
  TADsEnumerateNext = function(
             pEnumVariant: IEnumVARIANT;
             cElements: ULONG;
             var pvar: VARIANT;
             var pcElementsFetched: ULONG): HRESULT; stdcall;

  function ADsEnumerateNext (
             pEnumVariant: IEnumVARIANT;
             cElements: ULONG;
             var pvar: VARIANT;
             var pcElementsFetched: ULONG): HRESULT; stdcall;


type
  TADsFreeEnumerator = function(pEnumVariant:  IEnumVARIANT): HRESULT; stdcall;

  function ADsFreeEnumerator(pEnumVariant:  IEnumVARIANT): HRESULT; stdcall;

type
  TADsGetLastError = function(
           var lpError: DWORD;
           lpErrorBuf: PWideChar; 
           dwErrorBufLen: DWORD;
           lpNameBuf:  PWideChar;
           dwNameBufLen: DWORD): HRESULT; stdcall;

  function ADsGetLastError(
           var lpError: DWORD;
           lpErrorBuf: PWideChar; 
           dwErrorBufLen: DWORD;
           lpNameBuf:  PWideChar;
           dwNameBufLen: DWORD): HRESULT; stdcall;

type
  TADsSetLastError = procedure(
    dwErr:    DWORD; 
    pszError: PWideChar; 
    pszProviderName: PWideChar); stdcall;

  procedure ADsSetLastError (
    dwErr:    DWORD;
    pszError: PWideChar;
    pszProviderName: PWideChar); stdcall;

type
  TAllocADsMem = function(cb: DWORD): pointer; stdcall;
  function AllocADsMem(cb: DWORD): pointer; stdcall;

type
  TAllocADsStr = function(pStr: PWideChar): PWideChar; stdcall;
  function AllocADsStr(pStr: PWideChar): PWideChar; stdcall;

type
  TFreeADsMem = function (pMem: Pointer): wordbool; stdcall;
  function FreeADsMem(pMem: Pointer): wordbool; stdcall;

type
  TFreeADsStr = function (pStr: PWideChar): wordbool; stdcall;
  function FreeADsStr(pStr: PWideChar): wordbool; stdcall;

type
  TReallocADsMem = function (
      pOldMem: Pointer;
      cbOld:   DWORD;
      cbNew:   DWORD): pointer; stdcall;
  function ReallocADsMem(
      pOldMem: Pointer;
      cbOld:   DWORD;
      cbNew:   DWORD): pointer; stdcall;

type
  TReallocADsStr = function(
      var ppStr:   PWideChar;
      pStr:        PWideChar): wordbool; stdcall;

  function ReallocADsStr(
      var ppStr:   PWideChar;
      pStr:        PWideChar): wordbool; stdcall;

implementation

Uses SysUtils;


var
  DllName: string;
  Dll_HModule: HModule;

 _ADsGetObject:          TADsGetObject;
 _ADsBuildEnumerator:    TADsBuildEnumerator;
 _ADsBuildVarArrayInt:   TADsBuildVarArrayInt;
 _ADsBuildVarArrayStr:   TADsBuildVarArrayStr;
 _ADsEncodeBinaryData:   TADsEncodeBinaryData;
 _ADsEnumerateNext:      TADsEnumerateNext;
 _ADsFreeEnumerator:     TADsFreeEnumerator;
 _ADsGetLastError:       TADsGetLastError;
 _ADsOpenObject:         TADsOpenObject;
 _ADsSetLastError:       TADsSetLastError;
 _AllocADsMem:           TAllocADsMem;
 _AllocADsStr:           TAllocADsStr;
 _FreeADsMem:            TFreeADsMem;
 _FreeADsStr:            TFreeADsStr;
 _ReallocADsMem:         TReallocADsMem;
 _ReallocADsStr:         TReallocADsStr;

procedure CannotLoadLibraryException;
begin
  Raise TAdsException.Create('Cannot load library "'+DllName + '" or linked libraries');
end;

function ADsGetObject(
                     lpszPathName: PWideChar;
                     const IID: TGUID;
                     var Obj): HRESULT; stdcall;
begin
  Result := E_FAIL;
  if Assigned (_ADsGetObject) then
    result := _ADsGetObject(lpszPathName, IID, Obj)
    else CannotLoadLibraryException;
end;

function  ADsBuildEnumerator(
                ADsContainer: IADsContainer;
                var EnumVariant: IEnumVARIANT): HRESULT; stdcall;
begin
  Result := E_FAIL;
  if Assigned (_ADsBuildEnumerator) then
    result := _ADsBuildEnumerator(ADsContainer, EnumVariant)
    else CannotLoadLibraryException;
end;

function ADsBuildVarArrayInt(
             lpdwObjectTypes : PDWORD;
             dwObjectTypes: DWORD;
             var pVar: variant): HRESULT; stdcall;
begin
  Result := E_FAIL;
  if Assigned (_ADsBuildVarArrayInt) then
    result := _ADsBuildVarArrayInt(lpdwObjectTypes, dwObjectTypes, pVar)
    else CannotLoadLibraryException;
end;

function ADsBuildVarArrayStr(
             lppPathNames:  Pointer;
             dwPathNames:   DWORD;
             var pVar: OleVariant): HRESULT; stdcall;
begin
  Result := E_FAIL;
  if Assigned (_ADsBuildVarArrayStr) then
    result := _ADsBuildVarArrayStr(lppPathNames, dwPathNames, pVar)
    else CannotLoadLibraryException;
end;

function ADsEncodeBinaryData(
             pbSrcData:    PBYTE;
             dwSrcLen:     DWORD;
             var ppszDestData: PWideChar): HRESULT; stdcall;
begin
  Result := E_FAIL;
  if Assigned (_ADsEncodeBinaryData) then
    result := _ADsEncodeBinaryData(pbSrcData, dwSrcLen, ppszDestData)
    else CannotLoadLibraryException;
end;

function ADsEnumerateNext (
             pEnumVariant: IEnumVARIANT;
             cElements: ULONG;
             var pvar: VARIANT;
             var pcElementsFetched: ULONG): HRESULT; stdcall;
begin
  Result := E_FAIL;
  if Assigned (_ADsEnumerateNext) then
    result := _ADsEnumerateNext(pEnumVariant, cElements, pvar, pcElementsFetched)
    else CannotLoadLibraryException;
end;

function ADsFreeEnumerator(pEnumVariant:  IEnumVARIANT): HRESULT; stdcall;
begin
  Result := E_FAIL;
  if Assigned (_ADsFreeEnumerator) then
    result := _ADsFreeEnumerator(pEnumVariant)
    else CannotLoadLibraryException;
end;

function ADsGetLastError(
           var lpError: DWORD;
           lpErrorBuf: PWideChar;
           dwErrorBufLen: DWORD;
           lpNameBuf:  PWideChar;
           dwNameBufLen: DWORD): HRESULT; stdcall;
begin
  Result := E_FAIL;
  if Assigned (_ADsGetLastError) then
    result := _ADsGetLastError(lpError,
                               lpErrorBuf,
                               dwErrorBufLen,
                               lpNameBuf,
                               dwNameBufLen)
    else CannotLoadLibraryException;
end;

function ADsOpenObject(
          lpszPathName: PWideChar;
          lpszUserName: PWideChar;
          lpszPassword: PWideChar;
          dwReserved:   DWORD;
          const riid:         TGUID;
          var  Obj): HRESULT; stdcall;
begin
  Result := E_FAIL;
  if Assigned (_ADsOpenObject) then
    result := _ADsOpenObject(
                     lpszPathName,
                     lpszUserName,
                     lpszPassword,
                     dwReserved,
                     riid,
                     Obj)
    else CannotLoadLibraryException;
end;

procedure ADsSetLastError (
    dwErr:    DWORD;
    pszError: PWideChar;
    pszProviderName: PWideChar); stdcall;
begin
  if Assigned (_ADsSetLastError) then
    _ADsSetLastError(
        dwErr,
        pszError,
        pszProviderName)
    else CannotLoadLibraryException;
end;

function AllocADsMem(cb: DWORD): pointer; stdcall;
begin
  Result := nil;
  if Assigned (_AllocADsMem) then
    _AllocADsMem(cb)
    else CannotLoadLibraryException;
end;

function AllocADsStr(pStr: PWideChar): PWideChar; stdcall;
begin
  Result := nil;
  if Assigned (_AllocADsStr) then
    Result := _AllocADsStr(pStr)
    else CannotLoadLibraryException;
end;

function FreeADsMem(pMem: Pointer): wordbool; stdcall;
begin
  Result := false;
  if Assigned (_FreeADsMem) then
    Result := _FreeADsMem(pMem)
    else CannotLoadLibraryException;
end;

function FreeADsStr(pStr: PWideChar): wordbool; stdcall;
begin
  Result := false;
  if Assigned (_FreeADsStr) then
    Result := _FreeADsStr(pStr)
    else CannotLoadLibraryException;
end;

function ReallocADsMem(
      pOldMem: Pointer;
      cbOld:   DWORD;
      cbNew:   DWORD): pointer; stdcall;
begin
  Result := nil;
  if Assigned (_ReallocADsMem) then
    Result := _ReallocADsMem(pOldMem, cbOld, cbNew)
    else CannotLoadLibraryException;
end;

function ReallocADsStr(
      var ppStr:   PWideChar;
      pStr:        PWideChar): wordbool; stdcall;
begin
  Result := false;
  if Assigned (_ReallocADsStr) then
    Result := _ReallocADsStr(ppStr, pStr)
    else CannotLoadLibraryException;
end;

initialization


  DllName := 'activeds.dll';
  Dll_HModule := LoadLibrary(PChar(DllName));
  if Dll_HModule > 32 then
    begin
    _ADsGetObject        := GetProcAddress(Dll_HModule, 'ADsGetObject');
    _ADsOpenObject       := GetProcAddress(Dll_HModule, 'ADsOpenObject');
    _ADsBuildEnumerator  := GetProcAddress(Dll_HModule, 'ADsBuildEnumerator');
    _ADsBuildVarArrayInt := GetProcAddress(Dll_HModule, 'ADsBuildVarArrayInt');
    _ADsBuildVarArrayStr := GetProcAddress(Dll_HModule, 'ADsBuildVarArrayStr');
    _ADsEncodeBinaryData := GetProcAddress(Dll_HModule, 'ADsEncodeBinaryData');
    _ADsEnumerateNext    := GetProcAddress(Dll_HModule, 'ADsEnumerateNext');
    _ADsFreeEnumerator   := GetProcAddress(Dll_HModule, 'ADsFreeEnumerator');
    _ADsGetLastError     := GetProcAddress(Dll_HModule, 'ADsGetLastError');
    _ADsSetLastError     := GetProcAddress(Dll_HModule, 'ADsSetLastError');
    _AllocADsMem         := GetProcAddress(Dll_HModule, 'AllocADsMem');
    _AllocADsStr         := GetProcAddress(Dll_HModule, 'AllocADsStr');
    _FreeADsMem          := GetProcAddress(Dll_HModule, 'FreeADsMem');
    _FreeADsStr          := GetProcAddress(Dll_HModule, 'FreeADsStr');
    _ReallocADsMem       := GetProcAddress(Dll_HModule, 'ReallocADsMem');
    _ReallocADsStr       := GetProcAddress(Dll_HModule, 'ReallocADsStr');
    end;

finalization
  if Dll_HModule > 32 then FreeLibrary(Dll_HModule);
end.
