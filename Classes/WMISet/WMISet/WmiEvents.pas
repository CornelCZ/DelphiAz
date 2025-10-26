unit WmiEvents;

interface

uses
  Windows, Messages, SysUtils, Classes, WmiAbstract, WmiComponent,
  WmiUtil, WmiErr, WbemScripting_TLB;

type
  TWmiEvents = class(TWmiComponent)
  private
    { Private declarations }
    FConnectionPool: TStringList;
    FEventList:      TList;

    FOnUserAccount: TWmiNotifyEvent;
    procedure ClearConnectionPool;
    procedure SetOnUserAccount(const Value: TWmiNotifyEvent);
    procedure RegisterWmiEvent(ANameSpace, AQuery, ATestClassName: string;
      ACallBack: TWmiNotifyEvent);
    procedure UnregisterEvent(AQuery: string);
    procedure ConnectPool(IfConnect: boolean);
    function  GetConnection(ANameSpace: widestring): TWmiComponent;
    procedure ClearEvents;
    procedure ConnectEvent(vInfo: TEventInfoHolder);
  protected
    { Protected declarations }
    procedure UserAccountEvent(Sender: TObject; Event: OleVariant);
    procedure SetActive(Value: boolean); override;
    procedure Loaded; override;
    procedure CredentialsOrTargetChanged; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  published
    property Active;
    property Credentials;
    property MachineName;

    property OnUserAccount: TWmiNotifyEvent read FOnUserAccount write SetOnUserAccount;
  end;


implementation


const
  QUERY_USER_ACCOUNT =  'select * from __instanceOperationEvent within 10 where targetInstance isa "win32_Account"';

{ TWmiEvents }

constructor TWmiEvents.Create(AOwner: TComponent);
begin
  inherited;
  FConnectionPool := TStringList.Create;
  FConnectionPool.Sorted     := true;
  FConnectionPool.Duplicates := dupError;

  FEventList := TList.Create;
end;

procedure TWmiEvents.ClearConnectionPool;
var
  i: integer;
begin
  for i := 0 to FConnectionPool.Count - 1 do
  begin
    FConnectionPool.Objects[i].Free;
  end;

  FConnectionPool.Clear;
end;

procedure TWmiEvents.ClearEvents;
var
  i: integer;
begin
  for i := 0 to FEventList.Count - 1 do
    TObject(FEventList[i]).Free;
  FEventList.Clear;
end;

destructor TWmiEvents.Destroy;
begin
  ClearEvents;
  ClearConnectionPool;
  FConnectionPool.Free;
  FEventList.Free;
  inherited;
end;

procedure TWmiEvents.RegisterWmiEvent(ANameSpace, AQuery, ATestClassName: string;
                                      ACallBack: TWmiNotifyEvent);
var
  vInfo: TEventInfoHolder;
begin
  vInfo := TEventInfoHolder.Create(
              nil, ANameSpace,  AQuery, ATestClassName, ACallBack);
  if (not IsLoading) and Active then ConnectEvent(vInfo);
  FEventList.Add(vInfo);
end;

function TWmiEvents.GetConnection(ANameSpace: widestring): TWmiComponent;
var
  i: integer;
begin
  ANameSpace := UpperCase(ANameSpace);
  i := FConnectionPool.IndexOf(ANameSpace);

  if i = -1 then
  begin
    Result := TWmiComponent.Create(nil);
    Result.MachineName := MachineName;
    Result.Credentials.Assign(Credentials);
    if not (IsLoading) then Result.Active := Active;
    FConnectionPool.AddObject(ANameSpace, Result);
  end else
  begin
    Result := TWmiComponent(FConnectionPool.Objects[i]);
  end;
end;

procedure TWmiEvents.UnregisterEvent(AQuery: string);
var
  vInfo: TEventInfoHolder;
  i: integer;
begin
  i := 0;
  while i < FEventList.Count do
  begin
    vInfo := TEventInfoHolder(FEventList[i]);
    if vInfo.EventQuery = AQuery then
    begin
      vInfo.EventSource := nil;
      FEventList.Delete(i);
      Break;
    end;
    Inc(i);
  end;  
end;

procedure TWmiEvents.SetOnUserAccount(const Value: TWmiNotifyEvent);
begin
  FOnUserAccount := Value;
  if Assigned(FOnUserAccount) then
  begin
    RegisterWmiEvent(NAMESPACE_CIMV2, QUERY_USER_ACCOUNT, 'Win32_UserAccount', UserAccountEvent);
  end else
  begin
    UnregisterEvent(QUERY_USER_ACCOUNT);
  end;
end;

procedure TWmiEvents.UserAccountEvent(Sender: TObject; Event: OleVariant);
begin

end;

procedure TWmiEvents.SetActive(Value: boolean);
begin
  inherited;
  if not (IsLoading) then ConnectPool(Value);
end;

procedure TWmiEvents.ConnectEvent(vInfo: TEventInfoHolder);
var
  vConnection: TWmiComponent;
  vSource: ISWbemEventSource;
  vEventClass:    ISWbemObject;
begin
  vConnection := GetConnection(vInfo.NameSpace);
  if vConnection.WmiServices <> nil then
  begin
    if vConnection.WMiServices.Get(vInfo.EventClassName, 0, nil, vEventClass) = S_OK then
    begin
      WmiCheck(vConnection.WmiServices.ExecNotificationQuery(
                   vInfo.EventQuery,
                   'WQL',
                   wbemFlagReturnImmediately or wbemFlagForwardOnly,
                   nil,
                   vSource));
      vInfo.EventSource := vSource;
    end;               
  end;
end;

procedure TWmiEvents.ConnectPool(IfConnect: boolean);
var
  i: integer;
  vComponent: TWmiComponent;
  vEventInfo: TEventInfoHolder;
begin
  if not IfConnect then
    for i := 0 to FEventList.Count - 1 do
    begin
      vEventInfo := TEventInfoHolder(FEventList[i]);
      vEventInfo.EventSource := nil;
    end;

  for i := 0 to FConnectionPool.Count -1 do
  begin
    vComponent := TWmiComponent(FConnectionPool.Objects[i]);
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

procedure TWmiEvents.Loaded;
begin
  inherited;
  ConnectPool(Active);
end;

procedure TWmiEvents.CredentialsOrTargetChanged;
begin
  inherited;
  if not IsLoading then Active := false;
end;

end.
