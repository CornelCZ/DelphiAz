unit WmiComponent;

interface
{$I ..\Common\define.inc}

{$NOINCLUDE ActiveDS}
{$NOINCLUDE WbemScripting_TLB}
{$HPPEMIT '#include <wbemdisp.h>'}
{$HPPEMIT '#include <oaidl.h>'}
{$HPPEMIT '#include "wbem_script_support.h"'}

Uses
  Windows, Classes, WbemScripting_TLB, WmiAbstract, ActiveDsTlb, AdsErr,
  ActiveDS, AdsUtil, WmiUtil, WmiErr, ExtCtrls, ActiveX,
  {$IFDEF Delphi6} Variants, {$ENDIF} SysUtils;
  
const
  DEFAULT_EVENT_INTERVAL = 50;
  
type
  TWmiComponent = class;
  TWmiEntityList = class;
  TWmiEntity = class;
  TEventInfoHolder = class;
  TWmiEntityClass = class of TWmiEntity;
  TWmiEntityListClass = class of TWmiEntityList;
  TWmiNotifyEvent = procedure(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant) of object;

  TWmiEntityList = class(TCollection)
  private
    FOwner:     TWmiComponent;
    FNonModifieable: boolean;

    function    GetActive: boolean;
    function    GetWmiServices: ISWbemServices;
  protected
    function    IsDesignTime: boolean;
    function    IsDestroying: boolean;
    function    IfDoNotPerformApi: boolean;
    function    GetOwner: TPersistent; override;

    constructor Create(AOwner: TWmiComponent; ItemType: TWmiEntityClass; IsNonModifieable: boolean);
    property    Active: boolean read GetActive;
    property    WmiServices: ISWbemServices read GetWmiServices;
    {$WARNINGS OFF}
    property    Owner: TWmiComponent read FOwner write FOwner;
    {$WARNINGS ON}

  public
    property    NonModifieable: boolean read FNonModifieable;
    procedure   ClearEntities;
    function    Add: TWmiEntity; overload;
    procedure   Delete(Index: integer); 
  end;

  TWmiEntity = class(TCollectionItem)
  private
    FOwner: TWmiEntityList;
    FInternallyCreated: boolean;
    FUpdateLockCount: integer;
    FNativeInterface: ISWbemObject;
    function GetWmiServices: ISWbemServices;
  protected
    property    WmiServices: ISWbemServices read GetWmiServices;
    property    InternallyCreated: boolean read FInternallyCreated write FInternallyCreated;
    property    Owner: TWmiEntityList read FOwner write FOwner;
    property    UpdateLockCount: integer read FUpdateLockCount;
    property    NativeInterface: ISWbemObject read FNativeInterface;
    function    GetDisplayName: string; override;

    {$HINTS OFF} {$WARNINGS OFF}
    constructor Create(AOwner: TWmiEntityList;
                       AInternallyCreated: boolean;
                       AClass: TWmiEntityListClass); reintroduce;
    {$WARNINGS ON} {$HINTS ON}
    procedure   LoadProperties(AObject: ISWbemObject); virtual; 
    procedure   Unlocked; virtual;
  public
    destructor Destroy; override;
    procedure  Refresh; virtual; 
    function   BeginUpdate: integer; virtual;
    function   EndUpdate: integer; virtual; 
  end;

  TWmiComponent = class(TWmiAbstract)
  private
    FSystemInfo:   TAdsSystemInfo;
    FEventList:    TList;
    FEventTimer:   TTimer;
    FOnPoolingEvent: TNotifyEvent;

    procedure SetSystemInfo(const Value: TAdsSystemInfo);
    procedure SetPoolingInterval(const Value: integer);
    function  GetPoolingInterval: integer;
    procedure OnEventTimer(ASender: TObject);

  protected
    function  ObtainAdsContainer(AdsPath: widestring): IAdsContainer;
    procedure SetActive(Value: boolean); override;
    procedure RegisterEvents;virtual;
    function  ExecSelectQuery(AQuery: widestring): IEnumVariant;
    function  ExecNotificationQuery(AQuery: widestring): ISWbemEventSource;

    function  RegisterEvent(AEventQuery: widestring;
                              ACallBack: TWmiNotifyEvent;
                              AEventClassName: widestring): boolean;
    procedure ClearEventList;
    property  OnPoolingEvent: TNotifyEvent read FOnPoolingEvent write FOnPoolingEvent;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    procedure   ListDomains(AList: TStrings);
    procedure   ListServers(AList: TStrings);
    procedure   ListServersInDomain(ADomain: string; AList: TStrings);
    procedure   ListLogicalDisks(AList: TStrings);
    procedure   ListAccounts(AList: TStrings);

    property    SystemInfo: TAdsSystemInfo read FSystemInfo write SetSystemInfo stored false;
    property    PoolingInterval: integer read GetPoolingInterval write SetPoolingInterval;
  end;

  TEventInfoHolder = class
  private
    FEventSource: ISWbemEventSource;
    FCallBack: TWmiNotifyEvent;
    FEventQuery: widestring;
    FNameSpace: widestring;
    FEventClassName: widestring;
    FPrivileges: TList;
    FWaitingThread: TThread;
    function GetPrivileCount: integer;
    function GetPrivilege(AIndex: integer): TOleEnum;
  public
    constructor Create(AEventSource: ISWbemEventSource;
                       ANameSpace: widestring;
                       AEventQuery: widestring;
                       AEventClassName: widestring;
                       ACallBack: TWmiNotifyEvent);
    destructor  Destroy; override;                   
    property    EventSource: ISWbemEventSource read FEventSource write FEventSource;
    property    CallBack: TWmiNotifyEvent read FCallBack;
    property    NameSpace: widestring read FNameSpace;
    property    EventQuery: widestring read FEventQuery;
    property    EventClassName: widestring read FEventClassName;
    property    PrivileCount: integer read GetPrivileCount;
    property    Privileges[AIndex: integer]: TOleEnum read GetPrivilege;
    procedure   AddPrivilege(APrivilege: TOleEnum);
    property    WaitingThread: TThread read FWaitingThread write FWaitingThread;
  end;

implementation

const
  // filters used to retrieve list of domain or servers
  FILTER_COMPUTER = 'Computer';
  FILTER_DOMAIN   = 'Domain';
  HINT_NAME       = 'Name';

  CANNOT_ADD_TO_NON_MODIFIEBLE_LIST = 'Cannot add entity to non-modifieable list.';
  CANNOT_DELETE_FROM_NON_MODIFIEBLE_LIST = 'Cannot delete entity from non-modifieable list.';
  INVALID_OWNER = 'Invalid owner: expected %s';
  DELPHI5_DESIGN_RESTRICTIONS = 'Delphi 5: Design time adding or deletion of entries is not supported.';

  QUERY_SELECT_ACCOUNTS = 'select domain, name from Win32_Account';
  QUERY_SELECT_LOGICAL_DISKS = 'select name from Win32_LogicalDisk';


{ TWmiComponent }
constructor TWmiComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSystemInfo   := TAdsSystemInfo.Create;
  FEventList    := TList.Create;
  FEventTimer   := TTimer.Create(nil);
  FEventTimer.OnTimer  := OnEventTimer;
  PoolingInterval := DEFAULT_EVENT_INTERVAL;
end;

destructor  TWmiComponent.Destroy;
begin
  ClearEventList;
  FSystemInfo.Free;
  FEventTimer.Free;
  FEventList.Free;
  inherited;
end;

procedure TWmiComponent.SetActive(Value: boolean);
begin
  if Value <> GetActive then
  begin
    inherited SetActive(Value);
    if IsLoading then Exit;

    if Value then
    begin
      RegisterEvents;
      FEventTimer.Enabled  := not IsDesignTime;
    end else
    begin
      FEventTimer.Enabled  := false;
      ClearEventList;
    end;
  end;
end;

procedure TWmiComponent.RegisterEvents;
begin
  // do nothing. Descendants should override this method to register events.
end;

procedure TWmiComponent.ClearEventList;
var
  i: integer;
begin
  for i := 0 to FEventList.Count - 1 do
    TObject(FEventList[i]).Free;
  FEventList.Clear;
end;

procedure TWmiComponent.ListDomains(AList: TStrings);
var
  vContainer: IAdsContainer;
begin
  vContainer := ObtainAdsContainer(NAMESPACE_WINNT);
  AdsCheck(vContainer.Set_Filter(FILTER_DOMAIN));
  SetContainerHints(vContainer, [HINT_NAME]);
  RetrieveContainedItems(vContainer, AList);
end;

procedure TWmiComponent.ListServers(AList: TStrings);
begin
  ListServersInDomain(SystemInfo.DomainName, AList);
end;

procedure TWmiComponent.ListServersInDomain(ADomain: string; AList: TStrings);
var
  vContainer: IAdsContainer;
begin
  vContainer := ObtainAdsContainer(NAMESPACE_WINNT + '//'+ADomain);
  SetContainerFilter(vContainer, FILTER_COMPUTER);
  SetContainerHints(vContainer, [HINT_NAME]);
  RetrieveContainedItems(vContainer, AList);
end;

procedure TWmiComponent.SetSystemInfo(const Value: TAdsSystemInfo);begin end;

function TWmiComponent.ExecSelectQuery(AQuery: widestring): IEnumVariant;
begin
  if not Active then RaiseNotActiveException;
  Result := WmiExecSelectQuery(WmiServices, AQuery);
end;

function TWmiComponent.ExecNotificationQuery(AQuery: widestring): ISWbemEventSource;
begin
  if not Active then RaiseNotActiveException;
  WmiCheck(WmiServices.ExecNotificationQuery(AQuery,  'WQL',
                   wbemFlagReturnImmediately or wbemFlagForwardOnly,
                   nil, Result));
end;

function TWmiComponent.RegisterEvent(AEventQuery: widestring;
                                     ACallBack: TWmiNotifyEvent;
                                     AEventClassName: widestring): boolean;
var
  vEventSource: ISWbemEventSource;
  vEventInfo: TEventInfoHolder;
  vEventClass:    ISWbemObject;
  vInterval: double;
  vOldDecimalSeparator: char;
begin
  Result      := false;
  vInterval   := PoolingInterval / 10;
  vOldDecimalSeparator := DecimalSeparator;
  DecimalSeparator := '.';
  try
    AEventQuery := Format(AEventQuery, [vInterval]);
  finally
    DecimalSeparator := vOldDecimalSeparator;
  end;
  
  // first check if WMI supports this event
  if WMiServices.Get(AEventClassName, 0, nil, vEventClass) = S_OK then
  begin
    vEventSource   := ExecNotificationQuery(AEventQuery);
    vEventInfo     := TEventInfoHolder.Create(vEventSource, NameSpace, AEventQuery, AEventClassName, ACallBack);
    FEventList.Add(vEventInfo);
    Result := true;
  end;
end;

procedure TWmiComponent.SetPoolingInterval(const Value: integer);
var
  vMiliSec: integer;
begin
  // timer clicks twice as often as the pooling occures
  vMiliSec := Value * 100; 
  FEventTimer.Interval := vMiliSec div 2;
  if Active and (not IsDesignTime) then
  begin
    ClearEventList;
    RegisterEvents;
  end;
end;

function TWmiComponent.GetPoolingInterval: integer;
var
  vMilicSec: integer;
begin
  // timer clicks twice as often as the pooling occures
  vMilicSec := FEventTimer.Interval * 2;
  Result    := vMilicSec div 100;
end;

procedure TWmiComponent.OnEventTimer(ASender: TObject);
var
  i: integer;
  vEventInfo: TEventInfoHolder;
  vEvent: ISWbemObject;
  vRes: HRESULT;
begin
  if Assigned(FOnPoolingEvent) then
    FOnPoolingEvent(self);

  // loop through the list of event sources and
  // query each of them for available events
  for i := 0 to FEventList.Count - 1 do
  begin
    vEventInfo := TEventInfoHolder(FEventList[i]);
    vRes := vEventInfo.EventSource.NextEvent(10, vEvent);
    case vRes of
      {$WARNINGS OFF}
      wbemErrTimedOut:; // no event; do nothing
      {$WARNINGS ON}
      S_OK           :  vEventInfo.FCallBack(self, vEventInfo, vEvent);
      else WmiCheck(vRes);
    end;
  end;
end;


procedure TWmiComponent.ListAccounts(AList: TStrings);
var
  vEnum: IEnumVariant;
  vOleVar: OleVariant;
  vWmiObject: ISWbemObject;
  vFetchedCount: cardinal;
  vProperties: ISWbemPropertySet;
  s: string;
begin
  if not Active then RaiseNotActiveException;
  vEnum := ExecSelectQuery(QUERY_SELECT_ACCOUNTS);
  while (vEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
  begin
    vWmiObject := IUnknown(vOleVar) as SWBemObject;
    vOleVar    := Unassigned;
    WmiCheck(vWmiObject.Get_Properties_(vProperties));
    s := WmiGetStringPropertyValueByName(vProperties,   'Domain') + '\' +
         WmiGetStringPropertyValueByName(vProperties,   'Name');
    AList.Add(s);     
  end;
end;

procedure TWmiComponent.ListLogicalDisks(AList: TStrings);
var
  vEnum: IEnumVariant;
  vOleVar: OleVariant;
  vWmiObject: ISWbemObject;
  vFetchedCount: cardinal;
  vProperties: ISWbemPropertySet;
begin
  if not Active then RaiseNotActiveException;
  vEnum := ExecSelectQuery(QUERY_SELECT_LOGICAL_DISKS);
  while (vEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
  begin
    vWmiObject := IUnknown(vOleVar) as SWBemObject;
    vOleVar    := Unassigned;
    WmiCheck(vWmiObject.Get_Properties_(vProperties));
    AList.Add(WmiGetStringPropertyValueByName(vProperties,   'Name'));
  end;
end;

function TWmiComponent.ObtainAdsContainer(
  AdsPath: widestring): IAdsContainer;
var
  vUserName, vPassword: widestring;  
begin
  if Trim(Credentials.UserName) = '' then
  begin
    AdsCheck(ADsGetObject(PWideChar(AdsPath), IADsContainer, Result));
  end else
  begin
    vUserName := Credentials.UserName;
    vPassword := Credentials.Password;
    AdsCheck(ADsOpenObject(PWideChar(AdsPath),
                           GetWPointer(vUserName),
                           GetWPointer(vPassword),
                           0,
                           IADsContainer,
                           Result));
  end;
end;


{ TEventInfoHolder }

procedure TEventInfoHolder.AddPrivilege(APrivilege: TOleEnum);
begin
  FPrivileges.Add(Pointer(APrivilege));
end;

constructor TEventInfoHolder.Create(
                       AEventSource: ISWbemEventSource;
                       ANameSpace: widestring;
                       AEventQuery: widestring;
                       AEventClassName: widestring;
                       ACallBack: TWmiNotifyEvent);
begin
  inherited Create;
  FEventSource := AEventSource;
  FCallBack    := ACallBack;
  FNameSpace   := ANameSpace;
  FEventQuery  := AEventQuery;
  FEventClassName := AEventClassName;
  FPrivileges  := TList.Create;
end;

destructor TEventInfoHolder.Destroy;
begin
  FPrivileges.Free;
  inherited;
end;

function TEventInfoHolder.GetPrivileCount: integer;
begin
  Result := FPrivileges.Count;
end;


function TEventInfoHolder.GetPrivilege(AIndex: integer): TOleEnum;
begin
  Result := TOleEnum(Integer(FPrivileges[AIndex]));
end;

{ TWmiEntityList }

procedure TWmiEntityList.ClearEntities;
begin
  FOwner.IfDoNotPerformAPI := true;
  try
    Clear;
  finally
    FOwner.IfDoNotPerformAPI := false;
  end;
end;

constructor TWmiEntityList.Create(
            AOwner: TWmiComponent;
            ItemType: TWmiEntityClass;
            IsNonModifieable: boolean);
begin
  inherited Create(ItemType);
  FOwner := AOwner;
  FNonModifieable := IsNonModifieable;
end;

function TWmiEntityList.GetActive: boolean;
begin
  Result := FOwner.Active;
end;

function TWmiEntityList.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TWmiEntityList.GetWmiServices: ISWbemServices;
begin
  Result := FOwner.WMIServices;
end;

function TWmiEntityList.IfDoNotPerformApi: boolean;
begin
  Result := FOwner.IfDoNotPerformApi;
end;

function TWmiEntityList.IsDesignTime: boolean;
begin
  Result := FOwner.IsDesignTime;
end;

function TWmiEntityList.IsDestroying: boolean;
begin
  Result := FOwner.IsDestroying;
end;

function TWmiEntityList.Add: TWmiEntity;
begin
  if FNonModifieable then raise TWmiException.Create(CANNOT_ADD_TO_NON_MODIFIEBLE_LIST)
    else Result := TWmiEntity (inherited Add);
end;

procedure TWmiEntityList.Delete(Index: integer);
begin
  if FNonModifieable then raise TWmiException.Create(CANNOT_DELETE_FROM_NON_MODIFIEBLE_LIST)
    else inherited Delete(Index);
end;

{ TWmiEntity }

function TWmiEntity.BeginUpdate: integer;
begin
  Inc(FUpdateLockCount);
  Result := FUpdateLockCount;
end;

constructor TWmiEntity.Create(AOwner: TWmiEntityList;
                             AInternallyCreated: boolean;
                             AClass: TWmiEntityListClass);
begin
  FInternallyCreated := AInternallyCreated;
  if (AOwner = nil) or (AOwner.ClassName <> AClass.ClassName) then
    raise TWmiException.Create(Format(INVALID_OWNER, [AClass.ClassName]));
  FOwner := AOwner;
  inherited Create(AOwner);
  FUpdateLockCount := 0;
end;

destructor TWmiEntity.Destroy;
begin
  FNativeInterface := nil;
  inherited;
end;

function TWmiEntity.EndUpdate: integer;
begin
  Dec(FUpdateLockCount);
  if FUpdateLockCount < 0 then FUpdateLockCount := 0;
  if FUpdateLockCount = 0 then Unlocked;
  Result := FUpdateLockCount;
end;

function TWmiEntity.GetDisplayName: string;
begin
  {$IFNDEF Delphi6}
  if (WmiServices = nil) and (not InternallyCreated) then
    Result := DELPHI5_DESIGN_RESTRICTIONS
    else Result := '';
  {$ELSE}
  Result := '';
  {$ENDIF}
end;

function TWmiEntity.GetWmiServices: ISWbemServices;
begin
  if FOwner <> nil then Result := FOwner.WmiServices
    else Result := nil;
end;

procedure TWmiEntity.LoadProperties(AObject: ISWbemObject);
begin
   FNativeInterface := AObject;
end;

procedure TWmiEntity.Refresh;
var
  vPath: ISWbemObjectPath;
  vPathStr: widestring;
  vObj: ISWbemObject;
begin
  if NativeInterface <> nil then
  begin
    FUpdateLockCount := 0;
    WmiCheck(NativeInterface.Get_Path_(vPath));
    WmiCheck(vPath.Get_Path(vPathStr));
    WmiCheck(WmiServices.Get(vPathStr, 0, nil, vObj));
    LoadProperties(vObj);
  end;
end;

procedure TWmiEntity.Unlocked;
begin

end;

end.
