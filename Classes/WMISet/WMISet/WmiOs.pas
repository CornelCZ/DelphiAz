unit WmiOs;

interface
{$I ..\Common\define.inc}

{$NOINCLUDE WbemScripting_TLB}
{$HPPEMIT '#include <wbemdisp.h>'}
{$HPPEMIT '#include <oaidl.h>'}
{$HPPEMIT '#include "wbem_script_support.h"'}


uses
  Windows, Messages, SysUtils, Classes, WmiAbstract,
  WmiComponent, WbemScripting_TLB, ActiveX,
  WmiUtil, WmiErr,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  DetectWinOS;

type
  TWmiQuickFix = class;
  TWmiQuickFixList = class;
  TWmiOs = class;
  TWmiOsRecovery = class;

  TWmiQuickFix = class(TWmiEntity)
  private
    FInstallDate: TDateTime;
    FName: WideString;
    FInstalledOn: WideString;
    FStatus: WideString;
    FCaption: WideString;
    FServicePackInEffect: WideString;
    FHotFixId: WideString;
    FDescription: WideString;
    FInstalledBy: WideString;
    FFixComments: WideString;
    procedure SetCaption(const Value: WideString);
    procedure SetDescription(const Value: WideString);
    procedure SetFixComments(const Value: WideString);
    procedure SetHotFixId(const Value: WideString);
    procedure SetInstallDate(const Value: TDateTime);
    procedure SetInstalledBy(const Value: WideString);
    procedure SetInstalledOn(const Value: WideString);
    procedure SetName(const Value: WideString);
    procedure SetServicePackInEffect(const Value: WideString);
    procedure SetStatus(const Value: WideString);
  protected
    {$HINTS OFF} {$WARNINGS OFF}
    constructor Create(AOwner: TWmiEntityList); reintroduce;
    {$WARNINGS ON} {$HINTS ON}
    procedure   LoadProperties(AQuickFix: ISWbemObject); override;
    function    GetDisplayName: string; override;
  public
    procedure   Refresh; override;
  published
    property    Caption: WideString read FCaption write SetCaption;
    property    Description: WideString read FDescription write SetDescription;
    property    FixComments: WideString read FFixComments write SetFixComments;
    property    HotFixId: WideString read FHotFixId write SetHotFixId;
    property    InstallDate: TDateTime read FInstallDate write SetInstallDate;
    property    InstalledBy: WideString read FInstalledBy write SetInstalledBy;
    property    InstalledOn: WideString read FInstalledOn write SetInstalledOn;
    property    Name: WideString read FName write SetName;
    property    ServicePackInEffect: WideString read FServicePackInEffect write SetServicePackInEffect;
    property    Status: WideString read FStatus write SetStatus;
  end;

  TWmiQuickFixList = class(TWmiEntityList)
  private
    function  GetItem(AIndex: integer): TWmiQuickFix;
    procedure SetItem(AIndex: integer; const Value: TWmiQuickFix);
  protected
  public
    property Items[AIndex: integer]: TWmiQuickFix read GetItem write SetItem; default;
  end;

  TWmiOsRecovery = class(TPersistent)
  private
    FOwner: TWmiOs;
    FRecovery: ISWbemObject;
    FProperties: ISWbemPropertySet;
    function GetAutoReboot: boolean;
    function GetDebugFilePath: widestring;
    function GetDebugInfoType: integer;
    function GetExpandedDebugFilePath: widestring;
    function GetExpandedMiniDumpDirectory: widestring;
    function GetKernelDumpOnly: boolean;
    function GetMiniDumpDirectory: widestring;
    function GetOverwriteExistingDebugFile: boolean;
    function GetSendAdminAlert: boolean;
    function GetWriteDebugInfo: boolean;
    function GetWriteToSystemLog: boolean;
    procedure SetAutoReboot(const Value: boolean);
    procedure SetDebugFilePath(const Value: widestring);
    procedure SetDebugInfoType(const Value: integer);
    procedure SetExpandedDebugFilePath(const Value: widestring);
    procedure SetExpandedMiniDumpDirectory(const Value: widestring);
    procedure SetKernelDumpOnly(const Value: boolean);
    procedure SetMiniDumpDirectory(const Value: widestring);
    procedure SetOverwriteExistingDebugFile(const Value: boolean);
    procedure SetSendAdminAlert(const Value: boolean);
    procedure SetWriteDebugInfo(const Value: boolean);
    procedure SetWriteToSystemLog(const Value: boolean);
  protected
    constructor Create(AOwner: TWmiOs);
    procedure   SetRecoveryObject(ARecovery: ISWbemObject);
  published
    property AutoReboot: boolean read GetAutoReboot write SetAutoReboot stored false;
    property DebugFilePath: widestring read GetDebugFilePath write SetDebugFilePath stored false;
    property DebugInfoType: integer read GetDebugInfoType write SetDebugInfoType stored false;
    property ExpandedDebugFilePath: widestring read GetExpandedDebugFilePath write SetExpandedDebugFilePath stored false;
    property ExpandedMiniDumpDirectory: widestring read GetExpandedMiniDumpDirectory write SetExpandedMiniDumpDirectory stored false;
    property KernelDumpOnly: boolean read GetKernelDumpOnly write SetKernelDumpOnly stored false;
    property MiniDumpDirectory: widestring read GetMiniDumpDirectory write SetMiniDumpDirectory stored false;
    property OverwriteExistingDebugFile: boolean read GetOverwriteExistingDebugFile write SetOverwriteExistingDebugFile stored false;
    property SendAdminAlert: boolean read GetSendAdminAlert write SetSendAdminAlert stored false;
    property WriteDebugInfo: boolean read GetWriteDebugInfo write SetWriteDebugInfo stored false;
    property WriteToSystemLog: boolean read GetWriteToSystemLog write SetWriteToSystemLog stored false;  
  end;                                   

  TWmiOs = class(TWmiComponent)
  private
    FObject:     ISWbemObject;
    FProperties: ISWbemPropertySet;
    FQuickFixes: TWmiQuickFixList;
    FRecovery:   TWmiOsRecovery;

    function GetBootDevice: WideString;
    function GetBuildNumber: WideString;
    function GetBuildType: WideString;
    function GetCaption: WideString;
    function GetCodeSet: WideString;
    function GetCountryCode: WideString;
    function GetCSDVersion: WideString;
    function GetCSName: WideString;
    function GetCurrentTimeZone: integer;
    function GetDebug: boolean;
    function GetDescription: WideString;
    function GetDistributed: boolean;
    function GetEncryptionLevel: DWORD;
    function GetForegroundApplicationBoost: byte;
    function GetFreePhysicalMemory: int64;
    function GetFreeSpaceInPagingFiles: int64;
    function GetFreeVirtualMemory: int64;
    function GetInstallDate: TDateTime;
    function GetLargeSystemCache: DWORD;
    function GetLastBootUpTime: TDateTime;
    function GetLocalDateTime: TDateTime;
    function GetLocale: WideString;
    function GetManufacturer: WideString;
    function GetMaxNumberOfProcesses: DWORD;
    function GetMaxProcessMemorySize: int64;
    function GetNumberOfLicensedUsers: DWORD;
    function GetNumberOfProcesses: DWORD;
    function GetNumberOfUsers: DWORD;
    function GetOrganization: WideString;
    function GetOSLanguage: DWORD;
    function GetOSName: WideString;
    function GetOSProductSuite: DWORD;
    function GetOSType: word;
    function GetOtherTypeDescription: WideString;
    function GetPlusProductID: WideString;
    function GetPlusVersionNumber: WideString;
    function GetPrimary: boolean;
    function GetQuantumLength: byte;
    function GetQuantumType: byte;
    function GetRegisteredUser: WideString;
    function GetSerialNumber: WideString;
    function GetServicePackMajorVersion: word;
    function GetServicePackMinorVersion: word;
    function GetSizeStoredInPagingFiles: int64;
    function GetStatus: WideString;
    function GetSuiteMask: DWORD;
    function Get_SystemDevice: WideString;
    function Get_SystemDirectory: WideString;
    function GetSystemDrive: WideString;
    function GetTotalSwapSpaceSize: int64;
    function GetTotalVirtualMemorySize: int64;
    function GetTotalVisibleMemorySize: int64;
    function GetVersion: WideString;
    function Get_WindowsDirectory: WideString;
    procedure SetBootDevice(const Value: WideString);
    procedure SetBuildNumber(const Value: WideString);
    procedure SetBuildType(const Value: WideString);
    procedure SetCaption(const Value: WideString);
    procedure SetCodeSet(const Value: WideString);
    procedure SetCountryCode(const Value: WideString);
    procedure SetCSDVersion(const Value: WideString);
    procedure SetCSName(const Value: WideString);
    procedure SetCurrentTimeZone(const Value: integer);
    procedure SetDebug(const Value: boolean);
    procedure SetDescription(const Value: WideString);
    procedure SetDistributed(const Value: boolean);
    procedure SetEncryptionLevel(const Value: DWORD);
    procedure SetForegroundApplicationBoost(const Value: byte);
    procedure SetFreePhysicalMemory(const Value: int64);
    procedure SetFreeSpaceInPagingFiles(const Value: int64);
    procedure SetFreeVirtualMemory(const Value: int64);
    procedure SetInstallDate(const Value: TDateTime);
    procedure SetLargeSystemCache(const Value: DWORD);
    procedure SetLastBootUpTime(const Value: TDateTime);
    procedure SetLocalDateTime(const Value: TDateTime);
    procedure SetLocale(const Value: WideString);
    procedure SetManufacturer(const Value: WideString);
    procedure SetMaxNumberOfProcesses(const Value: DWORD);
    procedure SetMaxProcessMemorySize(const Value: int64);
    procedure SetNumberOfLicensedUsers(const Value: DWORD);
    procedure SetNumberOfProcesses(const Value: DWORD);
    procedure SetNumberOfUsers(const Value: DWORD);
    procedure SetOrganization(const Value: WideString);
    procedure SetOSLanguage(const Value: DWORD);
    procedure SetOSName(const Value: WideString);
    procedure SetOSProductSuite(const Value: DWORD);
    procedure SetOSType(const Value: word);
    procedure SetOtherTypeDescription(const Value: WideString);
    procedure SetPlusProductID(const Value: WideString);
    procedure SetPlusVersionNumber(const Value: WideString);
    procedure SetPrimary(const Value: boolean);
    procedure SetQuantumLength(const Value: byte);
    procedure SetQuantumType(const Value: byte);
    procedure SetRegisteredUser(const Value: WideString);
    procedure SetSerialNumber(const Value: WideString);
    procedure SetServicePackMajorVersion(const Value: word);
    procedure SetServicePackMinorVersion(const Value: word);
    procedure SetSizeStoredInPagingFiles(const Value: int64);
    procedure SetStatus(const Value: WideString);
    procedure SetSuiteMask(const Value: DWORD);
    procedure SetSystemDevice(const Value: WideString);
    procedure SetSystemDirectory(const Value: WideString);
    procedure SetSystemDrive(const Value: WideString);
    procedure SetTotalSwapSpaceSize(const Value: int64);
    procedure SetTotalVirtualMemorySize(const Value: int64);
    procedure SetTotalVisibleMemorySize(const Value: int64);
    procedure SetVersion(const Value: WideString);
    procedure SetWindowsDirectory(const Value: WideString);
    procedure ClearData;
    procedure LoadData;
    function  GetLocalTimeZone: integer;
    procedure SetLocalTimeZone(const Value: integer);
    function  GetQuickFixes: TWmiQuickFixList;
    procedure SetQuickFixes(const Value: TWmiQuickFixList);
    procedure LoadQuickFixes;
    function GetProductType: DWORD;
    procedure SetProductType(const Value: DWORD);
    function GetRecovery: TWmiOsRecovery;
    procedure SetRecovery(const Value: TWmiOsRecovery);

    { Private declarations }
  protected
    { Protected declarations }
    procedure SetActive(Value: boolean); override;
    procedure CredentialsOrTargetChanged; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    procedure  Refresh;
    procedure  Reboot;
    procedure  Shutdown;
    procedure  ShutdownEx(AFlags: integer);

    function   OSTypeToStr(AType: integer): string;
    function   QuantumTypeToStr(AType: integer): string;
    function   QuantumLengthToStr(ALength: integer): string;
    function   SuiteMaskToStr(AMask: integer): string;

  published
    { Published declarations }
    property BootDevice:  WideString read GetBootDevice write SetBootDevice stored false;
    property BuildNumber: WideString read GetBuildNumber write SetBuildNumber stored false;
    property BuildType:   WideString read GetBuildType write SetBuildType stored false;
    property Caption:     WideString read GetCaption write SetCaption stored false;
    property CodeSet:     WideString read GetCodeSet write SetCodeSet stored false;
    property CountryCode: WideString read GetCountryCode write SetCountryCode stored false;
    property CSDVersion:  WideString read GetCSDVersion write SetCSDVersion stored false;
    property CSName:      WideString read GetCSName write SetCSName stored false;
    property CurrentTimeZone: integer read GetCurrentTimeZone write SetCurrentTimeZone stored false;
    property Debug: boolean read GetDebug write SetDebug stored false;
    property Description: WideString read GetDescription write SetDescription stored false;
    property Distributed: boolean read GetDistributed write SetDistributed stored false;
    property EncryptionLevel: DWORD read GetEncryptionLevel write SetEncryptionLevel stored false;
    property ForegroundApplicationBoost: byte read GetForegroundApplicationBoost write SetForegroundApplicationBoost stored false;
    property FreePhysicalMemory: int64 read GetFreePhysicalMemory write SetFreePhysicalMemory stored false;
    property FreeSpaceInPagingFiles: int64 read GetFreeSpaceInPagingFiles write SetFreeSpaceInPagingFiles stored false;
    property FreeVirtualMemory: int64 read GetFreeVirtualMemory write SetFreeVirtualMemory stored false;
    property InstallDate: TDateTime read GetInstallDate write SetInstallDate stored false;
    property LargeSystemCache: DWORD read GetLargeSystemCache write SetLargeSystemCache stored false;
    property LastBootUpTime: TDateTime read GetLastBootUpTime write SetLastBootUpTime stored false;
    property LocalDateTime: TDateTime read GetLocalDateTime write SetLocalDateTime stored false;
    property Locale: WideString read GetLocale write SetLocale stored false;
    property Manufacturer: WideString read GetManufacturer write SetManufacturer stored false;
    property MaxNumberOfProcesses: DWORD read GetMaxNumberOfProcesses write SetMaxNumberOfProcesses stored false;
    property MaxProcessMemorySize: int64 read GetMaxProcessMemorySize write SetMaxProcessMemorySize stored false;
    property NumberOfLicensedUsers: DWORD read GetNumberOfLicensedUsers write SetNumberOfLicensedUsers stored false;
    property NumberOfProcesses: DWORD read GetNumberOfProcesses write SetNumberOfProcesses stored false;
    property NumberOfUsers: DWORD read GetNumberOfUsers write SetNumberOfUsers stored false;
    property Organization: WideString read GetOrganization write SetOrganization stored false;
    property OSLanguage: DWORD read GetOSLanguage write SetOSLanguage stored false;
    property OSName: WideString read GetOSName write SetOSName stored false;
    property OSProductSuite: DWORD read GetOSProductSuite write SetOSProductSuite stored false;
    property OSType: word read GetOSType write SetOSType stored false;
    property OtherTypeDescription: WideString read GetOtherTypeDescription write SetOtherTypeDescription stored false;
    property PlusProductID: WideString read GetPlusProductID write SetPlusProductID stored false;
    property PlusVersionNumber: WideString read GetPlusVersionNumber write SetPlusVersionNumber stored false;
    property Primary: boolean read GetPrimary write SetPrimary stored false;
    property ProductType: DWORD read GetProductType write SetProductType stored false;
    property QuantumLength: byte read GetQuantumLength write SetQuantumLength stored false;
    property QuantumType: byte read GetQuantumType write SetQuantumType stored false;
    property RegisteredUser: WideString read GetRegisteredUser write SetRegisteredUser stored false;
    property SerialNumber: WideString read GetSerialNumber write SetSerialNumber stored false;
    property ServicePackMajorVersion: word read GetServicePackMajorVersion write SetServicePackMajorVersion stored false;
    property ServicePackMinorVersion: word read GetServicePackMinorVersion write SetServicePackMinorVersion stored false;
    property SizeStoredInPagingFiles: int64 read GetSizeStoredInPagingFiles write SetSizeStoredInPagingFiles stored false;
    property Status: WideString read GetStatus write SetStatus stored false;
    property SuiteMask: DWORD read GetSuiteMask write SetSuiteMask stored false;
    property SystemDevice: WideString read Get_SystemDevice write SetSystemDevice stored false;
    property SystemDirectory: WideString read Get_SystemDirectory write SetSystemDirectory stored false;
    property SystemDrive: WideString read GetSystemDrive write SetSystemDrive stored false;
    property TotalSwapSpaceSize: int64 read GetTotalSwapSpaceSize write SetTotalSwapSpaceSize stored false;
    property TotalVirtualMemorySize: int64 read GetTotalVirtualMemorySize write SetTotalVirtualMemorySize stored false;
    property TotalVisibleMemorySize: int64 read GetTotalVisibleMemorySize write SetTotalVisibleMemorySize stored false;
    property LocalTimeZone: integer read GetLocalTimeZone write SetLocalTimeZone stored false;
    property Version: WideString read GetVersion write SetVersion stored false;
    property WindowsDirectory: WideString read Get_WindowsDirectory write SetWindowsDirectory stored false;
    property QuickFixes: TWmiQuickFixList read GetQuickFixes write SetQuickFixes stored false;
    property Recovery: TWmiOsRecovery read GetRecovery write SetRecovery stored false;

    property Active;
    property Credentials;
    property MachineName;
  end;


const
  OS_UNKNOWN        = 0;
  OS_OTHER          = 1;
  OS_MACOS          = 2;
  OS_ATTUNIX        = 3;
  OS_DGUX           = 4;
  OS_DECNT          = 5;
  OS_DIGITAL_UNIX   = 6;
  OS_OPENVMS        = 7;
  OS_HPUX           = 8;
  OS_AIX            = 9;
  OS_MVS               = 10;
  OS_OS400             = 11;
  OS_OS_2              = 12;
  OS_JAVAVM            = 13;
  OS_MSDOS             = 14;
  OS_WIN3X             = 15;
  OS_WIN95             = 16;
  OS_WIN98             = 17;
  OS_WINNT             = 18;
  OS_WINCE             = 19;
  OS_NCR3000           = 20;
  OS_NETWARE           = 21;
  OS_OSF               = 22;
  OS_DC_OS             = 23;
  OS_RELIANT_UNIX      = 24;
  OS_SCO_UNIXWARE      = 25;
  OS_SCO_OPENSERVER    = 26;
  OS_SEQUENT           = 27;
  OS_IRIX              = 28;
  OS_SOLARIS           = 29;
  OS_SUNOS             = 30;
  OS_U6000             = 31;
  OS_ASERIES           = 32;
  OS_TANDEMNSK         = 33;
  OS_TANDEMNT          = 34;
  OS_BS2000            = 35;
  OS_LINUX             = 36;
  OS_LYNX              = 37;
  OS_XENIX             = 38;
  OS_VM_ESA            = 39;
  OS_INTERACTIVE_UNIX  = 40;
  OS_BSDUNIX           = 41;
  OS_FREEBSD           = 42;
  OS_NETBSD            = 43;
  OS_GNU_HURD          = 44;
  OS_OS9               = 45;
  OS_MACH_KERNEL       = 46;
  OS_INFERNO           = 47;
  OS_QNX               = 48;
  OS_EPOC              = 49;
  OS_IXWORKS           = 50;
  OS_VXWORKS           = 51;
  OS_MINT              = 52;
  OS_BEOS              = 53;
  OS_HP_MPE            = 54;
  OS_NEXTSTEP          = 55;
  OS_PALMPILOT         = 56;
  OS_RHAPSODY          = 57;


  // Quantum Length
  // Documentation says that the values are 1, 2, 3.
  // WMI throws an exception if I pass value of 3.
  // I assume that documentation is wrong, and right values are 1, 2, 3
  QL_UNKNOWN           = 0;  // 1
  QL_ONE_TICK          = 1;  // 2
  QL_TWO_TICKS         = 2;  // 3

  // Quantum type
  // Documentation says that the values are 1, 2, 3.
  // WMI throws an exception if I pass value of 3.
  // I assume that documentation is wrong, and right values are 0, 1, 2
  QT_UNKNOWN           = 0;
  QT_FIXED             = 1;
  QT_VARIABLE          = 2;

  // Suite Mask
  SM_SMALL_BUSINESS = 1;
  SM_ENTERPRISE = 2;
  SM_BACK_OFFICE = 4;
  SM_COMMUNICATIONS = 8;
  SM_TERMINAL = 16;
  SM_SMALL_BUSINESS_RESTRICTED = 32;
  SM_EMBEDDED_NT = 64;
  SM_DATA_CENTER = 128;
  SM_SINGLE_USER = 256;
  SM_PERSONAL = 512;
  SM_BLADE = 1024;

  // Foreground application boost
  FAB_NONE     = 0;
  FAB_MINIMUM  = 1;
  FAB_MAXIMUM  = 2;

  FLAG_LOGOFF = 0;
  FLAG_LOGOFF_FORCED = 4;
  FLAG_SHUTDOWN = 1;
  FLAG_SHUTDOWN_FORCED = 5;
  FLAG_REBOOT = 2;
  FLAG_REBOOT_FORCED = 6;
  FLAG_POWEROFF = 8;
  FLAG_POWEROFF_FORCED = 12;

  // large system cash
  LSC_APPLICATION = 0;
  LSC_SYSTEM = 1;

  // product suite
  PS_SMALL_BUSINESS            = 1;
  PS_ENTERPRISE                = 2;
  PS_BACKOFFICE                = 4;
  PS_COMMUNICATION_SERVER      = 8;
  PS_TERMINAL_SERVER           = 16;
  PS_SMALL_BUSINESS_RESTRICTED = 32;
  PS_EMBEDDED_NT               = 64;
  PS_DATA_CENTER               = 128;

  // Product type
  PT_WORKSTATION       = 1;
  PT_DOMAIN_CONTROLLER = 2;
  PT_SERVER            = 3;

  // debug info type
  DIT_NONE = 0;
  DIT_COMPLETE_MEMORY = 1;
  DIT_KERNEL_MEMORY = 2;
  DIT_SMALL_MEMORY = 3;
   
implementation

const
  QUERY_SELECT_OS = 'select * FROM Win32_OperatingSystem';
  QUERY_SELECT_OS_RECOVERY = 'select * FROM Win32_OSRecoveryConfiguration';
  QUERY_FIND_QUICK_FIX_BY_ID = 'select * from Win32 Win32_QuickFixEngineering where HodFixId = %s';
  QUERY_SELECT_QUICK_FIXES = 'ASSOCIATORS OF {Win32_OperatingSystem.Name="%s"} '+
                             'WHERE ResultClass = Win32_QuickFixEngineering';


function OsSuiteMaskToString(AMask: DWORD): string;
begin
  case AMask of
    SM_SMALL_BUSINESS:            Result := 'Small Business';
    SM_ENTERPRISE:                Result := 'Enterprise';
    SM_BACK_OFFICE:               Result := 'Back Office';
    SM_COMMUNICATIONS:            Result := 'Communications';
    SM_TERMINAL:                  Result := 'Terminal';
    SM_SMALL_BUSINESS_RESTRICTED: Result := 'Small Business Restricted';
    SM_EMBEDDED_NT:               Result := 'Embedded NT';
    SM_DATA_CENTER:               Result := 'Data Center';
    SM_SINGLE_USER:               Result := 'Single User';
    SM_PERSONAL:                  Result := 'Personal';
    SM_BLADE:                     Result := 'Blade';
    else Result := IntToStr(AMask);
  end;
end;


// the function returns descriptions for error codes that are
// specific to Win32_OperatingSystem  class. 
function ErrorFunction(AErrorCode: integer): widestring;
begin
  case AErrorCode of
    0: Result := 'Successful completion';
    2: Result := 'The user does not have access to the requested information.';
    3: Result := 'The user does not have sufficient privilege.';
    8: Result := 'Unknown failure.';
    9: Result := 'The path specified does not exist.';
    21: Result := 'The specified parameter is invalid.';
    else Result := IntToStr(AErrorCode);
  end;
end;

// replaces "\" with "\\". At this time is not smart enough
// to find if string is already encoded.

function EncodeSlashes(AStr: string): string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to Length(AStr) do
  begin
    Result := Result + AStr[i];
    if AStr[i] = '\' then Result := Result + '\';
  end;
end;

{ TWmiOs }

function TWmiOs.GetBootDevice: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'BootDevice')
    else Result := ''; 
end;

function TWmiOs.GetBuildNumber: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'BuildNumber')
    else Result := ''; 
end;

function TWmiOs.GetBuildType: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'BuildType')
    else Result := ''; 
end;

function TWmiOs.GetCaption: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'Caption')
    else Result := ''; 
end;

function TWmiOs.GetCodeSet: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'CodeSet')
    else Result := ''; 
end;

function TWmiOs.GetCountryCode: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'CountryCode')
    else Result := '';
end;

function TWmiOs.GetCSDVersion: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'CSDVersion')
    else Result := '';
end;

function TWmiOs.GetCSName: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'CSName')
    else Result := '';
end;

function TWmiOs.GetCurrentTimeZone: integer;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByName(FProperties, 'CurrentTimeZone')
    else Result := 0;
end;

function TWmiOs.GetDebug: boolean;
begin
  if FProperties <> nil then
    Result := WmiGetBooleanPropertyValueByName(FProperties, 'Debug')
    else Result := false;
end;

function TWmiOs.GetDescription: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'Description')
    else Result := '';
end;

function TWmiOs.GetDistributed: boolean;
begin
  if FProperties <> nil then
    Result := WmiGetBooleanPropertyValueByName(FProperties, 'Distributed')
    else Result := false;
end;

function TWmiOs.GetEncryptionLevel: DWORD;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByNameSafe(FProperties, 'EncryptionLevel')
    else Result := 0;
end;

function TWmiOs.GetForegroundApplicationBoost: byte;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByName(FProperties, 'ForegroundApplicationBoost')
    else Result := 0;
end;

function TWmiOs.GetFreePhysicalMemory: int64;
begin
  if FProperties <> nil then
    Result := WmiGetInt64PropertyValueByName(FProperties, 'FreePhysicalMemory')
    else Result := 0;
end;

function TWmiOs.GetFreeSpaceInPagingFiles: int64;
begin
  if FProperties <> nil then
    Result := WmiGetInt64PropertyValueByName(FProperties, 'FreeSpaceInPagingFiles')
    else Result := 0;
end;

function TWmiOs.GetFreeVirtualMemory: int64;
begin
  if FProperties <> nil then
    Result := WmiGetInt64PropertyValueByName(FProperties, 'FreeVirtualMemory')
    else Result := 0;
end;

function TWmiOs.GetInstallDate: TDateTime;
var
  vStr: WideString;
begin
  if FProperties <> nil then
  begin
    vStr := WmiGetStringPropertyValueByName(FProperties, 'InstallDate');
    Result := WmiParseDateTime(vStr);
  end else
  begin
    Result := 0;
  end;  
end;

function TWmiOs.GetLargeSystemCache: DWORD;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByNameSafe(FProperties, 'LargeSystemCache')
    else Result := 0;
end;

function TWmiOs.GetLastBootUpTime: TDateTime;
var
  vStr: WideString;
begin
  if FProperties <> nil then
  begin
    vStr := WmiGetStringPropertyValueByName(FProperties, 'LastBootUpTime');
    Result := WmiParseDateTime(vStr);
  end else
  begin
    Result := 0;
  end;  
end;

function TWmiOs.GetLocalDateTime: TDateTime;
var
  vStr: WideString;
begin
  if FProperties <> nil then
  begin
    vStr := WmiGetStringPropertyValueByName(FProperties, 'LocalDateTime');
    Result := WmiParseDateTime(vStr);
  end else
  begin
    Result := 0;
  end;  
end;

function TWmiOs.GetLocale: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'Locale')
    else Result := '';
end;

function TWmiOs.GetManufacturer: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'Manufacturer')
    else Result := '';
end;

function TWmiOs.GetMaxNumberOfProcesses: DWORD;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByName(FProperties, 'MaxNumberOfProcesses')
    else Result := 0;
end;

function TWmiOs.GetMaxProcessMemorySize: int64;
begin
  if FProperties <> nil then
    Result := WmiGetInt64PropertyValueByName(FProperties, 'MaxProcessMemorySize')
    else Result := 0;
end;

function TWmiOs.GetNumberOfLicensedUsers: DWORD;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByName(FProperties, 'NumberOfLicensedUsers')
    else Result := 0;
end;

function TWmiOs.GetNumberOfProcesses: DWORD;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByName(FProperties, 'NumberOfProcesses')
    else Result := 0;
end;

function TWmiOs.GetNumberOfUsers: DWORD;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByName(FProperties, 'NumberOfUsers')
    else Result := 0;
end;

function TWmiOs.GetOrganization: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'Organization')
    else Result := '';
end;

function TWmiOs.GetOSLanguage: DWORD;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByName(FProperties, 'OSLanguage')
    else Result := 0;
end;

function TWmiOs.GetOSName: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'Name')
    else Result := '';
end;

function TWmiOs.GetOSProductSuite: DWORD;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByName(FProperties, 'OSProductSuite')
    else Result := 0;
end;

function TWmiOs.GetOSType: word;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByName(FProperties, 'OSType')
    else Result := 0;
end;

function TWmiOs.GetOtherTypeDescription: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'OtherTypeDescription')
    else Result := '';
end;

function TWmiOs.GetPlusProductID: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'PlusProductID')
    else Result := '';
end;

function TWmiOs.GetPlusVersionNumber: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'PlusVersionNumber')
    else Result := '';
end;

function TWmiOs.GetPrimary: boolean;
begin
  if FProperties <> nil then
    Result := WmiGetBooleanPropertyValueByName(FProperties, 'Primary')
    else Result := false;
end;

function TWmiOs.GetQuantumLength: byte;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByName(FProperties, 'QuantumLength')
    else Result := 0;
end;

function TWmiOs.GetQuantumType: byte;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByName(FProperties, 'QuantumType')
    else Result := 0;
end;

function TWmiOs.GetRegisteredUser: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'RegisteredUser')
    else Result := '';
end;

function TWmiOs.GetSerialNumber: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'SerialNumber')
    else Result := '';
end;

function TWmiOs.GetServicePackMajorVersion: word;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByName(FProperties, 'ServicePackMajorVersion')
    else Result := 0;
end;

function TWmiOs.GetServicePackMinorVersion: word;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByName(FProperties, 'ServicePackMinorVersion')
    else Result := 0;
end;

function TWmiOs.GetSizeStoredInPagingFiles: int64;
begin
  if FProperties <> nil then
    Result := WmiGetInt64PropertyValueByName(FProperties, 'SizeStoredInPagingFiles')
    else Result := 0;
end;

function TWmiOs.GetStatus: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'Status')
    else Result := '';
end;

function TWmiOs.GetSuiteMask: DWORD;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByNameSafe(FProperties, 'SuiteMask')
    else Result := 0;
end;

function TWmiOs.Get_SystemDevice: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'SystemDevice')
    else Result := '';
end;

function TWmiOs.Get_SystemDirectory: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'SystemDirectory')
    else Result := '';
end;

function TWmiOs.GetSystemDrive: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByNameSafe(FProperties, 'SystemDrive')
    else Result := '';
end;

function TWmiOs.GetTotalSwapSpaceSize: int64;
begin
  if FProperties <> nil then
    Result := WmiGetInt64PropertyValueByName(FProperties, 'TotalSwapSpaceSize')
    else Result := 0;
end;

function TWmiOs.GetTotalVirtualMemorySize: int64;
begin
  if FProperties <> nil then
    Result := WmiGetInt64PropertyValueByName(FProperties, 'TotalVirtualMemorySize')
    else Result := 0;
end;

function TWmiOs.GetTotalVisibleMemorySize: int64;
begin
  if FProperties <> nil then
    Result := WmiGetInt64PropertyValueByName(FProperties, 'TotalVisibleMemorySize')
    else Result := 0;
end;

function TWmiOs.GetVersion: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'Version')
    else Result := '';
end;

function TWmiOs.Get_WindowsDirectory: WideString;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'WindowsDirectory')
    else Result := '';
end;

procedure TWmiOs.LoadData;
begin
  FObject := WmiSelectSingleEntity(WmiServices, QUERY_SELECT_OS);
  if FObject <> nil then
  begin
    WmiCheck(FObject.Get_Properties_(FProperties));
  end;
  FRecovery.SetRecoveryObject(WmiSelectSingleEntity(WmiServices, QUERY_SELECT_OS_RECOVERY));
end;

procedure TWmiOs.ClearData;
begin
  FObject := nil;
  FProperties := nil;
end;

procedure TWmiOs.SetActive(Value: boolean);
begin
  inherited;
  if IsLoading then Exit;
  if (not Value) then
  begin
    ClearData;
    FQuickFixes.ClearEntities;
    FRecovery.SetRecoveryObject(nil);
  end else
  begin
    LoadData;
  end;
end;

procedure TWmiOs.SetBootDevice(const Value: WideString);begin end;
procedure TWmiOs.SetBuildNumber(const Value: WideString);begin end;
procedure TWmiOs.SetBuildType(const Value: WideString);begin end;
procedure TWmiOs.SetCaption(const Value: WideString);begin end;
procedure TWmiOs.SetCodeSet(const Value: WideString);begin end;
procedure TWmiOs.SetCountryCode(const Value: WideString);begin end;
procedure TWmiOs.SetCSDVersion(const Value: WideString);begin end;
procedure TWmiOs.SetCSName(const Value: WideString);begin end;
procedure TWmiOs.SetCurrentTimeZone(const Value: integer);begin end;
procedure TWmiOs.SetDebug(const Value: boolean);begin end;
procedure TWmiOs.SetProductType(const Value: DWORD);  begin end;
procedure TWmiOs.SetDistributed(const Value: boolean);begin end;
procedure TWmiOs.SetEncryptionLevel(const Value: DWORD);begin end;
procedure TWmiOs.SetFreePhysicalMemory(const Value: int64);begin end;
procedure TWmiOs.SetFreeSpaceInPagingFiles(const Value: int64);begin end;
procedure TWmiOs.SetFreeVirtualMemory(const Value: int64);begin end;
procedure TWmiOs.SetInstallDate(const Value: TDateTime);begin end;
procedure TWmiOs.SetLargeSystemCache(const Value: DWORD);begin end;
procedure TWmiOs.SetLastBootUpTime(const Value: TDateTime);begin end;


procedure TWmiOs.SetDescription(const Value: WideString);
begin
  WmiSetStringPropertyValueAndCommit(FObject, 'Description', Value);
end;

procedure TWmiOs.SetForegroundApplicationBoost(const Value: byte);
begin
  WmiSetIntegerPropertyValueAndCommit(FObject, 'ForegroundApplicationBoost', Value);
end;

procedure TWmiOs.SetLocalDateTime(const Value: TDateTime);
var
  inParams:  ISWbemObject;
begin
  // MSDN says that SetDateTime exists under WinNT 4.0 and higher.
  // It is wrong. It was added in Windows XP
  if IsWindowsXPOrHigher then
  begin
    if not Active then RaiseNotActiveException;
    WmiSetPrivilegeEnabled(FObject, wbemPrivilegeSystemtime, true);
    inParams  := WmiCreateClassMethodParameters(FObject, 'SetDateTime');
    WmiSetDateTimeParameter(inParams, 'LocalDateTime', Value, LocalTimeZone);
    WmiExecObjectMethod(FObject, 'SetDateTime', inParams, ErrorFunction);
    // call refresh to reload object. Otherwise reader method
    // method of the property will return the old value. 
    Refresh;
  end;  
end;

procedure TWmiOs.SetLocale(const Value: WideString);begin end;
procedure TWmiOs.SetManufacturer(const Value: WideString);begin end;
procedure TWmiOs.SetMaxNumberOfProcesses(const Value: DWORD);begin end;
procedure TWmiOs.SetMaxProcessMemorySize(const Value: int64);begin end;
procedure TWmiOs.SetNumberOfLicensedUsers(const Value: DWORD);begin end;
procedure TWmiOs.SetNumberOfProcesses(const Value: DWORD);begin end;
procedure TWmiOs.SetNumberOfUsers(const Value: DWORD);begin end;
procedure TWmiOs.SetOrganization(const Value: WideString);begin end;
procedure TWmiOs.SetOSLanguage(const Value: DWORD);begin end;
procedure TWmiOs.SetOSName(const Value: WideString);begin end;
procedure TWmiOs.SetOSProductSuite(const Value: DWORD);begin end;
procedure TWmiOs.SetOSType(const Value: word);begin end;
procedure TWmiOs.SetOtherTypeDescription(const Value: WideString);begin end;
procedure TWmiOs.SetPlusProductID(const Value: WideString);begin end;
procedure TWmiOs.SetPlusVersionNumber(const Value: WideString);begin end;
procedure TWmiOs.SetPrimary(const Value: boolean);begin end;

procedure TWmiOs.SetQuantumLength(const Value: byte);
begin
  WmiSetIntegerPropertyValueAndCommit(FObject, 'QuantumLength', Value);
end;

procedure TWmiOs.SetQuantumType(const Value: byte);
begin
  WmiSetIntegerPropertyValueAndCommit(FObject, 'QuantumType', Value);
end;

procedure TWmiOs.SetRegisteredUser(const Value: WideString); begin end;
procedure TWmiOs.SetSerialNumber(const Value: WideString); begin end;
procedure TWmiOs.SetServicePackMajorVersion(const Value: word);begin end;
procedure TWmiOs.SetServicePackMinorVersion(const Value: word);begin end;
procedure TWmiOs.SetSizeStoredInPagingFiles(const Value: int64);begin end;
procedure TWmiOs.SetStatus(const Value: WideString);begin end;
procedure TWmiOs.SetSuiteMask(const Value: DWORD);begin end;
procedure TWmiOs.SetSystemDevice(const Value: WideString);begin end;
procedure TWmiOs.SetSystemDirectory(const Value: WideString);begin end;
procedure TWmiOs.SetSystemDrive(const Value: WideString);begin end;
procedure TWmiOs.SetTotalSwapSpaceSize(const Value: int64);begin end;
procedure TWmiOs.SetTotalVirtualMemorySize(const Value: int64);begin end;
procedure TWmiOs.SetTotalVisibleMemorySize(const Value: int64);begin end;
procedure TWmiOs.SetVersion(const Value: WideString);begin end;
procedure TWmiOs.SetWindowsDirectory(const Value: WideString);begin end;
procedure TWmiOs.SetLocalTimeZone(const Value: integer); begin end;

procedure TWmiOs.Refresh;
begin
  if Active then LoadData;
end;

procedure TWmiOs.Reboot;
var
  vPrivilege:       WbemPrivilegeEnum;
begin
  if not Active then RaiseNotActiveException;

  if (MachineName = '') or (MachineName = SystemInfo.ComputerName) then
    vPrivilege := wbemPrivilegeShutdown
    else vPrivilege := wbemPrivilegeRemoteShutdown;

  WmiSetPrivilegeEnabled(FObject, vPrivilege, true);
  if WmiGetPrivilegeEnabled(FObject, vPrivilege) then 
    WmiExecObjectMethod(FObject, 'Reboot', ErrorFunction)
    else WmiCheck(HRESULT(WBEM_E_PRIVILEGE_NOT_HELD));
end;

procedure TWmiOs.Shutdown;
var
  vPrivilege:       WbemPrivilegeEnum;
begin
  if not Active then RaiseNotActiveException;

  if (MachineName = '') or (MachineName = SystemInfo.ComputerName) then
    vPrivilege := wbemPrivilegeShutdown
    else vPrivilege := wbemPrivilegeRemoteShutdown;

  WmiSetPrivilegeEnabled(FObject, vPrivilege, true);
  if WmiGetPrivilegeEnabled(FObject, vPrivilege) then 
    WmiExecObjectMethod(FObject, 'Shutdown', ErrorFunction)
    else WmiCheck(HRESULT(WBEM_E_PRIVILEGE_NOT_HELD)); 
end;

procedure TWmiOs.ShutdownEx(AFlags: integer);
var
  inParams:         ISWbemObject;
  vPrivilege:       WbemPrivilegeEnum;
begin
  if not Active then RaiseNotActiveException;

  if (MachineName = '') or (MachineName = SystemInfo.ComputerName) then
    vPrivilege := wbemPrivilegeShutdown
    else vPrivilege := wbemPrivilegeRemoteShutdown;

  WmiSetPrivilegeEnabled(FObject, vPrivilege, true);

  inParams  := WmiCreateClassMethodParameters(FObject, 'Win32Shutdown');
  WmiSetIntegerParameter(inParams, 'Flags', AFlags);
  WmiSetIntegerParameter(inParams, 'Reserved', 0);

  // fixme: this will not work under Windows NT:
  // In Windows NT the privileges must be enabled
  // before the initial connection to WMI services.   
  if WmiGetPrivilegeEnabled(FObject, vPrivilege) then
    WmiExecObjectMethod(FObject, 'Win32Shutdown', inParams, ErrorFunction)
    else WmiCheck(HRESULT(WBEM_E_PRIVILEGE_NOT_HELD));
end;

function TWmiOs.GetLocalTimeZone: integer;
var
  vStr: WideString;
  vResTime: TDateTime;
begin
  if FProperties <> nil then
  begin
    vStr := WmiGetStringPropertyValueByName(FProperties, 'LocalDateTime');
    WmiParseDateTime(vStr, vResTime, Result);
  end else
  begin
    Result := 0;
  end;
end;

(*
  // attempt to change time zone fails. It changes time, but time zone
  // stays the same
procedure TWmiOs.SetTimeZone(const Value: integer);
var
  inParams:  ISWbemObject;
  vObject:   ISWbemObject;
  vProperties: ISWbemPropertySet;
  vStr:        string;
  vTime:       TDateTime;
begin
  if not Active then RaiseNotActiveException;
  WmiSetPrivilegeEnabled(FObject, wbemPrivilegeSystemtime, true);
  inParams  := WmiCreateClassMethodParameters(FObject, 'SetDateTime');

  // get the latest time. I do not want to update all of the
  // component properties, so I do not call refresh.
  vObject := WmiSelectSingleEntity(WmiServices, SELECT_OS);
  WmiCheck(vObject.Get_Properties_(vProperties));
  vStr := WmiGetStringPropertyValueByName(FProperties, 'LocalDateTime');
  vTime := WmiParseDateTime(vStr);

  WmiSetDateTimeParameter(inParams, 'LocalDateTime', vTime, Value);
  WmiExecObjectMethod(FObject, 'SetDateTime', inParams, ErrorFunction);
end;
*)

function TWmiOs.GetQuickFixes: TWmiQuickFixList;
begin
  if Active then
  begin
    if FQuickFixes.Count = 0 then LoadQuickFixes;
  end else
  begin
    FQuickFixes.ClearEntities;
  end;
  Result := FQuickFixes;
end;

procedure TWmiOs.LoadQuickFixes;
var
  vQuery: string;
  vEnum: IEnumVariant;
  vOleVar: OleVariant;
  vWmiObject: ISWbemObject;
  vFetchedCount: cardinal;
  vQuickFix: TWmiQuickFix;
begin
  FQuickFixes.ClearEntities;
  if Active then
  begin
    vQuery := Format(QUERY_SELECT_QUICK_FIXES, [EncodeSlashes(OSName)]);
    vEnum := ExecSelectQuery(vQuery);
    while (vEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
    begin
      vWmiObject := IUnknown(vOleVar) as SWBemObject;
      vOleVar    := Unassigned;
      vQuickFix  := TWmiQuickFix.Create(FQuickFixes);
      vQuickFix.LoadProperties(vWmiObject);
    end;
  end;
end;

procedure TWmiOs.CredentialsOrTargetChanged;
begin
  inherited;
  FQuickFixes.ClearEntities;
end;


procedure TWmiOs.SetQuickFixes(const Value: TWmiQuickFixList); begin end;

constructor TWmiOs.Create(AOwner: TComponent);
begin
  inherited;
  FQuickFixes   := TWmiQuickFixList.Create(self, TWmiQuickFix, true);
  FRecovery     := TWmiOsRecovery.Create(self);
end;

destructor TWmiOs.Destroy;
begin
  FQuickFixes.Free;
  FRecovery.Free;
  inherited;
end;

function TWmiOs.QuantumTypeToStr(AType: integer): string;
begin
  Result := 'Unknown';
  case AType of
    QT_FIXED: Result := 'Fixed';
    QT_VARIABLE: Result := 'Variable';
  end;
end;

function TWmiOs.QuantumLengthToStr(ALength: integer): string;
begin
  Result := 'Unknown';
  case ALength of
    QL_ONE_TICK: Result := 'One tick';
    QL_TWO_TICKS: Result := 'Two ticks';
  end;
end;

function TWmiOs.SuiteMaskToStr(AMask: integer): string;
    procedure AddWord(var Res: string; AWord: string);
    begin if Res <> '' then Res := Res + ', '; Res := Res + AWord; end;
var
  vMask: dword;
  i: integer;
begin
  vMask := 1;
  Result := '';
  for i := 0 to 31 do
  begin
    if (AMask and vMask) > 0 then AddWord(Result, OsSuiteMaskToString(AMask and vMask));
    vMask := vMask * 2;
  end;
  if Result = '' then Result := '0';
end;

function TWmiOs.OSTypeToStr(AType: integer): string;
begin
  Result := 'Unknown';
  case AType of
    OS_OTHER: Result := 'Other';
    OS_MACOS: Result := 'MACOS';
    OS_ATTUNIX: Result := 'ATTUNIX';
    OS_DGUX: Result := 'DGUX';
    OS_DECNT: Result := 'DECNT';
    OS_DIGITAL_UNIX: Result := 'Digital Unix';
    OS_OPENVMS: Result := 'OpenVMS';
    OS_HPUX: Result := 'HPUX';
    OS_AIX: Result := 'AIX';
    OS_MVS: Result := 'MVS';
    OS_OS400: Result := 'OS400';
    OS_OS_2: Result := 'OS/2';
    OS_JAVAVM: Result := 'JavaVM';
    OS_MSDOS: Result := 'MSDOS';
    OS_WIN3X: Result := 'WIN3x';
    OS_WIN95: Result := 'WIN95';
    OS_WIN98: Result := 'WIN98';
    OS_WINNT: Result := 'WINNT';
    OS_WINCE: Result := 'WINCE';
    OS_NCR3000: Result := 'NCR3000';
    OS_NETWARE: Result := 'NetWare';
    OS_OSF: Result := 'OSF';
    OS_DC_OS: Result := 'DC/OS';
    OS_RELIANT_UNIX: Result := 'Reliant UNIX';
    OS_SCO_UNIXWARE: Result := 'SCO UnixWare';
    OS_SCO_OPENSERVER: Result := 'SCO OpenServer';
    OS_SEQUENT: Result := 'Sequent';
    OS_IRIX: Result := 'IRIX';
    OS_SOLARIS: Result := 'Solaris';
    OS_SUNOS: Result := 'SunOS';
    OS_U6000: Result := 'U6000';
    OS_ASERIES: Result := 'ASERIES';
    OS_TANDEMNSK: Result := 'TandemNSK';
    OS_TANDEMNT: Result := 'TandemNT';
    OS_BS2000: Result := 'BS2000';
    OS_LINUX: Result := 'LINUX';
    OS_LYNX: Result := 'Lynx';
    OS_XENIX: Result := 'XENIX';
    OS_VM_ESA: Result := 'VM/ESA';
    OS_INTERACTIVE_UNIX: Result := 'Interactive UNIX';
    OS_BSDUNIX: Result := 'BSDUNIX';
    OS_FREEBSD: Result := 'FreeBSD';
    OS_NETBSD: Result := 'NetBSD';
    OS_GNU_HURD: Result := 'GNU Hurd';
    OS_OS9: Result := 'OS9';
    OS_MACH_KERNEL: Result := 'MACH Kernel';
    OS_INFERNO: Result := 'Inferno';
    OS_QNX: Result := 'QNX';
    OS_EPOC: Result := 'EPOC';
    OS_IXWORKS: Result := 'IxWorks';
    OS_VXWORKS: Result := 'VxWorks';
    OS_MINT: Result := 'MiNT';
    OS_BEOS: Result := 'BeOS';
    OS_HP_MPE: Result := 'HP MPE';
    OS_NEXTSTEP: Result := 'NextStep';
    OS_PALMPILOT: Result := 'PalmPilot';
    OS_RHAPSODY: Result := 'Rhapsody';
  end;
end;


function TWmiOs.GetProductType: DWORD;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByNameSafe(FProperties, 'ProductType')
    else Result := 0;
end;

function TWmiOs.GetRecovery: TWmiOsRecovery;
begin
  Result := FRecovery;
end;

procedure TWmiOs.SetRecovery(const Value: TWmiOsRecovery);
begin

end;

{ TWmiQuickFixList }

function TWmiQuickFixList.GetItem(AIndex: integer): TWmiQuickFix;
begin
  Result := TWmiQuickFix(inherited GetItem(AIndex));
end;

procedure TWmiQuickFixList.SetItem(AIndex: integer;
  const Value: TWmiQuickFix);
begin
  inherited SetItem(AIndex, Value);
end;

{ TWmiQuickFix }

constructor TWmiQuickFix.Create(AOwner: TWmiEntityList);
begin
  inherited Create(AOwner, true, TWmiQuickFixList);
end;

procedure TWmiQuickFix.LoadProperties(AQuickFix: ISWbemObject);
var
  vProperties: ISWbemPropertySet;
  s: WideString;
begin
  inherited;
  WmiCheck(AQuickFix.Get_Properties_(vProperties));
  FHotFixId        := WmiGetStringPropertyValueByName(vProperties, 'HotFixId');
  s                := WmiGetStringPropertyValueByName(vProperties, 'InstallDate');
  InstallDate      := WmiParseDateTime(s);
  FName            := WmiGetStringPropertyValueByName(vProperties, 'Name');
  FInstalledOn     := WmiGetStringPropertyValueByName(vProperties, 'InstalledOn');
  FStatus          := WmiGetStringPropertyValueByName(vProperties, 'Status');
  FCaption         := WmiGetStringPropertyValueByName(vProperties, 'Status');
  FServicePackInEffect := WmiGetStringPropertyValueByName(vProperties, 'ServicePackInEffect');
  FDescription     := WmiGetStringPropertyValueByName(vProperties, 'Description');
  FInstalledBy     := WmiGetStringPropertyValueByName(vProperties, 'InstalledBy');
  FFixComments     := WmiGetStringPropertyValueByName(vProperties, 'FixComments');

end;

function TWmiQuickFix.GetDisplayName: string;
begin
  Result := HotFixId;
  if Result = '' then Result := inherited GetDisplayName;
end;


procedure TWmiQuickFix.Refresh;
var
  vQuickFixObj:      ISWbemObject;
  vQuery:            widestring;  
begin
  vQuery      := Format(QUERY_FIND_QUICK_FIX_BY_ID, [HotFixID]);
  vQuickFixObj := WmiSelectSingleEntity(WmiServices, vQuery);
  LoadProperties(vQuickFixObj);
end;

procedure TWmiQuickFix.SetCaption(const Value: WideString);begin end;
procedure TWmiQuickFix.SetDescription(const Value: WideString);begin end;
procedure TWmiQuickFix.SetFixComments(const Value: WideString);begin end;
procedure TWmiQuickFix.SetHotFixId(const Value: WideString);begin end;
procedure TWmiQuickFix.SetInstallDate(const Value: TDateTime);begin end;
procedure TWmiQuickFix.SetInstalledBy(const Value: WideString);begin end;
procedure TWmiQuickFix.SetInstalledOn(const Value: WideString);begin end;
procedure TWmiQuickFix.SetName(const Value: WideString);begin end;
procedure TWmiQuickFix.SetServicePackInEffect(const Value: WideString);begin end;
procedure TWmiQuickFix.SetStatus(const Value: WideString);begin end;

{ TWmiOsRecovery }

constructor TWmiOsRecovery.Create(AOwner: TWmiOs);
begin
  inherited Create;
  FOwner := AOwner;
  FRecovery := nil;
end;

function TWmiOsRecovery.GetAutoReboot: boolean;
begin
  if FProperties <> nil then
    Result := WmiGetBooleanPropertyValueByName(FProperties, 'AutoReboot')
    else Result := false;
end;

function TWmiOsRecovery.GetDebugFilePath: widestring;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByName(FProperties, 'DebugFilePath')
    else Result := '';
end;

function TWmiOsRecovery.GetDebugInfoType: integer;
begin
  if FProperties <> nil then
    Result := WmiGetIntegerPropertyValueByNameSafe(FProperties, 'DebugInfoType')
    else Result := 0;
end;

function TWmiOsRecovery.GetExpandedDebugFilePath: widestring;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByNameSafe(FProperties, 'ExpandedDebugFilePath')
    else Result := '';
end;

function TWmiOsRecovery.GetExpandedMiniDumpDirectory: widestring;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByNameSafe(FProperties, 'ExpandedMiniDumpDirectory')
    else Result := '';
end;

function TWmiOsRecovery.GetKernelDumpOnly: boolean;
begin
  if FProperties <> nil then
    Result := WmiGetBooleanPropertyValueByName(FProperties, 'KernelDumpOnly')
    else Result := false;
end;

function TWmiOsRecovery.GetMiniDumpDirectory: widestring;
begin
  if FProperties <> nil then
    Result := WmiGetStringPropertyValueByNameSafe(FProperties, 'MiniDumpDirectory')
    else Result := '';
end;

function TWmiOsRecovery.GetOverwriteExistingDebugFile: boolean;
begin
  if FProperties <> nil then
    Result := WmiGetBooleanPropertyValueByName(FProperties, 'OverwriteExistingDebugFile')
    else Result := false;
end;

function TWmiOsRecovery.GetSendAdminAlert: boolean;
begin
  if FProperties <> nil then
    Result := WmiGetBooleanPropertyValueByName(FProperties, 'SendAdminAlert')
    else Result := false;
end;

function TWmiOsRecovery.GetWriteDebugInfo: boolean;
begin
  if FProperties <> nil then
    Result := WmiGetBooleanPropertyValueByName(FProperties, 'WriteDebugInfo')
    else Result := false;
end;

function TWmiOsRecovery.GetWriteToSystemLog: boolean;
begin
  if FProperties <> nil then
    Result := WmiGetBooleanPropertyValueByName(FProperties, 'WriteToSystemLog')
    else Result := false;
end;

procedure TWmiOsRecovery.SetAutoReboot(const Value: boolean);
begin
  if FRecovery <> nil then
    WmiSetBooleanPropertyValueAndCommit(FRecovery, 'AutoReboot', Value);
end;

procedure TWmiOsRecovery.SetDebugFilePath(const Value: widestring);
begin
  if FRecovery <> nil then
    WmiSetStringPropertyValueAndCommit(FRecovery, 'DebugFilePath', Value);
end;

procedure TWmiOsRecovery.SetDebugInfoType(const Value: integer);
begin
  if (FRecovery <> nil) and (IsWindowsXPOrHigher) then
    WmiSetIntegerPropertyValueAndCommit(FRecovery, 'DebugInfoType', Value);
end;

procedure TWmiOsRecovery.SetExpandedDebugFilePath(const Value: widestring);
begin
  // Doc says that this property is read/write.
  // But, assigning this property has no effect.
  // if IsWindowsXPOrHigher then
  //   WmiSetStringPropertyValueAndCommit(FRecovery, 'ExpandedDebugFilePath', Value);
end;

procedure TWmiOsRecovery.SetExpandedMiniDumpDirectory(const Value: widestring);
begin
  // Doc says that this property is read/write.
  // But, assigning this property has no effect.
  // if IsWindowsXPOrHigher then
  //   WmiSetStringPropertyValueAndCommit(FRecovery, 'ExpandedMiniDumpDirectory', Value);
end;

procedure TWmiOsRecovery.SetKernelDumpOnly(const Value: boolean);
begin
  if FRecovery <> nil then
    WmiSetBooleanPropertyValueAndCommit(FRecovery, 'KernelDumpOnly', Value);
end;

procedure TWmiOsRecovery.SetMiniDumpDirectory(const Value: widestring);
begin
  if (FRecovery <> nil) and IsWindowsXPOrHigher then
    WmiSetStringPropertyValueAndCommit(FRecovery, 'MiniDumpDirectory', Value);
end;

procedure TWmiOsRecovery.SetOverwriteExistingDebugFile(const Value: boolean);
begin
  if FRecovery <> nil then
    WmiSetBooleanPropertyValueAndCommit(FRecovery, 'OverwriteExistingDebugFile', Value);
end;

procedure TWmiOsRecovery.SetRecoveryObject(ARecovery: ISWbemObject);
begin
  FRecovery := ARecovery;
  if FRecovery = nil then FProperties := nil
    else WmiCheck(FRecovery.Get_Properties_(FProperties));
end;

procedure TWmiOsRecovery.SetSendAdminAlert(const Value: boolean);
begin
  if FRecovery <> nil then
    WmiSetBooleanPropertyValueAndCommit(FRecovery, 'SendAdminAlert', Value);
end;

procedure TWmiOsRecovery.SetWriteDebugInfo(const Value: boolean);
begin
  if FRecovery <> nil then
    WmiSetBooleanPropertyValueAndCommit(FRecovery, 'WriteDebugInfo', Value);
end;

procedure TWmiOsRecovery.SetWriteToSystemLog(const Value: boolean);
begin
  if FRecovery <> nil then
    WmiSetBooleanPropertyValueAndCommit(FRecovery, 'WriteToSystemLog', Value);
end;

end.
