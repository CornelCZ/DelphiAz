unit WmiSystemEvents;

interface
{$I define.inc}

{$NOINCLUDE WbemScripting_TLB}
{$HPPEMIT '#include <wbemdisp.h>'}
{$HPPEMIT '#include <oaidl.h>'}
{$HPPEMIT '#include "wbem_script_support.h"'}

uses
  Windows, Messages, SysUtils, Classes, WmiAbstract, WmiComponent,
  WmiUtil, WmiErr, WbemScripting_TLB, ActiveX,
  {$IFDEF Delphi6}
  StrUtils,
  {$ENDIF}
  Forms;

const
  WAIT_FOR_EVENT = 100;

type
  TWmiEventAction = (weaUnknown, weaCreated, weaDeleted, weaModified);


  TWin32AccountEvent = procedure(ASender: TObject;
                                 Instance: OleVariant;
                                 Name, Domain: widestring;
                                 Action: TWmiEventAction) of object;

  TWin32GroupMembershipEvent = procedure(
                                 ASender: TObject;
                                 Instance: OleVariant;
                                 AGroupName, AGroupDomain: widestring;
                                 AUserName, AUserDomain: widestring;
                                 Action: TWmiEventAction) of object;

  TWin32EventLogEvent = procedure(
                                 ASender: TObject;
                                 Instance: OleVariant;
                                 EventLog: widestring;
                                 AMessage: widestring) of object;

  TWin32UserSessionEvent = procedure(ASender: TObject;
                                 LogonId, Name, Domain: widestring) of object;

  TWin32PrinterEvent = procedure(ASender: TObject;
                          Instance: OleVariant;
                          Name: widestring;
                          Action: TWmiEventAction) of object;

  TWin32ServiceEvent = procedure (ASender: TObject;
                          Instance: OleVariant;
                          ServiceName: widestring;
                          State: widestring;
                          Action: TWmiEventAction) of object;

  TWin32CDROMEvent = procedure (ASender: TObject;
                          Instance: OleVariant;
                          Drive: widestring) of object;


  TWin32PrintJobEvent = procedure(ASender: TObject;
                          Instance: OleVariant;
                          Document: widestring;
                          JobID: integer;
                          JobStatus: widestring;
                          Action: TWmiEventAction) of object;

  TWmiEventThread = class(TThread)
  private
    FEventInfo: TEventInfoHolder;
    FStream: Pointer;
    FThreadTerminated: boolean;
  public
    procedure EventOccured;
    constructor Create(AEventInfo: TEventInfoHolder);
    procedure Execute; override;
    property  ThreadTerminated: boolean read FThreadTerminated;
  end;

  TWmiSystemEvents = class(TWmiComponent)
  private
    { Private declarations }
    FConnectionPool: TStringList;
    FEventList:      TList;

    FOnUserAccount:  TWin32AccountEvent;
    FOnGroupAccount: TWin32AccountEvent;
    FOnGroupMembership: TWin32GroupMembershipEvent;

    FOnEventLogApplication: TWin32EventLogEvent;
    FOnEventLogSystem:      TWin32EventLogEvent;
    FOnEventLogSecurity:    TWin32EventLogEvent;
    FOnEventLogAny:         TWin32EventLogEvent;
    FOnNetworkDisconnect: TNotifyEvent;
    FOnNetworkConnect: TNotifyEvent;
    FOnUserLogon: TWin32UserSessionEvent;
    FOnUserLogoff: TWin32UserSessionEvent;
    FOnPrinter: TWin32PrinterEvent;
    FOnDocking: TNotifyEvent;
    FOnService: TWin32ServiceEvent;
    FOnCDROMInserted: TWin32CDROMEvent;
    FOnCDROMEjected: TWin32CDROMEvent;
    FOnPrintJob: TWin32PrintJobEvent;

    procedure SetOnUserAccount(const Value: TWin32AccountEvent);
    procedure SetOnGroupAccount(const Value: TWin32AccountEvent);
    procedure SetOnGroupMembership(const Value: TWin32GroupMembershipEvent);
    procedure SetOnEventLogApplication(const Value: TWin32EventLogEvent);
    procedure SetOnEventLogSecurity(const Value: TWin32EventLogEvent);
    procedure SetOnEventLogSystem(const Value: TWin32EventLogEvent);
    procedure SetOnEventLogAny(const Value: TWin32EventLogEvent);
    procedure SetOnNetworkConnect(const Value: TNotifyEvent);
    procedure SetOnNetworkDisconnect(const Value: TNotifyEvent);
    procedure SetOnUserLogoff(const Value: TWin32UserSessionEvent);
    procedure SetOnUserLogon(const Value: TWin32UserSessionEvent);
    procedure SetOnPrinter(const Value: TWin32PrinterEvent);
    procedure SetOnDocking(const Value: TNotifyEvent);
    procedure SetOnService(const Value: TWin32ServiceEvent);
    procedure SetOnCDROMInserted(const Value: TWin32CDROMEvent);
    procedure SetOnCDROMEjected(const Value: TWin32CDROMEvent);
    procedure SetOnPrintJob(const Value: TWin32PrintJobEvent);

    procedure ClearConnectionPool;
    procedure ConnectPool(IfConnect: boolean);
    function  GetConnection(ANameSpace: widestring): TWmiAbstract;
    procedure ClearEvents;
    procedure ConnectEvent(AInfo: TEventInfoHolder);
    procedure DisconnectEvent(AInfo: TEventInfoHolder);
    function  GetEventType(AEvent: ISWbemObject): TWmiEventAction;
    procedure ParseDomainAndName(UserPath: widestring; var UserDomain, UserName: widestring);
    function  ExtractLogonId(ASessionPath: widestring): widestring;
    function  ProcessMessage: Boolean;
    procedure RetrieveParamsForUserLogonEvent(AEvent: ISWbemObject;
      AEventInfo: TEventInfoHolder; var AUserDomain, AUserName,
      ALogonId: widestring);

  protected
    { Protected declarations }
    procedure UserAccountEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure GroupAccountEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure GroupMembershipEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure NTLogEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure NetworkConnectEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure NetworkDisconnectEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure UserLogonEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure UserLogoffEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure PrinterEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure DockingEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure ServiceEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure CDROMInsertedEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure CDROMEjectedEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure PrintJobEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);

    procedure SetActive(Value: boolean); override;
    procedure Loaded; override;
    procedure CredentialsOrTargetChanged; override;
    procedure RegisterEvents; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    procedure RegisterWmiEvent(ANameSpace, AQuery, ATestClassName: string;
                               ACallBack: TWmiNotifyEvent;
                               const Privileges: array of TOleEnum);
    function UnregisterWmiEvent(AQuery: string): boolean;
  published
    property Active;
    property Credentials;
    property MachineName;
    property PoolingInterval;

    property OnUserAccount: TWin32AccountEvent read FOnUserAccount write SetOnUserAccount;
    property OnGroupAccount: TWin32AccountEvent read FOnGroupAccount write SetOnGroupAccount;
    property OnGroupMembership: TWin32GroupMembershipEvent read FOnGroupMembership write SetOnGroupMembership;

    property OnEventLogApplication: TWin32EventLogEvent read FOnEventLogApplication write SetOnEventLogApplication;
    property OnEventLogSystem:      TWin32EventLogEvent read FOnEventLogSystem write SetOnEventLogSystem;
    property OnEventLogSecurity:    TWin32EventLogEvent read FOnEventLogSecurity write SetOnEventLogSecurity;
    property OnEventLogAny:         TWin32EventLogEvent read FOnEventLogAny write SetOnEventLogAny;

    property OnNetworkConnect:      TNotifyEvent read FOnNetworkConnect write SetOnNetworkConnect;
    property OnNetworkDisconnect:   TNotifyEvent read FOnNetworkDisconnect write SetOnNetworkDisconnect;

    property OnUserLogon:           TWin32UserSessionEvent read FOnUserLogon write SetOnUserLogon;
    property OnUserLogoff:          TWin32UserSessionEvent read FOnUserLogoff write SetOnUserLogoff;

    property OnPrinter:            TWin32PrinterEvent read FOnPrinter write SetOnPrinter;
    property OnPrintJob:           TWin32PrintJobEvent read FOnPrintJob write SetOnPrintJob; 
    property OnDocking:            TNotifyEvent read FOnDocking write SetOnDocking;
    property OnService:            TWin32ServiceEvent read FOnService write SetOnService;
    property OnCDROMInserted:      TWin32CDROMEvent read FOnCDROMInserted write SetOnCDROMInserted;
    property OnCDROMEjected:       TWin32CDROMEvent read FOnCDROMEjected write SetOnCDROMEjected;
    
  end;


implementation


resourcestring
  APPLICATION = 'Application';
  SECURITY    = 'Security';
  CNST_SYSTEM = 'System';

  QUERY_USER_ACCOUNT  =    'select * from __instanceOperationEvent within %d where TargetInstance isa "win32_UserAccount"';
  QUERY_GROUP_ACCOUNT =    'select * from __instanceOperationEvent within %d where TargetInstance isa "Win32_Group"';
  QUERY_GROUP_MEMBERSHIP = 'select * from __instanceOperationEvent within %d where TargetInstance isa "Win32_GroupUser"';
  QUERY_LOG_EVENT_APPLICATION = 'select * from __InstanceCreationEvent where TargetInstance isa "Win32_NTLogEvent" and TargetInstance.Logfile = "Application"';
  QUERY_LOG_EVENT_SECURITY = 'select * from __InstanceCreationEvent where TargetInstance isa "Win32_NTLogEvent" and TargetInstance.Logfile = "Security"';
  QUERY_LOG_EVENT_SYSTEM = 'select * from __InstanceCreationEvent where TargetInstance isa "Win32_NTLogEvent" and TargetInstance.Logfile = "System"';
  QUERY_LOG_EVENT_ANY =    'select * from __InstanceCreationEvent where TargetInstance isa "Win32_NTLogEvent"';
  QUERY_NETWORK_DISCONNECT = 'select * from MSNdis_StatusMediaDisconnect';
  QUERY_NETWORK_CONNECT = 'select * from MSNdis_StatusMediaConnect';
  QUERY_USER_LOGON = 'select * from __InstanceCreationEvent within %d where TargetInstance isa "Win32_LoggedOnUser"';
  QUERY_USER_LOGOFF = 'select * from __InstanceDeletionEvent within %d where TargetInstance isa "Win32_LoggedOnUser"';
  QUERY_PRINTER = 'select * from __InstanceOperationEvent within %d where TargetInstance isa "Win32_Printer"';
  QUERY_DOCKING = 'select * from Win32_DeviceChangeEvent where EventType = 4';
  QUERY_SERVICE = 'select * from __instanceOperationEvent within %d where TargetInstance isa "Win32_Service"';
  QUERY_CDROM_INSERTED = 'SELECT * FROM __InstanceModificationEvent WITHIN %d WHERE TargetInstance ISA "Win32_CDROMDrive" and TargetInstance.MediaLoaded=TRUE and PreviousInstance.MediaLoaded = FALSE';
  QUERY_CDROM_EJECTED = 'SELECT * FROM __InstanceModificationEvent WITHIN %d WHERE TargetInstance ISA "Win32_CDROMDrive" and TargetInstance.MediaLoaded=FALSE and PreviousInstance.MediaLoaded = TRUE';
  QUERY_PRINT_JOB = 'select * from __InstanceOperationEvent within %d where TargetInstance ISA "Win32_PrintJob"';

function ExtractQuotedValueAfterTag(ASourceStr, ATag: string): string;
var
  vStartPos, vEndPos: integer;
begin
  Result := '';
  vStartPos := Pos(ATag, ASourceStr);
  if vStartPos = 0 then Exit;
  vStartPos := vStartPos + Length(ATag);
  vEndPos := PosEx('"', ASourceStr, vStartPos);
  if vEndPos = 0 then Exit;
  Result := Copy(ASourceStr, vStartPos, vEndPos - vStartPos);
end;

{ TWmiSystemEvents }

constructor TWmiSystemEvents.Create(AOwner: TComponent);
begin
  inherited;
  FConnectionPool := TStringList.Create;
  FConnectionPool.Sorted     := true;
  FConnectionPool.Duplicates := dupError;

  FEventList := TList.Create;
end;

procedure TWmiSystemEvents.ClearConnectionPool;
var
  i: integer;
begin
  ConnectPool(false);
  for i := 0 to FConnectionPool.Count - 1 do
  begin
    FConnectionPool.Objects[i].Free;
  end;
  FConnectionPool.Clear;
end;

procedure TWmiSystemEvents.ClearEvents;
var
  i: integer;
  vInfo: TEventInfoHolder;
begin
  for i := 0 to FEventList.Count - 1 do
  begin
    vInfo := TEventInfoHolder(FEventList[i]);
    DisconnectEvent(vInfo);
    TEventInfoHolder(FEventList[i]).Free;
  end;
  FEventList.Clear;
end;

destructor TWmiSystemEvents.Destroy;
begin
  Active := false;
  ClearEvents;
  ClearConnectionPool;
  FConnectionPool.Free;
  FEventList.Free;
  inherited;
end;

procedure TWmiSystemEvents.RegisterWmiEvent(ANameSpace, AQuery, ATestClassName: string;
                                      ACallBack: TWmiNotifyEvent;
                                      const Privileges: array of TOleEnum);
var
  vInfo: TEventInfoHolder;
  i: integer;
begin
  vInfo := TEventInfoHolder.Create(
              nil, ANameSpace,  AQuery, ATestClassName, ACallBack);
    if Assigned(@Privileges) then
      for i := Low(Privileges) to High(Privileges) do
         vInfo.AddPrivilege(Privileges[i]);
     
  if (not IsLoading) and Active then ConnectEvent(vInfo);
  FEventList.Add(vInfo);
end;

function TWmiSystemEvents.GetConnection(ANameSpace: widestring): TWmiAbstract;
var
  i: integer;
begin
  ANameSpace := UpperCase(ANameSpace);
  i := FConnectionPool.IndexOf(ANameSpace);

  if i = -1 then
  begin
    Result := TWmiAbstract.Create(nil);
    Result.Name := 'Connection' + IntToStr(FConnectionPool.Count);
    Result.MachineName := MachineName;
    Result.Credentials.Assign(Credentials);
    Result.NameSpace := ANameSpace;
    if not (IsLoading) then Result.Active := Active;
    FConnectionPool.AddObject(ANameSpace, Result);
  end else
  begin
    Result := TWmiAbstract(FConnectionPool.Objects[i]);
  end;
end;

function TWmiSystemEvents.UnregisterWmiEvent(AQuery: string): boolean;
var
  vInfo: TEventInfoHolder;
  i: integer;
begin
  Result := false;
  i := 0;
  while i < FEventList.Count do
  begin
    vInfo := TEventInfoHolder(FEventList[i]);
    if vInfo.EventQuery = AQuery then
    begin
      DisconnectEvent(vInfo);
      FEventList.Delete(i);
      Result := true;
      Break;
    end;
    Inc(i);
  end;  
end;

procedure TWmiSystemEvents.SetOnUserAccount(const Value: TWin32AccountEvent);
begin
  FOnUserAccount := Value;
  if Assigned(FOnUserAccount) then
  begin
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_USER_ACCOUNT, 'Win32_UserAccount', UserAccountEventHandler, []);
  end else
  begin
    UnregisterWmiEvent(QUERY_USER_ACCOUNT);
  end;
end;

function TWmiSystemEvents.GetEventType(AEvent: ISWbemObject): TWmiEventAction;
var
  vPath: ISWbemObjectPath;
  vClassName: widestring;
begin
  Result := weaUnknown;
  if AEvent = nil then Exit;

  WmiCheck(AEvent.Get_Path_(vPath));
  WmiCheck(vPath.Get_Class_(vClassName));

  if vClassName = '__InstanceModificationEvent' then
    Result := weaModified
  else
  if vClassName = '__InstanceDeletionEvent' then
    Result := weaDeleted
  else
  if vClassName = '__InstanceCreationEvent' then
    Result := weaCreated;
end;

procedure TWmiSystemEvents.UserAccountEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
var
  vEvent:    ISWbemObject;
  vTarget:   ISWbemObject;
  vProperty: ISWbemProperty;

  vAccount:  widestring;
  vDomain:   widestring;
begin
  if Assigned(FOnUserAccount) then
  begin
    vEvent     := IUnknown(Event) as ISWbemObject;

    vProperty  := WmiGetObjectProperty(vEvent, 'TargetInstance');
    vTarget    := IUnknown(WmiGetVariantPropertyValue(vProperty)) as ISWbemObject;
    vProperty  := WmiGetObjectProperty(vTarget, 'Domain');
    vDomain    := WmiGetStringPropertyValue(vProperty);
    vProperty  := WmiGetObjectProperty(vTarget, 'Name');
    vAccount   := WmiGetStringPropertyValue(vProperty);

    FOnUserAccount(Self, vTarget, vAccount, vDomain, GetEventType(vEvent));
  end;
end;

procedure TWmiSystemEvents.SetActive(Value: boolean);
begin
  if not Value then ConnectPool(false);
  inherited;
  if (not IsLoading) and (not IsDesignTime) and Value then ConnectPool(true);
end;


procedure TWmiSystemEvents.DisconnectEvent(AInfo: TEventInfoHolder);
begin
  if AInfo.WaitingThread <> nil then
  begin
    with AInfo.WaitingThread as TWmiEventThread do
    begin
      Terminate;
      while not ThreadTerminated do
      begin
        Sleep(0);
        // withot message loop ruuning, the waiting thread never has a changce
        // to terminate. Specifically, NextEvent method call never returns.
        ProcessMessage;
      end;
      AInfo.WaitingThread.Free;
      AInfo.WaitingThread := nil;
    end;
  end;

  AInfo.EventSource := nil;
end;

procedure TWmiSystemEvents.ConnectEvent(AInfo: TEventInfoHolder);
var
  vConnection:  TWmiAbstract;
  vSource:      ISWbemEventSource;
  vEventClass:  ISWbemObject;
  vWQL:         WideString;
  i, vInterval: integer;
  vRes: HRESULT; 
begin
  vConnection := GetConnection(AInfo.NameSpace);
  if vConnection.WmiServices <> nil then
  begin
    vRes := S_OK;
    if AInfo.EventClassName <> '' then
      vRes := vConnection.WMiServices.Get(AInfo.EventClassName, 0, nil, vEventClass);
    if vRes = S_OK then
    begin
      for i := 0 to AInfo.PrivileCount - 1 do
        WmiSetPrivilegeEnabled(vConnection.WMiServices, AInfo.Privileges[i], true);
      vWQL := AInfo.EventQuery;
      // the query may contain formatting symbol instead time value in WITHING
      // clause: I have to replace it with the value of pooling interval.
      if Pos('%d', vWQL) <> 0 then
      try
        vInterval := PoolingInterval div 10;
        if vInterval = 0 then vInterval := 1;
        vWQL := Format(vWQL, [vInterval]);
      except
      end;

      WmiCheck(vConnection.WmiServices.ExecNotificationQuery(
                   vWQL,
                   'WQL',
                   wbemFlagReturnImmediately or wbemFlagForwardOnly,
                   nil,
                   vSource));

      AInfo.EventSource := vSource;
      AInfo.WaitingThread := TWmiEventThread.Create(AInfo);
    end;
  end;
end;

procedure TWmiSystemEvents.ConnectPool(IfConnect: boolean);
var
  i: integer;
  vComponent: TWmiAbstract;
  vEventInfo: TEventInfoHolder;
begin
  if not IfConnect then
    for i := 0 to FEventList.Count - 1 do
    begin
      vEventInfo := TEventInfoHolder(FEventList[i]);
      DisconnectEvent(vEventInfo);
    end;

  for i := 0 to FConnectionPool.Count -1 do
  begin
    vComponent := TWmiAbstract(FConnectionPool.Objects[i]);
    vComponent.MachineName := MachineName;
    vComponent.Credentials.Assign(Credentials);
    vComponent.Active := IfConnect;
  end;

  if IfConnect then
    for i := 0 to FEventList.Count - 1 do
    begin
      vEventInfo := TEventInfoHolder(FEventList[i]);
      if vEventInfo.EventSource = nil then ConnectEvent(vEventInfo);
    end;
end;

procedure TWmiSystemEvents.Loaded;
begin
  inherited;
  ConnectPool(Active);
end;

procedure TWmiSystemEvents.CredentialsOrTargetChanged;
begin
  inherited;
  if not IsLoading then Active := false;
end;

procedure TWmiSystemEvents.SetOnGroupAccount(const Value: TWin32AccountEvent);
begin
  FOnGroupAccount := Value;
  if Assigned(FOnGroupAccount) then
  begin
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_GROUP_ACCOUNT, 'Win32_Group', GroupAccountEventHandler, []);
  end else
  begin
    UnregisterWmiEvent(QUERY_GROUP_ACCOUNT);
  end;
end;

procedure TWmiSystemEvents.GroupAccountEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
var
  vEvent:    ISWbemObject;
  vTarget:   ISWbemObject;
  vProperty: ISWbemProperty;

  vGroup:  widestring;
  vDomain:   widestring;
begin
  if Assigned(FOnGroupAccount) then
  begin
    vEvent     := IUnknown(Event) as ISWbemObject;

    vProperty  := WmiGetObjectProperty(vEvent, 'TargetInstance');
    vTarget    := IUnknown(WmiGetVariantPropertyValue(vProperty)) as ISWbemObject;
    vProperty  := WmiGetObjectProperty(vTarget, 'Domain');
    vDomain    := WmiGetStringPropertyValue(vProperty);
    vProperty  := WmiGetObjectProperty(vTarget, 'Name');
    vGroup     := WmiGetStringPropertyValue(vProperty);

    FOnGroupAccount(Self, vTarget, vGroup, vDomain, GetEventType(vEvent));
  end;
end;


procedure TWmiSystemEvents.ParseDomainAndName(UserPath: widestring; var UserDomain, UserName: widestring);
const
  TAG_DOMAIN = 'Domain="';
  TAG_NAME = 'Name="';
begin
  // this method tries to extract domain and user names from the string like
  // '\\CEWAR11344175\root\cimv2:Win32_Group.Domain="",Name="Everyone"'
  UserDomain := ExtractQuotedValueAfterTag(UserPath, TAG_DOMAIN);
  UserName   := ExtractQuotedValueAfterTag(UserPath, TAG_NAME);
end;

procedure TWmiSystemEvents.GroupMembershipEventHandler(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
var
  vEvent:             ISWbemObject;
  vTarget, vObject:   ISWbemObject;
  vProperty:          ISWbemProperty;
  vConnection:        TWmiAbstract;
  vGroupPath, vUserPath: widestring;
  vGroupName, vGroupDomain:  widestring;
  vUserName, vUserDomain:    widestring;
  vAction: TWmiEventAction;
  vRes: HRESULT;
begin
  if Assigned(OnGroupMembership) then
  begin
    vEvent      := IUnknown(Event) as ISWbemObject;
    vConnection := GetConnection(EventInfo.NameSpace);
    vProperty   := WmiGetObjectProperty(vEvent, 'TargetInstance');
    vTarget     := IUnknown(WmiGetVariantPropertyValue(vProperty)) as ISWbemObject;

    vProperty     := WmiGetObjectProperty(vTarget, 'GroupComponent');
    vGroupPath    := WmiGetStringPropertyValue(vProperty);
    vRes := vConnection.WmiServices.Get(vGroupPath, 0, nil, vObject);
    if vRes = 0 then
    begin
      vProperty     := WmiGetObjectProperty(vObject, 'Domain');
      vGroupDomain  := WmiGetStringPropertyValue(vProperty);
      vProperty     := WmiGetObjectProperty(vObject, 'Name');
      vGroupName    := WmiGetStringPropertyValue(vProperty);
    end else
    begin
      // some group objects cannot be retrieved.
      // Try to find domain and name by parsing
      ParseDomainAndName(vGroupPath, vGroupDomain, vGroupName);
    end;  
    

    vProperty     := WmiGetObjectProperty(vTarget, 'PartComponent');
    vUserPath     := WmiGetStringPropertyValue(vProperty);
    vRes := vConnection.WmiServices.Get(vUserPath, 0, nil, vObject);
    if vRes = 0 then
    begin
      vProperty     := WmiGetObjectProperty(vObject, 'Domain');
      vUserDomain   := WmiGetStringPropertyValue(vProperty);
      vProperty     := WmiGetObjectProperty(vObject, 'Name');
      vUserName     := WmiGetStringPropertyValue(vProperty);
    end else
    begin
      // some user objects cannot be retrieved, for example
      // "Everyone". Try to find domain and name by parsing
      ParseDomainAndName(vUserPath, vUserDomain, vUserName);
    end;

    vAction := GetEventType(vEvent);
    OnGroupMembership(Self, vTarget,
                      vGroupName, vGroupDomain,
                      vUserName, vUserDomain,
                      vAction);
  end;
end;

procedure TWmiSystemEvents.SetOnGroupMembership(
  const Value: TWin32GroupMembershipEvent);
begin
  FOnGroupMembership := Value;
  if Assigned(FOnGroupMembership) then
  begin
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_GROUP_MEMBERSHIP, 'Win32_GroupUser', GroupMembershipEventHandler, []);
  end else
  begin
    UnregisterWmiEvent(QUERY_GROUP_MEMBERSHIP);
  end;
end;

procedure TWmiSystemEvents.RegisterEvents;
var
  i: integer;
  vInfo: TEventInfoHolder;
begin
  for i := 0 to FEventList.Count - 1 do
  begin
    vInfo := TEventInfoHolder(FEventList[i]);
    if Pos('%d', vInfo.EventQuery) <> 0 then
    begin
      DisconnectEvent(vInfo);
      ConnectEvent(vInfo);
    end;
  end;
end;

procedure TWmiSystemEvents.SetOnEventLogApplication(
  const Value: TWin32EventLogEvent);
begin
  FOnEventLogApplication := Value;
  if Assigned(FOnEventLogApplication) then
  begin
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_LOG_EVENT_APPLICATION, 'Win32_NTLogEvent', NTLogEventHandler, []);
  end else
  begin
    UnregisterWmiEvent(QUERY_LOG_EVENT_APPLICATION);
  end;
end;

procedure TWmiSystemEvents.SetOnEventLogSecurity(
  const Value: TWin32EventLogEvent);
begin
  FOnEventLogSecurity := Value;
  if Assigned(FOnEventLogSecurity) then
  begin
    // Fixme: this will not work under Windows NT: it does not support
    // setting privileges after the WMI connection was established.
    // see section "SWbemSecurity.Privileges" in Platform SDK
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_LOG_EVENT_SECURITY, 'Win32_NTLogEvent',
                     NTLogEventHandler, [wbemPrivilegeSecurity]);
  end else
  begin
    UnregisterWmiEvent(QUERY_LOG_EVENT_SECURITY);
  end;
end;

procedure TWmiSystemEvents.SetOnEventLogSystem(const Value: TWin32EventLogEvent);
begin
  FOnEventLogSystem := Value;
  if Assigned(FOnEventLogSystem) then
  begin
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_LOG_EVENT_SYSTEM, 'Win32_NTLogEvent', NTLogEventHandler, []);
  end else
  begin
    UnregisterWmiEvent(QUERY_LOG_EVENT_SYSTEM);
  end;
end;

procedure TWmiSystemEvents.NTLogEventHandler(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
var
  vEvent:    ISWbemObject;
  vTarget:   ISWbemObject;
  vProperty: ISWbemProperty;

  vMessage:    widestring;
  vEventLog:   widestring;
  vEventLogU:  widestring;
begin
  if Assigned(FOnEventLogAny) or
     Assigned(FOnEventLogApplication) or
     Assigned(FOnEventLogSystem) or
     Assigned(FOnEventLogSecurity) then
  begin
    vEvent     := IUnknown(Event) as ISWbemObject;

    vProperty  := WmiGetObjectProperty(vEvent, 'TargetInstance');
    vTarget    := IUnknown(WmiGetVariantPropertyValue(vProperty)) as ISWbemObject;
    vProperty  := WmiGetObjectProperty(vTarget, 'Logfile');
    vEventLog  := WmiGetStringPropertyValue(vProperty);
    vProperty  := WmiGetObjectProperty(vTarget, 'Message');
    vMessage   := WmiGetStringPropertyValue(vProperty);

    vEventLogU := Uppercase(vEventLog);
    if Assigned(FOnEventLogAny) then
      FOnEventLogAny(Self, vTarget, vEventLog, vMessage);

    if Assigned(FOnEventLogApplication) and
       (vEventLogU = UpperCase(APPLICATION)) then
      FOnEventLogApplication(Self, vTarget, vEventLog, vMessage)
    else
    if Assigned(FOnEventLogSecurity) and
       (vEventLogU = UpperCase(SECURITY)) then
      FOnEventLogSecurity(Self, vTarget, vEventLog, vMessage)
    else
    if Assigned(FOnEventLogSystem) and
       (vEventLogU = UpperCase(CNST_SYSTEM)) then
      FOnEventLogSystem(Self, vTarget, vEventLog, vMessage)
  end;
end;

procedure TWmiSystemEvents.SetOnEventLogAny(const Value: TWin32EventLogEvent);
begin
  FOnEventLogAny := Value;
  if Assigned(FOnEventLogAny) then
  begin
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_LOG_EVENT_ANY, 'Win32_NTLogEvent',
                     NTLogEventHandler, [wbemPrivilegeSecurity]);
  end else
  begin
    UnregisterWmiEvent(QUERY_LOG_EVENT_ANY);
  end;
end;

procedure TWmiSystemEvents.SetOnNetworkConnect(const Value: TNotifyEvent);
begin
  FOnNetworkConnect := Value;
  if Assigned(FOnNetworkConnect) then
  begin
    RegisterWmiEvent(NAMESPACE_WMI, QUERY_NETWORK_CONNECT, '',
                     NetworkConnectEventHandler, []);
  end else
  begin
    UnregisterWmiEvent(QUERY_NETWORK_CONNECT);
  end;
end;

procedure TWmiSystemEvents.SetOnNetworkDisconnect(const Value: TNotifyEvent);
begin
  FOnNetworkDisconnect := Value;
  if Assigned(FOnNetworkDisconnect) then
  begin
    RegisterWmiEvent(NAMESPACE_WMI, QUERY_NETWORK_DISCONNECT, '',
                     NetworkDisconnectEventHandler, []);
  end else
  begin
    UnregisterWmiEvent(QUERY_NETWORK_DISCONNECT);
  end;
end;

procedure TWmiSystemEvents.NetworkConnectEventHandler(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
begin
  if Assigned(FOnNetworkConnect) then
    FOnNetworkConnect(Self);
end;

procedure TWmiSystemEvents.NetworkDisconnectEventHandler(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
begin
  if Assigned(FOnNetworkDisconnect) then
    FOnNetworkDisconnect(Self);
end;

procedure TWmiSystemEvents.SetOnUserLogoff(const Value: TWin32UserSessionEvent);
begin
  FOnUserLogoff := Value;
  if Assigned(FOnUserLogoff) then
  begin
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_USER_LOGOFF, 'Win32_LoggedOnUser',
                     UserLogoffEventHandler, []);
  end else
  begin
    UnregisterWmiEvent(QUERY_USER_LOGOFF);
  end;
end;

procedure TWmiSystemEvents.SetOnUserLogon(const Value: TWin32UserSessionEvent);
begin
  FOnUserLogon := Value;
  if Assigned(FOnUserLogon) then
  begin
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_USER_LOGON, 'Win32_LoggedOnUser',
                     UserLogonEventHandler, []);
  end else
  begin
    UnregisterWmiEvent(QUERY_USER_LOGON);
  end;
end;

procedure TWmiSystemEvents.RetrieveParamsForUserLogonEvent(
      AEvent: ISWbemObject;
      AEventInfo: TEventInfoHolder;
      var AUserDomain, AUserName, ALogonId: widestring);
var
  vTarget:   ISWbemObject;
  vProperty:          ISWbemProperty;
  vSessionPath, vUserPath: widestring;
begin
  vProperty   := WmiGetObjectProperty(AEvent, 'TargetInstance');
  vTarget     := IUnknown(WmiGetVariantPropertyValue(vProperty)) as ISWbemObject;

  vProperty     := WmiGetObjectProperty(vTarget, 'Antecedent');
  vUserPath     := WmiGetStringPropertyValue(vProperty);
  ParseDomainAndName(vUserPath, AUserDomain, AUserName);

  vProperty     := WmiGetObjectProperty(vTarget, 'Dependent');
  vSessionPath  := WmiGetStringPropertyValue(vProperty);
  ALogonId      := ExtractLogonId(vSessionPath);
end;

procedure TWmiSystemEvents.UserLogonEventHandler(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
var
  vEvent:             ISWbemObject;
  vLogonId, vUserName, vUserDomain:    widestring;
begin
  if Assigned(FOnUserLogon) then
  begin
    vEvent      := IUnknown(Event) as ISWbemObject;
    RetrieveParamsForUserLogonEvent(vEvent, EventInfo, vUserDomain, vUserName, vLogonId);
    OnUserLogon(Self, vLogonId, vUserName, vUserDomain);
  end;
end;

procedure TWmiSystemEvents.SetOnPrinter(const Value: TWin32PrinterEvent);
begin
  FOnPrinter := Value;
  if Assigned(FOnPrinter) then
  begin
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_PRINTER, 'Win32_Printer', PrinterEventHandler, []);
  end else
  begin
    UnregisterWmiEvent(QUERY_USER_LOGON);
  end;
end;

procedure TWmiSystemEvents.PrinterEventHandler(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
var
  vEvent:    ISWbemObject;
  vTarget:   ISWbemObject;
  vProperty: ISWbemProperty;

  vName:  widestring;
begin
  if Assigned(FOnPrinter) then
  begin
    vEvent     := IUnknown(Event) as ISWbemObject;

    vProperty  := WmiGetObjectProperty(vEvent, 'TargetInstance');
    vTarget    := IUnknown(WmiGetVariantPropertyValue(vProperty)) as ISWbemObject;
    vProperty  := WmiGetObjectProperty(vTarget, 'Name');
    vName      := WmiGetStringPropertyValue(vProperty);

    FOnPrinter(Self, vTarget, vName, GetEventType(vEvent));
  end;
end;

procedure TWmiSystemEvents.SetOnDocking(const Value: TNotifyEvent);
begin
  FOnDocking := Value;
  if Assigned(FOnDocking) then
  begin
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_DOCKING, 'Win32_DeviceChangeEvent',
                     DockingEventHandler, []);
  end else
  begin
    UnregisterWmiEvent(QUERY_DOCKING);
  end;
end;

procedure TWmiSystemEvents.DockingEventHandler(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
begin
  if Assigned(FOnDocking) then
    FOnDocking(Self);
end;

procedure TWmiSystemEvents.SetOnService(const Value: TWin32ServiceEvent);
begin
  FOnService := Value;
  if Assigned(FOnService) then
  begin
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_SERVICE, 'Win32_Service',
                     ServiceEventHandler, []);
  end else
  begin
    UnregisterWmiEvent(QUERY_SERVICE);
  end;
end;

procedure TWmiSystemEvents.ServiceEventHandler(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
var
  vEvent:    ISWbemObject;
  vTarget:   ISWbemObject;
  vProperty: ISWbemProperty;

  vServiceName:    widestring;
  vState:   widestring;
begin
  if Assigned(FOnService) then
  begin
    vEvent     := IUnknown(Event) as ISWbemObject;

    vProperty    := WmiGetObjectProperty(vEvent, 'TargetInstance');
    vTarget      := IUnknown(WmiGetVariantPropertyValue(vProperty)) as ISWbemObject;
    vProperty    := WmiGetObjectProperty(vTarget, 'Name');
    vServiceName := WmiGetStringPropertyValue(vProperty);
    vProperty    := WmiGetObjectProperty(vTarget, 'State');
    vState       := WmiGetStringPropertyValue(vProperty);

    FOnService(Self, vTarget, vServiceName, vState, GetEventType(vEvent));
  end;
end;

procedure TWmiSystemEvents.UserLogoffEventHandler(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
var
  vEvent:             ISWbemObject;
  vLogonId, vUserName, vUserDomain:    widestring;
begin
  if Assigned(FOnUserLogoff) then
  begin
    vEvent      := IUnknown(Event) as ISWbemObject;
    RetrieveParamsForUserLogonEvent(vEvent, EventInfo, vUserDomain, vUserName, vLogonId);
    FOnUserLogoff(Self, vLogonId, vUserName, vUserDomain);
  end;
end;

function TWmiSystemEvents.ExtractLogonId(ASessionPath: widestring): widestring;
const
  TAG_LOGONID = 'LogonId="';
begin
  // this method tries to extract logonid from the string like
  // '\\CEWAR11344175\root\cimv2:Win32_LogonSession.LogonId="xxxxx"'
  Result := ExtractQuotedValueAfterTag(ASessionPath, TAG_LOGONID);
end;

procedure TWmiSystemEvents.SetOnCDROMInserted(const Value: TWin32CDROMEvent);
begin
  FOnCDROMInserted := Value;
  if Assigned(FOnCDROMInserted) then
  begin
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_CDROM_INSERTED, 'Win32_CDROMDrive',
                     CDROMInsertedEventHandler, []);
  end else
  begin
    UnregisterWmiEvent(QUERY_CDROM_INSERTED);
  end;
end;

procedure TWmiSystemEvents.CDROMInsertedEventHandler(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
var
  vEvent:    ISWbemObject;
  vTarget:   ISWbemObject;
  vProperty: ISWbemProperty;
  vDrive:    widestring;
begin
  if Assigned(FOnCDROMInserted) then
  begin
    vEvent     := IUnknown(Event) as ISWbemObject;

    vProperty    := WmiGetObjectProperty(vEvent, 'TargetInstance');
    vTarget      := IUnknown(WmiGetVariantPropertyValue(vProperty)) as ISWbemObject;
    vProperty    := WmiGetObjectProperty(vTarget, 'Drive');
    vDrive       := WmiGetStringPropertyValue(vProperty);

    FOnCDROMInserted(Self, vTarget, vDrive);
  end;
end;

procedure TWmiSystemEvents.SetOnCDROMEjected(const Value: TWin32CDROMEvent);
begin
  FOnCDROMEjected := Value;
  if Assigned(FOnCDROMEjected) then
  begin
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_CDROM_EJECTED, 'Win32_CDROMDrive',
                     CDROMEjectedEventHandler, []);
  end else
  begin
    UnregisterWmiEvent(QUERY_CDROM_EJECTED);
  end;
end;

procedure TWmiSystemEvents.CDROMEjectedEventHandler(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
var
  vEvent:    ISWbemObject;
  vTarget:   ISWbemObject;
  vProperty: ISWbemProperty;
  vDrive:    widestring;
begin
  if Assigned(FOnCDROMEjected) then
  begin
    vEvent     := IUnknown(Event) as ISWbemObject;

    vProperty    := WmiGetObjectProperty(vEvent, 'TargetInstance');
    vTarget      := IUnknown(WmiGetVariantPropertyValue(vProperty)) as ISWbemObject;
    vProperty    := WmiGetObjectProperty(vTarget, 'Drive');
    vDrive       := WmiGetStringPropertyValue(vProperty);

    FOnCDROMEjected(Self, vTarget, vDrive);
  end;
end;

procedure TWmiSystemEvents.SetOnPrintJob(const Value: TWin32PrintJobEvent);
begin
  FOnPrintJob := Value;
  if Assigned(FOnPrintJob) then
  begin
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_PRINT_JOB, 'Win32_PrintJob',
                     PrintJobEventHandler, []);
  end else
  begin
    UnregisterWmiEvent(QUERY_PRINT_JOB);
  end;
end;

procedure TWmiSystemEvents.PrintJobEventHandler(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
var
  vEvent:     ISWbemObject;
  vTarget:    ISWbemObject;
  vProperty:  ISWbemProperty;
  vDocument:  widestring;
  vJobId:     integer;
  vJobStatus: widestring;
begin
  if Assigned(FOnPrintJob) then
  begin
    vEvent     := IUnknown(Event) as ISWbemObject;

    vProperty    := WmiGetObjectProperty(vEvent, 'TargetInstance');
    vTarget      := IUnknown(WmiGetVariantPropertyValue(vProperty)) as ISWbemObject;
    vProperty    := WmiGetObjectProperty(vTarget, 'Document');
    vDocument    := WmiGetStringPropertyValue(vProperty);
    vProperty    := WmiGetObjectProperty(vTarget, 'JobStatus');
    vJobStatus   := WmiGetStringPropertyValue(vProperty);
    vProperty    := WmiGetObjectProperty(vTarget, 'JobId');
    vJobId       := WmiGetIntegerPropertyValue(vProperty);

    FOnPrintJob(Self, vTarget, vDocument, vJobId, vJobStatus, GetEventType(vEvent));
  end;
end;

{ TWmiEventThread }

constructor TWmiEventThread.Create(AEventInfo: TEventInfoHolder);
begin
  inherited Create(false);
  FEventInfo := AEventInfo;
  WmiCheck(CoMarshalInterThreadInterfaceInStream(ISWbemEventSource, FEventInfo.EventSource, IStream(FStream)));
  FreeOnTerminate := false;
  FThreadTerminated := false;
  Priority := tpLowest;	
end;

procedure TWmiEventThread.EventOccured;
var
  vEvent: ISWbemObject;
  vRes: HRESULT; 
begin
  vRes := CoGetInterfaceAndReleaseStream(IStream(FStream), ISWbemObject, vEvent);
  FStream := nil;
  if vRes <> 0 then WmiCheck(vRes);
  try
    FEventInfo.CallBack(self, FEventInfo, vEvent);
  except
    // if error occures in this thread - I do not wont to screw up the
    // waithing thread.
  end;

end;

procedure TWmiEventThread.Execute;
var
  vEventRes, vRes: HRESULT;
  vEvent: ISWbemObject;
  vUnk: IUnknown;
  vEventSource: ISWbemEventSource;
begin
  try
  WmiCheck(CoInitializeEx(nil, COINIT_APARTMENTTHREADED));
  WmiCheck(CoGetInterfaceAndReleaseStream(IStream(FStream), ISWbemEventSource, vEventSource));
  FStream := nil;

  while not Terminated do
  begin
    vEventRes := vEventSource.NextEvent(WAIT_FOR_EVENT, vEvent);
    if Terminated then Break;
    case vEventRes of
      {$WARNINGS OFF}
      wbemErrTimedOut:; // no event; do nothing
      {$WARNINGS ON}
      S_OK:
        begin
        vUnk := vEvent as IUnknown;
        vRes := CoMarshalInterThreadInterfaceInStream(IUnknown, vUnk, IStream(FStream));
        if vRes <> 0 then Break;
        Synchronize(EventOccured);
        vEvent := nil;
        end;
      else Break;
    end;
  end;
  CoUninitialize;
  FThreadTerminated := true;

  except
    // exceptions in the thread are not caught and may kill an application. 
  end;
end;


function TWmiSystemEvents.ProcessMessage: Boolean;
var
  Msg: TMsg;
begin
  Result := False;
  if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end;

end.
