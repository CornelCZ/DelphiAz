unit WmiConnection;

interface

{$NOINCLUDE WbemScripting_TLB}
{$HPPEMIT '#include <wbemdisp.h>'}
{$HPPEMIT '#include <oaidl.h>'}
{$HPPEMIT '#include "wbem_script_support.h"'}

uses
  Windows, Messages, SysUtils, Classes, WmiAbstract, WmiComponent, DB,
  WbemScripting_TLB, WmiErr, WmiUtil;

type
  TWmiConnection = class(TCustomConnection, IWmiObjectSource)
  private
    FWmiConnection: TWmiComponent;
    FObjectPath: widestring;
    FCurrentObject: ISWbemObject;

    function  GetMachineName: widestring;
    procedure SetMachineName(const Value: widestring);
    procedure SetWmiCredentials(const Value: TWmiCredentials);
    function  GetCredentials: TWmiCredentials;
    function  GetWMIServices: ISWbemServices;
    function  GetNameSpace: widestring;
    procedure SetNameSpace(const Value: widestring);
    procedure SetObjectPath(const Value: widestring);
    { Private declarations }
  protected
    procedure DoConnect; override;
    procedure DoDisconnect; override;
    function  GetConnected: Boolean; override;
  public
    property    WMIServices: ISWbemServices read GetWMIServices;

    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   ListServers(AList: TStrings);
    procedure   ListClasses(AList: TStrings);
    procedure   ListNameSpaces(AList: TStrings);
    { IWmiObjectSource implementation}
    function    GetWmiObject: ISWbemObject; overload;
    function    GetImplementingComponent: TComponent;
    function    GetWmiObject(AObjectPath: widestring): ISWbemObject; overload;

  published
    { Published declarations }
    property Credentials: TWmiCredentials read GetCredentials write SetWmiCredentials;
    property MachineName: widestring read GetMachineName write SetMachineName;
    property NameSpace: widestring read GetNameSpace write SetNameSpace;
    property ObjectPath: widestring read FObjectPath write SetObjectPath; 

    property Connected;
    property LoginPrompt;
    property AfterConnect;
    property BeforeConnect;
    property AfterDisconnect;
    property BeforeDisconnect;
    property OnLogin;
  end;

implementation

Uses
  WmiDataSet;

  { TWmiConnection }

constructor TWmiConnection.Create(AOwner: TComponent);
begin
  inherited;
  FWmiConnection := TWmiComponent.Create(self);
end;

destructor TWmiConnection.Destroy;
begin
  FreeAndNil(FWmiConnection);
  inherited;
end;

procedure TWmiConnection.DoConnect;
begin
  inherited;
  FWmiConnection.Active := true;
end;

procedure TWmiConnection.DoDisconnect;
begin
  inherited;
  FWmiConnection.Active := false;
  FCurrentObject := nil;
end;

function TWmiConnection.GetConnected: Boolean;
begin
  if FWmiConnection <> nil then
    Result := FWmiConnection.Active
    else Result := false;
end;

function TWmiConnection.GetCredentials: TWmiCredentials;
begin
  Result := FWmiConnection.Credentials;
end;

function TWmiConnection.GetMachineName: widestring;
begin
  Result := FWmiConnection.MachineName;
end;

function TWmiConnection.GetNameSpace: widestring;
begin
  Result := FWmiConnection.NameSpace;
end;

function TWmiConnection.GetWMIServices: ISWbemServices;
begin
  Result := FWmiConnection.WmiServices;
end;


procedure TWmiConnection.ListNameSpaces(AList: TStrings);
var
  vQuery: TWmiQuery;
  vConnection: TWmiConnection;
begin
  if not Connected then Exit;
  vConnection := TWmiConnection.Create(nil);
  vQuery := TWmiQuery.Create(nil);
  try
    vConnection.NameSpace := NameSpace;
    vConnection.MachineName := MachineName;
    vConnection.Credentials.Assign(Credentials);
    vConnection.Connected := true;
    
    vQuery.Connection := vConnection;
    vQuery.WQL.text := 'select * from __NAMESPACE';
    vQuery.Active := true;
    while not vQuery.EOF do
    begin
      AList.Add(LowerCase(vQuery.FieldByName('Name').AsString));
      vQuery.next;
    end;
    vQuery.Close;
  finally
    vConnection.Free;
    vQuery.Free;
  end;
end;

procedure TWmiConnection.ListClasses(AList: TStrings);
var
  vPath: ISWbemObjectPath;
  vS: widestring;
  vQuery: TWmiQuery;
begin
  if not Connected then Exit;
  vQuery := TWmiQuery.Create(nil);
  try
    vQuery.Connection := self;
    vQuery.WQL.text := 'select * from meta_class';
    vQuery.Active := true;
    while not vQuery.EOF do
    begin
      WmiCheck(vQuery.CurrentObject.Get_Path_(vPath));
      WmiCheck(vPath.Get_Class_(vS));
      AList.Add(vS);
      vQuery.next;
    end;
    vQuery.Close;
  finally
    vQuery.Free;
  end;
end;

procedure TWmiConnection.ListServers(AList: TStrings);
begin
  FWmiConnection.ListServers(AList);
end;

procedure TWmiConnection.SetMachineName(const Value: widestring);
begin
  FWmiConnection.MachineName := Value;
  Connected := FWmiConnection.Active; 
end;

procedure TWmiConnection.SetNameSpace(const Value: widestring);
begin
  if FWmiConnection.NameSpace <> Value then
  begin
    FWmiConnection.NameSpace := Value;
  end;  
end;

procedure TWmiConnection.SetWmiCredentials(const Value: TWmiCredentials);
begin
  FWmiConnection.Credentials.Assign(Value);
  Connected := FWmiConnection.Active;
end;

function TWmiConnection.GetWmiObject: ISWbemObject;
begin
  if (Connected) and (FCurrentObject = nil) and (ObjectPath <> '') then
    FCurrentObject :=  GetWmiObject(ObjectPath);
  Result := FCurrentObject;
end;

procedure TWmiConnection.SetObjectPath(const Value: widestring);
begin
  FObjectPath := Value;
  FCurrentObject := nil;
end;

function TWmiConnection.GetImplementingComponent: TComponent;
begin
  Result := self;
end;

function TWmiConnection.GetWmiObject(
  AObjectPath: widestring): ISWbemObject;
begin
  if (Connected) and (AObjectPath <> '') then
    WmiCheck(WMiServices.Get(AObjectPath, wbemFlagUseAmendedQualifiers , nil, Result))
    else Result := nil;
end;

end.
