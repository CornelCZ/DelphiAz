unit AdsErr;

interface

Uses SysUtils;

(*
//  Abstract:    Error codes for ADs
//  Subject:     Translation of AdsErr.h, created by Microsoft Corporation
//  Author:      Serguei Khramtchenko

//  Values are 32 bit values layed out as follows:
//
//   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
//   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
//  +---+-+-+-----------------------+-------------------------------+
//  |Sev|C|R|     Facility          |               Code            |
//  +---+-+-+-----------------------+-------------------------------+
//
//  where
//      Sev - is the severity code
//          00 - Success
//          01 - Informational
//          10 - Warning
//          11 - Error
//
//      C - is the Customer code flag
//      R - is a reserved bit
//      Facility - is the facility code
//      Code - is the facility's status code
//
*)

// Define the facility codes

const
  {$EXTERNALSYM FACILITY_WINDOWS}
  FACILITY_WINDOWS       =          8;
  {$EXTERNALSYM FACILITY_STORAGE}
  FACILITY_STORAGE       =          3;
  {$EXTERNALSYM FACILITY_RPC}
  FACILITY_RPC           =          1;
  {$EXTERNALSYM FACILITY_SSPI}
  FACILITY_SSPI          =          9;
  {$EXTERNALSYM FACILITY_WIN32}
  FACILITY_WIN32         =          7;
  {$EXTERNALSYM FACILITY_CONTROL}
  FACILITY_CONTROL       =          10;
  {$EXTERNALSYM FACILITY_NULL}
  FACILITY_NULL          =          0;
  {$EXTERNALSYM FACILITY_ITF}
  FACILITY_ITF           =          4;
  {$EXTERNALSYM FACILITY_DISPATCH}
  FACILITY_DISPATCH      =          2;


// Define the severity codes

// success
 E_ADS_SUCCESS                   = 0;
// An invalid Active Directory pathname was passed
 E_ADS_BAD_PATHNAME              =  $80005000;
// An unknown Active Directory domain object was requested
 E_ADS_INVALID_DOMAIN_OBJECT    = $80005001;
// An unknown Active Directory user object was requested
 E_ADS_INVALID_USER_OBJECT      = $80005002;
// An unknown Active Directory computer object was requested
 E_ADS_INVALID_COMPUTER_OBJECT  = $80005003;
// An unknown Active Directory object was requested
 E_ADS_UNKNOWN_OBJECT             = $80005004;
// The specified Active Directory property was not set
 E_ADS_PROPERTY_NOT_SET           = $80005005;
// The specified Active Directory property is not supported
 E_ADS_PROPERTY_NOT_SUPPORTED     = $80005006;
// The specified Active Directory property is invalid
 E_ADS_PROPERTY_INVALID           = $80005007;
//  One or more input parameters are invalid
 E_ADS_BAD_PARAMETER              = $80005008;
//  The specified Active Directory object is not bound to a remote resource
 E_ADS_OBJECT_UNBOUND             = $80005009;
//  The specified Active Directory object has not been modified
 E_ADS_PROPERTY_NOT_MODIFIED      = $8000500A;
//  The specified Active Directory object has been modified
 E_ADS_PROPERTY_MODIFIED          = $8000500B;
//  The Active Directory datatype cannot be converted to/from a native DS datatype
 E_ADS_CANT_CONVERT_DATATYPE      = $8000500C;
//  The Active Directory property cannot be found in the cache.
 E_ADS_PROPERTY_NOT_FOUND         = $8000500D;
//  The Active Directory object exists.
 E_ADS_OBJECT_EXISTS              = $8000500E;
//  The attempted action violates the DS schema rules.
 E_ADS_SCHEMA_VIOLATION           = $8000500F;
//  The specified column in the Active Directory was not set.
 E_ADS_COLUMN_NOT_SET             = $80005010;
//  One or more errors occurred
 S_ADS_ERRORSOCCURRED             = $00005011;
//  No more rows to be obatained by the search result.
 S_ADS_NOMORE_ROWS                = $00005012;
//  No more columns to be obatained for the current row.
 S_ADS_NOMORE_COLUMNS             = $00005013;
//  The search filter specified is invalid
 E_ADS_INVALID_FILTER             = $80005014;

type
  TAdsException = class(Exception);

function  GetAdsErrorString(ACode: HRESULT): string;
procedure AdsCheck(Result: HResult);
function  Succeeded(Res: HResult): Boolean;


implementation


function GetAdsErrorString(ACode: HRESULT): string;
begin
  {$WARNINGS  OFF}
  case ACode of
    E_ADS_BAD_PATHNAME:            Result := 'An invalid Active Directory pathname was passed';
    E_ADS_INVALID_DOMAIN_OBJECT:   Result := 'An unknown Active Directory domain object was requested';
    E_ADS_INVALID_USER_OBJECT:     Result := 'An unknown Active Directory user object was requested';
    E_ADS_INVALID_COMPUTER_OBJECT: Result := 'An unknown Active Directory computer object was requested';
    E_ADS_UNKNOWN_OBJECT:          Result := 'An unknown Active Directory object was requested';
    E_ADS_PROPERTY_NOT_SET:        Result := 'The specified Active Directory property was not set';
    E_ADS_PROPERTY_NOT_SUPPORTED:  Result := 'The specified Active Directory property is not supported';
    E_ADS_PROPERTY_INVALID:        Result := 'The specified Active Directory property is invalid';
    E_ADS_BAD_PARAMETER:           Result := 'One or more input parameters are invalid';
    E_ADS_OBJECT_UNBOUND:          Result := 'The specified Active Directory object is not bound to a remote resource';
    E_ADS_PROPERTY_NOT_MODIFIED:   Result := 'The specified Active Directory object has not been modified';
    E_ADS_PROPERTY_MODIFIED:       Result := 'The specified Active Directory object has been modified';
    E_ADS_CANT_CONVERT_DATATYPE:   Result := 'The Active Directory datatype cannot be converted to/from a native DS datatype';
    E_ADS_PROPERTY_NOT_FOUND:      Result := 'The Active Directory property cannot be found in the cache.';
    E_ADS_OBJECT_EXISTS:           Result := 'The Active Directory object exists.';
    E_ADS_SCHEMA_VIOLATION:        Result := 'The attempted action violates the DS schema rules';
    E_ADS_COLUMN_NOT_SET:          Result := 'The specified column in the Active Directory was not set.';
    S_ADS_ERRORSOCCURRED:          Result := 'One or more errors occurred';
    S_ADS_NOMORE_ROWS:             Result := 'No more rows to be obatained by the search result.';
    S_ADS_NOMORE_COLUMNS:          Result := 'No more columns to be obatained for the current row.';
    E_ADS_INVALID_FILTER:          Result := 'The search filter specified is invalid';
    else Result := SysErrorMessage(ACode);
  end;
  Result := IntToHex(ACode, 8) + ': ' + Result;  
  {$WARNINGS  ON}
end;

procedure AdsError(ErrorCode: HResult);
begin
  raise TAdsException.Create(GetAdsErrorString(ErrorCode));
end;

function Succeeded(Res: HResult): Boolean;
begin
  Result := Res and $80000000 = 0;
end;

procedure AdsCheck(Result: HResult);
begin
  if not Succeeded(Result) then AdsError(Result);
end;


end.
