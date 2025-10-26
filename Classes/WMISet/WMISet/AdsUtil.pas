unit AdsUtil;

interface
{$I ..\Common\define.inc}

{$NOINCLUDE ActiveDS}
{$HPPEMIT '#include <oaidl.h>'}

uses
  Windows, ActiveX, Classes, ActiveDsTlb, AdsErr,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  ActiveDS, WmiUtil;

type
  TAdsSystemInfo = class(TPersistent)
  private
    FISystemInfo:     IADsWinNTSystemInfo;
    // cached value of property PDC
    FCachedPDC: widestring;
    function _GetComputerName: widestring;
    function GetDomainName: widestring;
    function GetPDC: widestring;
    function GetUserName: widestring;
    procedure SetComputerName(const Value: widestring);
    procedure SetDomainName(const Value: widestring);
    procedure SetPDC(const Value: widestring);
    procedure SetUserName(const Value: widestring);
    function  GetISystemInfo: IADsWinNTSystemInfo;
    function  GetWmiLibVersion: widestring;
    procedure SetWmiLibVersion(const Value: widestring);
  protected
    property  ISystemInfo: IADsWinNTSystemInfo read GetISystemInfo;
  public
    constructor Create;
    procedure   Refresh; 
  published
    property UserName: widestring read GetUserName write SetUserName stored false;
    property DomainName: widestring read GetDomainName write SetDomainName stored false;
    property ComputerName: widestring read _GetComputerName write SetComputerName stored false;
    property PDC: widestring read GetPDC write SetPDC stored false; 
    property WmiLibVersion: widestring read GetWmiLibVersion write SetWmiLibVersion;  
  end;


// retrieve all the items from the profided container
// and puts their names int a string list
procedure RetrieveContainedItems(AContainer: IAdsContainer; AList: TStrings);

// sets a filter on the properties in provided container. When enumerated,
// container is supposed to only retrieve properties named in AHints parameter.
// Returns true if hints are successfully set. BUT most providers do not
// implement hints.
function SetContainerHints(AContainer: IAdsContainer; AHints: array of widestring): boolean;

// Sets a filter on the provided container. When enumerated, container is
// supposed to only retrieve objects whose type matches AFilter Parameter.
procedure SetContainerFilter(AContainer: IAdsContainer; AFilter: widestring);

// if empty string is passed as a parameter, returns null;
// otherwise typecasts the parameter to PWideChar and returns it.
function GetWPointer(var S: widestring): PWideChar;


implementation

const
  NOT_DEFINED = 'NOT_DEFINED';

function GetWPointer(var S: widestring): PWideChar;
begin
  if S = '' then Result := nil
    else Result := PWideChar(S);
end;

procedure SetContainerFilter(AContainer: IAdsContainer; AFilter: widestring);
var
  vFilter: OleVariant;
begin
  VariantInit(vFilter);
  AdsCheck(ADsBuildVarArrayStr(@AFilter, 1, vFilter));
  AdsCheck(AContainer.Set_Filter(vFilter));
end;

function SetContainerHints(AContainer: IAdsContainer; AHints: array of widestring): boolean; 
var
  vOleVar: OleVariant;
  i: integer;
begin
  vOleVar := VarArrayCreate([0, High(AHints)], varOleStr);
  for i := 0 to High(AHints) do vOleVar[i] := AHints[i];
  // do not check resut of setting hints: it may be not implemented
  Result := AContainer.Set_Hints(vOleVar) = S_OK;
end;

procedure RetrieveContainedItems(AContainer: IAdsContainer; AList: TStrings);
var
  vUnknown: IUnknown;
  vEnum:    IEnumVariant;
  vADs:     IADs;
  vOleObj:  OleVariant;
  vFetchedCount: cardinal;
  vName:    widestring;
begin
  AdsCheck(AContainer.Get__NewEnum(vUnknown));
  vEnum := vUnknown as IEnumVariant;
  while vEnum.Next(1, vOleObj, vFetchedCount) = S_OK do
  begin
    if vFetchedCount = 0 then Break;
    vADs     := IUnknown(vOleObj) as IADs;
    vOleObj  := Unassigned;
    AdsCheck(vADs.Get_Name(vName));
    AList.Add(vName);
  end;
end;      


{ TAdsSystemInfo }

function TAdsSystemInfo._GetComputerName: widestring;
begin
  if ISystemInfo <> nil then
    ISystemInfo.Get_ComputerName(Result)
    else Result := '';
end;

function TAdsSystemInfo.GetDomainName: widestring;
begin
  if ISystemInfo <> nil then
    ISystemInfo.Get_DomainName(Result)
    else Result := '';
end;

function TAdsSystemInfo.GetPDC: widestring;
begin
  if FCachedPDC = NOT_DEFINED then
  begin
    if ISystemInfo <> nil then
      ISystemInfo.Get_PDC(FCachedPDC)
      else FCachedPDC := '';
  end;
  Result := FCachedPDC;
end;

function TAdsSystemInfo.GetUserName: widestring;
begin
  if ISystemInfo <> nil then
    ISystemInfo.Get_UserName(Result)
    else Result := '';
end;

procedure TAdsSystemInfo.SetComputerName(const Value: widestring);begin end;
procedure TAdsSystemInfo.SetDomainName(const Value: widestring);begin end;
procedure TAdsSystemInfo.SetPDC(const Value: widestring);begin end;
procedure TAdsSystemInfo.SetUserName(const Value: widestring);begin end;

function TAdsSystemInfo.GetISystemInfo: IADsWinNTSystemInfo;
var
  vRes: HRESULT;
begin
  if FISystemInfo = nil then
  begin
    vRes := CoCreateInstance(CLASS_WinNTSystemInfo,    nil,
                CLSCTX_INPROC_SERVER,  IADsWinNTSystemInfo,
                FISystemInfo);
    if vRes <> 0 then FISystemInfo := nil;
  end;

  Result := FISystemInfo;
end;


function TAdsSystemInfo.GetWmiLibVersion: widestring;
begin
  Result := WmiUtil.WmiGetLibVersion;
end;

procedure TAdsSystemInfo.SetWmiLibVersion(const Value: widestring);begin end;

constructor TAdsSystemInfo.Create;
begin
  inherited;
  FCachedPDC := NOT_DEFINED;
end;

procedure TAdsSystemInfo.Refresh;
begin
  FCachedPDC := NOT_DEFINED;
end;

end.

