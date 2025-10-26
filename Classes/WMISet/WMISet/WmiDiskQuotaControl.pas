unit WmiDiskQuotaControl;

interface
{$I DEFINE.INC}

{$NOINCLUDE WbemScripting_TLB}
{$HPPEMIT '#include <wbemdisp.h>'}
{$HPPEMIT '#include <oaidl.h>'}
{$HPPEMIT '#include "wbem_script_support.h"'}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  WmiAbstract, WbemScripting_TLB, ActiveX, ComObj, WmiErr, WmiUtil,
  {$IFDEF Delphi6} Variants, {$ENDIF}
  {$IFDEF Delphi7}
  StrUtils,
  {$ENDIF}
  WmiComponent;

const
  // this constatnt denotes no limit on disk quota  
  NO_LIMIT = '18446744073709551615';
    
resourcestring
  INVALID_OWNER       = 'Invalid owner: expected TWmiPartitionList';

type
  TWmiDiskQuotaControl = class;
  TWmiDiskQuota = class;
  TWmiDiskQuotaList = class;
  TWmiQuotaSetting = class;

  TWmiQuotaSetting = class(TWmiEntity)
  private
    FNativeInterface: ISWbemObject;
    FLockUpdated: boolean;

    // FWarningExceededNotification: boolean;
    FExceededNotification: boolean;
    FDescription: widestring;
    FDefaultWarningLimit: widestring;
    FDefaultLimit: widestring;
    FCaption: widestring;
    FSettingID: widestring;
    FState: DWORD;
    FVolumePath: widestring;
    procedure SetCaption(const Value: widestring);
    procedure SetDefaultLimit(const Value: widestring);
    procedure SetDefaultWarningLimit(const Value: widestring);
    procedure SetDescription(const Value: widestring);
    procedure SetSettingID(const Value: widestring);
    procedure SetState(const Value: DWORD);
    // procedure SetWarningExceededNotification(const Value: boolean);
    procedure SetVolumePath(const Value: widestring);
    procedure SetExceededNotification(const Value: boolean);

    property    LockUpdated: boolean read FLockUpdated write FLockUpdated;
    procedure   StoreProperties;
  protected
    {$HINTS OFF} {$WARNINGS OFF}
    constructor Create(AOwner: TWmiEntityList); reintroduce;
    {$WARNINGS ON} {$HINTS ON}
    function    GetDisplayName: string; override;
    property    NativeInterface: ISWbemObject read FNativeInterface write FNativeInterface;
    procedure   LoadProperties(AQuotaSetting: ISWbemObject); override;
    procedure   Unlocked; override;
  published
    property    Caption: widestring read FCaption write SetCaption;
    property    DefaultLimit: widestring read FDefaultLimit write SetDefaultLimit;
    property    DefaultWarningLimit: widestring read FDefaultWarningLimit write SetDefaultWarningLimit;
    property    Description: widestring read FDescription write SetDescription;
    property    SettingID: widestring read FSettingID write SetSettingID;
    property    State: DWORD read FState write SetState;
    property    VolumePath: widestring read FVolumePath write SetVolumePath;
    property    ExceededNotification: boolean read FExceededNotification write SetExceededNotification;
    // There seems to be a bug in WMI implementation:
    // if WarningExceededNotification and ExceededNotification properties have the opposite values,
    // their values are often swapped. To avoid problems, this class will have only one property
    // that keeps both WMI properties in sync. 
    // property    WarningExceededNotification: boolean read FWarningExceededNotification write SetWarningExceededNotification;
  end;

  TWmiQuotaSettingList = class(TWmiEntityList)
  private
    function  GetItem(AIndex: integer): TWmiQuotaSetting;
    procedure SetItem(AIndex: integer; const Value: TWmiQuotaSetting);
  protected
  public
    property Items[AIndex: integer]: TWmiQuotaSetting read GetItem write SetItem; default;
  end;

  TWmiDiskQuota = class(TWmiEntity)
  private
    FStatus: DWORD;
    FDiskSpaceUsed: int64;
    FQuotaVolume: widestring;
    FAccount: widestring;
    FWarningLimit: widestring;
    FLimit: widestring;
    FNativeInterface: ISWbemObject;
    procedure SetDiskSpaceUsed(const Value: int64);
    procedure SetQuotaVolume(const Value: widestring);
    procedure SetStatus(const Value: DWORD);
    procedure SetAccount(const Value: widestring);
    procedure SetWarningLimit(const Value: widestring);
    procedure SetLimit(const Value: widestring);
  protected
    {$HINTS OFF} {$WARNINGS OFF}
    constructor Create(AOwner: TWmiEntityList); reintroduce;
    {$WARNINGS ON} {$HINTS ON}
    function    GetDisplayName: string; override;
    procedure   LoadProperties(AQuota: ISWbemObject); override;
    property    NativeInterface: ISWbemObject read FNativeInterface write FNativeInterface;
  public
  published
    property DiskSpaceUsed: int64 read FDiskSpaceUsed write SetDiskSpaceUsed;
    property Limit: widestring read FLimit write SetLimit;
    property QuotaVolume: widestring read FQuotaVolume write SetQuotaVolume;
    property Status: DWORD read FStatus write SetStatus;
    property Account: widestring read FAccount write SetAccount;
    property WarningLimit: widestring read FWarningLimit write SetWarningLimit;
  end;

  TWmiDiskQuotaList = class(TWmiEntityList)
  private
    function  GetItem(AIndex: integer): TWmiDiskQuota;
    procedure SetItem(AIndex: integer; const Value: TWmiDiskQuota);
    function  CreateQuotaWithPrompt(AQuota: TWmiDiskQuota): boolean;
  protected
    {$IFDEF Delphi6}
    procedure   Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
    {$ENDIF}
    class function AddDiskQuota(AOwner: TWmiComponent; AUser,
      AQuotaVolume, AWarningLimit, ALimit: widestring): ISWbemObject;
  public
    property  Items[AIndex: integer]: TWmiDiskQuota read GetItem write SetItem; default;
    function  Add(Account, AQuotaVolume, AWarningLimit, ALimit: widestring): TWmiDiskQuota;
    procedure Delete(AIndex: integer);
  end;

  TWmiDiskQuotaControl = class(TWmiComponent)
  private
    FFilterVolume: widestring;
    FFilterAccount: widestring;
    FDiskQuotas: TWmiDiskQuotaList;
    FQuotaSettings: TWmiQuotaSettingList;
    
    procedure SetFilterVolume(const Value: widestring);
    procedure SetFilterAccount(const Value: widestring);
    function  GetDiskQuotas: TWmiDiskQuotaList;
    procedure SetDiskQuotas(const Value: TWmiDiskQuotaList);
    procedure LoadDiskQuotas;
    procedure LoadQuotaSettings;
    function  BuildQuotaQueryWithFilter: widestring;
    function  BuildSettingQueryWithFilter: widestring;
    function  GetQuotaSettings: TWmiQuotaSettingList;
    procedure SetQuotaSettings(const Value: TWmiQuotaSettingList);
  protected
    { Protected declarations }
    procedure CredentialsOrTargetChanged; override;
    procedure RegisterEvents; override;
    procedure SetActive(AValue: boolean); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   Refresh;

  published
    { Published declarations }
    property    Active;
    property    Credentials;
    property    MachineName;
    property    SystemInfo;

    property    FilterAccount: widestring read FFilterAccount write SetFilterAccount;
    property    FilterVolume: widestring read FFilterVolume write SetFilterVolume;

    property    DiskQuotas: TWmiDiskQuotaList read GetDiskQuotas write SetDiskQuotas stored false;
    property    QuotaSettings: TWmiQuotaSettingList read GetQuotaSettings write SetQuotaSettings stored false; 
  end;

const
  QUOTAS_DISABLE = 0;
  QUOTAS_TRACK = 1;
  QUOTAS_ENFORCE = 2;

  QUOTAS_STATUS_OK = 0;
  QUOTAS_STATUS_WARNING = 1;
  QUOTAS_STATUS_EXCEEDED = 2;

function QuotaStatusToString(Status: DWORD): widestring;

implementation

Uses FrmAddDiskQuotaU;

resourcestring
  INVALID_USER_NAME_FORMAT = 'Invalid username format. The valid format is "DOMAIN\User"';

//const
//  Query1 = 'REFERENCES OF {Win32_LogicalDisk.DeviceId="C:"}  WHERE resultclass = Win32_DiskQuota';
//  Query2 = 'REFERENCES OF {Win32_Account.Domain="CEWAR11344175",Name="Administrators"}  WHERE resultclass = Win32_DiskQuota';
//  Query3 = 'select * from Win32_DiskQuota where QuotaVolume="Win32_LogicalDisk.DeviceID=\"C:\""';
//  Query4 = 'select * from Win32_DiskQuota where User="Win32_Account.Domain=\"cewar11344175\",Name=\"Administrators\""';

  // this template requires parameter disk, like "C:"
  TEMPLATE_QUOTA_VOLUME = 'QuotaVolume="Win32_LogicalDisk.DeviceID=\"%s\""';

  // this template requires parameters in order:
  // 1) User's domain, like "MOON"
  // 2) User's name, like 'Administrator';
  TEMPLATE_USER = 'User="Win32_Account.Domain=\"%s\",Name=\"%s\""';

  QUERY_SELECT_QUOTAS = 'select * from Win32_DiskQuota';
  QUERY_SELECT_QUOTA_SETTINGS = 'select * from Win32_QuotaSetting';

  // this query requires parameters in order:
  // 1) MachineName, like 'MY_PC'
  // 2) NameSpace like root\cimv2
  // 3) Disk, like 'C:'
  // 4) User's domain, like "MOON"
  // 5) User's name, like 'Administrator';
  // The example of formatted query:
  // \\CEWAR11344175\root\cimv2:Win32_DiskQuota.QuotaVolume="Win32_LogicalDisk.DeviceID=\"C:\"",User="Win32_Account.Domain=\"CEWAR11344175\",Name=\"TestUser1\""';
  QUERY_CREATE_QUOTA = '\\%s\%s:Win32_DiskQuota.QuotaVolume="Win32_LogicalDisk.DeviceID=\"%s\"",User="Win32_Account.Domain=\"%s\",Name=\"%s\""';

  // this query requires parameters in order:
  // 1) MachineName, like 'MY_PC'
  // 2) NameSpace like root\cimv2
  // 3) Disk, like 'C:'
  QUERY_CREATE_QUOTA_SETTING = '\\%s\%s:Win32_QuotaSetting.VolumePath="%s\\"';

  // this query requires parameters in order:
  // 1) User's domain, like MOON
  // 2) User's name, like 'Administrator';
  QUERY_SELECT_ACCOUNT_SID = 'select SID from Win32_Account where Domain="%s" and Name="%s"';


function QuotaStatusToString(Status: DWORD): widestring;
begin
  case Status of
    QUOTAS_STATUS_OK: Result := 'Ok';
    QUOTAS_STATUS_WARNING: Result := 'Warning';
    QUOTAS_STATUS_EXCEEDED: Result := 'Exceeded';
  end;
end;  

procedure SplitUserName(AFullName: widestring; var ADomain, AUserName: widestring);
var
  vPos: integer;
begin
  vPos := Pos('\', AFullName);
  if vPos = 0 then raise TWmiException.Create(INVALID_USER_NAME_FORMAT);
  ADomain := Copy(AFullName, 1, vPos - 1);
  AUserName := Copy(AFullName, vPos + 1, Length(AFullName) - vPos);
end;



{ TWmiDiskQuotaControl }
procedure TWmiDiskQuotaControl.CredentialsOrTargetChanged;
begin
  inherited;
end;

procedure TWmiDiskQuotaControl.RegisterEvents;
begin
  ClearEventList;
  if (not IsDesignTime) and Active then
  begin
//    RegisterEvent(QUERY_EVENT_PROCESS_STARTED, ProcessStarted, 'Win32_ProcessStartTrace');
//    RegisterEvent(QUERY_EVENT_PROCESS_STOPPED, ProcessStopped, 'Win32_ProcessStopTrace');
  end;
end;

constructor TWmiDiskQuotaControl.Create(AOwner: TComponent);
begin
  inherited;
  FDiskQuotas    := TWmiDiskQuotaList.Create(self, TWmiDiskQuota, false);
  FQuotaSettings := TWmiQuotaSettingList.Create(self, TWmiQuotaSetting, true)
end;

destructor TWmiDiskQuotaControl.Destroy;
begin
  FDiskQuotas.Free;
  FQuotaSettings.Free;
  inherited;
end;

procedure TWmiDiskQuotaControl.SetFilterVolume(const Value: widestring);
begin
  FFilterVolume := Value;
end;

procedure TWmiDiskQuotaControl.SetFilterAccount(const Value: widestring);
begin
  FFilterAccount := Value;
end;

function TWmiDiskQuotaControl.GetDiskQuotas: TWmiDiskQuotaList;
begin
  if Active then
  begin
    if FDiskQuotas.Count = 0 then LoadDiskQuotas;
  end else
  begin
    FDiskQuotas.ClearEntities;
  end;
  Result := FDiskQuotas;
end;

procedure TWmiDiskQuotaControl.SetDiskQuotas(const Value: TWmiDiskQuotaList); begin end;
procedure TWmiDiskQuotaControl.SetQuotaSettings(const Value: TWmiQuotaSettingList);begin end;

procedure TWmiDiskQuotaControl.LoadDiskQuotas;
var
  vEnum: IEnumVariant;
  vOleVar: OleVariant;
  vWmiObject: ISWbemObject;
  vFetchedCount: cardinal;
  vQuota: TWmiDiskQuota;
begin
  FDiskQuotas.ClearEntities;
  if Active then
  begin
    vEnum := ExecSelectQuery(BuildQuotaQueryWithFilter);
    while (vEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
    begin
      vWmiObject := IUnknown(vOleVar) as SWBemObject;
      vOleVar    := Unassigned;
      vQuota     := TWmiDiskQuota.Create(FDiskQuotas);
      vQuota.LoadProperties(vWmiObject);
    end;
  end;
end;

procedure TWmiDiskQuotaControl.LoadQuotaSettings;
var
  vEnum: IEnumVariant;
  vOleVar: OleVariant;
  vWmiObject: ISWbemObject;
  vFetchedCount: cardinal;
  vQuotaSetting: TWmiQuotaSetting;
begin
  FQuotaSettings.ClearEntities;
  if Active then
  begin
    vEnum := ExecSelectQuery(BuildSettingQueryWithFilter);
    while (vEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
    begin
      vWmiObject        := IUnknown(vOleVar) as SWBemObject;
      vOleVar           := Unassigned;
      vQuotaSetting     := TWmiQuotaSetting.Create(FQuotaSettings);
      vQuotaSetting.LoadProperties(vWmiObject);
    end;
  end;
end;

function TWmiDiskQuotaControl.BuildSettingQueryWithFilter: widestring;
begin
  Result := QUERY_SELECT_QUOTA_SETTINGS;
  if FilterVolume <> '' then Result := Result + ' where VolumePath="' +
      FilterVolume + '\\"';
end;

function TWmiDiskQuotaControl.BuildQuotaQueryWithFilter: widestring;
var
  vFilter, vAccountFilter, vVolumeFilter: widestring;
  AUserName, ADomain: widestring;
begin
  vAccountFilter := '';
  vVolumeFilter := '';
  vFilter := '';
  if FilterVolume <> '' then vVolumeFilter := Format(TEMPLATE_QUOTA_VOLUME, [FilterVolume]);
  if FilterAccount <> '' then
  begin
    SplitUserName(FilterAccount, ADomain, AUserName);
    vAccountFilter := Format(TEMPLATE_USER, [ADomain, AUserName]);
  end;

  if (vVolumeFilter <> '') and (vAccountFilter <> '') then
  begin
    vFilter := vVolumeFilter + ' and ' + vAccountFilter;
  end else
  if (vVolumeFilter <> '') then vFilter := vVolumeFilter else
  if (vAccountFilter <> '') then vFilter := vAccountFilter;

  Result := QUERY_SELECT_QUOTAS;
  if vFilter <> '' then Result := Result + ' where ' + vFilter;
end;


function TWmiDiskQuotaControl.GetQuotaSettings: TWmiQuotaSettingList;
begin
  if Active then
  begin
    if FQuotaSettings.Count = 0 then LoadQuotaSettings;
  end else
  begin
    FQuotaSettings.ClearEntities;
  end;
  Result := FQuotaSettings;
end;



procedure TWmiDiskQuotaControl.SetActive(AValue: boolean);
begin
  if (AValue <> GetActive) and (AValue = false) then
  begin
    FDiskQuotas.ClearEntities;
    FQuotaSettings.ClearEntities;
  end;

  inherited;
end;

procedure TWmiDiskQuotaControl.Refresh;
begin
  FDiskQuotas.ClearEntities;
  FQuotaSettings.ClearEntities;
end;

{ TWmiDiskQuota }

constructor TWmiDiskQuota.Create(AOwner: TWmiEntityList);
begin
  inherited Create(AOwner, true, TWmiDiskQuotaList);
end;

function TWmiDiskQuota.GetDisplayName: string;
begin
  Result := '';
  if (Account <> '') or (QuotaVolume <> '') then
    Result := Account + ' on ' + QuotaVolume;
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure TWmiDiskQuota.LoadProperties(AQuota: ISWbemObject);
var
  vProperties: ISWbemPropertySet;
  StartPos, EndPos: integer;
  vDomain, vUserName: string;
begin
  inherited;
  FNativeInterface := AQuota;
  WmiCheck(AQuota.Get_Properties_(vProperties));

  FStatus           := WmiGetIntegerPropertyValueByName(vProperties, 'Status');
  FDiskSpaceUsed    := WmiGetInt64PropertyValueByName(vProperties,   'DiskSpaceUsed');
  FWarningLimit     := WmiGetStringPropertyValueByName(vProperties,   'WarningLimit');
  FLimit            := WmiGetStringPropertyValueByName(vProperties,   'Limit');

  // QuotaVolume is string in format: 'Win32_LogicalDisk.DeviceId="C:"'
  FQuotaVolume      := WmiGetStringPropertyValueByName(vProperties,  'QuotaVolume');
  StartPos := PosEx('"', FQuotaVolume, 1);
  EndPos   := PosEx('"', FQuotaVolume, StartPos + 1);
  FQuotaVolume      := Copy(FQuotaVolume, StartPos + 1, EndPos - StartPos - 1);

  // User in format: 'Win32_Accoun.Domain="DOMAIN",Name="UserName"'
  FAccount             := WmiGetStringPropertyValueByName(vProperties,  'User');
  StartPos  := PosEx('"', FAccount, 1);
  EndPos    := PosEx('"', FAccount, StartPos + 1);
  vDomain   := Copy(FAccount, StartPos + 1, EndPos - StartPos - 1);
  StartPos  := EndPos;
  StartPos  := PosEx('"', FAccount, StartPos + 1);
  EndPos    := PosEx('"', FAccount, StartPos + 1);
  vUserName := Copy(FAccount, StartPos + 1, EndPos - StartPos - 1);;
  FAccount     := vDomain + '\' + vUserName;

end;

procedure TWmiDiskQuota.SetDiskSpaceUsed(const Value: int64);begin end;

procedure TWmiDiskQuota.SetQuotaVolume(const Value: widestring);begin end;
procedure TWmiDiskQuota.SetStatus(const Value: DWORD); begin end;
procedure TWmiDiskQuota.SetAccount(const Value: widestring);begin end;

procedure TWmiDiskQuota.SetLimit(const Value: widestring);
var
  vProperties: ISWbemPropertySet;
  vPath: ISWbemObjectPath;
begin
  if (NativeInterface <> nil) and (Value <> FLimit) then
  begin
    WmiCheck(NativeInterface.Get_Properties_(vProperties));
    WmiSetPropertyValueByName(vProperties, 'Limit', value);
    WmiCheck(NativeInterface.Put_(wbemChangeFlagUpdateOnly, nil, vPath));
    FLimit := Value;
  end;
end;

procedure TWmiDiskQuota.SetWarningLimit(const Value: widestring);
var
  vProperties: ISWbemPropertySet;
  vPath: ISWbemObjectPath;
begin
  if (NativeInterface <> nil) and (Value <> FWarningLimit) then
  begin
    WmiCheck(NativeInterface.Get_Properties_(vProperties));
    WmiSetPropertyValueByName(vProperties, 'WarningLimit', value);
    WmiCheck(NativeInterface.Put_(wbemChangeFlagCreateOrUpdate, nil, vPath));
    FWarningLimit := Value;
  end;
end;

{ TWmiDiskQuotaList }

class function TWmiDiskQuotaList.AddDiskQuota(AOwner: TWmiComponent;
       AUser, AQuotaVolume, AWarningLimit, ALimit: widestring): ISWbemObject;
var
  iQuota: ISWbemObject;
  vProperties: ISWbemPropertySet;
  vUserName, vDomain: widestring;
  vPath: ISWbemObjectPath;

  vQuery: string;
  vMachineName: widestring;
begin
  if not AOwner.Active then RaiseNotActiveException;
  SplitUserName(AUser, vDomain, vUserName);
  if AOwner.MachineName <> '' then vMachineName := AOwner.MachineName
    else vMachineName := AOwner.SystemInfo.ComputerName;
  vQuery := Format(QUERY_CREATE_QUOTA, [vMachineName, AOwner.NameSpace, AQuotaVolume, vDomain, vUserName]);
  WmiCheck(AOwner.WmiServices.Get(vQuery, 0, nil, iQuota));
  WmiCheck(iQuota.Get_Properties_(vProperties));

  WmiSetPropertyValueByName(vProperties, 'Limit', ALimit);
  WmiSetPropertyValueByName(vProperties, 'WarningLimit', AWarningLimit);
  WmiCheck(iQuota.Put_(wbemChangeFlagCreateOrUpdate, nil, vPath));
  WmiCheck(AOwner.WmiServices.Get(vQuery, 0, nil, Result));
end;


function TWmiDiskQuotaList.Add(Account, AQuotaVolume, AWarningLimit,
  ALimit: widestring): TWmiDiskQuota;
var
  iQuota: ISWbemObject;
  vQuota: TWmiDiskQuota;
begin
  if not Active then RaiseNotActiveException;
  iQuota := AddDiskQuota(Owner, Account, AQuotaVolume, AWarningLimit, ALimit);
  vQuota := TWmiDiskQuota.Create(self);
  vQuota.LoadProperties(iQuota);
  Result := vQuota;
end;

function TWmiDiskQuotaList.CreateQuotaWithPrompt(AQuota: TWmiDiskQuota): boolean;
var
  vForm: TFrmAddDiskQuota;
  iQuota: ISWbemObject;
begin
  Result := false;
  vForm := TFrmAddDiskQuota.Create(nil);
  try
    Owner.ListAccounts(vForm.cmbUser.Items);
    Owner.ListLogicalDisks(vForm.cmbVolume.Items);
    while vForm.ShowModal = mrOk do
    begin
      try
        iQuota := AddDiskQuota(Owner, vForm.cmbUser.Text, vForm.cmbVolume.Text, vForm.edtWarningLimit.Text, vForm.edtLimit.Text);
        AQuota.LoadProperties(iQuota);
        Result := true;
        Break;
      except
         on E: Exception do
          begin
            ShowMessage(E.Message);
          end;
      end;
    end;
  finally
    vForm.Free;
  end;
end;

function TWmiDiskQuotaList.GetItem(AIndex: integer): TWmiDiskQuota;
begin
  Result := TWmiDiskQuota(inherited GetItem(AIndex));
end;

{$IFDEF Delphi6}
procedure TWmiDiskQuotaList.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
var
  vQuota:         TWmiDiskQuota;
begin
  if Item = nil then Exit;
  
  vQuota := TWmiDiskQuota(Item);
  
  case Action of
     cnAdded:
       begin
         if not Active then Abort;
         if not vQuota.InternallyCreated then
           if not CreateQuotaWithPrompt(vQuota) then Abort;
       end;
     cnDeleting:
        if vQuota.NativeInterface <> nil then
        begin
          WmiCheck(vQuota.NativeInterface.Delete_(0, nil));
          vQuota.NativeInterface := nil;
        end;
     cnExtracting:
       begin
         // Extraction is performed
         // 1) At design time or run time, when component is destroying
         // 2) At design time, when item(s) is deleted from property editor
         // 3) At run time, when clear() is called.
         // 4) When component is changing credentials;
         // The process should be terminated only in case 2).
         if isDesignTime and
            (not IsDestroying) and
            (not IfDoNotPerformApi) and
            (vQuota.NativeInterface <> nil) then
         begin
            vQuota.NativeInterface.Delete_(0, nil);
            vQuota.NativeInterface := nil;
         end;
       end;
  end;
end;
{$ENDIF}

procedure TWmiDiskQuotaList.SetItem(AIndex: integer;
  const Value: TWmiDiskQuota);
begin
  inherited SetItem(AIndex, Value);
end;

procedure TWmiDiskQuotaList.Delete(AIndex: integer);
var
  vQuota: TWmiDiskQuota;
begin
  vQuota := Items[AIndex];
  if (vQuota.NativeInterface <> nil) then 
  begin
    WmiCheck(vQuota.NativeInterface.Delete_(0, nil));
    vQuota.NativeInterface := nil;
  end;

  inherited Delete(AIndex);  
end;

{ TWmiQuotaSetting }

constructor TWmiQuotaSetting.Create(AOwner: TWmiEntityList);
begin
  inherited Create(AOwner, true, TWmiQuotaSettingList);
end;

function TWmiQuotaSetting.GetDisplayName: string;
begin
  Result := Caption;
  if Result = '' then Result := inherited GetDisplayName;
end;


procedure TWmiQuotaSetting.LoadProperties(AQuotaSetting: ISWbemObject);
var
  vProperties: ISWbemPropertySet;
begin
  inherited;
  FNativeInterface := AQuotaSetting;
  WmiCheck(AQuotaSetting.Get_Properties_(vProperties));

  // There seems to be a bug in WMI implementation:
  // if WarningExceededNotification and ExceededNotification property has the opposite values,
  // their values are often swapped.
  // FWarningExceededNotification := WmiGetBooleanPropertyValueByName(vProperties, 'WarningExceededNotification');
  FExceededNotification        := WmiGetBooleanPropertyValueByName(vProperties, 'ExceededNotification');
  FDescription                 := WmiGetStringPropertyValueByName(vProperties, 'Description');
  FDefaultWarningLimit         := WmiGetStringPropertyValueByName(vProperties, 'DefaultWarningLimit');
  FDefaultLimit                := WmiGetStringPropertyValueByName(vProperties, 'DefaultLimit');
  FCaption                     := WmiGetStringPropertyValueByName(vProperties, 'Caption');
  FSettingID                   := WmiGetStringPropertyValueByName(vProperties, 'SettingID');
  FState                       := WmiGetIntegerPropertyValueByName(vProperties, 'State');
  FVolumePath                  := WmiGetStringPropertyValueByName(vProperties, 'VolumePath');
end;

procedure TWmiQuotaSetting.SetCaption(const Value: widestring); begin end;
procedure TWmiQuotaSetting.SetSettingID(const Value: widestring);begin end;

procedure TWmiQuotaSetting.SetDefaultLimit(const Value: widestring);
begin
  if (NativeInterface <> nil) and (Value <> FDefaultLimit) then
  begin
    BeginUpdate;
    FDefaultLimit := Value;
    LockUpdated := true;
    EndUpdate;
  end;  
end;

procedure TWmiQuotaSetting.SetDefaultWarningLimit(const Value: widestring);
begin
  if (NativeInterface <> nil) and (Value <> FDefaultWarningLimit) then
  begin
    BeginUpdate;
    FDefaultWarningLimit := Value;
    LockUpdated := true;
    EndUpdate;
  end;
end;

procedure TWmiQuotaSetting.SetDescription(const Value: widestring);
begin
  if (NativeInterface <> nil) and (Value <> FDescription) then
  begin
    BeginUpdate;
    FDescription := Value;
    LockUpdated := true;
    EndUpdate;
  end;
end;

procedure TWmiQuotaSetting.SetState(const Value: DWORD);
begin
  if (NativeInterface <> nil) and (Value <> FState) then
  begin
    BeginUpdate;
    FState := Value;
    LockUpdated := true;
    EndUpdate;
  end;
end;

procedure TWmiQuotaSetting.SetVolumePath(const Value: widestring);
begin
  if (NativeInterface <> nil) and (Value <> FVolumePath) then
  begin
    BeginUpdate;
    FVolumePath := Value;
    LockUpdated := true;
    EndUpdate;
  end;
end;

(*
    // There seems to be a bug in WMI implementation:
    // if WarningExceededNotification and ExceededNotification property has the opposite values,
    // their values are often swapped.

procedure TWmiQuotaSetting.SetWarningExceededNotification(
  const Value: boolean);
begin
  if (NativeInterface <> nil) and (Value <> FWarningExceededNotification) then
  begin
    BeginUpdate;
    FWarningExceededNotification := Value;
    LockUpdated := true;
    EndUpdate;
  end;
end;
*)

procedure TWmiQuotaSetting.SetExceededNotification(const Value: boolean);
begin
  if (NativeInterface <> nil) and (Value <> FExceededNotification) then
  begin
    BeginUpdate;
    FExceededNotification := Value;
    LockUpdated := true;
    EndUpdate;
  end;
end;

procedure TWmiQuotaSetting.Unlocked;
begin
  if LockUpdated then
  begin
    StoreProperties;
    LockUpdated := false;
  end;

end;

procedure TWmiQuotaSetting.StoreProperties;
var
  vProperties: ISWbemPropertySet;
  vPath: ISWbemObjectPath;
begin
  if NativeInterface <> nil then
  begin
    WmiCheck(NativeInterface.Get_Properties_(vProperties));
    WmiSetPropertyValueByName(vProperties, 'State', FState);
    WmiSetPropertyValueByName(vProperties, 'ExceededNotification', FExceededNotification);
    // There seems to be a bug in WMI implementation:
    // if WarningExceededNotification and ExceededNotification property has the opposite values,
    // their values are often swapped.
    WmiSetPropertyValueByName(vProperties, 'WarningExceededNotification', FExceededNotification);
    WmiSetPropertyValueByName(vProperties, 'Description', FDescription);
    WmiSetPropertyValueByName(vProperties, 'DefaultWarningLimit', FDefaultWarningLimit);
    WmiSetPropertyValueByName(vProperties, 'DefaultLimit', FDefaultLimit);
    WmiSetPropertyValueByName(vProperties, 'VolumePath', FVolumePath);
    WmiCheck(NativeInterface.Put_(wbemChangeFlagUpdateOnly, nil, vPath));

    Refresh;
  end;
end;

{ TWmiQuotaSettingList }

function TWmiQuotaSettingList.GetItem(AIndex: integer): TWmiQuotaSetting;
begin
  Result := TWmiQuotaSetting (inherited GetItem(AIndex));
end;

procedure TWmiQuotaSettingList.SetItem(AIndex: integer;
  const Value: TWmiQuotaSetting);
begin
  inherited SetItem(AIndex,Value);
end;

end.


