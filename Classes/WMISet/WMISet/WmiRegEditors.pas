unit WmiRegEditors;
{$I DEFINE.INC}

interface

Uses
  Registry, Windows, Classes, SysUtils, Controls, Forms,
{$IFDEF Delphi5}
  contnrs,
{$ENDIF}
{$IFDEF Delphi6}
  DesignIntf, PropertyCategories, DesignEditors, ColnEdit,
{$ELSE}
  DsgnIntf,
{$ENDIF}
  TypInfo, DetectWinOS, NTSelectionList, CommPropEditors;

type

  TRegCurrentPathProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function  GetAttributes: TPropertyAttributes; override;
  end;

  TAdsProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TAccountProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TLogicalDiskProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TObjectPathProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TRegValueNameProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TWmiMachineNameProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TAdsPropertyValues = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TAdsObjectNameProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function  GetAttributes: TPropertyAttributes; override;
  end;

  TAdsAuthenticationProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TOsDebugInfoTypeProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;


  TOsLargeSysCacheProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TOsProductTypeProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TOsAppBoostProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TOsQuantumLengthProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TOsQuantumTypeProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TOsTypeProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TRegValueTypeProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;
  
  TQuotaStateProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TAdsTypeProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TPriorityClassProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;
  
  TShowWindowProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TDiskAccessProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TDriveAvailabilityProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TConfigManagerErrorProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TMediaTypeProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TStatusInfoProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TDriveTypeProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TRootKeyProperty = class(TIntegerLookupProperty)
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); override;
  end;

  TOsSuiteMaskAsSetProperty = class(TDwordAsSetProperty)
  private
  public
    function   GetDummyComponent: TDWORDDummy; override;
    function   GetValue: string; override;
  end;


  TRegAccessAsSetProperty = class(TDwordAsSetProperty)
  private
  public
    function   GetDummyComponent: TDWORDDummy; override;
    function   GetValue: string; override;
  end;

  TCDROMFileSystemFlagsAsSetProperty = class(TDwordAsSetProperty)
  private
  public
    function   GetDummyComponent: TDWORDDummy; override;
    function   GetValue: string; override;
  end;

  TProcessCreateFlagsAsSetProperty = class(TDwordAsSetProperty)
  private
  public
    function   GetDummyComponent: TDWORDDummy; override;
    function   GetValue: string; override;
  end;

  TProcessErrorModeAsSetProperty = class(TDwordAsSetProperty)
  private
  public
    function   GetDummyComponent: TDWORDDummy; override;
    function   GetValue: string; override;
  end;

  TFillAttributeAsSetProperty = class(TDwordAsSetProperty)
  private
  public
    function   GetDummyComponent: TDWORDDummy; override;
    function   GetValue: string; override;
  end;

  TDefaultValueProperty = class(TIntegerProperty)
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;
  
  TDiskLimitProperty = class(TStringProperty)
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{$IFDEF Delphi6}
  TWmiEntityListCollectionProperty = class(TCollectionProperty)
  public
    function GetColOptions: TColOptions; override;
  end;

  TReadOnlyCollectionProperty = class(TCollectionProperty)
  public
    function GetColOptions: TColOptions; override;
  end;

{$ENDIF}

  TMethodNameProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TWmiMethodExecuteProperty = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure Register;

implementation

Uses AdsBrowser, FrmAdsPathBuilderU, WmiProcessControl, ActiveDsTLB,
     FrmEditVariantsU, WmiAbstract, FrmSelectComputerU, WmiStorageInfo,
     WmiDevice, WmiDiskQuotaControl, WmiComponent, WmiRegistry,
     FrmRegBrowserU, WmiOs, WmiMethod, WmiConnection, WmiQualifiers;

type
  TStringPropertyCache = class
  private
    FCache: TStringList;
  public
    constructor Create;
    destructor  Destroy; override;
    function    HasCache(AMachineName, AKeyWord: string): boolean;
    procedure   GetCache(AMachineName, AKeyWord: string; AList: TStrings);
    procedure   PutChache(AMachineName, AKeyWord: string; AList: TStrings);
  end;

var
  PropertyCache: TStringPropertyCache;  

type
  TCDROMFileSystemFlagsDummy = class(TDwordDummy)
  private
    function GetFSF_CASE_PRESERVED_NAMES: boolean;
    function GetFSF_CASE_SENSITIVE_SEARCH: boolean;
    function GetFSF_FILE_COMPRESSION: boolean;
    function GetFSF_PERSISTENT_ACLS: boolean;
    function GetFSF_SUPPORTS_ENCRYPTION: boolean;
    function GetFSF_SUPPORTS_LONG_NAMES: boolean;
    function GetFSF_SUPPORTS_NAMED_STREAMS: boolean;
    function GetFSF_SUPPORTS_OBJECT_IDS: boolean;
    function GetFSF_SUPPORTS_REMOTE_STORAGE: boolean;
    function GetFSF_SUPPORTS_REPARSE_POINTS: boolean;
    function GetFSF_SUPPORTS_SPARSE_FILES: boolean;
    function GetFSF_UNICODE_ON_DISK: boolean;
    function GetFSF_VOLUME_IS_COMPRESSED: boolean;
    function GetFSF_VOLUME_QUOTAS: boolean;
    procedure SetFSF_CASE_PRESERVED_NAMES(const Value: boolean);
    procedure SetFSF_CASE_SENSITIVE_SEARCH(const Value: boolean);
    procedure SetFSF_FILE_COMPRESSION(const Value: boolean);
    procedure SetFSF_PERSISTENT_ACLS(const Value: boolean);
    procedure SetFSF_SUPPORTS_ENCRYPTION(const Value: boolean);
    procedure SetFSF_SUPPORTS_LONG_NAMES(const Value: boolean);
    procedure SetFSF_SUPPORTS_NAMED_STREAMS(const Value: boolean);
    procedure SetFSF_SUPPORTS_OBJECT_IDS(const Value: boolean);
    procedure SetFSF_SUPPORTS_REMOTE_STORAGE(const Value: boolean);
    procedure SetFSF_SUPPORTS_REPARSE_POINTS(const Value: boolean);
    procedure SetFSF_SUPPORTS_SPARSE_FILES(const Value: boolean);
    procedure SetFSF_UNICODE_ON_DISK(const Value: boolean);
    procedure SetFSF_VOLUME_IS_COMPRESSED(const Value: boolean);
    procedure SetFSF_VOLUME_QUOTAS(const Value: boolean);
  published
    property FSF_CASE_SENSITIVE_SEARCH:   boolean read GetFSF_CASE_SENSITIVE_SEARCH   write SetFSF_CASE_SENSITIVE_SEARCH;
    property FSF_CASE_PRESERVED_NAMES:    boolean read GetFSF_CASE_PRESERVED_NAMES    write SetFSF_CASE_PRESERVED_NAMES;
    property FSF_UNICODE_ON_DISK:         boolean read GetFSF_UNICODE_ON_DISK         write SetFSF_UNICODE_ON_DISK;
    property FSF_PERSISTENT_ACLS:         boolean read GetFSF_PERSISTENT_ACLS         write SetFSF_PERSISTENT_ACLS;
    property FSF_FILE_COMPRESSION:        boolean read GetFSF_FILE_COMPRESSION        write SetFSF_FILE_COMPRESSION;
    property FSF_VOLUME_QUOTAS:           boolean read GetFSF_VOLUME_QUOTAS           write SetFSF_VOLUME_QUOTAS;
    property FSF_SUPPORTS_SPARSE_FILES:   boolean read GetFSF_SUPPORTS_SPARSE_FILES   write SetFSF_SUPPORTS_SPARSE_FILES;
    property FSF_SUPPORTS_REPARSE_POINTS: boolean read GetFSF_SUPPORTS_REPARSE_POINTS write SetFSF_SUPPORTS_REPARSE_POINTS;
    property FSF_SUPPORTS_REMOTE_STORAGE: boolean read GetFSF_SUPPORTS_REMOTE_STORAGE write SetFSF_SUPPORTS_REMOTE_STORAGE;
    property FSF_SUPPORTS_LONG_NAMES:     boolean read GetFSF_SUPPORTS_LONG_NAMES     write SetFSF_SUPPORTS_LONG_NAMES;
    property FSF_VOLUME_IS_COMPRESSED:    boolean read GetFSF_VOLUME_IS_COMPRESSED    write SetFSF_VOLUME_IS_COMPRESSED;
    property FSF_SUPPORTS_OBJECT_IDS:     boolean read GetFSF_SUPPORTS_OBJECT_IDS     write SetFSF_SUPPORTS_OBJECT_IDS;
    property FSF_SUPPORTS_ENCRYPTION:     boolean read GetFSF_SUPPORTS_ENCRYPTION     write SetFSF_SUPPORTS_ENCRYPTION;
    property FSF_SUPPORTS_NAMED_STREAMS:  boolean read GetFSF_SUPPORTS_NAMED_STREAMS  write SetFSF_SUPPORTS_NAMED_STREAMS;
  end;


  TOsSuiteMaskDummy = class(TDwordDummy)
  private
    function GetSM_BACK_OFFICE: boolean;
    function GetSM_BLADE: boolean;
    function GetSM_COMMUNICATIONS: boolean;
    function GetSM_DATA_CENTER: boolean;
    function GetSM_EMBEDDED_NT: boolean;
    function GetSM_ENTERPRISE: boolean;
    function GetSM_PERSONAL: boolean;
    function GetSM_SINGLE_USER: boolean;
    function GetSM_SMALL_BUSINESS: boolean;
    function GetSM_SMALL_BUSINESS_RESTRICTED: boolean;
    function GetSM_TERMINAL: boolean;
    procedure SetSM_BACK_OFFICE(const Value: boolean);
    procedure SetSM_BLADE(const Value: boolean);
    procedure SetSM_COMMUNICATIONS(const Value: boolean);
    procedure SetSM_DATA_CENTER(const Value: boolean);
    procedure SetSM_EMBEDDED_NT(const Value: boolean);
    procedure SetSM_ENTERPRISE(const Value: boolean);
    procedure SetSM_PERSONAL(const Value: boolean);
    procedure SetSM_SINGLE_USER(const Value: boolean);
    procedure SetSM_SMALL_BUSINESS(const Value: boolean);
    procedure SetSM_SMALL_BUSINESS_RESTRICTED(const Value: boolean);
    procedure SetSM_TERMINAL(const Value: boolean);
  published
    property SM_SMALL_BUSINESS:            boolean read GetSM_SMALL_BUSINESS            write SetSM_SMALL_BUSINESS;
    property SM_ENTERPRISE:                boolean read GetSM_ENTERPRISE                write SetSM_ENTERPRISE;
    property SM_BACK_OFFICE:               boolean read GetSM_BACK_OFFICE               write SetSM_BACK_OFFICE;
    property SM_COMMUNICATIONS:            boolean read GetSM_COMMUNICATIONS            write SetSM_COMMUNICATIONS;
    property SM_TERMINAL:                  boolean read GetSM_TERMINAL                  write SetSM_TERMINAL;
    property SM_SMALL_BUSINESS_RESTRICTED: boolean read GetSM_SMALL_BUSINESS_RESTRICTED write SetSM_SMALL_BUSINESS_RESTRICTED;
    property SM_EMBEDDED_NT:               boolean read GetSM_EMBEDDED_NT               write SetSM_EMBEDDED_NT;
    property SM_DATA_CENTER:               boolean read GetSM_DATA_CENTER               write SetSM_DATA_CENTER;
    property SM_SINGLE_USER:               boolean read GetSM_SINGLE_USER               write SetSM_SINGLE_USER;
    property SM_PERSONAL:                  boolean read GetSM_PERSONAL                  write SetSM_PERSONAL;
    property SM_BLADE:                     boolean read GetSM_BLADE                     write SetSM_BLADE;                    
  end;

  TRegAccessDummy = class(TDwordDummy)
  private
    function Get_DELETE: boolean;
    function GetKEY_CREATE_LINK: boolean;
    function GetKEY_CREATE_SUB_KEY: boolean;
    function GetKEY_ENUMERATE_SUB_KEYS: boolean;
    function GetKEY_NOTIFY: boolean;
    function GetKEY_QUERY_VALUE: boolean;
    function GetKEY_SET_VALUE: boolean;
    function GetREAD_CONTROL: boolean;
    function GetWRITE_DAC: boolean;
    function GetWRITE_OWNER: boolean;
    procedure Set_DELETE(const Value: boolean);
    procedure SetKEY_CREATE_LINK(const Value: boolean);
    procedure SetKEY_CREATE_SUB_KEY(const Value: boolean);
    procedure SetKEY_ENUMERATE_SUB_KEYS(const Value: boolean);
    procedure SetKEY_NOTIFY(const Value: boolean);
    procedure SetKEY_QUERY_VALUE(const Value: boolean);
    procedure SetKEY_SET_VALUE(const Value: boolean);
    procedure SetREAD_CONTROL(const Value: boolean);
    procedure SetWRITE_DAC(const Value: boolean);
    procedure SetWRITE_OWNER(const Value: boolean);
  published
    property KEY_QUERY_VALUE:         boolean read GetKEY_QUERY_VALUE        write SetKEY_QUERY_VALUE;
    property KEY_SET_VALUE:           boolean read GetKEY_SET_VALUE          write SetKEY_SET_VALUE;
    property KEY_CREATE_SUB_KEY:      boolean read GetKEY_CREATE_SUB_KEY     write SetKEY_CREATE_SUB_KEY;
    property KEY_ENUMERATE_SUB_KEYS:  boolean read GetKEY_ENUMERATE_SUB_KEYS write SetKEY_ENUMERATE_SUB_KEYS;
    property KEY_NOTIFY:              boolean read GetKEY_NOTIFY             write SetKEY_NOTIFY;
    property KEY_CREATE_LINK:         boolean read GetKEY_CREATE_LINK        write SetKEY_CREATE_LINK;
    property _DELETE:                 boolean read Get_DELETE                write Set_DELETE;
    property READ_CONTROL:            boolean read GetREAD_CONTROL           write SetREAD_CONTROL;
    property WRITE_DAC:               boolean read GetWRITE_DAC              write SetWRITE_DAC;
    property WRITE_OWNER:             boolean read GetWRITE_OWNER            write SetWRITE_OWNER;           
  end;

  TProcessCreateFlagsDummy = class(TDwordDummy)
  private
    function GetDEBUG_PROCESS: boolean;
    function GetCREATE_DEFAULT_ERROR_MODE: boolean;
    function GetCREATE_NEW_CONSOLE: boolean;
    function GetCREATE_NEW_PROCESS_GROUP: boolean;
    function GetCREATE_SUSPENDED: boolean;
    function GetCREATE_UNICODE_ENVIRONMENT: boolean;
    function GetDEBUG_ONLY_THIS_PROCESS: boolean;
    function GetDETACHED_PROCESS: boolean;
    procedure SetDEBUG_PROCESS(const Value: boolean);
    procedure SetCREATE_DEFAULT_ERROR_MODE(const Value: boolean);
    procedure SetCREATE_NEW_CONSOLE(const Value: boolean);
    procedure SetCREATE_NEW_PROCESS_GROUP(const Value: boolean);
    procedure SetCREATE_SUSPENDED(const Value: boolean);
    procedure SetCREATE_UNICODE_ENVIRONMENT(const Value: boolean);
    procedure SetDEBUG_ONLY_THIS_PROCESS(const Value: boolean);
    procedure SetDETACHED_PROCESS(const Value: boolean);
  published
    property DEBUG_PROCESS: boolean read GetDEBUG_PROCESS write SetDEBUG_PROCESS;
    property DEBUG_ONLY_THIS_PROCESS: boolean read GetDEBUG_ONLY_THIS_PROCESS write SetDEBUG_ONLY_THIS_PROCESS;
    property CREATE_SUSPENDED: boolean read GetCREATE_SUSPENDED write SetCREATE_SUSPENDED;
    property DETACHED_PROCESS: boolean read GetDETACHED_PROCESS write SetDETACHED_PROCESS;
    property CREATE_NEW_CONSOLE: boolean read GetCREATE_NEW_CONSOLE write SetCREATE_NEW_CONSOLE;
    property CREATE_NEW_PROCESS_GROUP: boolean read GetCREATE_NEW_PROCESS_GROUP write SetCREATE_NEW_PROCESS_GROUP;
    property CREATE_UNICODE_ENVIRONMENT: boolean read GetCREATE_UNICODE_ENVIRONMENT write SetCREATE_UNICODE_ENVIRONMENT;
    property CREATE_DEFAULT_ERROR_MODE: boolean read GetCREATE_DEFAULT_ERROR_MODE write SetCREATE_DEFAULT_ERROR_MODE;   
  end;

  TProcessErrorModeDummy = class(TDwordDummy)
  private
    function GetFAIL_CRITICAL_ERRORS: boolean;
    function GetNO_ALIGNMENT_FAULT_EXCEPT: boolean;
    function GetNO_GP_FAULT_ERROR_BOX: boolean;
    function GetNO_OPEN_FILE_ERROR_BOX: boolean;
    procedure SetFAIL_CRITICAL_ERRORS(const Value: boolean);
    procedure SetNO_ALIGNMENT_FAULT_EXCEPT(const Value: boolean);
    procedure SetNO_GP_FAULT_ERROR_BOX(const Value: boolean);
    procedure SetNO_OPEN_FILE_ERROR_BOX(const Value: boolean);
  published
    property FAIL_CRITICAL_ERRORS: boolean read GetFAIL_CRITICAL_ERRORS write SetFAIL_CRITICAL_ERRORS;
    property NO_ALIGNMENT_FAULT_EXCEPT: boolean read GetNO_ALIGNMENT_FAULT_EXCEPT write SetNO_ALIGNMENT_FAULT_EXCEPT;
    property NO_GP_FAULT_ERROR_BOX: boolean read GetNO_GP_FAULT_ERROR_BOX write SetNO_GP_FAULT_ERROR_BOX;
    property NO_OPEN_FILE_ERROR_BOX: boolean read GetNO_OPEN_FILE_ERROR_BOX write SetNO_OPEN_FILE_ERROR_BOX;
  end;

  TFillAttributeDummy = class(TDwordDummy)
  private
    function GetBACKGROUND_BLUE: boolean;
    function GetBACKGROUND_GREEN: boolean;
    function GetBACKGROUND_INTENSITY: boolean;
    function GetBACKGROUND_RED: boolean;
    function GetFOREGROUND_BLUE: boolean;
    function GetFOREGROUND_GREEN: boolean;
    function GetFOREGROUND_INTENSITY: boolean;
    function GetFOREGROUND_RED: boolean;
    procedure SetBACKGROUND_BLUE(const Value: boolean);
    procedure SetBACKGROUND_GREEN(const Value: boolean);
    procedure SetBACKGROUND_INTENSITY(const Value: boolean);
    procedure SetBACKGROUND_RED(const Value: boolean);
    procedure SetFOREGROUND_BLUE(const Value: boolean);
    procedure SetFOREGROUND_GREEN(const Value: boolean);
    procedure SetFOREGROUND_INTENSITY(const Value: boolean);
    procedure SetFOREGROUND_RED(const Value: boolean);
  published
    property FOREGROUND_BLUE: boolean read GetFOREGROUND_BLUE write SetFOREGROUND_BLUE;
    property FOREGROUND_GREEN: boolean read GetFOREGROUND_GREEN write SetFOREGROUND_GREEN;
    property FOREGROUND_RED: boolean read GetFOREGROUND_RED write SetFOREGROUND_RED;
    property FOREGROUND_INTENSITY: boolean read GetFOREGROUND_INTENSITY write SetFOREGROUND_INTENSITY;
    property BACKGROUND_BLUE: boolean read GetBACKGROUND_BLUE write SetBACKGROUND_BLUE;
    property BACKGROUND_GREEN: boolean read GetBACKGROUND_GREEN write SetBACKGROUND_GREEN;
    property BACKGROUND_RED: boolean read GetBACKGROUND_RED write SetBACKGROUND_RED;
    property BACKGROUND_INTENSITY: boolean read GetBACKGROUND_INTENSITY write SetBACKGROUND_INTENSITY;
  end;


function ProcessCreateFlagsToString(AFlags: DWORD): string;
begin
  case AFlags of
    DEBUG_PROCESS:   Result := 'DEBUG_PROCESS';
    DEBUG_ONLY_THIS_PROCESS:    Result := 'DEBUG_ONLY_THIS_PROCESS';
    CREATE_SUSPENDED:           Result := 'CREATE_SUSPENDED';
    DETACHED_PROCESS:           Result := 'DETACHED_PROCESS';
    CREATE_NEW_CONSOLE:         Result := 'CREATE_NEW_CONSOLE';
    CREATE_NEW_PROCESS_GROUP:   Result := 'CREATE_NEW_PROCESS_GROUP';
    CREATE_UNICODE_ENVIRONMENT: Result := 'CREATE_UNICODE_ENVIRONMENT';
    CREATE_DEFAULT_ERROR_MODE:  Result := 'CREATE_DEFAULT_ERROR_MODE';
    else Result := IntToStr(AFlags);
  end;
end;

function RegAccessToString(Access: DWORD): string;
begin
  case Access of
    KEY_QUERY_VALUE:        Result := 'KEY_QUERY_VALUE';
    KEY_SET_VALUE:          Result := 'KEY_SET_VALUE';
    KEY_CREATE_SUB_KEY:     Result := 'KEY_CREATE_SUB_KEY';
    KEY_ENUMERATE_SUB_KEYS: Result := 'KEY_ENUMERATE_SUB_KEYS';
    KEY_NOTIFY:             Result := 'KEY_NOTIFY';
    KEY_CREATE_LINK:        Result := 'KEY_CREATE_LINK';
    _DELETE:                Result := '_DELETE';
    READ_CONTROL:           Result := 'READ_CONTROL';
    WRITE_DAC:              Result := 'WRITE_DAC';
    WRITE_OWNER:            Result := 'WRITE_OWNER';
    else Result := IntToStr(Access);
  end;
end;

function OsSuiteMaskToString(AMask: DWORD): string;
begin
  case AMask of
    SM_SMALL_BUSINESS:            Result := 'SM_SMALL_BUSINESS';
    SM_ENTERPRISE:                Result := 'SM_ENTERPRISE';
    SM_BACK_OFFICE:               Result := 'SM_BACK_OFFICE';
    SM_COMMUNICATIONS:            Result := 'SM_COMMUNICATIONS';
    SM_TERMINAL:                  Result := 'SM_TERMINAL';
    SM_SMALL_BUSINESS_RESTRICTED: Result := 'SM_SMALL_BUSINESS_RESTRICTED';
    SM_EMBEDDED_NT:               Result := 'SM_EMBEDDED_NT';
    SM_DATA_CENTER:               Result := 'SM_DATA_CENTER';
    SM_SINGLE_USER:               Result := 'SM_SINGLE_USER';
    SM_PERSONAL:                  Result := 'SM_PERSONAL';
    SM_BLADE:                     Result := 'SM_BLADE';
    else Result := IntToStr(AMask);
  end;
end;

function FileSystemFlagsToString(AFlags: DWORD): string;
begin
  case AFlags of
    FSF_CASE_SENSITIVE_SEARCH:    Result := 'FSF_CASE_SENSITIVE_SEARCH';
    FSF_CASE_PRESERVED_NAMES:     Result := 'FSF_CASE_PRESERVED_NAMES';
    FSF_UNICODE_ON_DISK:          Result := 'FSF_UNICODE_ON_DISK';
    FSF_PERSISTENT_ACLS:          Result := 'FSF_PERSISTENT_ACLS';
    FSF_FILE_COMPRESSION:         Result := 'FSF_FILE_COMPRESSION';
    FSF_VOLUME_QUOTAS:            Result := 'FSF_VOLUME_QUOTAS';
    FSF_SUPPORTS_SPARSE_FILES:    Result := 'FSF_SUPPORTS_SPARSE_FILES';
    FSF_SUPPORTS_REPARSE_POINTS:  Result := 'FSF_SUPPORTS_REPARSE_POINTS';
    FSF_SUPPORTS_REMOTE_STORAGE:  Result := 'FSF_SUPPORTS_REMOTE_STORAGE';
    FSF_SUPPORTS_LONG_NAMES:      Result := 'FSF_SUPPORTS_LONG_NAMES';
    FSF_VOLUME_IS_COMPRESSED:     Result := 'FSF_VOLUME_IS_COMPRESSED';
    FSF_SUPPORTS_OBJECT_IDS:      Result := 'FSF_SUPPORTS_OBJECT_IDS';
    FSF_SUPPORTS_ENCRYPTION:      Result := 'FSF_SUPPORTS_ENCRYPTION';
    FSF_SUPPORTS_NAMED_STREAMS:   Result := 'FSF_SUPPORTS_NAMED_STREAMS';
    else Result := IntToStr(AFlags);
  end;
end;



function ProcessErrorModeToString(AMode: DWORD): string;
begin
  case AMode of
    FAIL_CRITICAL_ERRORS:      Result := 'FAIL_CRITICAL_ERRORS';
    NO_ALIGNMENT_FAULT_EXCEPT: Result := 'NO_ALIGNMENT_FAULT_EXCEPT';
    NO_GP_FAULT_ERROR_BOX:     Result := 'NO_GP_FAULT_ERROR_BOX';
    NO_OPEN_FILE_ERROR_BOX:    Result := 'NO_OPEN_FILE_ERROR_BOX';
    else Result := IntToStr(AMode);
  end;
end;


function FillAttributeToString(AValue: DWORD): string;
begin
  case AValue of
    FOREGROUND_BLUE:      Result := 'FOREGROUND_BLUE';
    FOREGROUND_GREEN:     Result := 'FOREGROUND_GREEN';
    FOREGROUND_RED:       Result := 'FOREGROUND_RED';
    FOREGROUND_INTENSITY: Result := 'FOREGROUND_INTENSITY';
    BACKGROUND_BLUE:      Result := 'BACKGROUND_BLUE';
    BACKGROUND_GREEN:     Result := 'BACKGROUND_GREEN';
    BACKGROUND_RED:       Result := 'BACKGROUND_RED';
    BACKGROUND_INTENSITY: Result := 'BACKGROUND_INTENSITY';
    else Result := IntToStr(AValue);
  end;
end;

{ TAdsPropertyValues }

function TAdsPropertyValues.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TAdsPropertyValues.Edit;
var
  vComponent: TAdsPropertyInfo;
begin
  with TFrmEditVariants.Create(nil) do
  try
    vComponent := GetComponent(0) as TAdsPropertyInfo;
    Variants := vComponent.Values;
    MultiValued := vComponent.IsMultiValued;

    if ShowModal = mrOk then
      vComponent.Values := Variants;
  finally
    Free;
  end;
end;


{ TAdsObjectNameProperty }

procedure TAdsObjectNameProperty.Edit;
var
  vComponent: TAdsBrowser;
begin
  with TFrmAdsPathBuilder.Create(nil) do
  try
    vComponent := GetComponent(0) as TAdsBrowser;
    ObjectName := vComponent.ObjectPath;
    if ShowModal = mrOk then vComponent.ObjectPath := ObjectName;
  finally
    Free;
  end;
end;

function TAdsObjectNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{ TPriorityClassProperty }

procedure TPriorityClassProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('PRIORITY_NORMAL', TObject(Pointer(PRIORITY_NORMAL)));
  AList.AddObject('PRIORITY_IDLE', TObject(Pointer(PRIORITY_IDLE)));
  AList.AddObject('PRIORITY_HIGH', TObject(Pointer(PRIORITY_HIGH)));
  AList.AddObject('PRIORITY_REALTIME', TObject(Pointer(PRIORITY_REALTIME)));
  AList.AddObject('PRIORITY_ABOVE_NORMAL', TObject(Pointer(PRIORITY_ABOVE_NORMAL)));
  AList.AddObject('PRIORITY_BELOW_NORMAL', TObject(Pointer(PRIORITY_BELOW_NORMAL)));
end;

{ TQuotaStateProperty }
procedure TQuotaStateProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('QUOTAS_DISABLE', TObject(Pointer(QUOTAS_DISABLE)));
  AList.AddObject('QUOTAS_TRACK', TObject(Pointer(QUOTAS_TRACK)));
  AList.AddObject('QUOTAS_ENFORCE', TObject(Pointer(QUOTAS_ENFORCE)));
end;

{ TAdsTypeProperty }

procedure TAdsTypeProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('ADSTYPE_INVALID', TObject(Pointer(ADSTYPE_INVALID)));
  AList.AddObject('ADSTYPE_DN_STRING', TObject(Pointer(ADSTYPE_DN_STRING)));
  AList.AddObject('ADSTYPE_CASE_EXACT_STRING', TObject(Pointer(ADSTYPE_CASE_EXACT_STRING)));
  AList.AddObject('ADSTYPE_CASE_IGNORE_STRING', TObject(Pointer(ADSTYPE_CASE_IGNORE_STRING)));
  AList.AddObject('ADSTYPE_PRINTABLE_STRING', TObject(Pointer(ADSTYPE_PRINTABLE_STRING)));
  AList.AddObject('ADSTYPE_NUMERIC_STRING', TObject(Pointer(ADSTYPE_NUMERIC_STRING)));
  AList.AddObject('ADSTYPE_BOOLEAN', TObject(Pointer(ADSTYPE_BOOLEAN)));
  AList.AddObject('ADSTYPE_INTEGER', TObject(Pointer(ADSTYPE_INTEGER)));
  AList.AddObject('ADSTYPE_OCTET_STRING', TObject(Pointer(ADSTYPE_OCTET_STRING)));
  AList.AddObject('ADSTYPE_UTC_TIME', TObject(Pointer(ADSTYPE_UTC_TIME)));
  AList.AddObject('ADSTYPE_LARGE_INTEGER', TObject(Pointer(ADSTYPE_LARGE_INTEGER)));
  AList.AddObject('ADSTYPE_PROV_SPECIFIC', TObject(Pointer(ADSTYPE_PROV_SPECIFIC)));
  AList.AddObject('ADSTYPE_OBJECT_CLASS', TObject(Pointer(ADSTYPE_OBJECT_CLASS)));
  AList.AddObject('ADSTYPE_CASEIGNORE_LIST', TObject(Pointer(ADSTYPE_CASEIGNORE_LIST)));
  AList.AddObject('ADSTYPE_OCTET_LIST', TObject(Pointer(ADSTYPE_OCTET_LIST)));
  AList.AddObject('ADSTYPE_PATH', TObject(Pointer(ADSTYPE_PATH)));
  AList.AddObject('ADSTYPE_POSTALADDRESS', TObject(Pointer(ADSTYPE_POSTALADDRESS)));
  AList.AddObject('ADSTYPE_TIMESTAMP', TObject(Pointer(ADSTYPE_TIMESTAMP)));
  AList.AddObject('ADSTYPE_BACKLINK', TObject(Pointer(ADSTYPE_BACKLINK)));
  AList.AddObject('ADSTYPE_TYPEDNAME', TObject(Pointer(ADSTYPE_TYPEDNAME)));
  AList.AddObject('ADSTYPE_HOLD', TObject(Pointer(ADSTYPE_HOLD)));
  AList.AddObject('ADSTYPE_NETADDRESS', TObject(Pointer(ADSTYPE_NETADDRESS)));
  AList.AddObject('ADSTYPE_REPLICAPOINTER', TObject(Pointer(ADSTYPE_REPLICAPOINTER)));
  AList.AddObject('ADSTYPE_FAXNUMBER', TObject(Pointer(ADSTYPE_FAXNUMBER)));
  AList.AddObject('ADSTYPE_EMAIL', TObject(Pointer(ADSTYPE_EMAIL)));
  AList.AddObject('ADSTYPE_NT_SECURITY_DESCRIPTOR', TObject(Pointer(ADSTYPE_NT_SECURITY_DESCRIPTOR)));
  AList.AddObject('ADSTYPE_UNKNOWN', TObject(Pointer(ADSTYPE_UNKNOWN)));
  AList.AddObject('ADSTYPE_DN_WITH_BINARY', TObject(Pointer(ADSTYPE_DN_WITH_BINARY)));
  AList.AddObject('ADSTYPE_DN_WITH_STRING', TObject(Pointer(ADSTYPE_DN_WITH_STRING)));
end;

{ TStatusInfoProperty }
procedure TStatusInfoProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('SI_OTHER', TObject(Pointer(SI_OTHER)));
  AList.AddObject('SI_UNKNOWN', TObject(Pointer(SI_UNKNOWN)));
  AList.AddObject('SI_ENABLED', TObject(Pointer(SI_ENABLED)));
  AList.AddObject('SI_DISABLED', TObject(Pointer(SI_DISABLED)));
  AList.AddObject('SI_NOT_APPLICABLE', TObject(Pointer(SI_NOT_APPLICABLE)));
end;

(*
{ TPowerCapabilitiesProperty }
procedure TPowerCapabilitiesProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('PM_UNKNOWN', TObject(Pointer(PM_UNKNOWN)));
  AList.AddObject('PM_NOT_SUPPORTED', TObject(Pointer(PM_NOT_SUPPORTED)));
  AList.AddObject('PM_DISABLED', TObject(Pointer(PM_DISABLED)));
  AList.AddObject('PM_Enabled', TObject(Pointer(PM_Enabled)));
  AList.AddObject('PM_AUTO_POWER_SAVING', TObject(Pointer(PM_AUTO_POWER_SAVING)));
  AList.AddObject('PM_POWER_STATE_SETTABLE', TObject(Pointer(PM_POWER_STATE_SETTABLE)));
  AList.AddObject('PM_POWER_CYCLING_SUPPORTED', TObject(Pointer(PM_POWER_CYCLING_SUPPORTED)));
  AList.AddObject('PM_TIMED_POWER_ON_SUPPORTED', TObject(Pointer(PM_TIMED_POWER_ON_SUPPORTED)));
end;
*)

{ TMediaTypeProperty }
procedure TMediaTypeProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('MT_UNKNOWN', TObject(Pointer(MT_UNKNOWN)));
  AList.AddObject('MT_F5_1Pt2_512', TObject(Pointer(MT_F5_1Pt2_512)));
  AList.AddObject('MT_F3_1Pt44_512', TObject(Pointer(MT_F3_1Pt44_512)));
  AList.AddObject('MT_F3_2Pt88_512', TObject(Pointer(MT_F3_2Pt88_512)));
  AList.AddObject('MT_F3_20Pt8_512', TObject(Pointer(MT_F3_20Pt8_512)));
  AList.AddObject('MT_F3_720_512', TObject(Pointer(MT_F3_720_512)));
  AList.AddObject('MT_F5_360_512', TObject(Pointer(MT_F5_360_512)));
  AList.AddObject('MT_F5_320_512', TObject(Pointer(MT_F5_320_512)));
  AList.AddObject('MT_F5_320_1024', TObject(Pointer(MT_F5_320_1024)));
  AList.AddObject('MT_F5_180_512', TObject(Pointer(MT_F5_180_512)));
  AList.AddObject('MT_F5_160_512', TObject(Pointer(MT_F5_160_512)));
  AList.AddObject('MT_REMOVABLE', TObject(Pointer(MT_REMOVABLE)));
  AList.AddObject('MT_FIXED', TObject(Pointer(MT_FIXED)));
  AList.AddObject('MT_F3_120M_512', TObject(Pointer(MT_F3_120M_512)));
  AList.AddObject('MT_F3_640_512', TObject(Pointer(MT_F3_640_512)));
  AList.AddObject('MT_F5_640_512', TObject(Pointer(MT_F5_640_512)));
  AList.AddObject('MT_F5_720_512', TObject(Pointer(MT_F5_720_512)));
  AList.AddObject('MT_F3_1Pt2_512', TObject(Pointer(MT_F3_1Pt2_512)));
  AList.AddObject('MT_F3_1Pt23_1024', TObject(Pointer(MT_F3_1Pt23_1024)));
  AList.AddObject('MT_F5_1Pt23_1024', TObject(Pointer(MT_F5_1Pt23_1024)));
  AList.AddObject('MT_F3_128Mb_512', TObject(Pointer(MT_F3_128Mb_512)));
  AList.AddObject('MT_F3_230Mb_512', TObject(Pointer(MT_F3_230Mb_512)));
  AList.AddObject('MT_F8_256_128', TObject(Pointer(MT_F8_256_128)));
end;

{TDriveTypeProperty}
procedure TDriveTypeProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('DT_NO_ROOT_DIRECTORY', TObject(Pointer(DT_NO_ROOT_DIRECTORY)));
  AList.AddObject('DT_REMOVABLE_DISK', TObject(Pointer(DT_REMOVABLE_DISK)));
  AList.AddObject('DT_LOCAL_DISK', TObject(Pointer(DT_LOCAL_DISK)));
  AList.AddObject('DT_NETWORK_DRIVE', TObject(Pointer(DT_NETWORK_DRIVE)));
  AList.AddObject('DT_COMPACT_DISK', TObject(Pointer(DT_COMPACT_DISK)));
  AList.AddObject('DT_RAM_DISK', TObject(Pointer(DT_RAM_DISK)));
end;

{TRootKeyProperty}
procedure TRootKeyProperty.GetLookupData(AList: TStrings; AIsUpperCase: boolean);
begin
  AList.AddObject('HKEY_CLASSES_ROOT', TObject(Pointer(HKEY_CLASSES_ROOT)));
  AList.AddObject('HKEY_CURRENT_USER', TObject(Pointer(HKEY_CURRENT_USER)));
  AList.AddObject('HKEY_LOCAL_MACHINE', TObject(Pointer(HKEY_LOCAL_MACHINE)));
  AList.AddObject('HKEY_USERS', TObject(Pointer(HKEY_USERS)));
  AList.AddObject('HKEY_PERFORMANCE_DATA', TObject(Pointer(HKEY_PERFORMANCE_DATA)));
  AList.AddObject('HKEY_CURRENT_CONFIG', TObject(Pointer(HKEY_CURRENT_CONFIG)));
  AList.AddObject('HKEY_DYN_DATA', TObject(Pointer(HKEY_DYN_DATA)));
end;


{ TConfigManagerErrorProperty }
procedure TConfigManagerErrorProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('CM_ERR_WORKING_PROPERLY', TObject(Pointer(CM_ERR_WORKING_PROPERLY)));
  AList.AddObject('CM_ERR_NOT_CONFIGURED', TObject(Pointer(CM_ERR_NOT_CONFIGURED)));
  AList.AddObject('CM_ERR_CANNOT_LOAD_DRIVER', TObject(Pointer(CM_ERR_CANNOT_LOAD_DRIVER)));
  AList.AddObject('CM_ERR_DRIVER_CORRUPTED_OR_LOW_RESOURCES', TObject(Pointer(CM_ERR_DRIVER_CORRUPTED_OR_LOW_RESOURCES)));
  AList.AddObject('CM_ERR_NOT_WORKING_PROPERLY', TObject(Pointer(CM_ERR_NOT_WORKING_PROPERLY)));
  AList.AddObject('CM_ERR_UMANAGEBLE_RESOURCE', TObject(Pointer(CM_ERR_UMANAGEBLE_RESOURCE)));
  AList.AddObject('CM_ERR_BOOT_CONFIGURATION_CONFLICT', TObject(Pointer(CM_ERR_BOOT_CONFIGURATION_CONFLICT)));
  AList.AddObject('CM_ERR_CANNOT_FILTER', TObject(Pointer(CM_ERR_CANNOT_FILTER)));
  AList.AddObject('CM_ERR_DRIVER_LOADER_MISSING', TObject(Pointer(CM_ERR_DRIVER_LOADER_MISSING)));
  AList.AddObject('CM_ERR_INCORRECT_RESOURCES', TObject(Pointer(CM_ERR_INCORRECT_RESOURCES)));
  AList.AddObject('CM_ERR_DEVICE_CANNOT_START', TObject(Pointer(CM_ERR_DEVICE_CANNOT_START)));
  AList.AddObject('CM_ERR_DEVICE_FAILED', TObject(Pointer(CM_ERR_DEVICE_FAILED)));
  AList.AddObject('CM_ERR_NOT_ENOUGH_RESOURCES', TObject(Pointer(CM_ERR_NOT_ENOUGH_RESOURCES)));
  AList.AddObject('CM_ERR_CANNOT_VERIFY_RESOURCES', TObject(Pointer(CM_ERR_CANNOT_VERIFY_RESOURCES)));
  AList.AddObject('CM_ERR_NEED_RESTART', TObject(Pointer(CM_ERR_NEED_RESTART)));
  AList.AddObject('CM_ERR_REENUMERATOR_PROBLEM', TObject(Pointer(CM_ERR_REENUMERATOR_PROBLEM)));
  AList.AddObject('CM_ERR_CANNOT_IDENTIFY_RESOURCES', TObject(Pointer(CM_ERR_CANNOT_IDENTIFY_RESOURCES)));
  AList.AddObject('CM_ERR_UNKNOWN_RESOURCE_TYPE', TObject(Pointer(CM_ERR_UNKNOWN_RESOURCE_TYPE)));
  AList.AddObject('CM_ERR_REINSTALL_DRIVERS', TObject(Pointer(CM_ERR_REINSTALL_DRIVERS)));
  AList.AddObject('CM_ERR_VDX_LOADER_FAILURE', TObject(Pointer(CM_ERR_VDX_LOADER_FAILURE)));
  AList.AddObject('CM_ERR_REGISTRY_CORRUPTED', TObject(Pointer(CM_ERR_REGISTRY_CORRUPTED)));
  AList.AddObject('CM_ERR_SYS_REMOVING_DEVICE', TObject(Pointer(CM_ERR_SYS_REMOVING_DEVICE)));
  AList.AddObject('CM_ERR_DEVICE_DISABLED', TObject(Pointer(CM_ERR_DEVICE_DISABLED)));
  AList.AddObject('CM_ERR_SYS_FAILURE_CHANGE_DRIVER', TObject(Pointer(CM_ERR_SYS_FAILURE_CHANGE_DRIVER)));
  AList.AddObject('CM_ERR_DIVICE_IS_NOT_PRESENT', TObject(Pointer(CM_ERR_DIVICE_IS_NOT_PRESENT)));
  AList.AddObject('CM_ERR_STILL_IN_SETUP', TObject(Pointer(CM_ERR_STILL_IN_SETUP)));
  AList.AddObject('CM_ERR_STILL_SETTING_UP', TObject(Pointer(CM_ERR_STILL_SETTING_UP)));
  AList.AddObject('CM_ERR_INVALID_LOG', TObject(Pointer(CM_ERR_INVALID_LOG)));
  AList.AddObject('CM_ERR_DRIVERS_NOT_INSTALLED', TObject(Pointer(CM_ERR_DRIVERS_NOT_INSTALLED)));
  AList.AddObject('CM_ERR_DISABLED_NO_RESOURCES', TObject(Pointer(CM_ERR_DISABLED_NO_RESOURCES)));
  AList.AddObject('CM_ERR_IRQ_CONFLICT', TObject(Pointer(CM_ERR_IRQ_CONFLICT)));
  AList.AddObject('CM_ERR_CANNOT_LOAD_DRIVERS', TObject(Pointer(CM_ERR_CANNOT_LOAD_DRIVERS)));
end;


{ TDriveAvailabilityProperty }
procedure TDriveAvailabilityProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('AVAIL_OTHER', TObject(Pointer(AVAIL_OTHER)));
  AList.AddObject('AVAIL_UNKNOWN', TObject(Pointer(AVAIL_UNKNOWN)));
  AList.AddObject('AVAIL_RUNNING', TObject(Pointer(AVAIL_RUNNING)));
  AList.AddObject('AVAIL_WARNING', TObject(Pointer(AVAIL_WARNING)));
  AList.AddObject('AVAIL_IN_TEST', TObject(Pointer(AVAIL_IN_TEST)));
  AList.AddObject('AVAIL_NOT_APPLICABLE', TObject(Pointer(AVAIL_NOT_APPLICABLE)));
  AList.AddObject('AVAIL_POWER_OFF', TObject(Pointer(AVAIL_POWER_OFF)));
  AList.AddObject('AVAIL_OFF_LINE', TObject(Pointer(AVAIL_OFF_LINE)));
  AList.AddObject('AVAIL_OFF_DUTY', TObject(Pointer(AVAIL_OFF_DUTY)));
  AList.AddObject('AVAIL_DEGRADED', TObject(Pointer(AVAIL_DEGRADED)));
  AList.AddObject('AVAIL_NOT_INSTALLED', TObject(Pointer(AVAIL_NOT_INSTALLED)));
  AList.AddObject('AVAIL_INSTALL_ERROR', TObject(Pointer(AVAIL_INSTALL_ERROR)));
  AList.AddObject('AVAIL_POWER_SAVE_UNKNOWN', TObject(Pointer(AVAIL_POWER_SAVE_UNKNOWN)));
  AList.AddObject('AVAIL_POWER_SAVE_LOW_POWER_MODE', TObject(Pointer(AVAIL_POWER_SAVE_LOW_POWER_MODE)));
  AList.AddObject('AVAIL_POWER_SAVE_STANDBY', TObject(Pointer(AVAIL_POWER_SAVE_STANDBY)));
  AList.AddObject('AVAIL_POWER_POWER_CYCLE', TObject(Pointer(AVAIL_POWER_POWER_CYCLE)));
  AList.AddObject('AVAIL_POWER_SAVE_WARNING', TObject(Pointer(AVAIL_POWER_SAVE_WARNING)));
  AList.AddObject('AVAIL_PAUSED', TObject(Pointer(AVAIL_PAUSED)));
  AList.AddObject('AVAIL_NOT_READY', TObject(Pointer(AVAIL_NOT_READY)));
  AList.AddObject('AVAIL_NOT_CONFIGURED', TObject(Pointer(AVAIL_NOT_CONFIGURED)));
  AList.AddObject('AVAIL_QUIESCED', TObject(Pointer(AVAIL_QUIESCED)));
end;

{ TDiskAccessProperty }
procedure TDiskAccessProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('DISK_ACCESS_UNKNOWN', TObject(Pointer(DISK_ACCESS_UNKNOWN)));
  AList.AddObject('DISK_ACCESS_READABLE', TObject(Pointer(DISK_ACCESS_READABLE)));
  AList.AddObject('DISK_ACCESS_WRITABLE', TObject(Pointer(DISK_ACCESS_WRITABLE)));
  AList.AddObject('DISK_ACCESS_READ_WRITE', TObject(Pointer(DISK_ACCESS_READ_WRITE)));
  AList.AddObject('DISK_ACCESS_WRITE_ONCE', TObject(Pointer(DISK_ACCESS_WRITE_ONCE)));
end;

{ TShowWindowProperty }
procedure TShowWindowProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('SW_HIDE', TObject(Pointer(SW_HIDE)));
  AList.AddObject('SW_NORMAL', TObject(Pointer(SW_NORMAL)));
  AList.AddObject('SW_SHOWMINIMIZED', TObject(Pointer(SW_SHOWMINIMIZED)));
  AList.AddObject('SW_SHOWMAXIMIZED', TObject(Pointer(SW_SHOWMAXIMIZED)));
  AList.AddObject('SW_SHOWNOACTIVATE', TObject(Pointer(SW_SHOWNOACTIVATE)));
  AList.AddObject('SW_SHOW', TObject(Pointer(SW_SHOW)));
  AList.AddObject('SW_MINIMIZE', TObject(Pointer(SW_MINIMIZE)));
  AList.AddObject('SW_SHOWMINNOACTIVE', TObject(Pointer(SW_SHOWMINNOACTIVE)));
  AList.AddObject('SW_SHOWNA', TObject(Pointer(SW_SHOWNA)));
  AList.AddObject('SW_RESTORE', TObject(Pointer(SW_RESTORE)));
  AList.AddObject('SW_SHOWDEFAULT', TObject(Pointer(SW_SHOWDEFAULT)));
end;

{ TRegValueTypeProperty }
procedure TRegValueTypeProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('REG_NONE', TObject(Pointer(REG_NONE)));
  AList.AddObject('REG_SZ', TObject(Pointer(REG_SZ)));
  AList.AddObject('REG_EXPAND_SZ', TObject(Pointer(REG_EXPAND_SZ)));
  AList.AddObject('REG_BINARY', TObject(Pointer(REG_BINARY)));
  AList.AddObject('REG_DWORD', TObject(Pointer(REG_DWORD)));
  AList.AddObject('REG_MULTI_SZ', TObject(Pointer(REG_MULTI_SZ)));
end;

{ TOsProductTypeProperty }
procedure TOsProductTypeProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('LSC_APPLICATION', TObject(Pointer(LSC_APPLICATION)));
  AList.AddObject('LSC_SYSTEM', TObject(Pointer(LSC_SYSTEM)));
  AList.AddObject('LSC_SYSTEM', TObject(Pointer(LSC_SYSTEM)));
end;

{ TOsDebugInfoTypeProperty }
procedure TOsDebugInfoTypeProperty.GetLookupData(AList: TStrings; AIsUpperCase: boolean); 
begin
  AList.AddObject('DIT_NONE', TObject(Pointer(DIT_NONE)));
  AList.AddObject('DIT_COMPLETE_MEMORY', TObject(Pointer(DIT_COMPLETE_MEMORY)));
  AList.AddObject('DIT_KERNEL_MEMORY', TObject(Pointer(DIT_KERNEL_MEMORY)));
  AList.AddObject('DIT_SMALL_MEMORY', TObject(Pointer(DIT_SMALL_MEMORY)));
end;

{ TOsLargeSysCacheProperty }
procedure TOsLargeSysCacheProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('LSC_APPLICATION', TObject(Pointer(LSC_APPLICATION)));
  AList.AddObject('LSC_SYSTEM', TObject(Pointer(LSC_SYSTEM)));
end;

{ TOsAppBoostProperty }
procedure TOsAppBoostProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('PT_WORKSTATION', TObject(Pointer(PT_WORKSTATION)));
  AList.AddObject('PT_DOMAIN_CONTROLLER', TObject(Pointer(PT_DOMAIN_CONTROLLER)));
  AList.AddObject('PT_SERVER', TObject(Pointer(PT_SERVER)));
end;

{ TOsQuantumLengthProperty }
procedure TOsQuantumLengthProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('QL_UNKNOWN', TObject(Pointer(QL_UNKNOWN)));
  AList.AddObject('QL_ONE_TICK', TObject(Pointer(QL_ONE_TICK)));
  AList.AddObject('QL_TWO_TICKS', TObject(Pointer(QL_TWO_TICKS)));
end;

{ TOsQuantumTypeProperty }
procedure TOsQuantumTypeProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('QT_UNKNOWN', TObject(Pointer(QT_UNKNOWN)));
  AList.AddObject('QT_FIXED', TObject(Pointer(QT_FIXED)));
  AList.AddObject('QT_VARIABLE', TObject(Pointer(QT_VARIABLE)));
end;

{ TOsTypeProperty }
procedure TOsTypeProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('OS_UNKNOWN', TObject(Pointer(OS_UNKNOWN)));
  AList.AddObject('OS_OTHER', TObject(Pointer(OS_OTHER)));
  AList.AddObject('OS_MACOS', TObject(Pointer(OS_MACOS)));
  AList.AddObject('OS_ATTUNIX', TObject(Pointer(OS_ATTUNIX)));
  AList.AddObject('OS_DGUX', TObject(Pointer(OS_DGUX)));
  AList.AddObject('OS_DECNT', TObject(Pointer(OS_DECNT)));
  AList.AddObject('OS_DIGITAL_UNIX', TObject(Pointer(OS_DIGITAL_UNIX)));
  AList.AddObject('OS_OPENVMS', TObject(Pointer(OS_OPENVMS)));
  AList.AddObject('OS_HPUX', TObject(Pointer(OS_HPUX)));
  AList.AddObject('OS_AIX', TObject(Pointer(OS_AIX)));
  AList.AddObject('OS_MVS', TObject(Pointer(OS_MVS)));
  AList.AddObject('OS_OS400', TObject(Pointer(OS_OS400)));
  AList.AddObject('OS_OS_2', TObject(Pointer(OS_OS_2)));
  AList.AddObject('OS_JAVAVM', TObject(Pointer(OS_JAVAVM)));
  AList.AddObject('OS_MSDOS', TObject(Pointer(OS_MSDOS)));
  AList.AddObject('OS_WIN3X', TObject(Pointer(OS_WIN3X)));
  AList.AddObject('OS_WIN95', TObject(Pointer(OS_WIN95)));
  AList.AddObject('OS_WIN98', TObject(Pointer(OS_WIN98)));
  AList.AddObject('OS_WINNT', TObject(Pointer(OS_WINNT)));
  AList.AddObject('OS_WINCE', TObject(Pointer(OS_WINCE)));
  AList.AddObject('OS_NCR3000', TObject(Pointer(OS_NCR3000)));
  AList.AddObject('OS_NETWARE', TObject(Pointer(OS_NETWARE)));
  AList.AddObject('OS_OSF', TObject(Pointer(OS_OSF)));
  AList.AddObject('OS_DC_OS', TObject(Pointer(OS_DC_OS)));
  AList.AddObject('OS_RELIANT_UNIX', TObject(Pointer(OS_RELIANT_UNIX)));
  AList.AddObject('OS_SCO_UNIXWARE', TObject(Pointer(OS_SCO_UNIXWARE)));
  AList.AddObject('OS_SCO_OPENSERVER', TObject(Pointer(OS_SCO_OPENSERVER)));
  AList.AddObject('OS_SEQUENT', TObject(Pointer(OS_SEQUENT)));
  AList.AddObject('OS_IRIX', TObject(Pointer(OS_IRIX)));
  AList.AddObject('OS_SOLARIS', TObject(Pointer(OS_SOLARIS)));
  AList.AddObject('OS_SUNOS', TObject(Pointer(OS_SUNOS)));
  AList.AddObject('OS_U6000', TObject(Pointer(OS_U6000)));
  AList.AddObject('OS_ASERIES', TObject(Pointer(OS_ASERIES)));
  AList.AddObject('OS_TANDEMNSK', TObject(Pointer(OS_TANDEMNSK)));
  AList.AddObject('OS_TANDEMNT', TObject(Pointer(OS_TANDEMNT)));
  AList.AddObject('OS_BS2000', TObject(Pointer(OS_BS2000)));
  AList.AddObject('OS_LINUX', TObject(Pointer(OS_LINUX)));
  AList.AddObject('OS_LYNX', TObject(Pointer(OS_LYNX)));
  AList.AddObject('OS_XENIX', TObject(Pointer(OS_XENIX)));
  AList.AddObject('OS_VM_ESA', TObject(Pointer(OS_VM_ESA)));
  AList.AddObject('OS_INTERACTIVE_UNIX', TObject(Pointer(OS_INTERACTIVE_UNIX)));
  AList.AddObject('OS_BSDUNIX', TObject(Pointer(OS_BSDUNIX)));
  AList.AddObject('OS_FREEBSD', TObject(Pointer(OS_FREEBSD)));
  AList.AddObject('OS_NETBSD', TObject(Pointer(OS_NETBSD)));
  AList.AddObject('OS_GNU_HURD', TObject(Pointer(OS_GNU_HURD)));
  AList.AddObject('OS_OS9', TObject(Pointer(OS_OS9)));
  AList.AddObject('OS_MACH_KERNEL', TObject(Pointer(OS_MACH_KERNEL)));
  AList.AddObject('OS_INFERNO', TObject(Pointer(OS_INFERNO)));
  AList.AddObject('OS_QNX', TObject(Pointer(OS_QNX)));
  AList.AddObject('OS_EPOC', TObject(Pointer(OS_EPOC)));
  AList.AddObject('OS_IXWORKS', TObject(Pointer(OS_IXWORKS)));
  AList.AddObject('OS_VXWORKS', TObject(Pointer(OS_VXWORKS)));
  AList.AddObject('OS_MINT', TObject(Pointer(OS_MINT)));
  AList.AddObject('OS_BEOS', TObject(Pointer(OS_BEOS)));
  AList.AddObject('OS_HP_MPE', TObject(Pointer(OS_HP_MPE)));
  AList.AddObject('OS_NEXTSTEP', TObject(Pointer(OS_NEXTSTEP)));
  AList.AddObject('OS_PALMPILOT', TObject(Pointer(OS_PALMPILOT)));
  AList.AddObject('OS_RHAPSODY', TObject(Pointer(OS_RHAPSODY)));
end;

{ TAdsAuthenticationProperty }
procedure TAdsAuthenticationProperty.GetLookupData(AList: TStrings;
  AIsUpperCase: boolean);
begin
  AList.AddObject('ADS_SECURE_AUTHENTICATION', TObject(Pointer(ADS_SECURE_AUTHENTICATION)));
  AList.AddObject('ADS_USE_ENCRYPTION', TObject(Pointer(ADS_USE_ENCRYPTION)));
  AList.AddObject('ADS_USE_SSL', TObject(Pointer(ADS_USE_SSL)));
  AList.AddObject('ADS_READONLY_SERVER', TObject(Pointer(ADS_READONLY_SERVER)));
  AList.AddObject('ADS_PROMPT_CREDENTIALS', TObject(Pointer(ADS_PROMPT_CREDENTIALS)));
  AList.AddObject('ADS_NO_AUTHENTICATION', TObject(Pointer(ADS_NO_AUTHENTICATION)));
  AList.AddObject('ADS_FAST_BIND', TObject(Pointer(ADS_FAST_BIND)));
  AList.AddObject('ADS_USE_SIGNING', TObject(Pointer(ADS_USE_SIGNING)));
  AList.AddObject('ADS_USE_SEALING', TObject(Pointer(ADS_USE_SEALING)));
  AList.AddObject('ADS_USE_DELEGATION', TObject(Pointer(ADS_USE_DELEGATION)));
  AList.AddObject('ADS_SERVER_BIND', TObject(Pointer(ADS_SERVER_BIND)));
  AList.AddObject('ADS_AUTH_RESERVED', TObject(Pointer(ADS_AUTH_RESERVED)));
end;


{ TRegAccessDummy }

function TRegAccessDummy.Get_DELETE: boolean;
begin Result := FDWORDValue and Windows._DELETE <> 0; end;

function TRegAccessDummy.GetKEY_CREATE_LINK: boolean;
begin Result := FDWORDValue and Windows.KEY_CREATE_LINK <> 0; end;

function TRegAccessDummy.GetKEY_CREATE_SUB_KEY: boolean;
begin Result := FDWORDValue and Windows.KEY_CREATE_SUB_KEY <> 0; end;

function TRegAccessDummy.GetKEY_ENUMERATE_SUB_KEYS: boolean;
begin Result := FDWORDValue and Windows.KEY_ENUMERATE_SUB_KEYS <> 0; end;

function TRegAccessDummy.GetKEY_NOTIFY: boolean;
begin Result := FDWORDValue and Windows.KEY_NOTIFY <> 0; end;

function TRegAccessDummy.GetKEY_QUERY_VALUE: boolean;
begin Result := FDWORDValue and Windows.KEY_QUERY_VALUE <> 0; end;

function TRegAccessDummy.GetKEY_SET_VALUE: boolean;
begin Result := FDWORDValue and Windows.KEY_SET_VALUE <> 0; end;

function TRegAccessDummy.GetREAD_CONTROL: boolean;
begin Result := FDWORDValue and Windows.READ_CONTROL <> 0; end;

function TRegAccessDummy.GetWRITE_DAC: boolean;
begin Result := FDWORDValue and Windows.WRITE_DAC <> 0; end;

function TRegAccessDummy.GetWRITE_OWNER: boolean;
begin Result := FDWORDValue and Windows.WRITE_OWNER <> 0; end;

procedure TRegAccessDummy.Set_DELETE(const Value: boolean); begin end;
procedure TRegAccessDummy.SetKEY_CREATE_LINK(const Value: boolean); begin end;
procedure TRegAccessDummy.SetKEY_CREATE_SUB_KEY(const Value: boolean); begin end;
procedure TRegAccessDummy.SetKEY_ENUMERATE_SUB_KEYS(const Value: boolean); begin end;
procedure TRegAccessDummy.SetKEY_NOTIFY(const Value: boolean); begin end;
procedure TRegAccessDummy.SetKEY_QUERY_VALUE(const Value: boolean); begin end;
procedure TRegAccessDummy.SetKEY_SET_VALUE(const Value: boolean); begin end;
procedure TRegAccessDummy.SetREAD_CONTROL(const Value: boolean); begin end;
procedure TRegAccessDummy.SetWRITE_DAC(const Value: boolean); begin end;
procedure TRegAccessDummy.SetWRITE_OWNER(const Value: boolean); begin end;

{ TProcessCreateFlagsDummy }

function TProcessCreateFlagsDummy.GetCREATE_DEFAULT_ERROR_MODE: boolean;
begin Result := FDWORDValue and Windows.CREATE_DEFAULT_ERROR_MODE <> 0; end;

function TProcessCreateFlagsDummy.GetCREATE_NEW_CONSOLE: boolean;
begin Result := FDWORDValue and Windows.CREATE_NEW_CONSOLE <> 0; end;

function TProcessCreateFlagsDummy.GetCREATE_NEW_PROCESS_GROUP: boolean;
begin Result := FDWORDValue and Windows.CREATE_NEW_PROCESS_GROUP <> 0; end;

function TProcessCreateFlagsDummy.GetCREATE_SUSPENDED: boolean;
begin Result := FDWORDValue and Windows.CREATE_SUSPENDED <> 0; end;

function TProcessCreateFlagsDummy.GetCREATE_UNICODE_ENVIRONMENT: boolean;
begin Result := FDWORDValue and Windows.CREATE_UNICODE_ENVIRONMENT <> 0; end;

function TProcessCreateFlagsDummy.GetDEBUG_ONLY_THIS_PROCESS: boolean;
begin Result := FDWORDValue and Windows.DEBUG_ONLY_THIS_PROCESS <> 0; end;

function TProcessCreateFlagsDummy.GetDEBUG_PROCESS: boolean;
begin Result := FDWORDValue and Windows.DEBUG_PROCESS <> 0; end;

function TProcessCreateFlagsDummy.GetDETACHED_PROCESS: boolean;
begin Result := FDWORDValue and Windows.DEBUG_PROCESS <> 0; end;

procedure TProcessCreateFlagsDummy.SetCREATE_DEFAULT_ERROR_MODE(const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or Windows.CREATE_DEFAULT_ERROR_MODE
    else DWORDValue := DWORDValue and not Windows.CREATE_DEFAULT_ERROR_MODE;
end;

procedure TProcessCreateFlagsDummy.SetCREATE_NEW_CONSOLE(const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or Windows.CREATE_NEW_CONSOLE
    else DWORDValue := DWORDValue and not Windows.CREATE_NEW_CONSOLE;
end;

procedure TProcessCreateFlagsDummy.SetCREATE_NEW_PROCESS_GROUP(
  const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or Windows.CREATE_NEW_PROCESS_GROUP
    else DWORDValue := DWORDValue and not Windows.CREATE_NEW_PROCESS_GROUP;
end;

procedure TProcessCreateFlagsDummy.SetCREATE_SUSPENDED(
  const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or Windows.CREATE_SUSPENDED
    else DWORDValue := DWORDValue and not Windows.CREATE_SUSPENDED;
end;

procedure TProcessCreateFlagsDummy.SetCREATE_UNICODE_ENVIRONMENT(
  const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or Windows.CREATE_UNICODE_ENVIRONMENT
    else DWORDValue := DWORDValue and not Windows.CREATE_UNICODE_ENVIRONMENT;
end;

procedure TProcessCreateFlagsDummy.SetDEBUG_ONLY_THIS_PROCESS(const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or Windows.DEBUG_ONLY_THIS_PROCESS
    else DWORDValue := DWORDValue and not Windows.DEBUG_ONLY_THIS_PROCESS;
end;

procedure TProcessCreateFlagsDummy.SetDEBUG_PROCESS(const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or Windows.DEBUG_PROCESS
    else DWORDValue := DWORDValue and not Windows.DEBUG_PROCESS;
end;

procedure TProcessCreateFlagsDummy.SetDETACHED_PROCESS(
  const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or Windows.DETACHED_PROCESS
    else DWORDValue := DWORDValue and not Windows.DETACHED_PROCESS;
end;

{ TProcessErrorModeDummy }

function TProcessErrorModeDummy.GetFAIL_CRITICAL_ERRORS: boolean;
begin Result := FDWORDValue and WmiProcessControl.FAIL_CRITICAL_ERRORS <> 0; end;

function TProcessErrorModeDummy.GetNO_ALIGNMENT_FAULT_EXCEPT: boolean;
begin Result := FDWORDValue and WmiProcessControl.NO_ALIGNMENT_FAULT_EXCEPT <> 0; end;

function TProcessErrorModeDummy.GetNO_GP_FAULT_ERROR_BOX: boolean;
begin Result := FDWORDValue and WmiProcessControl.NO_GP_FAULT_ERROR_BOX <> 0; end;

function TProcessErrorModeDummy.GetNO_OPEN_FILE_ERROR_BOX: boolean;
begin Result := FDWORDValue and WmiProcessControl.NO_OPEN_FILE_ERROR_BOX <> 0; end;

procedure TProcessErrorModeDummy.SetFAIL_CRITICAL_ERRORS(
  const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or WmiProcessControl.FAIL_CRITICAL_ERRORS
    else DWORDValue := DWORDValue and not WmiProcessControl.FAIL_CRITICAL_ERRORS;
end;

procedure TProcessErrorModeDummy.SetNO_ALIGNMENT_FAULT_EXCEPT(
  const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or WmiProcessControl.NO_ALIGNMENT_FAULT_EXCEPT
    else DWORDValue := DWORDValue and not WmiProcessControl.NO_ALIGNMENT_FAULT_EXCEPT;
end;

procedure TProcessErrorModeDummy.SetNO_GP_FAULT_ERROR_BOX(
  const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or WmiProcessControl.NO_GP_FAULT_ERROR_BOX
    else DWORDValue := DWORDValue and not WmiProcessControl.NO_GP_FAULT_ERROR_BOX;
end;

procedure TProcessErrorModeDummy.SetNO_OPEN_FILE_ERROR_BOX(
  const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or WmiProcessControl.NO_OPEN_FILE_ERROR_BOX
    else DWORDValue := DWORDValue and not WmiProcessControl.NO_OPEN_FILE_ERROR_BOX;
end;

{ TCDROMFileSystemFlagsAsSetProperty }

function   TCDROMFileSystemFlagsAsSetProperty.GetDummyComponent: TDWORDDummy;
begin
  Result := TCDROMFileSystemFlagsDummy.Create(nil);
end;

function   TCDROMFileSystemFlagsAsSetProperty.GetValue: string;
begin
  inherited GetValue;
  Result := GetElementName(GetOrdValue, FileSystemFlagsToString);
end;

{ TOsSuiteMaskAsSetProperty }
function   TOsSuiteMaskAsSetProperty.GetDummyComponent: TDWORDDummy;
begin
  Result := TOsSuiteMaskDummy.Create(nil);
end;

function   TOsSuiteMaskAsSetProperty.GetValue: string;
begin
  inherited GetValue;
  Result := GetElementName(GetOrdValue, OsSuiteMaskToString);
end;


{ TRegAccessAsSetProperty }
function   TRegAccessAsSetProperty.GetDummyComponent: TDWORDDummy;
begin
  Result := TRegAccessDummy.Create(nil);
end;

function   TRegAccessAsSetProperty.GetValue: string;
begin
  inherited GetValue;
  Result := GetElementName(GetOrdValue, RegAccessToString);
end;

{ TProcessCreateFlagsAsSetProperty }

function TProcessCreateFlagsAsSetProperty.GetDummyComponent: TDWORDDummy;
begin
  Result := TProcessCreateFlagsDummy.Create(nil);
end;

function TProcessCreateFlagsAsSetProperty.GetValue: string;
begin
  inherited GetValue;
  Result := GetElementName(GetOrdValue, ProcessCreateFlagsToString);
end;

{ TProcessErrorModeAsSetProperty }

function TProcessErrorModeAsSetProperty.GetDummyComponent: TDWORDDummy;
begin
  Result := TProcessErrorModeDummy.Create(nil);
end;

function TProcessErrorModeAsSetProperty.GetValue: string;
begin
  inherited GetValue;
  Result := GetElementName(GetOrdValue, ProcessErrorModeToString);
end;

{ TFillAttributeDummy }
function TFillAttributeDummy.GetBACKGROUND_BLUE: boolean;
begin Result := FDWORDValue and WmiProcessControl.BACKGROUND_BLUE <> 0; end;

function TFillAttributeDummy.GetBACKGROUND_GREEN: boolean;
begin Result := FDWORDValue and WmiProcessControl.BACKGROUND_GREEN <> 0; end;

function TFillAttributeDummy.GetBACKGROUND_INTENSITY: boolean;
begin Result := FDWORDValue and WmiProcessControl.BACKGROUND_INTENSITY <> 0; end;

function TFillAttributeDummy.GetBACKGROUND_RED: boolean;
begin Result := FDWORDValue and WmiProcessControl.BACKGROUND_RED <> 0; end;

function TFillAttributeDummy.GetFOREGROUND_BLUE: boolean;
begin Result := FDWORDValue and WmiProcessControl.FOREGROUND_BLUE <> 0; end;

function TFillAttributeDummy.GetFOREGROUND_GREEN: boolean;
begin Result := FDWORDValue and WmiProcessControl.FOREGROUND_GREEN <> 0; end;

function TFillAttributeDummy.GetFOREGROUND_INTENSITY: boolean;
begin Result := FDWORDValue and WmiProcessControl.FOREGROUND_INTENSITY <> 0; end;

function TFillAttributeDummy.GetFOREGROUND_RED: boolean;
begin Result := FDWORDValue and WmiProcessControl.FOREGROUND_RED <> 0; end;

procedure TFillAttributeDummy.SetBACKGROUND_BLUE(const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or WmiProcessControl.BACKGROUND_BLUE
    else DWORDValue := DWORDValue and not WmiProcessControl.BACKGROUND_BLUE;
end;    

procedure TFillAttributeDummy.SetBACKGROUND_GREEN(const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or WmiProcessControl.BACKGROUND_GREEN
    else DWORDValue := DWORDValue and not WmiProcessControl.BACKGROUND_GREEN;
end;    

procedure TFillAttributeDummy.SetBACKGROUND_INTENSITY(
  const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or WmiProcessControl.BACKGROUND_INTENSITY
    else DWORDValue := DWORDValue and not WmiProcessControl.BACKGROUND_INTENSITY;
end;

procedure TFillAttributeDummy.SetBACKGROUND_RED(const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or WmiProcessControl.BACKGROUND_RED
    else DWORDValue := DWORDValue and not WmiProcessControl.BACKGROUND_RED;
end;

procedure TFillAttributeDummy.SetFOREGROUND_BLUE(const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or WmiProcessControl.FOREGROUND_BLUE
    else DWORDValue := DWORDValue and not WmiProcessControl.FOREGROUND_BLUE;
end;

procedure TFillAttributeDummy.SetFOREGROUND_GREEN(const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or WmiProcessControl.FOREGROUND_GREEN
    else DWORDValue := DWORDValue and not WmiProcessControl.FOREGROUND_GREEN;
end;

procedure TFillAttributeDummy.SetFOREGROUND_INTENSITY(
  const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or WmiProcessControl.FOREGROUND_INTENSITY
    else DWORDValue := DWORDValue and not WmiProcessControl.FOREGROUND_INTENSITY;
end;

procedure TFillAttributeDummy.SetFOREGROUND_RED(const Value: boolean);
begin
  if Value then DWORDValue := FDWORDValue or WmiProcessControl.FOREGROUND_RED
    else DWORDValue := DWORDValue and not WmiProcessControl.FOREGROUND_RED;
end;

{ TOsSuiteMaskDummy }

function TOsSuiteMaskDummy.GetSM_BACK_OFFICE: boolean;
begin Result := FDWORDValue and WmiOs.SM_BACK_OFFICE <> 0; end;

function TOsSuiteMaskDummy.GetSM_BLADE: boolean;
begin Result := FDWORDValue and WmiOs.SM_BLADE <> 0; end;

function TOsSuiteMaskDummy.GetSM_COMMUNICATIONS: boolean;
begin Result := FDWORDValue and WmiOs.SM_COMMUNICATIONS <> 0; end;

function TOsSuiteMaskDummy.GetSM_DATA_CENTER: boolean;
begin Result := FDWORDValue and WmiOs.SM_DATA_CENTER <> 0; end;

function TOsSuiteMaskDummy.GetSM_EMBEDDED_NT: boolean;
begin Result := FDWORDValue and WmiOs.SM_EMBEDDED_NT <> 0; end;

function TOsSuiteMaskDummy.GetSM_ENTERPRISE: boolean;
begin Result := FDWORDValue and WmiOs.SM_ENTERPRISE <> 0; end;

function TOsSuiteMaskDummy.GetSM_PERSONAL: boolean;
begin Result := FDWORDValue and WmiOs.SM_PERSONAL <> 0; end;

function TOsSuiteMaskDummy.GetSM_SINGLE_USER: boolean;
begin Result := FDWORDValue and WmiOs.SM_SINGLE_USER <> 0; end;

function TOsSuiteMaskDummy.GetSM_SMALL_BUSINESS: boolean;
begin Result := FDWORDValue and WmiOs.SM_SMALL_BUSINESS <> 0; end;

function TOsSuiteMaskDummy.GetSM_SMALL_BUSINESS_RESTRICTED: boolean;
begin Result := FDWORDValue and WmiOs.SM_SMALL_BUSINESS_RESTRICTED <> 0; end;

function TOsSuiteMaskDummy.GetSM_TERMINAL: boolean;
begin Result := FDWORDValue and WmiOs.SM_TERMINAL <> 0; end;

procedure TOsSuiteMaskDummy.SetSM_BACK_OFFICE(const Value: boolean);
begin ChangeBit(Value, WmiOs.SM_BACK_OFFICE); end;

procedure TOsSuiteMaskDummy.SetSM_BLADE(const Value: boolean);
begin ChangeBit(Value, WmiOs.SM_BLADE); end;

procedure TOsSuiteMaskDummy.SetSM_COMMUNICATIONS(const Value: boolean);
begin ChangeBit(Value, WmiOs.SM_COMMUNICATIONS); end;

procedure TOsSuiteMaskDummy.SetSM_DATA_CENTER(const Value: boolean);
begin ChangeBit(Value, WmiOs.SM_DATA_CENTER); end;

procedure TOsSuiteMaskDummy.SetSM_EMBEDDED_NT(const Value: boolean);
begin ChangeBit(Value, WmiOs.SM_EMBEDDED_NT); end;

procedure TOsSuiteMaskDummy.SetSM_ENTERPRISE(const Value: boolean);
begin ChangeBit(Value, WmiOs.SM_ENTERPRISE); end;

procedure TOsSuiteMaskDummy.SetSM_PERSONAL(const Value: boolean);
begin ChangeBit(Value, WmiOs.SM_PERSONAL); end;

procedure TOsSuiteMaskDummy.SetSM_SINGLE_USER(const Value: boolean);
begin ChangeBit(Value, WmiOs.SM_SINGLE_USER); end;

procedure TOsSuiteMaskDummy.SetSM_SMALL_BUSINESS(const Value: boolean);
begin ChangeBit(Value, WmiOs.SM_SMALL_BUSINESS); end;

procedure TOsSuiteMaskDummy.SetSM_SMALL_BUSINESS_RESTRICTED(const Value: boolean);
begin ChangeBit(Value, WmiOs.SM_SMALL_BUSINESS_RESTRICTED); end;

procedure TOsSuiteMaskDummy.SetSM_TERMINAL(const Value: boolean);
begin ChangeBit(Value, WmiOs.SM_TERMINAL); end;

{ TCDROMFileSystemFlagsDummy }

function TCDROMFileSystemFlagsDummy.GetFSF_CASE_PRESERVED_NAMES: boolean;
begin Result := FDWORDValue and WmiStorageInfo.FSF_CASE_PRESERVED_NAMES <> 0; end;

function TCDROMFileSystemFlagsDummy.GetFSF_CASE_SENSITIVE_SEARCH: boolean;
begin Result := FDWORDValue and WmiStorageInfo.FSF_CASE_SENSITIVE_SEARCH <> 0; end;

function TCDROMFileSystemFlagsDummy.GetFSF_FILE_COMPRESSION: boolean;
begin Result := FDWORDValue and WmiStorageInfo.FSF_FILE_COMPRESSION <> 0; end;

function TCDROMFileSystemFlagsDummy.GetFSF_PERSISTENT_ACLS: boolean;
begin Result := FDWORDValue and WmiStorageInfo.FSF_PERSISTENT_ACLS <> 0; end;

function TCDROMFileSystemFlagsDummy.GetFSF_SUPPORTS_ENCRYPTION: boolean;
begin Result := FDWORDValue and WmiStorageInfo.FSF_SUPPORTS_ENCRYPTION <> 0; end;

function TCDROMFileSystemFlagsDummy.GetFSF_SUPPORTS_LONG_NAMES: boolean;
begin Result := FDWORDValue and WmiStorageInfo.FSF_SUPPORTS_LONG_NAMES <> 0; end;

function TCDROMFileSystemFlagsDummy.GetFSF_SUPPORTS_NAMED_STREAMS: boolean;
begin Result := FDWORDValue and WmiStorageInfo.FSF_SUPPORTS_NAMED_STREAMS <> 0; end;

function TCDROMFileSystemFlagsDummy.GetFSF_SUPPORTS_OBJECT_IDS: boolean;
begin Result := FDWORDValue and WmiStorageInfo.FSF_SUPPORTS_OBJECT_IDS <> 0; end;

function TCDROMFileSystemFlagsDummy.GetFSF_SUPPORTS_REMOTE_STORAGE: boolean;
begin Result := FDWORDValue and WmiStorageInfo.FSF_SUPPORTS_REMOTE_STORAGE <> 0; end;

function TCDROMFileSystemFlagsDummy.GetFSF_SUPPORTS_REPARSE_POINTS: boolean;
begin Result := FDWORDValue and WmiStorageInfo.FSF_SUPPORTS_REPARSE_POINTS <> 0; end;

function TCDROMFileSystemFlagsDummy.GetFSF_SUPPORTS_SPARSE_FILES: boolean;
begin Result := FDWORDValue and WmiStorageInfo.FSF_SUPPORTS_SPARSE_FILES <> 0; end;

function TCDROMFileSystemFlagsDummy.GetFSF_UNICODE_ON_DISK: boolean;
begin Result := FDWORDValue and WmiStorageInfo.FSF_UNICODE_ON_DISK <> 0; end;

function TCDROMFileSystemFlagsDummy.GetFSF_VOLUME_IS_COMPRESSED: boolean;
begin Result := FDWORDValue and WmiStorageInfo.FSF_VOLUME_IS_COMPRESSED <> 0; end;

function TCDROMFileSystemFlagsDummy.GetFSF_VOLUME_QUOTAS: boolean;
begin Result := FDWORDValue and WmiStorageInfo.FSF_VOLUME_QUOTAS <> 0; end;

procedure TCDROMFileSystemFlagsDummy.SetFSF_CASE_PRESERVED_NAMES(const Value: boolean);begin end;
procedure TCDROMFileSystemFlagsDummy.SetFSF_CASE_SENSITIVE_SEARCH(const Value: boolean); begin end;
procedure TCDROMFileSystemFlagsDummy.SetFSF_FILE_COMPRESSION(const Value: boolean); begin end;
procedure TCDROMFileSystemFlagsDummy.SetFSF_PERSISTENT_ACLS(const Value: boolean); begin end;
procedure TCDROMFileSystemFlagsDummy.SetFSF_SUPPORTS_ENCRYPTION(const Value: boolean); begin end;
procedure TCDROMFileSystemFlagsDummy.SetFSF_SUPPORTS_LONG_NAMES(const Value: boolean); begin end;
procedure TCDROMFileSystemFlagsDummy.SetFSF_SUPPORTS_NAMED_STREAMS(const Value: boolean); begin end;
procedure TCDROMFileSystemFlagsDummy.SetFSF_SUPPORTS_OBJECT_IDS(const Value: boolean); begin end;
procedure TCDROMFileSystemFlagsDummy.SetFSF_SUPPORTS_REMOTE_STORAGE(const Value: boolean); begin end;
procedure TCDROMFileSystemFlagsDummy.SetFSF_SUPPORTS_REPARSE_POINTS(const Value: boolean); begin end;
procedure TCDROMFileSystemFlagsDummy.SetFSF_SUPPORTS_SPARSE_FILES(const Value: boolean); begin end;
procedure TCDROMFileSystemFlagsDummy.SetFSF_UNICODE_ON_DISK(const Value: boolean); begin end;
procedure TCDROMFileSystemFlagsDummy.SetFSF_VOLUME_IS_COMPRESSED(const Value: boolean); begin end;
procedure TCDROMFileSystemFlagsDummy.SetFSF_VOLUME_QUOTAS(const Value: boolean); begin end;



{ TFillAttributeAsSetProperty }

function TFillAttributeAsSetProperty.GetDummyComponent: TDWORDDummy;
begin
  Result := TFillAttributeDummy.Create(nil);
end;

function TFillAttributeAsSetProperty.GetValue: string;
begin
  inherited GetValue;
  Result := GetElementName(GetOrdValue, FillAttributeToString);
end;

{ TDiskLimitProperty }

function TDiskLimitProperty.GetValue: string;
begin
  if GetStrValue = NO_LIMIT then Result := 'NO_LIMIT'
    else Result := GetStrValue;
end;

procedure TDiskLimitProperty.SetValue(const Value: string);
begin
  if UpperCase(Value) = 'NO_LIMT' then SetStrValue(NO_LIMIT)
   else SetStrValue(Value);
end;

{ TMethodNameProperty }
function  TMethodNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TMethodNameProperty.GetValues(Proc: TGetStrProc);
var
  vResultList: TStringList;
  i          : integer;
  vComponent : TWmiMethod;
begin
  vResultList := TStringList.Create;
  try
    try
      vComponent := TWmiMethod(GetComponent(0));
      vComponent.ListMethodNames(vResultList);
      for i := 0 to vResultList.Count - 1 do Proc(vResultList[i]);
    except
      // do not throw exceptions at design time
      on E: Exception do
      begin
        Proc(E.Message);
      end;
    end;  
  finally
    vResultList.Free;
  end;
end;

{ TDefaultValueProperty }

function TDefaultValueProperty.GetValue: string;
begin
  if GetOrdValue = -1 then Result := 'DEFAULT_VALUE'
    else Result := IntToStr(GetOrdValue);
end;

procedure TDefaultValueProperty.SetValue(const Value: string);
begin
  if UpperCase(Value) = 'DEFAULT_VALUE' then SetOrdValue(-1)
   else SetOrdValue(StrToInt(Value));
end;

{ TWmiMachineNameProperty }

function TWmiMachineNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TWmiMachineNameProperty.Edit;
var
  vComponent  : TWmiAbstract;
  vForm       : TFrmSelectComputer;
begin
  vComponent  := TWmiAbstract(GetComponent(0));
  vForm       := TFrmSelectComputer.Create(nil);
  try
    vForm.ComputerName := vComponent.MachineName;
    if vForm.ShowModal = mrOk then  vComponent.MachineName := vForm.ComputerName;
  finally
    vForm.Free;
  end;
end;

function  TRegValueNameProperty.GetAttributes: TPropertyAttributes; 
begin
  Result := [paValueList];
end;

procedure TRegValueNameProperty.GetValues(Proc: TGetStrProc); 
var
  vResultList  : TStringList;
  i           : integer;
  vComponent: TWmiRegistry;
begin
  if not (GetComponent(0) is TWmiRegistry) then Exit;

  vResultList := TStringList.Create;
  try
    vComponent := TWmiRegistry(GetComponent(0));
    vComponent.ListValues(vResultList);
    for i := 0 to vResultList.Count - 1 do Proc(vResultList.Names[i]);
  finally
    vResultList.Free;
  end;
end;

{ TObjectPathProperty }
function  TObjectPathProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TObjectPathProperty.GetValues(Proc: TGetStrProc);
const
  OBJECT_PATH = 'ObjectPath';
var
  vResultList  : TStringList;
  i           : integer;
  vComponent, vNewComponent: TWmiConnection;
begin
  vResultList := TStringList.Create;
  try
    try
      vComponent := TWmiConnection(GetComponent(0));
      if PropertyCache.HasCache(vComponent.MachineName, OBJECT_PATH) then
      begin
        PropertyCache.GetCache(vComponent.MachineName, OBJECT_PATH, vResultList);
      end else
      begin
        if vComponent.Connected then vComponent.ListClasses(vResultList) else
        begin
          // create a new temp component
          vNewComponent := TWmiConnection.Create(nil);
          try
            vNewComponent.MachineName := vComponent.MachineName;
            vNewComponent.Credentials.Assign(vComponent.Credentials);
            vNewComponent.Connected := true;
            vNewComponent.ListClasses(vResultList);
          finally
            vNewComponent.Connected := false;
            vNewComponent.Free;
          end;
        end;
        PropertyCache.PutChache(vComponent.MachineName, OBJECT_PATH, vResultList);
      end;  

      for i := 0 to vResultList.Count - 1 do Proc(vResultList[i]);
    except
      // do not throw exceptions at design time
      on E: Exception do
      begin
        Proc(E.Message);
      end;
    end;  
  finally
    vResultList.Text := '';
    vResultList.Free;
  end;
end;


{ TLogicalDiskProperty }

function TLogicalDiskProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TLogicalDiskProperty.GetValues(Proc: TGetStrProc);
var
  vResultList  : TStringList;
  i           : integer;
  vComponent, vNewComponent: TWmiComponent;
begin
  vResultList := TStringList.Create;
  try
    try
      vComponent := TWmiComponent(GetComponent(0));
      if vComponent.Active then vComponent.ListLogicalDisks(vResultList) else
      begin
        // create a new temp component
        vNewComponent := TWmiComponent.Create(nil);
        try
          vNewComponent.MachineName := vComponent.MachineName;
          vNewComponent.Credentials.Assign(vComponent.Credentials);
          vNewComponent.Active := true;
          vNewComponent.ListLogicalDisks(vResultList);
        finally
          vNewComponent.Active := false;
          vNewComponent.Free;
        end;
      end;

      for i := 0 to vResultList.Count - 1 do Proc(vResultList[i]);
    except
      // do not throw exceptions at design time
      on E: Exception do
      begin
        Proc(E.Message);
      end;
    end;  
  finally
    vResultList.Free;
  end;
end;

{ TAccountProperty }

function TAccountProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TAccountProperty.GetValues(Proc: TGetStrProc);
var
  vResultList  : TStringList;
  i           : integer;
  vComponent, vNewComponent: TWmiComponent;
begin
  vResultList := TStringList.Create;
  try
    try
      vComponent := TWmiComponent(GetComponent(0));
      if vComponent.Active then vComponent.ListAccounts(vResultList) else
      begin
        // create a new temporal component
        vNewComponent := TWmiComponent.Create(nil);
        try
          vNewComponent.MachineName := vComponent.MachineName;
          vNewComponent.Credentials.Assign(vComponent.Credentials);
          vNewComponent.Active := true;
          vNewComponent.ListAccounts(vResultList);
        finally
          vNewComponent.Active := false;
          vNewComponent.Free;
        end;
      end;

      for i := 0 to vResultList.Count - 1 do Proc(vResultList[i]);
    except
      // do not throw exceptions at design time
      on E: Exception do
      begin
        Proc(E.Message);
      end;
    end;
  finally
    vResultList.Free;
  end;
end;

{$IFDEF Delphi6}
{ TWmiEntityListCollectionProperty }
function TWmiEntityListCollectionProperty.GetColOptions: TColOptions;
begin
  if TWmiEntityList(GetOrdValue).NonModifieable then
  begin
    Result := [];
  end else
  begin
    Result := [coAdd, coDelete];
  end;
end;

function TReadOnlyCollectionProperty.GetColOptions: TColOptions;
begin
  Result := [];
end;

{$ENDIF}


{ TRegCurrentPathProperty }

procedure TRegCurrentPathProperty.Edit;
var
  AComponent: TWmiRegistry;
begin
  AComponent := GetComponent(0) as TWmiRegistry;
  with TFrmRegBrowser.Create(nil, AComponent) do
  try
    if ShowModal = mrOk then AComponent.CurrentPath := CurrentPath;
  finally
    Free;
  end;
end;

function TRegCurrentPathProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{ TAdsProperty }

function TAdsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TAdsProperty.GetValues(Proc: TGetStrProc);
var
  vResultList  : TStringList;
  i           : integer;
  vAdsBrowser : TAdsBrowser;
  vOriginalComponent: TAdsBrowser;
  vWasCreated : boolean;
begin
  try
    vOriginalComponent := TAdsPropertyInfo(GetComponent(0)).GetOwner;
    if vOriginalComponent.Active then
    begin
      vAdsBrowser := vOriginalComponent;
      vWasCreated := false;
    end else
    begin
      vAdsBrowser := TAdsBrowser.Create(nil);
      vWasCreated := true;
      vAdsBrowser.ObjectPath := vOriginalComponent.ObjectPath;
    end;

    vResultList := TStringList.Create;
    try
      vAdsBrowser.Active := true;

      vAdsBrowser.GetAdsPropertyNames(vResultList);
      for i := 0 to vResultList.Count - 1 do Proc(vResultList[i]);
    finally
      vResultList.Free;
      if vWasCreated then vAdsBrowser.Free;
    end;

  except
    // error expected if ObjectName is invalid
  end;

end;

{ TWmiMethodExecuteProperty }
function TWmiMethodExecuteProperty.GetVerbCount: Integer;
begin
  Result := 1;
end;

function TWmiMethodExecuteProperty.GetVerb(Index: Integer): String;
begin
  case Index of
    0: Result := 'Execute method';
  end;
end;

procedure TWmiMethodExecuteProperty.ExecuteVerb(Index: Integer);
var
  vMessage, vCaption: string;
  vComponent: TWmiMethod;
begin
  vComponent := TWmiMethod(Component);
  try
    vComponent.Execute;
    vMessage := Format('The return value is %d (%s). Method returned %d output parameter(s)',
                    [vComponent.LastWmiError,
                     vComponent.LastWmiErrorDescription,
                     vComponent.OutParams.Count]);
    vCaption := vComponent.Name + ': Method executed';
    Application.MessageBox(PChar(vMessage), PChar(vCaption), MB_OK+MB_ICONINFORMATION);
  except
    on e: Exception do
    begin
      vCaption := vComponent.Name + ': Method failed';
      vMessage := e.Message;
        Application.MessageBox(PChar(vMessage), PChar(vCaption), MB_OK + MB_ICONERROR);
    end;
  end;  
end;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(WideString),  TAdsBrowser, 'ObjectPath', TAdsObjectNameProperty);
  RegisterPropertyEditor(TypeInfo(WideString),  TAdsPropertyInfo, 'Name', TAdsProperty);
  RegisterPropertyEditor(TypeInfo(integer),  TAdsPropertyInfo, 'PropertyType', TAdsTypeProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),  TAdsCredentials, 'Authentication', TAdsAuthenticationProperty);
  RegisterPropertyEditor(TypeInfo(TAdsVariants),  nil, '', TAdsPropertyValues);
  
  RegisterPropertyEditor(TypeInfo(Widestring),  TWmiAbstract, 'MachineName', TWmiMachineNameProperty);
  RegisterPropertyEditor(TypeInfo(Widestring),  TWmiConnection, 'MachineName', TWmiMachineNameProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),  TWmiProcessStartupInfo, 'PriorityClass', TPriorityClassProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),  TWmiProcessStartupInfo, 'ShowWindow', TShowWindowProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),  TWmiProcessStartupInfo, 'CreateFlags', TProcessCreateFlagsAsSetProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),  TWmiProcessStartupInfo, 'ErrorMode', TProcessErrorModeAsSetProperty);
  RegisterPropertyEditor(TypeInfo(integer),  TWmiProcessStartupInfo, 'X', TDefaultValueProperty);
  RegisterPropertyEditor(TypeInfo(integer),  TWmiProcessStartupInfo, 'Y', TDefaultValueProperty);
  RegisterPropertyEditor(TypeInfo(integer),  TWmiProcessStartupInfo, 'XSize', TDefaultValueProperty);
  RegisterPropertyEditor(TypeInfo(integer),  TWmiProcessStartupInfo, 'YSize', TDefaultValueProperty);
  RegisterPropertyEditor(TypeInfo(integer),  TWmiProcessStartupInfo, 'XCountChars', TDefaultValueProperty);
  RegisterPropertyEditor(TypeInfo(integer),  TWmiProcessStartupInfo, 'YCountChars', TDefaultValueProperty);

  RegisterPropertyEditor(TypeInfo(word),    TWmiLogicalDisk, 'Access', TDiskAccessProperty);
  RegisterPropertyEditor(TypeInfo(word),    TWmiPartition, 'Access', TDiskAccessProperty);
  RegisterPropertyEditor(TypeInfo(word),    TWmiDriveBase, 'Availability', TDriveAvailabilityProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),   TWmiDevice, 'ConfigManagerErrorCode', TConfigManagerErrorProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),   TWmiLogicalDisk, 'DriveType', TDriveTypeProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),   TWmiLogicalDisk, 'MediaType', TMediaTypeProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),   TWmiCDROMDrive, 'MediaType', TMediaTypeProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),   TWmiDiskDrive, 'MediaType', TMediaTypeProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),   TWmiTapeDrive, 'MediaType', TMediaTypeProperty);
  RegisterPropertyEditor(TypeInfo(word),   TWmiDevice, 'StatusInfo', TStatusInfoProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),  TWmiCDROMDrive, 'FileSystemFlagsEx', TCDROMFileSystemFlagsAsSetProperty);

  RegisterPropertyEditor(TypeInfo(DWORD),  TWmiQuotaSetting, 'State', TQuotaStateProperty);
  RegisterPropertyEditor(TypeInfo(widestring),  TWmiDiskQuotaControl, 'FilterUser', TAccountProperty);
  RegisterPropertyEditor(TypeInfo(widestring),  TWmiDiskQuotaControl, 'FilterVolume', TLogicalDiskProperty);
  RegisterPropertyEditor(TypeInfo(widestring),  TWmiDiskQuota, 'Limit', TDiskLimitProperty);
  RegisterPropertyEditor(TypeInfo(widestring),  TWmiDiskQuota, 'WarningLimit', TDiskLimitProperty);
  RegisterPropertyEditor(TypeInfo(widestring),  TWmiQuotaSetting, 'DefaultWarningLimit', TDiskLimitProperty);
  RegisterPropertyEditor(TypeInfo(widestring),  TWmiQuotaSetting, 'DefaultLimit', TDiskLimitProperty);

  RegisterPropertyEditor(TypeInfo(DWORD),  TWmiRegistry, 'RootKey', TRootKeyProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),  TWmiRegistry, 'ValueType', TRegValueTypeProperty);
  RegisterPropertyEditor(TypeInfo(WideString),  TWmiRegistry, 'ValueName', TRegValueNameProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),  TWmiRegistry, 'KeyAccess', TRegAccessAsSetProperty);
  RegisterPropertyEditor(TypeInfo(WideString),  TWmiRegistry, 'CurrentPath', TRegCurrentPathProperty);

  RegisterPropertyEditor(TypeInfo(byte),  TWmiOs, 'ForegroundApplicationBoost', TOsAppBoostProperty);
  RegisterPropertyEditor(TypeInfo(word),  TWmiOs, 'OSType', TOsTypeProperty);
  RegisterPropertyEditor(TypeInfo(byte),  TWmiOs, 'QuantumLength', TOsQuantumLengthProperty);
  RegisterPropertyEditor(TypeInfo(byte),  TWmiOs, 'QuantumType', TOsQuantumTypeProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),  TWmiOs, 'SuiteMask', TOsSuiteMaskAsSetProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),  TWmiOs, 'LargeSystemCache', TOsLargeSysCacheProperty);
  RegisterPropertyEditor(TypeInfo(DWORD),  TWmiOs, 'ProductType', TOsAppBoostProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TWmiMethod, 'WmiMethodName', TMethodNameProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TWmiConnection, 'ObjectPath', TObjectPathProperty);

  RegisterComponentEditor(TWmiMethod, TWmiMethodExecuteProperty);

  {$IFDEF Delphi6}
  RegisterPropertyEditor(TypeInfo(TWmiEntityList), nil, '', TWmiEntityListCollectionProperty);
  RegisterPropertyEditor(TypeInfo(TWmiParams), TWmiMethod, 'OutParams', TReadOnlyCollectionProperty);
  RegisterPropertyEditor(TypeInfo(TWmiQualifiers), TWmiMethod, 'WmiMethodQualifiers', TReadOnlyCollectionProperty);
  {$ENDIF}


end;



{ TStringPropertyCache }

constructor TStringPropertyCache.Create;
begin
  inherited;
  FCache := TStringList.Create;
  FCache.Sorted := true;
end;

destructor TStringPropertyCache.Destroy;
var
  i: integer;
begin
  for i := 0 to FCache.Count -1 do FCache.Objects[i].Free;
  FCache.Free;
  inherited;
end;

procedure TStringPropertyCache.GetCache(AMachineName, AKeyWord: string; AList: TStrings);
var
  vIndex: integer;
  vList: TStringList;
begin
  vIndex := FCache.IndexOf(AMachineName+AKeyWord);
  if vIndex >= 0 then
  begin
    vList := TStringList(FCache.Objects[vIndex]);
    AList.Text := vList.Text;
  end;
end;

function TStringPropertyCache.HasCache(AMachineName, AKeyWord: string): boolean;
begin
  Result := FCache.IndexOf(AMachineName+AKeyWord) >= 0;
end;

procedure TStringPropertyCache.PutChache(AMachineName, AKeyWord: string;
  AList: TStrings);
var
  vIndex: integer;
  vList: TStringList;
begin
  vIndex := FCache.IndexOf(AMachineName+AKeyWord);
  if vIndex >= 0 then
  begin
    vList := TStringList(FCache.Objects[vIndex]);
  end else
  begin
    vList := TStringList.Create;
    FCache.AddObject(AMachineName+AKeyWord, vList);
  end;
  vList.Text := AList.Text;
end;

initialization
  PropertyCache := TStringPropertyCache.Create;

finalization
  PropertyCache.Free;


end.




