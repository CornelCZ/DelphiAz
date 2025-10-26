unit WmiDevice;

interface
{$I ..\Common\define.inc}

{$NOINCLUDE WbemScripting_TLB}
{$HPPEMIT '#include <wbemdisp.h>'}
{$HPPEMIT '#include <oaidl.h>'}
{$HPPEMIT '#include "wbem_script_support.h"'}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  WmiAbstract, WbemScripting_TLB, ActiveX, ComObj, WmiErr,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  WmiUtil, WmiComponent;

type
  TWmiDeviceAction = (daOther, daCreated, daDeleted, daChanged);
  TWmiDeviceEvent = procedure(Sender: TObject; DeviceId: widestring; Action: TWmiDeviceAction) of object;

  TWmiDevice = class;

  TWmiDevice = class(TWmiEntity)
  private
    FAvailability: word;
    FConfigManagerUserConfig: boolean;
    FPowerManagementSupported: boolean;
    FPowerManagementCapabilities: TStrings;
    FLastErrorCleared: boolean;
    FConfigManagerErrorCode: DWORD;
    FInstallDate: TDateTime;
    FDeviceId: widestring;
    FLastErrorDescription: widestring;
    FSystemName: widestring;
    FDescription: widestring;
    FName: widestring;
    FPNPDeviceID: widestring;
    FErrorMethodology: widestring;
    FCaption: widestring;
    FStatus: widestring;
    FStatusInfo: word;
    FLastErrorCode: DWORD;

    function  GetPowerManagementCapabilities: TStrings;
    procedure SetAvailability(const Value: word);
    procedure SetCaption(const Value: widestring);
    procedure SetConfigManagerErrorCode(const Value: DWORD);
    procedure SetConfigManagerUserConfig(const Value: boolean);
    procedure SetDescription(const Value: widestring);
    procedure SetDeviceId(const Value: widestring);
    procedure SetErrorMethodology(const Value: widestring);
    procedure SetInstallDate(const Value: TDateTime);
    procedure SetLastErrorCleared(const Value: boolean);
    procedure SetLastErrorDescription(const Value: widestring);
    procedure SetName(const Value: widestring);
    procedure SetPNPDeviceID(const Value: widestring);
    procedure SetPowerManagementCapabilities(const Value: TStrings);
    procedure SetPowerManagementSupported(const Value: boolean);
    procedure SetStatus(const Value: widestring);
    procedure SetStatusInfo(const Value: word);
    procedure SetSystemName(const Value: widestring);
    procedure SetLastErrorCode(const Value: DWORD);
  protected
    {$HINTS OFF} {$WARNINGS OFF}
    constructor Create(AOwner: TWmiEntityList;
                       AInternallyCreated: boolean;
                       AClass: TWmiEntityListClass); reintroduce;
    {$WARNINGS ON} {$HINTS ON}
    procedure   LoadProperties(ADrive: ISWbemObject); override;
    function    GetDisplayName: string; override;
  public
    destructor  Destroy; override;
  published
    property    Availability: word read FAvailability write SetAvailability;
    property    Caption: widestring read FCaption write SetCaption;
    property    ConfigManagerErrorCode: DWORD read FConfigManagerErrorCode write SetConfigManagerErrorCode;
    property    ConfigManagerUserConfig: boolean read FConfigManagerUserConfig write SetConfigManagerUserConfig;
    property    Description: widestring read FDescription write SetDescription;
    property    DeviceId: widestring read FDeviceId write SetDeviceId;
    property    ErrorMethodology: widestring read FErrorMethodology write SetErrorMethodology;
    property    InstallDate: TDateTime read FInstallDate write SetInstallDate;
    property    LastErrorCleared: boolean read FLastErrorCleared write SetLastErrorCleared;
    property    LastErrorCode: DWORD read FLastErrorCode write SetLastErrorCode;
    property    LastErrorDescription: widestring read FLastErrorDescription write SetLastErrorDescription;
    property    Name: widestring read FName write SetName;
    property    PNPDeviceID: widestring read FPNPDeviceID write SetPNPDeviceID;
    property    PowerManagementCapabilities: TStrings read GetPowerManagementCapabilities write SetPowerManagementCapabilities;
    property    PowerManagementSupported: boolean read FPowerManagementSupported write SetPowerManagementSupported;
    property    Status: widestring read FStatus write SetStatus;
    property    StatusInfo: word read FStatusInfo write SetStatusInfo;
    property    SystemName: widestring read FSystemName write SetSystemName;
  end;

const
  // device's availability
  AVAIL_OTHER               = 1;
  AVAIL_UNKNOWN             = 2;
  AVAIL_RUNNING             = 3;
  AVAIL_WARNING             = 4;
  AVAIL_IN_TEST             = 5;
  AVAIL_NOT_APPLICABLE      = 6;
  AVAIL_POWER_OFF           = 7;
  AVAIL_OFF_LINE            = 8;
  AVAIL_OFF_DUTY            = 9;
  AVAIL_DEGRADED            = 10;
  AVAIL_NOT_INSTALLED       = 11;
  AVAIL_INSTALL_ERROR       = 12;
  AVAIL_POWER_SAVE_UNKNOWN  = 13;
  AVAIL_POWER_SAVE_LOW_POWER_MODE = 14;
  AVAIL_POWER_SAVE_STANDBY  = 15;
  AVAIL_POWER_POWER_CYCLE   = 16;
  AVAIL_POWER_SAVE_WARNING  = 17;
  AVAIL_PAUSED              = 18;
  AVAIL_NOT_READY           = 19;
  AVAIL_NOT_CONFIGURED      = 20;
  AVAIL_QUIESCED            = 21;

  // Status info constants
  SI_OTHER = 1;
  SI_UNKNOWN = 2;
  SI_ENABLED = 3;
  SI_DISABLED = 4;
  SI_NOT_APPLICABLE = 5;

  // Power management capabilities
  PM_UNKNOWN = 0;
  PM_NOT_SUPPORTED = 1;
  PM_DISABLED = 2;
  PM_ENABLED = 3;
  PM_AUTO_POWER_SAVING = 4; //  Power Saving Modes Entered Automatically
  PM_POWER_STATE_SETTABLE = 5;
  PM_POWER_CYCLING_SUPPORTED = 6;
  PM_TIMED_POWER_ON_SUPPORTED = 7;


  
  // This device is working properly.
  CM_ERR_WORKING_PROPERLY = 0;

  // This device is not configured correctly.
  CM_ERR_NOT_CONFIGURED = 1;

  // Windows cannot load the driver for this device.
  CM_ERR_CANNOT_LOAD_DRIVER = 2;

  // The driver for this device might be corrupted, or your system may be running low on memory or other resources.
  CM_ERR_DRIVER_CORRUPTED_OR_LOW_RESOURCES = 3;

  // This device is not working properly. One of its drivers or your registry might be corrupted.
  CM_ERR_NOT_WORKING_PROPERLY = 4;

  // The driver for this device needs a resource that Windows cannot manage.
  CM_ERR_UMANAGEBLE_RESOURCE = 5;

  // The boot configuration for this device conflicts with other devices.
  CM_ERR_BOOT_CONFIGURATION_CONFLICT = 6;

  // Cannot filter.
  CM_ERR_CANNOT_FILTER = 7;

  // The driver loader for the device is missing.
  CM_ERR_DRIVER_LOADER_MISSING = 8;

  // This device is not working properly because the controlling firmware is reporting the resources for the device incorrectly.
  CM_ERR_INCORRECT_RESOURCES = 9;

  // This device cannot start.
  CM_ERR_DEVICE_CANNOT_START = 10;

  // This device failed.
  CM_ERR_DEVICE_FAILED = 11;

  // This device cannot find enough free resources that it can use.
  CM_ERR_NOT_ENOUGH_RESOURCES = 12;

  // Windows cannot verify this device's resources.
  CM_ERR_CANNOT_VERIFY_RESOURCES = 13;

  // This device cannot work properly until you restart your computer.
  CM_ERR_NEED_RESTART = 14;

  // This device is not working properly because there is probably a re-enumeration problem.
  CM_ERR_REENUMERATOR_PROBLEM = 15;

  // Windows cannot identify all the resources this device uses.
  CM_ERR_CANNOT_IDENTIFY_RESOURCES = 16;

  // This device is asking for an unknown resource type.
  CM_ERR_UNKNOWN_RESOURCE_TYPE = 17;

  // Reinstall the drivers for this device.
  CM_ERR_REINSTALL_DRIVERS = 18;

  // Failure using the VXD loader.
  CM_ERR_VDX_LOADER_FAILURE = 19;

  // Your registry might be corrupted.
  CM_ERR_REGISTRY_CORRUPTED = 20;

  // System failure: Try changing the driver for this device. If that does not work, see your hardware documentation. Windows is removing this device.
  CM_ERR_SYS_REMOVING_DEVICE = 21;

  // This device is disabled.
  CM_ERR_DEVICE_DISABLED = 22;

  // System failure: Try changing the driver for this device. If that doesn't work, see your hardware documentation.
  CM_ERR_SYS_FAILURE_CHANGE_DRIVER = 23;

  // This device is not present, is not working properly, or does not have all its drivers installed.
  CM_ERR_DIVICE_IS_NOT_PRESENT = 24;

  // Windows is still setting up this device.
  CM_ERR_STILL_IN_SETUP = 25;

  // Windows is still setting up this device.
  CM_ERR_STILL_SETTING_UP = 26;

  // This device does not have valid log configuration.
  CM_ERR_INVALID_LOG = 27;

  // The drivers for this device are not installed.
  CM_ERR_DRIVERS_NOT_INSTALLED = 28;

  // This device is disabled because the firmware of the device did not give it the required resources.
  CM_ERR_DISABLED_NO_RESOURCES = 29;

  // This device is using an Interrupt Request (IRQ) resource that another device is using.
  CM_ERR_IRQ_CONFLICT = 30;

  // This device is not working properly because Windows cannot load the drivers required for this device.
  CM_ERR_CANNOT_LOAD_DRIVERS = 31;


implementation

procedure LoadPowerManagementCapabilities(AProperties: ISWbemPropertySet; AList: TStrings);
var
  vVariant: OleVariant;
  i: integer;
begin
  AList.Clear;
  vVariant := WmiGetPropertyValueByName(AProperties, 'PowerManagementCapabilities');
  if VarIsArray(vVariant) then
  begin
    for i := VarArrayLowBound(vVariant, 1) to VarArrayHighBound(vVariant, 1) do
       AList.Add(IntToStr(vVariant[i]));
  end;
end;


{ TWmiDevice }

constructor TWmiDevice.Create(AOwner: TWmiEntityList;
  AInternallyCreated: boolean; AClass: TWmiEntityListClass);
begin
  inherited Create(AOwner, AInternallyCreated, AClass);
end;

destructor TWmiDevice.Destroy;
begin
  if FPowerManagementCapabilities <> nil then FPowerManagementCapabilities.Free;
  inherited;
end;

function TWmiDevice.GetDisplayName: string;
begin
  Result := FCaption;
  if Result = '' then Result := inherited GetDisplayName; 
end;

function TWmiDevice.GetPowerManagementCapabilities: TStrings;
begin
   if FPowerManagementCapabilities = nil then
     FPowerManagementCapabilities := TStringList.Create;
   Result := FPowerManagementCapabilities;
end;

procedure TWmiDevice.LoadProperties(ADrive: ISWbemObject);
var
  vProperties: ISWbemPropertySet;
begin
  inherited;
  WmiCheck(ADrive.Get_Properties_(vProperties));
  FAvailability             := WmiGetIntegerPropertyValueByName(vProperties, 'Availability');
  FCaption                  := WmiGetStringPropertyValueByName(vProperties, 'Caption');
  FDeviceId                 := WmiGetStringPropertyValueByName(vProperties, 'DeviceId');
  FPowerManagementSupported := WmiGetBooleanPropertyValueByName(vProperties, 'PowerManagementSupported');
  FLastErrorCleared         := WmiGetBooleanPropertyValueByName(vProperties, 'ErrorCleared');
  FLastErrorCode            := WmiGetIntegerPropertyValueByName(vProperties, 'LastErrorCode');
  FConfigManagerUserConfig  := WmiGetBooleanPropertyValueByName(vProperties, 'ConfigManagerUserConfig');
  FConfigManagerErrorCode   := WmiGetIntegerPropertyValueByName(vProperties, 'ConfigManagerErrorCode');
  FInstallDate              := WmiParseDateTime(WmiGetStringPropertyValueByName(vProperties, 'InstallDate'));
  FSystemName               := WmiGetStringPropertyValueByName(vProperties, 'SystemName');
  FStatus                   := WmiGetStringPropertyValueByName(vProperties, 'Status');
  FPNPDeviceID              := WmiGetStringPropertyValueByName(vProperties, 'PNPDeviceID');
  FLastErrorDescription     := WmiGetStringPropertyValueByName(vProperties, 'ErrorDescription');
  FDescription              := WmiGetStringPropertyValueByName(vProperties, 'Description');
  FErrorMethodology         := WmiGetStringPropertyValueByName(vProperties, 'ErrorMethodology');
  FName                     := WmiGetStringPropertyValueByName(vProperties, 'Name');
  FStatusInfo               := WmiGetIntegerPropertyValueByName(vProperties, 'StatusInfo');

  if FPowerManagementCapabilities = nil then FPowerManagementCapabilities := TStringList.Create; 
  LoadPowerManagementCapabilities(vProperties, FPowerManagementCapabilities);
end;


procedure TWmiDevice.SetAvailability(const Value: word);begin end;
procedure TWmiDevice.SetCaption(const Value: widestring);begin end;
procedure TWmiDevice.SetConfigManagerErrorCode(const Value: DWORD);begin end;
procedure TWmiDevice.SetConfigManagerUserConfig(const Value: boolean);begin end;
procedure TWmiDevice.SetDescription(const Value: widestring);begin end;
procedure TWmiDevice.SetDeviceId(const Value: widestring);begin end;
procedure TWmiDevice.SetErrorMethodology(const Value: widestring);begin end;
procedure TWmiDevice.SetInstallDate(const Value: TDateTime);begin end;
procedure TWmiDevice.SetLastErrorCleared(const Value: boolean);begin end;
procedure TWmiDevice.SetLastErrorCode(const Value: DWORD);begin end;
procedure TWmiDevice.SetLastErrorDescription(const Value: widestring);begin end;
procedure TWmiDevice.SetName(const Value: widestring);begin end;
procedure TWmiDevice.SetPNPDeviceID(const Value: widestring);begin end;
procedure TWmiDevice.SetPowerManagementCapabilities(const Value: TStrings);begin end;
procedure TWmiDevice.SetPowerManagementSupported(const Value: boolean);begin end;
procedure TWmiDevice.SetStatus(const Value: widestring);begin end;
procedure TWmiDevice.SetStatusInfo(const Value: word);begin end;
procedure TWmiDevice.SetSystemName(const Value: widestring);begin end;



end.


