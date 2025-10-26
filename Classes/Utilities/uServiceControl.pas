// Mike Palmer, 2004
// (c) Zonal Retail Data Systems Ltd
// Service Control Interface

Unit    uServiceControl;

Interface

Type     ServiceStatusTypes = ( QUERY_FAILED, RUNNING, PAUSED, STOPPED, STARTING,
                                STOPPING, PAUSE_PENDING, CONTINUE_PENDING );

         ServiceCommands    = ( SRVC_START, SRVC_STOP, SRVC_PAUSE, SRVC_CONTINUE );

         IServiceControl    =
         Interface
           Function  Status        : ServiceStatusTypes;  // Returns Status Of The Service
           Function  Start         : Boolean;             // Starts The Service
           Function  Stop          : Boolean;             // Stops The Service
           Function  Pause         : Boolean;             // Pauses The Service
           Function  Restart       : Boolean;             // Restarts The Service
           Function  Continue      : Boolean;             // Continues The Service
           Function  GetStatusText : String;              // Returns The Status As A String
           Function  IsConnected   : Boolean;             // Checks For A Connection To The Service
           Function  Delete        : Boolean;             // Deletes The Service From The Service Database
           Function  GetDisplayName: String;
         End;

Function MakeServiceControlInterface ( Const ServiceName, AdminUserName,
            AdminPassword, AdminDomain : String) : IServiceControl;


Implementation

Uses     WinSvc, Windows, WinTypes, TlHelp32, ShellAPI,
         Registry, uLogon, SysUtils;

Type     TServiceController =
         Class ( TInterfacedObject, IServiceControl )
             Constructor Create ( Const ServiceName, AdminUserName, AdminPassword, AdminDomain : String);
             Destructor  Destroy; Override;
             Function    IsConnected    : Boolean;
             Function    Status         : ServiceStatusTypes;
             Function    Stop           : Boolean;
             Function    Start          : Boolean;
             Function    Pause          : Boolean;
             Function    Restart        : Boolean;
             Function    Continue       : Boolean;
             Function    GetStatusText  : String;
             Function    Delete         : Boolean;
             Function    KillService    : Boolean;         // Kills The Service Process
             Function    GetDisplayName : String;
           Private
             iServiceName     : String;
             iDisplayName     : string;
             iModuleName      : PChar;
             iControlManager  : SC_Handle;
             iServiceHandle   : SC_Handle;
             iAdminUserName   : PChar;
             iAdminPassword   : PChar;
             iAdminDomain     : PChar;
             iAdminLogin      : IWindowsLogon;
             Function    ServiceCommand ( Command : DWORD ) : Boolean;
             Procedure   SetServiceImageName;
             Procedure   ChangeProcessPrivileges;
       End;


// Private Unit Routines

Function  BoolToStatus ( Value : Boolean ) : String;
// Converts TRUE or FALSE Into An Equivelent String Value
Begin
  Case Value Of
    TRUE  : Result := 'Succeeded';
    FALSE : Result := 'Failed';
  End
End;

Function StopServiceByProcessID ( ServiceProcessID : Cardinal ) : Boolean;
// Attempts To Kill The Service Using It's ProcessID (PID)
Var      ServiceProcessHandle : THandle;
Begin
  Result := FALSE;
  ServiceProcessHandle := OpenProcess ( STANDARD_RIGHTS_REQUIRED Or TOKEN_ALL_ACCESS Or PROCESS_TERMINATE, FALSE, ServiceProcessID );
  Try
    If ServiceProcessHandle > 0 Then
       Result := TerminateProcess ( ServiceProcessHandle, 1 );
  Finally
    CloseHandle ( ServiceProcessHandle );
  End;
End;

// Interface Calls

Function StopServiceByName  ( Const ServiceImageName : String ) : Boolean;
// Stops The Service By It's Module Name
Var      ServiceSnapShot : THandle;
         ProcessEntry    : PROCESSENTRY32;
         ServiceResult  : Boolean;
Begin
  Result := FALSE;
  ZeroMemory ( @ProcessEntry, SizeOf ( ProcessEntry ));
  ProcessEntry.dwSize := SizeOf ( ProcessEntry );
  ServiceSnapShot := CreateToolhelp32Snapshot ( TH32CS_SNAPALL, 0 );
  Try
    ServiceResult := Process32First ( ServiceSnapShot, ProcessEntry );
    While ServiceResult Do
    Begin
      If Uppercase ( ProcessEntry.szExeFile ) = Uppercase ( ServiceImageName ) Then
      Begin
        Result := StopServiceByProcessID ( ProcessEntry.th32ProcessID );
        Exit;
      End;
      ProcessEntry.dwSize := SizeOf ( ProcessEntry );
      ServiceResult := Process32Next ( ServiceSnapShot, ProcessEntry );
    End;
  Finally
    CloseHandle ( ServiceSnapShot );
  End;
End;

Function MakeServiceControlInterface ( Const ServiceName, AdminUserName, AdminPassword, AdminDomain : String) : IServiceControl;
//  Instantiates an IServerControl Object
Begin
  Result := TServiceController.Create ( ServiceName, AdminUserName, AdminPassword, AdminDomain);
End;

// TServiceControl
Function     TServiceController.Delete;
// Deletes An Installed Service
Begin
  Result := FALSE;
  If IsConnected And ( Status In [STOPPED] ) Then
     Result := DeleteService ( iServiceHandle );
End;

Procedure    TServiceController.SetServiceImageName;
// Opens The Registry And Returns The ImagePath For The Associated Service
Var          Registry : TRegistry;
Begin
  Registry := TRegistry.Create ( KEY_READ );
  Registry.RootKey := HKEY_LOCAL_MACHINE;
  If Registry.OpenKey ( 'SYSTEM\ControlSet001\Services\' + iServiceName, FALSE ) Then
  Begin
    iModuleName := PChar ( UpperCase ( ExtractFileName ( Registry.ReadString ( 'ImagePath' ))));
    iDisplayName := Registry.ReadString ( 'DisplayName' );
    Registry.CloseKey;
  End
  else
    iDisplayName := iServiceName;
  Registry.Free;
End;

Function    TServiceController.GetStatusText;
// Returns Status Of Service As A Text String
Const       StatusText : Array [0..7] Of String =
            ( 'SERVICE QUERY HAS FAILED','SERVICE IS RUNNING','SERVICE IS PAUSED',
              'SERVICE IS STOPPED','SERVICE IS STARTING','SERVICE IS STOPPING',
              'SERVICE IS PENDING PAUSE','SERVICE IS PENDING CONTINUE' );
Begin
  Result := StatusText [ Ord ( Status ) ];
End;

Procedure   TServiceController.ChangeProcessPrivileges;
// Takes The Current Process And Assign Administration Rights To The Process
Begin
  iAdminLogin := MakeWindowsLogonInterface ( iAdminUserName, iAdminPassword, iAdminDomain );
End;

Constructor TServiceController.Create;
// Initialises Service Controller
Begin
  iAdminUserName := PChar ( AdminUserName );
  iAdminPassword := PChar ( AdminPassword );
  iAdminDomain   := PChar ( AdminDomain );
  ChangeProcessPrivileges;
  iControlManager:= OpenSCManager ( Nil, Nil, SC_MANAGER_ALL_ACCESS );

  If iControlManager <> 0 Then
  Begin
    // Would Have Used GETSERVICEKEY But WinAPI Call Is Failing.  Returning Error Code
    // 14 ERROR_OUTOFMEMORY - No Explanation As To Why!
    iServiceName := ServiceName;
    SetServiceImageName;
    iServiceHandle := OpenService ( iControlManager, PChar(iServiceName), SERVICE_ALL_ACCESS Or WRITE_DAC Or WRITE_OWNER );
  End;
End;

Destructor  TServiceController.Destroy;
// Closes All Open Handles
Begin
  Inherited;
End;

Function    TServiceController.IsConnected;
// Checks That A Valid Handle Exists To The Service Control Manager And The
// Service Required
Begin
  Result := ( iControlManager <> 0 ) And ( iServiceHandle <> 0 );
End;

Function    TServiceController.Status;
// Retrieves The Current Status Of The Service
// Returns QUERY_FAILED If Unable To Determine The Status Of The Service
Var         ServiceStatus : TSERVICESTATUS;
Begin
  Result := QUERY_FAILED;
  If IsConnected And QueryServiceStatus ( iServiceHandle, ServiceStatus ) Then
  Begin
    Case ServiceStatus.dwCurrentState Of
      SERVICE_STOPPED          : Result := STOPPED;
      SERVICE_START_PENDING    : Result := STARTING;
      SERVICE_STOP_PENDING     : Result := STOPPING;
      SERVICE_RUNNING          : Result := RUNNING;
      SERVICE_CONTINUE_PENDING : Result := CONTINUE_PENDING;
      SERVICE_PAUSE_PENDING    : Result := PAUSE_PENDING;
      SERVICE_PAUSED           : Result := PAUSED;
    End;
  End;
End;

Function TServiceController.Start;
// Attempts To Start The Service
Var      ServiceArguments : PChar;
Begin
  Result := FALSE;
  If Not IsConnected Then
     Exit;
  ServiceArguments := Nil;
  If Status In [STOPPED, QUERY_FAILED] Then
     Result :=  StartService ( iServiceHandle, 0, ServiceArguments )
  Else Result := FALSE;
End;

Function TServiceController.ServiceCommand;
// Sends A SC_Command To The Service
Var      ServiceStatus : TSERVICESTATUS;
Begin
  Result := ControlService ( iServiceHandle, COMMAND, ServiceStatus );
End;

Function TServiceController.Stop;
// Attempts To Stop The Service
Begin
  Result := FALSE;
  If Not IsConnected Then
     Exit;
  If Status In [RUNNING, PAUSED] Then
  Begin
    Result :=  ServiceCommand ( SERVICE_CONTROL_STOP );
    If Not Result Then
       Result := KillService;
  End Else Result := FALSE;
End;

Function TServiceController.Pause;
// Attempts To Pause The Service
Begin
  Result := FALSE;
  If Not IsConnected Then
     Exit;
  If Status In [RUNNING] Then
     Result := ServiceCommand ( SERVICE_CONTROL_PAUSE )
  Else Result := FALSE;
End;

Function TServiceController.Continue;
// Attempts To Continue The Service After Being Paused
Begin
  Result := FALSE;
  If Not IsConnected Then
     Exit;
  If Status In [PAUSED] Then
     Result := ServiceCommand ( SERVICE_CONTROL_CONTINUE )
  Else Result := FALSE;
End;

Function TServiceController.Restart;
// Attempts To Restart The Service
Begin
  Result := FALSE;
  If Not IsConnected Then
     Exit;
  If Status In [STOPPED] Then
  Begin
    Result := Stop;
    If Result Then
       Result := Start;
  End Else Result := FALSE;
End;

Function TServiceController.KillService;
// Will Attempt To Kill The Service.  This Will Affect All Dependant Services
Begin
  Result := FALSE;
  If Not IsConnected Then
     Exit;
  If Status In [RUNNING, STARTING, CONTINUE_PENDING, STOPPING] Then
  Begin
    Result := Stop;
    If Not Stop Then
       StopServiceByName ( iModuleName );
  End Else Result := FALSE;
End;


function TServiceController.GetDisplayName: String;
begin
  Result := iDisplayName;
end;

End.
