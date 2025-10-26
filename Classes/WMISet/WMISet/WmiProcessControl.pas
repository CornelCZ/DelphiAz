unit WmiProcessControl;

interface
{$I ..\Common\define.inc}

{$NOINCLUDE WbemScripting_TLB}
{$HPPEMIT '#include <wbemdisp.h>'}
{$HPPEMIT '#include <oaidl.h>'}
{$HPPEMIT '#include "wbem_script_support.h"'}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  WmiAbstract, WbemScripting_TLB, 
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  ActiveX, ComObj, WmiErr, WmiUtil, WmiComponent;

const
  DEFAULT_VALUE = -1;

  // constants for PriorityClass property.
  PRIORITY_NORMAL       = 32;
  PRIORITY_IDLE         = 64;
  PRIORITY_HIGH         = 128;
  PRIORITY_REALTIME     = 256;
  PRIORITY_ABOVE_NORMAL = 16384;
  PRIORITY_BELOW_NORMAL = 32768;

  // Constants for ErrorMode property
  FAIL_CRITICAL_ERRORS      = 1;
  NO_ALIGNMENT_FAULT_EXCEPT = 2;
  NO_GP_FAULT_ERROR_BOX     = 4;
  NO_OPEN_FILE_ERROR_BOX    = 8;

  // Constants for FillAttribute property
  {$EXTERNALSYM FOREGROUND_BLUE}
  FOREGROUND_BLUE           = $01;
  {$EXTERNALSYM FOREGROUND_GREEN}
  FOREGROUND_GREEN          = $02;
  {$EXTERNALSYM FOREGROUND_RED}
  FOREGROUND_RED            = $04;
  {$EXTERNALSYM FOREGROUND_INTENSITY}
  FOREGROUND_INTENSITY      = $08;
  {$EXTERNALSYM BACKGROUND_BLUE}
  BACKGROUND_BLUE           = $10;
  {$EXTERNALSYM BACKGROUND_GREEN}
  BACKGROUND_GREEN          = $20;
  {$EXTERNALSYM BACKGROUND_RED}
  BACKGROUND_RED            = $40;
  {$EXTERNALSYM BACKGROUND_INTENSITY}
  BACKGROUND_INTENSITY      = $80;

resourcestring
  PROCESS_TERMINATED  = 'The process with ID %u has been terminated';
  PROCESS_NOT_FOUND   = 'Process with ID %u not found';

type
  TWmiProcessEvent = procedure(Sender: TObject; ProcessId: dword; ExecutablePath: widestring) of object;

  TCardinalArray = array of cardinal;
  TWmiProcessControl = class;
  TWmiProcess = class;
  TWmiProcessList = class;
  TWmiProcessStartupInfo = class;

  TWmiProcessStartupInfo = class(TPersistent)
  private
    FY: integer;
    FErrorMode: DWORD;
    FXSize: integer;
    FX: integer;
    FYSize: integer;
    FShowWindow: DWORD;
    FXCountChars: integer;
    FYCountChars: integer;
    FCreateFlags: DWORD;
    FPriorityClass: DWORD;
    FFillAttribute: DWORD;
    FWinstationDesktop: widestring;
    FTitle: widestring;
    FEnvironmentVariables: TStrings;
    procedure SetEnvironmentVariables(const Value: TStrings);
    procedure SetShowWindow(const Value: DWORD);
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property CreateFlags: DWORD read FCreateFlags write FCreateFlags;
    property EnvironmentVariables: TStrings read FEnvironmentVariables write SetEnvironmentVariables;
    property ErrorMode: DWORD read FErrorMode write FErrorMode;
    property FillAttribute: DWORD read FFillAttribute write FFillAttribute;
    property PriorityClass: DWORD read FPriorityClass write FPriorityClass default PRIORITY_NORMAL;
    property ShowWindow: DWORD read FShowWindow write SetShowWindow default SW_NORMAL;
    property Title: widestring read FTitle write FTitle;
    property WinstationDesktop: widestring read FWinstationDesktop write FWinstationDesktop;
    property X: integer read FX write FX default DEFAULT_VALUE;
    property XCountChars: integer read FXCountChars write FXCountChars default DEFAULT_VALUE;
    property XSize: integer read FXSize write FXSize default DEFAULT_VALUE;
    property Y: integer read FY write FY default DEFAULT_VALUE;
    property YCountChars: integer read FYCountChars write FYCountChars default DEFAULT_VALUE;
    property YSize: integer read FYSize write FYSize default DEFAULT_VALUE;
  end;

  TWmiProcess = class(TWmiEntity)
  private
    FTerminated: boolean;

    FHandle: THandle;
    FMinWorkingSetSize: cardinal;
    FKernelModeTime: int64;
    FHandleCount: cardinal;
    FMaxWorkingSetSize: cardinal;
    FCreationDate: TDateTime;
    FCaption: widestring;
    FExecutablePath: widestring;
    FDescription: widestring;
    FName: widestring;
    FPageFileUsage: cardinal;
    FQuotaNonPagePoolUsage: cardinal;
    FPageFaults: cardinal;
    FPrivatePageCount: cardinal;
    FPeakPageFileUsage: cardinal;
    FReadOperationCount: int64;
    FProcessId: cardinal;
    FReadTransferCount: int64;
    FParentProcessId: cardinal;
    FQuotaPeakPagePoolUsage: cardinal;
    FPeakWorkingSetSize: cardinal;
    FSessionId: cardinal;
    FUserModeTime: int64;
    FPriority: cardinal;
    FOtherTransferCount: int64;
    FQuotaPeakNonPagePoolUsage: cardinal;
    FOtherOperationCount: int64;
    FWriteOperationCount: int64;
    FWriteTransferCount: int64;
    FQuotaPagePoolUsage: cardinal;
    FPeakVirtualSize: cardinal;
    FWorkingSetSize: cardinal;
    FThreadCount: cardinal;
    procedure SetHandle(const Value: THandle);
    procedure SetCaption(const Value: widestring);
    procedure SetCreationDate(const Value: TDateTime);
    procedure SetDescription(const Value: widestring);
    procedure SetExecutablePath(const Value: widestring);
    procedure SetKernelModeTime(const Value: int64);
    procedure SetMaxWorkingSetSize(const Value: cardinal);
    procedure SetMinWorkingSetSize(const Value: cardinal);
    procedure SetName(const Value: widestring);
    procedure SetHandleCount(const Value: cardinal);
    procedure SetOtherOperationCount(const Value: int64);
    procedure SetOtherTransferCount(const Value: int64);
    procedure SetPageFaults(const Value: cardinal);
    procedure SetPageFileUsage(const Value: cardinal);
    procedure SetParentProcessId(const Value: cardinal);
    procedure SetPeakPageFileUsage(const Value: cardinal);
    procedure SetPeakVirtualSize(const Value: cardinal);
    procedure SetPeakWorkingSetSize(const Value: cardinal);
    procedure SetPriority(const Value: cardinal);
    procedure SetPrivatePageCount(const Value: cardinal);
    procedure SetProcessId(const Value: cardinal);
    procedure SetQuotaNonPagePoolUsage(const Value: cardinal);
    procedure SetQuotaPagePoolUsage(const Value: cardinal);
    procedure SetQuotaPeakNonPagePoolUsage(const Value: cardinal);
    procedure SetQuotaPeakPagePoolUsage(const Value: cardinal);
    procedure SetReadOperationCount(const Value: int64);
    procedure SetReadTransferCount(const Value: int64);
    procedure SetSessionId(const Value: cardinal);
    procedure SetThreadCount(const Value: cardinal);
    procedure SetUserModeTime(const Value: int64);
    procedure SetWorkingSetSize(const Value: cardinal);
    procedure SetWriteOperationCount(const Value: int64);
    procedure SetWriteTransferCount(const Value: int64);
    function  GetTerminated: boolean;
  protected
    {$HINTS OFF} {$WARNINGS OFF}
    constructor Create(AOwner: TWmiEntityList); reintroduce;
    {$WARNINGS ON} {$HINTS ON}
    function    GetDisplayName: string; override;
    procedure   LoadProperties(AProcess: ISWbemObject); override;
    property    Terminated: boolean read GetTerminated;
  public
    procedure   Terminate(AReason: cardinal);
    function    GetOwnerSid: widestring;
    procedure   GetProcessOwner(var UserName: widestring; var DomainName: widestring);
    procedure   Refresh; override;
  published
    property Handle: THandle read FHandle write SetHandle;
    property Caption: widestring read FCaption write SetCaption;
    property CreationDate: TDateTime read FCreationDate write SetCreationDate;
    property Description: widestring read FDescription write SetDescription;
    property ExecutablePath: widestring read FExecutablePath write SetExecutablePath;
    property HandleCount: cardinal read FHandleCount write SetHandleCount;
    property KernelModeTime: int64 read FKernelModeTime write SetKernelModeTime;
    property MaxWorkingSetSize: cardinal read FMaxWorkingSetSize write SetMaxWorkingSetSize;
    property MinWorkingSetSize: cardinal read FMinWorkingSetSize write SetMinWorkingSetSize;
    property Name: widestring read FName write SetName;
    property OtherOperationCount: int64 read FOtherOperationCount write SetOtherOperationCount;
    property OtherTransferCount: int64 read FOtherTransferCount write SetOtherTransferCount;
    property PageFaults: cardinal read FPageFaults write SetPageFaults;
    property PageFileUsage: cardinal read FPageFileUsage write SetPageFileUsage;
    property ParentProcessId: cardinal read FParentProcessId write SetParentProcessId;
    property PeakPageFileUsage: cardinal read FPeakPageFileUsage write SetPeakPageFileUsage;
    property PeakVirtualSize: cardinal read FPeakVirtualSize write SetPeakVirtualSize;
    property PeakWorkingSetSize: cardinal read FPeakWorkingSetSize write SetPeakWorkingSetSize;
    property Priority: cardinal read FPriority write SetPriority;
    property PrivatePageCount: cardinal read FPrivatePageCount write SetPrivatePageCount;
    property ProcessId: cardinal read FProcessId write SetProcessId;
    property QuotaNonPagePoolUsage: cardinal read FQuotaNonPagePoolUsage write SetQuotaNonPagePoolUsage;
    property QuotaPagePoolUsage: cardinal read FQuotaPagePoolUsage write SetQuotaPagePoolUsage;
    property QuotaPeakNonPagePoolUsage: cardinal read FQuotaPeakNonPagePoolUsage write SetQuotaPeakNonPagePoolUsage;
    property QuotaPeakPagePoolUsage: cardinal read FQuotaPeakPagePoolUsage write SetQuotaPeakPagePoolUsage;
    property ReadOperationCount: int64 read FReadOperationCount write SetReadOperationCount;
    property ReadTransferCount: int64 read FReadTransferCount write SetReadTransferCount;
    property SessionId: cardinal read FSessionId write SetSessionId;
    property ThreadCount: cardinal read FThreadCount write SetThreadCount;
    property UserModeTime: int64 read FUserModeTime write SetUserModeTime;
    property WorkingSetSize: cardinal read FWorkingSetSize write SetWorkingSetSize;
    property WriteOperationCount: int64 read FWriteOperationCount write SetWriteOperationCount;
    property WriteTransferCount: int64 read FWriteTransferCount write SetWriteTransferCount;
  end;

  TWmiProcessList = class(TWmiEntityList)
  private
    function  GetItem(AIndex: integer): TWmiProcess;
    procedure SetItem(AIndex: integer; const Value: TWmiProcess);
    procedure CreateProcessWithPrompt(AProcess: TWmiProcess);
  protected
    {$IFDEF Delphi6}
    procedure   Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
    {$ENDIF}
    function    FindProcessById(AProcessId: cardinal): ISWbemObject;
    class function  FindProcessByProcessId(
                WmiServices: ISWbemServices;
                AProcessId: cardinal): ISWbemObject;
    class procedure CreateProcess(
                WmiServices: ISWbemServices;
                ACommandLile: widestring;
                ACurrentDir: widestring;
                AStartupInfo: TWmiProcessStartupInfo;
                var AProcessId: cardinal);
    class procedure TerminateProcess(
                WmiServices: ISWbemServices;
                AProcessId: cardinal;
                AReason: cardinal);
    class function FindProcessByName(
                WmiServices: ISWbemServices;
                AName: widestring): TCardinalArray;
  public
    function Add(ACommandLine: widestring; ACurrentDir: widestring; UseStartupInfo: boolean): TWmiProcess; overload;
    function FindByName(AName: widestring): TWmiProcess;
    property Items[AIndex: integer]: TWmiProcess read GetItem write SetItem; default;
  end;

  TWmiProcessControl = class(TWmiComponent)
  private
    FProcesses: TWmiProcessList;
    FStartupInfo: TWmiProcessStartupInfo;

    FOnProcessStarted: TWmiProcessEvent;
    FOnProcessStopped: TWmiProcessEvent;

    function  GetProcesses: TWmiProcessList;
    procedure SetProcesses(const Value: TWmiProcessList);
    procedure LoadProcesses;
    procedure SetStartupInfo(const Value: TWmiProcessStartupInfo);

    procedure ProcessStarted(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure ProcessStopped(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure FireProcessEvent(Sender: TObject; Event: OleVariant; EventHandler: TWmiProcessEvent);
  protected
    procedure CredentialsOrTargetChanged; override;
    procedure RegisterEvents; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function    StartProcess(ACommandLine, ACurrentDir: widestring; UseStartupInfo: boolean): cardinal;
    function    FindProcessByName(AProcessName: widestring): TCardinalArray;
    procedure   TerminateProcess(AProcessID, AReason: cardinal);
    procedure   Refresh; 
  published
    property    Active;
    property    Credentials;
    property    MachineName;
    property    SystemInfo;
    property    Processes: TWmiProcessList read GetProcesses write SetProcesses stored false;
    property    StartupInfo: TWmiProcessStartupInfo read FStartupInfo write SetStartupInfo;

    property    OnProcessStarted: TWmiProcessEvent read FOnProcessStarted write FOnProcessStarted;
    property    OnProcessStopped: TWmiProcessEvent read FOnProcessStopped write FOnProcessStopped; 
  end;

implementation

Uses FrmStartProcessU;

const
  // WQL queries to work with processes
  QUERY_GET_PROCESS_WITH_HANDLE    = 'Win32_Process.Handle="%u"';
  QUERY_SELECT_PROCESSES           = 'select * from Win32_Process';
  QUERY_FIND_PROCESSID_BY_NAME     = 'select ProcessId from Win32_Process where name="%s"';
  QUERY_FIND_PROCESS_BY_PROCESSID  = 'select * from Win32_Process where ProcessId="%u"';
  QUERY_EVENT_PROCESS_STARTED      = 'SELECT * FROM __InstanceCreationEvent '+
                                     'WITHIN %f '+
                                     'WHERE TargetInstance ISA "Win32_Process"';

  QUERY_EVENT_PROCESS_STOPPED      = 'SELECT * FROM __InstanceDeletionEvent '+
                                     'WITHIN %f '+
                                     'WHERE TargetInstance ISA "Win32_Process"';

// the function returns descriptions for error codes that are
// specific to Win32_Process  class. 
function ErrorFunction(AErrorCode: integer): widestring;
begin
  case AErrorCode of
    0: Result := 'Successful completion';
    2: Result := 'The user does not have access to the requested information.';
    3: Result := 'The user does not have sufficient privilege.';
    8: Result := 'Unknown failure.';
    9: Result := 'The path specified does not exist.';
    21: Result := 'The specified parameter is invalid.';
    else Result := SysErrorMessage(AErrorCode);
  end;
  Result := IntToStr(AErrorCode) + ': ' + Result;
end;


{ TWmiProcessControl }

procedure TWmiProcessControl.CredentialsOrTargetChanged;
begin
  inherited;
  FProcesses.ClearEntities;
end;

constructor TWmiProcessControl.Create(AOwner: TComponent);
begin
  inherited;
  FProcesses := TWmiProcessList.Create(self, TWmiProcess, false);
  FStartupInfo := TWmiProcessStartupInfo.Create;
end;

destructor TWmiProcessControl.Destroy;
begin
  FreeAndNil(FProcesses);
  FreeAndNil(FStartupInfo);
  inherited;
end;

procedure TWmiProcessControl.RegisterEvents; 
begin
  ClearEventList;
  if (not IsDesignTime) and Active then
  begin
    RegisterEvent(QUERY_EVENT_PROCESS_STARTED, ProcessStarted, 'Win32_ProcessStartTrace');
    RegisterEvent(QUERY_EVENT_PROCESS_STOPPED, ProcessStopped, 'Win32_ProcessStopTrace');
  end;
end;

procedure TWmiProcessControl.ProcessStarted(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
begin
  FireProcessEvent(Sender, Event, FOnProcessStarted);
end;

procedure TWmiProcessControl.ProcessStopped(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
begin
  FireProcessEvent(Sender, Event, FOnProcessStopped);
end;

procedure TWmiProcessControl.FireProcessEvent(Sender: TObject; Event: OleVariant; EventHandler: TWmiProcessEvent);
var
  vEvent:     ISWbemObject;
  vProcess:   ISWbemObject;
  vProperty:  ISWbemProperty;

  vProcessId: DWORD;
  vExecutablePath: widestring;
begin
  if Assigned(EventHandler) then
  begin
    vEvent     := IUnknown(Event) as ISWbemObject;
    vProperty  := WmiGetObjectProperty(vEvent, 'TargetInstance');
    vProcess   := IUnknown(WmiGetVariantPropertyValue(vProperty)) as ISWbemObject;

    vProperty  := WmiGetObjectProperty(vProcess, 'ProcessId');
    vProcessId := WmiGetIntegerPropertyValue(vProperty);
    vProperty  := WmiGetObjectProperty(vProcess, 'ExecutablePath');
    vExecutablePath := WmiGetStringPropertyValue(vProperty);
    EventHandler(self, vProcessId, vExecutablePath);
  end;
end;

procedure TWmiProcessControl.LoadProcesses;
var
  vEnum: IEnumVariant;
  vOleVar: OleVariant;
  vWmiObject: ISWbemObject;
  vFetchedCount: cardinal;
  vProcess: TWmiProcess;
begin
  FProcesses.ClearEntities;
  if Active then
  begin
    vEnum := ExecSelectQuery(QUERY_SELECT_PROCESSES);
    while (vEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
    begin
      vWmiObject := IUnknown(vOleVar) as SWBemObject;
      vOleVar    := Unassigned;
      vProcess  := TWmiProcess.Create(FProcesses);
      vProcess.LoadProperties(vWmiObject);
    end;
    vEnum := nil;
  end;
end;

(*
procedure TWmiProcessControl.LoadProcessProperties(AWmiObject: ISWbemObject; AProcess: TWmiProcess);
var
  vPropEnum: IEnumVariant;
  vOleVar: OleVariant;
  vFetchedCount: cardinal;
  vProp: SWBemProperty;
  vPropName: widestring;
begin
  vPropEnum := (AWmiObject.Properties_._NewEnum) as IEnumVariant;
  while (vPropEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
  begin
    vProp   := IUnknown(vOleVar) as SWBemProperty;
    vOleVar := Unassigned;
    if VarIsNull(vProp.Get_Value) then Continue;
    vPropName := UpperCase(vProp.Name);

    if vPropName = 'CAPTION' then AProcess.FCaption := vProp.Get_Value else
    if vPropName = 'CREATIONDATE' then AProcess.FCreationDate := ParseDate(vProp.Get_Value) else
    if vPropName = 'DESCRIPTION' then AProcess.FDescription := vProp.Get_Value else
    if vPropName = 'EXECUTABLEPATH' then AProcess.FExecutablePath := vProp.Get_Value else
    if vPropName = 'HANDLE' then AProcess.FHandle := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'HANDLECOUNT' then AProcess.FHandleCount := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'KERNELMODETIME' then AProcess.FKernelModeTime := VariantToInt64(vProp.Get_Value) else
    if vPropName = 'MAXIMUMWORKINGSETSIZE' then AProcess.FMaxWorkingSetSize := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'MINIMUMWORKINGSETSIZE' then AProcess.FMinWorkingSetSize := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'NAME' then AProcess.FName := vProp.Get_Value else
    if vPropName = 'OTHEROPERATIONCOUNT' then AProcess.FOtherOperationCount := VariantToInt64(vProp.Get_Value) else
    if vPropName = 'OTHERTRANSFERCOUNT' then AProcess.FOtherTransferCount := VariantToInt64(vProp.Get_Value) else
    if vPropName = 'PAGEFAULTS' then AProcess.FPageFaults := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'PAGEFILEUSAGE' then AProcess.FPageFileUsage := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'PARENTPROCESSID' then AProcess.FParentProcessId := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'PEAKPAGEFILEUSAGE' then AProcess.FPeakPageFileUsage := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'PEAKVIRTUALSIZE' then AProcess.FPeakVirtualSize := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'PEAKWORKINGSETSIZE' then AProcess.FPeakWorkingSetSize := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'PRIORITY' then AProcess.FPriority := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'PRIVATEPAGECOUNT' then AProcess.FPrivatePageCount := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'PROCESSID' then AProcess.FProcessId := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'QUOTANONPAGEDPOOLUSAGE' then AProcess.FQuotaNonPagePoolUsage := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'QUOTAPAGEDPOOLUSAGE' then AProcess.FQuotaPagePoolUsage := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'QUOTAPEAKNONPAGEDPOOLUSAGE' then AProcess.FQuotaPeakNonPagePoolUsage := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'QUOTAPEAKPAGEDPOOLUSAGE' then AProcess.FQuotaPeakPagePoolUsage := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'READOPERATIONCOUNT' then AProcess.FReadOperationCount := VariantToInt64(vProp.Get_Value) else
    if vPropName = 'READTRANSFERCOUNT' then AProcess.FReadTransferCount := VariantToInt64(vProp.Get_Value) else
    if vPropName = 'SESSIONID' then AProcess.FSessionId := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'THREADCOUNT' then AProcess.FThreadCount := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'USERMODETIME' then AProcess.FUserModeTime := VariantToInt64(vProp.Get_Value) else
    if vPropName = 'WORKINGSETSIZE' then AProcess.FWorkingSetSize := VariantToCardinal(vProp.Get_Value) else
    if vPropName = 'WRITEOPERATIONCOUNT' then AProcess.FWriteOperationCount := VariantToInt64(vProp.Get_Value) else
    if vPropName = 'WRITETRANSFERCOUNT' then AProcess.FWriteTransferCount := VariantToInt64(vProp.Get_Value);
  end;
end;
*)

function TWmiProcessControl.GetProcesses: TWmiProcessList;
begin
  if Active then
  begin
    if FProcesses.Count = 0 then LoadProcesses;
  end else
  begin
    FProcesses.ClearEntities;
  end;

  Result := FProcesses;
end;

procedure TWmiProcessControl.SetProcesses(const Value: TWmiProcessList);begin end;

function TWmiProcessControl.StartProcess(ACommandLine,
  ACurrentDir: widestring;
  UseStartupInfo: boolean): cardinal;
var
  vStartupInfo: TWmiProcessStartupInfo;
begin
  if not Active then RaiseNotActiveException;

  if UseStartupInfo then vStartupInfo := StartupInfo
    else  vStartupInfo := nil;
  TWmiProcessList.CreateProcess(
                               WmiServices,
                               ACommandLine,
                               ACurrentDir,
                               vStartupInfo,
                               Result);
end;

function TWmiProcessControl.FindProcessByName(
  AProcessName: widestring): TCardinalArray;
begin
  if not Active then RaiseNotActiveException;
  Result := TWmiProcessList.FindProcessByName(WmiServices, AProcessName);
end;

procedure TWmiProcessControl.TerminateProcess(AProcessID, AReason: cardinal);
begin
  if not Active then RaiseNotActiveException;
  TWmiProcessList.TerminateProcess(WmiServices, AProcessId, AReason);
end;

procedure TWmiProcessControl.Refresh;
begin
  FProcesses.ClearEntities;
end;

procedure TWmiProcessControl.SetStartupInfo(const Value: TWmiProcessStartupInfo);begin end;

{ TWmiProcess }

constructor TWmiProcess.Create(AOwner: TWmiEntityList);
begin
  inherited Create(AOwner, true, TWmiProcessList);
end;

function TWmiProcess.GetDisplayName: string;
begin
  Result := Name;
  if Result = '' then Result := inherited GetDisplayName; 
end;

procedure TWmiProcess.GetProcessOwner(var UserName, DomainName: widestring);
var
  vProcessObj:      ISWbemObject;
  vQuery:           widestring;
  outParams:        ISWbemObject;
  vValue:           OleVariant;
begin
  vQuery := Format(QUERY_GET_PROCESS_WITH_HANDLE, [Handle]);
  WmiCheck(WMIServices.Get(vQuery, 0, nil, vProcessObj));
  outParams := WmiExecObjectMethod(vProcessObj, 'GetOwner', ErrorFunction);

  WmiCheck(WmiGetObjectProperty(outParams, 'User').Get_Value(vValue));
  UserName    := vValue; 
  WmiCheck(WmiGetObjectProperty(outParams, 'Domain').Get_Value(vValue));
  DomainName  := vValue;
end;

function TWmiProcess.GetOwnerSid: widestring;
var
  vProcessObj:      ISWbemObject;
  vQuery:           widestring;
  outParams:        ISWbemObject;
  vValue:           OleVariant;
begin
  vQuery := Format(QUERY_GET_PROCESS_WITH_HANDLE, [Handle]);
  WmiCheck(WMiServices.Get(vQuery, 0, nil, vProcessObj));
  outParams := WmiExecObjectMethod(vProcessObj, 'GetOwnerSid', ErrorFunction);

  WmiCheck(WmiGetObjectProperty(outParams, 'Sid').Get_Value(vValue));
  result    := vValue; 
end;

function TWmiProcess.GetTerminated: boolean;
begin
  Result := FTerminated;
end;

// these are setters for read-only ptoperties
procedure TWmiProcess.SetCaption(const Value: widestring);begin end;
procedure TWmiProcess.SetCreationDate(const Value: TDateTime);begin end;
procedure TWmiProcess.SetDescription(const Value: widestring);begin end;
procedure TWmiProcess.SetExecutablePath(const Value: widestring);begin end;
procedure TWmiProcess.SetHandle(const Value: THandle);begin end;
procedure TWmiProcess.SetHandleCount(const Value: cardinal);begin end;
procedure TWmiProcess.SetKernelModeTime(const Value: int64);begin end;
procedure TWmiProcess.SetMaxWorkingSetSize(const Value: cardinal);begin end;
procedure TWmiProcess.SetMinWorkingSetSize(const Value: cardinal);begin end;
procedure TWmiProcess.SetName(const Value: widestring);begin end;
procedure TWmiProcess.SetOtherOperationCount(const Value: int64);begin end;
procedure TWmiProcess.SetOtherTransferCount(const Value: int64);begin end;
procedure TWmiProcess.SetPageFaults(const Value: cardinal);begin end;
procedure TWmiProcess.SetPageFileUsage(const Value: cardinal);begin end;
procedure TWmiProcess.SetParentProcessId(const Value: cardinal);begin end;
procedure TWmiProcess.SetPeakPageFileUsage(const Value: cardinal);begin end;
procedure TWmiProcess.SetPeakVirtualSize(const Value: cardinal);begin end;
procedure TWmiProcess.SetPeakWorkingSetSize(const Value: cardinal);begin end;
procedure TWmiProcess.SetPriority(const Value: cardinal);begin end;
procedure TWmiProcess.SetPrivatePageCount(const Value: cardinal);begin end;
procedure TWmiProcess.SetProcessId(const Value: cardinal);begin end;
procedure TWmiProcess.SetQuotaNonPagePoolUsage(const Value: cardinal);begin end;
procedure TWmiProcess.SetQuotaPagePoolUsage(const Value: cardinal);begin end;
procedure TWmiProcess.SetQuotaPeakNonPagePoolUsage(const Value: cardinal);begin end;
procedure TWmiProcess.SetQuotaPeakPagePoolUsage(const Value: cardinal);begin end;
procedure TWmiProcess.SetReadOperationCount(const Value: int64);begin end;
procedure TWmiProcess.SetReadTransferCount(const Value: int64);begin end;
procedure TWmiProcess.SetSessionId(const Value: cardinal);begin end;
procedure TWmiProcess.SetThreadCount(const Value: cardinal);begin end;
procedure TWmiProcess.SetUserModeTime(const Value: int64);begin end;
procedure TWmiProcess.SetWorkingSetSize(const Value: cardinal);begin end;
procedure TWmiProcess.SetWriteOperationCount(const Value: int64);begin end;
procedure TWmiProcess.SetWriteTransferCount(const Value: int64);begin end;

procedure TWmiProcess.Terminate(AReason: cardinal);
begin
  TWmiProcessControl(TWmiProcessList(GetOwner).GetOwner).TerminateProcess(ProcessId, AReason);
end;

procedure TWmiProcess.Refresh;
var
  vProcessObj:      ISWbemObject;
  vOldCreationDate: TDateTime;
begin
  vOldCreationDate := CreationDate;
  vProcessObj := TWmiProcessList(GetOwner).FindProcessById(FProcessId);
  if vProcessObj = nil then
    raise TWmiException.Create(Format(PROCESS_TERMINATED, [FProcessId]));

  LoadProperties(vProcessObj);
  // process IDs may be reused. Check that it is still the same process.
  if vOldCreationDate <> CreationDate then
    raise TWmiException.Create(Format(PROCESS_TERMINATED, [FProcessId]));

end;

{ TWmiProcessList }

class procedure TWmiProcessList.CreateProcess(
        WmiServices: ISWbemServices;
        ACommandLile,
        ACurrentDir: widestring;
        AStartupInfo: TWmiProcessStartupInfo;
        var AProcessId: cardinal);
var
  vProcessClass:    ISWbemObject;
  inParams, outParams: ISWbemObject;
  vProperty:        ISWbemProperty;
  vStartupInfo:      ISWbemObject;
  vVarArray:        variant;
  vValue:           OleVariant;
  i: integer;
begin
  WmiCheck(WMiServices.Get('Win32_Process', 0, nil, vProcessClass));
  inParams  := WmiCreateClassMethodParameters(vProcessClass, 'Create');
  WmiSetStringParameter(inParams, 'CommandLine', ACommandLile);
  WmiSetStringParameter(inParams, 'CurrentDirectory', ACurrentDir);
  if AStartupInfo <> nil then
  begin
    WmiCheck(WMiServices.Get('Win32_ProcessStartup', 0, nil, vStartupInfo));
    if AStartupInfo.CreateFlags <> 0 then 
      WmiSetDWORDPropertyValue(vStartupInfo, 'CreateFlags', AStartupInfo.CreateFlags); 
    if AStartupInfo.EnvironmentVariables.Count > 0 then
    begin
      vVarArray := VarArrayCreate([0, AStartupInfo.EnvironmentVariables.Count - 1], varOleStr);
      for i := 0 to AStartupInfo.EnvironmentVariables.Count - 1 do
        vVarArray[i] := AStartupInfo.EnvironmentVariables[i];
      WmiSetObjectPropertyValue(vStartupInfo, 'EnvironmentVariables', vVarArray);
    end;

    WmiSetDWORDPropertyValue(vStartupInfo, 'ErrorMode', AStartupInfo.ErrorMode); 

    if AStartupInfo.FillAttribute <> 0 then
      WmiSetDWORDPropertyValue(vStartupInfo, 'FillAttribute', AStartupInfo.FillAttribute); 
    WmiSetDWORDPropertyValue(vStartupInfo, 'PriorityClass', AStartupInfo.PriorityClass); 
    WmiSetDWORDPropertyValue(vStartupInfo, 'ShowWindow', AStartupInfo.ShowWindow); 
    if Trim(AStartupInfo.Title) <> '' then
      WmiSetStringPropertyValue(vStartupInfo, 'Title', AStartupInfo.Title);
    if Trim(AStartupInfo.WinstationDesktop) <> '' then
      WmiSetStringPropertyValue(vStartupInfo, 'WinstationDesktop', AStartupInfo.WinstationDesktop);
    if AStartupInfo.X <> DEFAULT_VALUE then WmiSetIntegerPropertyValue(vStartupInfo, 'X', AStartupInfo.X);
    if AStartupInfo.XCountChars <> DEFAULT_VALUE then WmiSetIntegerPropertyValue(vStartupInfo, 'XCountChars', AStartupInfo.XCountChars);
    if AStartupInfo.XSize <> DEFAULT_VALUE then  WmiSetIntegerPropertyValue(vStartupInfo, 'XSize', AStartupInfo.XSize);
    if AStartupInfo.Y <> DEFAULT_VALUE then  WmiSetIntegerPropertyValue(vStartupInfo, 'Y', AStartupInfo.Y);
    if AStartupInfo.YCountChars <> DEFAULT_VALUE then WmiSetIntegerPropertyValue(vStartupInfo, 'YCountChars', AStartupInfo.YCountChars);
    if AStartupInfo.YSize <> DEFAULT_VALUE then  WmiSetIntegerPropertyValue(vStartupInfo, 'YSize', AStartupInfo.YSize);

    WmiSetObjectParameter(inParams,   'ProcessStartupInformation', vStartupInfo);
  end;

  outParams := WmiExecObjectMethod(vProcessClass, 'Create', inParams, ErrorFunction);
  vProperty := WmiGetObjectProperty(outParams, 'ProcessID');
  WmiCheck(vProperty.Get_Value(vValue));
  AProcessId := vValue;
end;

function TWmiProcessList.Add(ACommandLine,
  ACurrentDir: widestring;
  UseStartupInfo: boolean): TWmiProcess;
var
  vProcess:         ISWbemObject;
  vProcessId:       cardinal;
  vStartupInfo:     TWmiProcessStartupInfo;
begin
  if not Active then RaiseNotActiveException;

  if UseStartupInfo then vStartupInfo := TWmiProcessControl(GetOwner).StartupInfo
    else  vStartupInfo := nil;

  CreateProcess(WMIServices,
                ACommandLine,
                ACurrentDir,
                vStartupInfo,
                vProcessId);
  vProcess := FindProcessById(vProcessId);
  if vProcess = nil then
    raise TWmiException.Create(Format(PROCESS_NOT_FOUND, [vProcessId]));
  Result := TWmiProcess.Create(self);
  Result.LoadProperties(vProcess);
end;

function TWmiProcessList.GetItem(AIndex: integer): TWmiProcess;
begin
  Result := TWmiProcess(inherited GetItem(AIndex));
end;

procedure TWmiProcessList.SetItem(AIndex: integer;
  const Value: TWmiProcess);
begin
  inherited SetItem(AIndex, Value);
end;

procedure TWmiProcessList.CreateProcessWithPrompt(AProcess: TWmiProcess);
var
  vProcessObj:      ISWbemObject;
  vProcessId:       cardinal;
  vForm:            TFrmStartProcess;
begin
  if not Active then RaiseNotActiveException;

  // the item has been added using TCollection.Add.
  // It represents new procces. There is a number of settings for
  // new process that are required. Show dialog and ask for values.
  // If user cancels action - do not add item.
  vForm := TFrmStartProcess.Create(nil);
  try
    if vForm.ShowModal = mrOk then
    begin
      // start process and obtain its properties
      CreateProcess(WMiServices,
                    vForm.edtCommandLine.Text,
                    vForm.edtStartDirectory.Text,
                    nil,
                    vProcessId);
      vProcessObj := FindProcessById(vProcessId);
      if vProcessObj = nil then Abort;

      // set properties that should have been set
      // with the protected constructor
      AProcess.InternallyCreated := true;
      Aprocess.Owner    := self;

      AProcess.LoadProperties(vProcessObj);
    end else
    begin
      Abort;
    end;
  finally
    vForm.Free;
  end;
end;

{$IFDEF Delphi6}
procedure TWmiProcessList.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
var
  vProcess:         TWmiProcess;
begin
  if Item = nil then Exit;
  vProcess := TWmiProcess(Item);
  
  case Action of
     cnAdded:
       begin
         if not vProcess.InternallyCreated then CreateProcessWithPrompt(vProcess);
       end;
     cnDeleting:
       begin
         if not vProcess.Terminated then vProcess.Terminate(0);
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
            (not vProcess.Terminated) and
            (vProcess.ProcessId <> 0) and
            (not IfDoNotPerformApi) then
         begin
           vProcess.Terminate(0);
         end;
       end;
  end;
end;
{$ENDIF}


function TWmiProcessList.FindByName(AName: widestring): TWmiProcess;
var
  i: integer;
begin
  AName := UpperCase(AName);
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    if UpperCase(Items[i].Name) = AName then
    begin
      Result := Items[i];
      Exit;
    end;
  end;
end;

class procedure TWmiProcessList.TerminateProcess(
  WmiServices: ISWbemServices; AProcessId, AReason: cardinal);
var
  vProcessObj:      ISWbemObject;
  inParams:         ISWbemObject;
begin
  vProcessObj   := FindProcessByProcessId(WMiServices, AProcessId);
  if vProcessObj = nil then
    raise TWmiException.Create(Format(PROCESS_NOT_FOUND, [AProcessId]));
  
  inParams  := WmiCreateClassMethodParameters(vProcessObj, 'Terminate');
  WmiSetDWORDParameter(inParams, 'Reason', AReason);
  WmiExecObjectMethod(vProcessObj, 'Terminate', inParams, ErrorFunction);
end;

class function TWmiProcessList.FindProcessByName(
        WmiServices: ISWbemServices;
        AName: widestring): TCardinalArray;
var
  vProcessObj:      ISWbemObject;
  vQuery:           widestring;
  vEnum:            IEnumVariant;
  vProperty:        ISWbemProperty;
  vOleVar:          OleVariant;
  vFetchedCount:    cardinal;
  vResults:         TStrings;
  i:                integer;
begin
  vResults := TStringList.Create;
  try
    vQuery := Format(QUERY_FIND_PROCESSID_BY_NAME, [AName]);
    vEnum  := WmiExecSelectQuery(WMiServices, vQuery);
    while (vEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
    begin
      vProcessObj   := IUnknown(vOleVar) as SWBemObject;
      vProperty     := WmiGetObjectProperty(vProcessObj, 'ProcessId');
      WmiCheck(vProperty.Get_Value(vOleVar));
      vResults.Add(vOleVar);
      vOleVar       := Unassigned;
    end;
    SetLength(Result, vResults.Count);
    for i := 0 to vResults.Count - 1 do
    begin
      Result[i] := StrToInt(vResults[i]);
    end;
  finally
    vResults.Free;
  end;
  
end;

class function TWmiProcessList.FindProcessByProcessId(
    WMiServices: ISWbemServices;
    AProcessId: cardinal): ISWbemObject;
var
  vQuery:           widestring;
  vOleVar:          OleVariant;
  vEnum:            IEnumVariant;
  vFetchedCount:    cardinal;
begin
  Result := nil;
  vQuery      := Format(QUERY_FIND_PROCESS_BY_PROCESSID, [AProcessId]);
  vEnum := WmiExecSelectQuery(WMiServices, vQuery);
  if (vEnum.Next(1, vOleVar, vFetchedCount) = S_OK) then
  begin
    if vFetchedCount = 1 then
      Result := IUnknown(vOleVar) as SWBemObject;
  end;
  vOleVar    := Unassigned;
end;

function TWmiProcessList.FindProcessById(
  AProcessId: cardinal): ISWbemObject;
begin
  if not Active then RaiseNotActiveException;
  Result := FindProcessByProcessId(WMiServices, AProcessId);
end;

{ TWmiProcessStartupInfo }

procedure TWmiProcessStartupInfo.Assign(Source: TPersistent);
var
  vOther: TWmiProcessStartupInfo;
begin
  if (Source is TWmiProcessStartupInfo) then
  begin
    vOther := Source as TWmiProcessStartupInfo;
    CreateFlags           := vOther.CreateFlags;
    EnvironmentVariables  := vOther.EnvironmentVariables;
    ErrorMode             := vOther.ErrorMode;
    FillAttribute         := vOther.FillAttribute;
    PriorityClass         := vOther.PriorityClass;
    ShowWindow            := vOther.ShowWindow;
    Title                 := vOther.Title;
    WinstationDesktop     := vOther.WinstationDesktop;
    X                     := vOther.X;
    XCountChars           := vOther.XCountChars;
    XSize                 := vOther.XSize;
    Y                     := vOther.Y;
    YCountChars           := vOther.YCountChars;
    YSize                 := vOther.YSize;
  end else
  begin
    inherited Assign(Source);
  end;
end;

constructor TWmiProcessStartupInfo.Create;
begin
  inherited Create;
  FEnvironmentVariables := TStringList.Create;
  FPriorityClass := PRIORITY_NORMAL;
  FShowWindow    := SW_NORMAL;
  FX := DEFAULT_VALUE;
  FY := DEFAULT_VALUE;
  FXSize := DEFAULT_VALUE;
  FYSize := DEFAULT_VALUE;
  FXCountChars := DEFAULT_VALUE;
  FYCountChars := DEFAULT_VALUE;
end;

destructor TWmiProcessStartupInfo.Destroy;
begin
  FEnvironmentVariables.Free;
  inherited;
end;

procedure TWmiProcess.LoadProperties(AProcess: ISWbemObject);
var
  vProperties: ISWbemPropertySet;
begin
  inherited;
  WmiCheck(AProcess.Get_Properties_(vProperties));

  FName                := WmiGetStringPropertyValueByName(vProperties, 'Name');
  FCaption             := WmiGetStringPropertyValueByName(vProperties, 'Caption');
  FCreationDate        := WmiParseDateTime(WmiGetStringPropertyValueByName(vProperties, 'CreationDate'));
  FDescription         := WmiGetStringPropertyValueByName(vProperties, 'Description');
  FExecutablePath      := WmiGetStringPropertyValueByName(vProperties, 'ExecutablePath');
  FHandle              := WmiGetCardinalPropertyValueByName(vProperties, 'Handle');
  FHandleCount         := WmiGetCardinalPropertyValueByNameSafe(vProperties, 'HandleCount');
  FKernelModeTime      := WmiGetInt64PropertyValueByName(vProperties, 'KernelModeTime');
  FMaxWorkingSetSize   := WmiGetInt64PropertyValueByName(vProperties, 'MaximumWorkingsetSize');
  FMinWorkingSetSize   := WmiGetInt64PropertyValueByName(vProperties, 'MinimumWorkingsetSize');
  FOtherOperationCount := WmiGetInt64PropertyValueByNameSafe(vProperties, 'OtherOperationCount');
  FOtherTransferCount  := WmiGetInt64PropertyValueByNameSafe(vProperties, 'OtherTransferCount');
  FPageFaults          := WmiGetCardinalPropertyValueByName(vProperties, 'PageFaults');
  FParentProcessId     := WmiGetCardinalPropertyValueByNameSafe(vProperties, 'ParentProcessID');
  FPageFileUsage       := WmiGetCardinalPropertyValueByName(vProperties, 'PageFileUsage');
  FPeakPageFileUsage   := WmiGetCardinalPropertyValueByName(vProperties, 'PeakPageFileUsage');
  FPeakVirtualSize     := WmiGetCardinalPropertyValueByNameSafe(vProperties, 'PeakVirtualSize');
  FPeakWorkingSetSize  := WmiGetCardinalPropertyValueByName(vProperties, 'PeakWorkingSetSize');
  FPriority            := WmiGetCardinalPropertyValueByName(vProperties, 'Priority');
  FPrivatePageCount    := WmiGetCardinalPropertyValueByNameSafe(vProperties, 'PrivatePageCount');
  FProcessId           := WmiGetCardinalPropertyValueByName(vProperties, 'ProcessID');
  FQuotaNonPagePoolUsage     := WmiGetCardinalPropertyValueByName(vProperties, 'QuotaNonPagedPoolUsage');
  FQuotaPagePoolUsage  := WmiGetCardinalPropertyValueByName(vProperties, 'QuotaPagedPoolUsage');
  FQuotaPeakNonPagePoolUsage := WmiGetCardinalPropertyValueByName(vProperties, 'QuotaPeakNonPagedPoolUsage');
  FQuotaPeakPagePoolUsage    := WmiGetCardinalPropertyValueByName(vProperties, 'QuotaPeakPagedPoolUsage');
  FReadOperationCount  := WmiGetInt64PropertyValueByNameSafe(vProperties, 'ReadOperationCount');
  FReadTransferCount   := WmiGetInt64PropertyValueByNameSafe(vProperties, 'ReadTransferCount');
  FSessionId           := WmiGetCardinalPropertyValueByNameSafe(vProperties, 'SessionID');
  FThreadCount         := WmiGetCardinalPropertyValueByNameSafe(vProperties, 'ThreadCount');
  FUserModeTime        := WmiGetInt64PropertyValueByName(vProperties, 'UserModeTime');
  FWorkingSetSize      := WmiGetInt64PropertyValueByName(vProperties, 'WorkingSetSize');
  FWriteOperationCount := WmiGetInt64PropertyValueByNameSafe(vProperties, 'WriteOperationCount');
  FWriteTransferCount  := WmiGetInt64PropertyValueByNameSafe(vProperties, 'WriteTransferCount');

(*
  Exit;


  vPropEnum := WmiGetObjectProperties(AProcess);
  while (vPropEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
  begin
    vProp    := IUnknown(vOleVar) as SWBemProperty;
    vOleVar  := Unassigned;
    WmiCheck(vProp.Get_Value(vValue));
    if VarIsNull(vValue) then Continue;
    WmiCheck(vProp.Get_Name(vPropName));
    vPropName := UpperCase(vPropName);

    if vPropName = 'CAPTION' then FCaption := vValue else
    if vPropName = 'CREATIONDATE' then FCreationDate := WmiParseDate(vValue) else
    if vPropName = 'DESCRIPTION' then FDescription := vValue else
    if vPropName = 'EXECUTABLEPATH' then FExecutablePath := vValue else
    if vPropName = 'HANDLE' then FHandle := VariantToCardinal(vValue) else
    if vPropName = 'HANDLECOUNT' then FHandleCount := VariantToCardinal(vValue) else
    if vPropName = 'KERNELMODETIME' then FKernelModeTime := VariantToInt64(vValue) else
    if vPropName = 'MAXIMUMWORKINGSETSIZE' then FMaxWorkingSetSize := VariantToCardinal(vValue) else
    if vPropName = 'MINIMUMWORKINGSETSIZE' then FMinWorkingSetSize := VariantToCardinal(vValue) else
    if vPropName = 'NAME' then FName := vValue else
    if vPropName = 'OTHEROPERATIONCOUNT' then FOtherOperationCount := VariantToInt64(vValue) else
    if vPropName = 'OTHERTRANSFERCOUNT' then FOtherTransferCount := VariantToInt64(vValue) else
    if vPropName = 'PAGEFAULTS' then FPageFaults := VariantToCardinal(vValue) else
    if vPropName = 'PAGEFILEUSAGE' then FPageFileUsage := VariantToCardinal(vValue) else
    if vPropName = 'PARENTPROCESSID' then FParentProcessId := VariantToCardinal(vValue) else
    if vPropName = 'PEAKPAGEFILEUSAGE' then FPeakPageFileUsage := VariantToCardinal(vValue) else
    if vPropName = 'PEAKVIRTUALSIZE' then FPeakVirtualSize := VariantToCardinal(vValue) else
    if vPropName = 'PEAKWORKINGSETSIZE' then FPeakWorkingSetSize := VariantToCardinal(vValue) else
    if vPropName = 'PRIORITY' then FPriority := VariantToCardinal(vValue) else
    if vPropName = 'PRIVATEPAGECOUNT' then FPrivatePageCount := VariantToCardinal(vValue) else
    if vPropName = 'PROCESSID' then FProcessId := VariantToCardinal(vValue) else
    if vPropName = 'QUOTANONPAGEDPOOLUSAGE' then FQuotaNonPagePoolUsage := VariantToCardinal(vValue) else
    if vPropName = 'QUOTAPAGEDPOOLUSAGE' then FQuotaPagePoolUsage := VariantToCardinal(vValue) else
    if vPropName = 'QUOTAPEAKNONPAGEDPOOLUSAGE' then FQuotaPeakNonPagePoolUsage := VariantToCardinal(vValue) else
    if vPropName = 'QUOTAPEAKPAGEDPOOLUSAGE' then FQuotaPeakPagePoolUsage := VariantToCardinal(vValue) else
    if vPropName = 'READOPERATIONCOUNT' then FReadOperationCount := VariantToInt64(vValue) else
    if vPropName = 'READTRANSFERCOUNT' then FReadTransferCount := VariantToInt64(vValue) else
    if vPropName = 'SESSIONID' then FSessionId := VariantToCardinal(vValue) else
    if vPropName = 'THREADCOUNT' then FThreadCount := VariantToCardinal(vValue) else
    if vPropName = 'USERMODETIME' then FUserModeTime := VariantToInt64(vValue) else
    if vPropName = 'WORKINGSETSIZE' then FWorkingSetSize := VariantToCardinal(vValue) else
    if vPropName = 'WRITEOPERATIONCOUNT' then FWriteOperationCount := VariantToInt64(vValue) else
    if vPropName = 'WRITETRANSFERCOUNT' then FWriteTransferCount := VariantToInt64(vValue);
  end;
*)  
end;

procedure TWmiProcessStartupInfo.SetEnvironmentVariables(
  const Value: TStrings);
begin
  FEnvironmentVariables.Clear;
  if Value <> nil then FEnvironmentVariables.Assign(Value);
end;

procedure TWmiProcessStartupInfo.SetShowWindow(const Value: DWORD);
begin
  FShowWindow := Value;
end;

end.
