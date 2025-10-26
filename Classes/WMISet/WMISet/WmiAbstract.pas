unit WmiAbstract;

interface
{$I ..\Common\define.inc}

{$NOINCLUDE ActiveDS}
{$NOINCLUDE WbemScripting_TLB}
{$HPPEMIT '#include <wbemdisp.h>'}
{$HPPEMIT '#include <oaidl.h>'}
{$HPPEMIT '#include "wbem_script_support.h"'}


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  WbemScripting_TLB, ComObj, ActiveX,
  AdsUtil, WmiUtil, WmiErr, AdsErr, ActiveDS, RpcConstants,
  InitComSecurity;

type
  IWmiObjectSource = interface;
  TWmiCredentials = class;
  TWmiAbstract = class;

  IWmiObjectSource = interface
    ['{AD6BE6CC-5064-4EE3-8260-158BF92D0330}']
    function GetWmiObject: ISWbemObject;
    function GetWmiServices: ISWbemServices;
    function GetImplementingComponent: TComponent; // the component that implements the interface;
  end;

  TWmiCredentials = class(TPersistent)
  private
    FUserName: widestring;
    FPassword: widestring;
    FAuthority: widestring;
    FLocale: widestring;
    FOptions: TStrings;
    FOnChange: TNotifyEvent;

    procedure SetOptions(const Value: TStrings);
    procedure SetAuthority(const Value: widestring);
    procedure SetLocale(const Value: widestring);
    procedure SetPassword(const Value: widestring);
    procedure SetUserName(const Value: widestring);
    procedure FireOnChangeEvent;
  protected
    function  GetOptionSet: ISWbemNamedValueSet;
  public
    constructor Create; 
    destructor  Destroy; override;
    procedure   Clear;
    procedure   Assign(Source: TPersistent); override;
  published
    {:@summary Provides name of the account to use when connecting to a remote server.}
    property UserName: widestring read FUserName write SetUserName;
    property Password: widestring read FPassword write SetPassword;
    property Locale:   widestring read FLocale write SetLocale;
    property Authority: widestring read FAuthority write SetAuthority;
    property Options: TStrings read FOptions write SetOptions;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  
  TWmiAbstract = class(TComponent)
  private
    FNativeInterface: ISWbemServices;

    FCredentials:     TWmiCredentials;
    FMachineName:     widestring;
    FNameSpace:       widestring;
    FActive:          boolean; // keeps value of Active property while loading;
    FDoNotPerformAPI: boolean;
    FOnDisconnected: TNotifyEvent;
    FOnConnected: TNotifyEvent;

    procedure SetWmiCredentials(const Value: TWmiCredentials);
    function  GetMachineName: widestring;
    procedure SetMachineName(const Value: widestring);
    procedure OnCredentialsChanged(ASender: TObject);
    function  GetDesignTime: boolean;
    function  GetIsLoading: boolean;
    function  GetWmiServices: ISWbemServices;
    function  GetIsDestroying: boolean;
    procedure SetNameSpace(const Value: widestring);

    procedure ObtainNativeInterface;
    procedure ClearNativeInterface;
  protected
    procedure SetActive(Value: boolean); virtual;
    function  GetActive: boolean; virtual;
    procedure Loaded; override;
    procedure CredentialsOrTargetChanged; virtual;

    property  IsDesignTime: boolean read GetDesignTime;
    property  IsLoading: boolean read GetIsLoading;
    property  IsDestroying: boolean read GetIsDestroying;
    property  IfDoNotPerformAPI: boolean read FDoNotPerformAPI write FDoNotPerformAPI;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    property  Active: boolean read GetActive write SetActive;
    property  Credentials: TWmiCredentials read FCredentials write SetWmiCredentials;
    property  MachineName: widestring read GetMachineName write SetMachineName;
    property  NameSpace: widestring read FNameSpace write SetNameSpace;
    property  WmiServices: ISWbemServices read GetWmiServices;

    property  OnConnected: TNotifyEvent read FOnConnected write FOnConnected;
    property  OnDisconnected: TNotifyEvent read FOnDisconnected write FOnDisconnected;
  published
  end;

procedure RaiseNotActiveException;

implementation

resourcestring
  COMPONENT_IS_NOT_ACTIVE = 'Component is not Active.';

procedure RaiseNotActiveException;
begin
  raise TWmiException.Create(COMPONENT_IS_NOT_ACTIVE);
end;

{ TWmiCredentials }

procedure TWmiCredentials.Assign(Source: TPersistent);
var
  vOther: TWmiCredentials;
begin
  if (Source is TWmiCredentials) then
  begin
    vOther := Source as TWmiCredentials;
    Authority := vOther.Authority;
    Locale    := vOther.Locale;
    Options   := vOther.Options;
    Password  := vOther.Password;
    UserName  := vOther.UserName; 
  end else
  begin
    inherited Assign(Source);
  end;
end;

procedure TWmiCredentials.Clear;
begin
  FUserName  := '';
  FPassword  := '';
  FAuthority := '';
  FLocale    := '';
  FOptions.Clear;
end;

constructor TWmiCredentials.Create;
begin
  inherited;
  FOptions := TStringList.Create;
end;

destructor TWmiCredentials.Destroy;
begin
  FOptions.Free;
  inherited;
end;

procedure TWmiCredentials.FireOnChangeEvent;
begin
  if Assigned(FOnChange) then FOnChange(self);
end;

function TWmiCredentials.GetOptionSet: ISWbemNamedValueSet;
var
  vName: string;
  i: integer;
  vOleVar: OleVariant;
  vValue: ISWbemNamedValue;
begin
    if Options.Count > 0 then
    begin
      WmiCheck(CoCreateInstance(CLASS_SWbemNamedValueSet, nil,
                                CLSCTX_INPROC_SERVER,
                                ISWbemNamedValueSet,
                                Result));
      for i := 0 to Options.Count - 1 do
      begin
        vName   := Options.Names[i];
        vOleVar := Options.Values[vName];
        WmiCheck(Result.Add(vName, vOleVar, 0, vValue));
      end;  
    end else
    begin
      Result := nil;
    end;
end;

procedure TWmiCredentials.SetAuthority(const Value: widestring);
begin
  if Value <> FAuthority then
  begin
    FAuthority := Value;
    FireOnChangeEvent;
  end;
end;

procedure TWmiCredentials.SetLocale(const Value: widestring);
begin
  if Value <> FLocale then
  begin
    FLocale := Value;
    FireOnChangeEvent;
  end;
end;

procedure TWmiCredentials.SetOptions(const Value: TStrings);
begin
  if Value <> nil then
  begin
    if FOptions.Text <> Value.Text then
    begin
      FOptions.Assign(Value);
      FireOnChangeEvent;
    end;
  end;
end;

procedure TWmiCredentials.SetPassword(const Value: widestring);
begin
  if Value <> Fpassword then
  begin
    FPassword := Value;
    FireOnChangeEvent;
  end;
end;

procedure TWmiCredentials.SetUserName(const Value: widestring);
begin
  if Value <> FUserName then
  begin
    FUserName := Value;
    FireOnChangeEvent;
  end;
end;

{ TWmiAbstract }

constructor TWmiAbstract.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FNameSpace    := NAMESPACE_CIMV2;
  FCredentials  := TWmiCredentials.Create();
  FCredentials.FOnChange := OnCredentialsChanged;
end;

destructor TWmiAbstract.Destroy;
begin
  FCredentials.Free;
  inherited;
end;

function TWmiAbstract.GetMachineName: widestring;
begin
  Result := FMachineName;
end;

procedure TWmiAbstract.Loaded;
begin
  inherited;
  Active := FActive;
end;

function  TWmiAbstract.GetDesignTime: boolean;
begin
  Result := csDesigning in ComponentState;
end;

function  TWmiAbstract.GetIsLoading: boolean;
begin
  Result := csLoading in ComponentState;
end;

function  TWmiAbstract.GetActive: boolean;
begin
  Result := WMiServices <> nil;
end;

procedure TWmiAbstract.SetActive(Value: boolean);
begin
  if Value <> GetActive then
  begin
    if IsLoading then
    begin
      FActive := Value;
      Exit;
    end;
    
    if Value then
    begin
      ObtainNativeInterface;
      if Assigned(FOnConnected) then FOnConnected(self);
    end else
    begin
      ClearNativeInterface;
      if Assigned(FOnDisconnected) then FOnDisconnected(self);
    end;
  end;
end;

procedure TWmiAbstract.ClearNativeInterface;
begin
  FNativeInterface := nil;
end;

procedure TWmiAbstract.ObtainNativeInterface;
var
  vServices: ISWbemServices;
  vLocator:  ISWbemLocator;
  vSecurity: ISWbemSecurity;
begin
  if FNativeInterface = nil then
  begin
    DoInitComSecurity;
    WmiCheck(CoCreateInstance(CLASS_SWbemLocator, nil,
                              CLSCTX_INPROC_SERVER,
                              IID_ISWbemLocator,
                              vLocator));

    WmiCheck(vLocator.ConnectServer(
                           GetWPointer(FMachineName), 
                           GetWPointer(FNameSpace), 
                           GetWPointer(Credentials.FUserName),
                           GetWPointer(Credentials.FPassword),
                           GetWPointer(Credentials.FLocale),
                           GetWPointer(Credentials.FAuthority),
                           0,
                           Credentials.GetOptionSet,
                           vServices)
                           );

// should I insert this? They say it cures 800700005 problem,
// that one client saw in WmiSet.
//
// WmiCheck(CoSetProxyBlanket(
//      vServices,
//      RPC_C_AUTHN_DEFAULT,
//      RPC_C_AUTHN_NONE,
//      nil,
//      RPC_C_AUTHN_LEVEL_DEFAULT,
//      RPC_C_IMP_LEVEL_DEFAULT,
//      nil,
//      EOAC_NONE)); 

    WmiCheck(vServices.Get_Security_(vSecurity));
    WmiCheck(vSecurity.Set_ImpersonationLevel(wbemImpersonationLevelImpersonate));
    FNativeInterface := vServices;
  end;
end;

function TWmiAbstract.GetWmiServices: ISWbemServices;
begin
  Result := FNativeInterface;
end;

procedure TWmiAbstract.SeTWmiCredentials(const Value: TWmiCredentials);begin end;

procedure TWmiAbstract.SetMachineName(const Value: widestring);
begin
  if (FMachineName <> Value)  then
  begin
    FMachineName := Value;
    Active       := false;
    if not IsLoading then CredentialsOrTargetChanged;
  end;  
end;

procedure TWmiAbstract.OnCredentialsChanged(ASender: TObject);
begin
  if not IsLoading then
  begin
    Active := false;
    CredentialsOrTargetChanged;
  end;  
end;

procedure TWmiAbstract.CredentialsOrTargetChanged;
begin
  // do nothing. It is a virtual method that may be overriden by descendants.
end;

function TWmiAbstract.GetIsDestroying: boolean;
begin
  Result := csDestroying in ComponentState;
end;

procedure TWmiAbstract.SetNameSpace(const Value: widestring);
begin
  if (FNameSpace <> Value)  then
  begin
    FNameSpace   := Value;
    Active       := false;
    if not IsLoading then CredentialsOrTargetChanged;
  end;
end;


end.
