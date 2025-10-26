{ Mike Palmer, David Johnstone
  (c) Copyright Zonal Retail Data Systems Ltd. All Rights Reserved.}

unit uAztecProcess;

interface

uses uAztecAction, uCommon, WMIConnection, uAztecFiles, uAztecComputer;

type
  TAztecProcess=class(TAztecAction)
  public
    constructor Create(const AProcessName:string); reintroduce; virtual;
    destructor destroy;override;
  private
    FProcess:string;
    FRemotePath:string;
    FRemotePathType:TPathType;
    function FindProcessID(Computer : TAztecComputer) : Cardinal; // Looks for a process with the specified name.  Returns 0 if not found
    function IsProcessRunning(Computer : TAztecComputer; ProcessID : Cardinal) : boolean; // Checks if process with processID is running
  protected
    function GetUncRemotePath(Computer : TAztecComputer): string;
  published
    property ProcessName:string read FProcess write FProcess;
    property RemotePath:string read FRemotePath write FRemotePath;
    property RemotePathType:TPathType read FRemotePathType write FRemotePathType;
  end;

  TAztecCreateProcess=class(TAztecProcess)
  private
    FParameters:string;
    FVisibleProcess:boolean;
    FWait:boolean;
  public
    constructor Create(const AProcessName:string); override;
    function Execute(Computer : TAztecComputer; var AResultString:string):boolean;override;
  published
    property VisibleProcess:boolean read FVisibleProcess write FVisibleProcess default TRUE;
    property Parameters:string read FParameters write FParameters;
    property WaitForObject:boolean read FWait write FWait default FALSE;
  end;

  TAztecStopProcess=class(TAztecProcess)
  public
    constructor Create(const AProcess:string); override;
    function Execute(Computer : TAztecComputer; var AResultString:string):boolean;override;
  end;


implementation

uses Forms, Windows, SysUtils, WMIProcessControl, WMIMethod, WMIDataSet,DB;

{ TAztecProcess }

constructor TAztecProcess.Create(const AProcessName:string);
begin
  inherited Create;
  FProcess:=AProcessName;
  FConnectionNeeded:=TRUE;
end;

destructor TAztecProcess.destroy;
begin
  inherited;
end;

function TAztecProcess.FindProcessID(Computer : TAztecComputer):Cardinal;
var
  WMIQuery:TWMIQuery;
begin
  Result := 0;
  WMIQuery:=TWMIQuery.Create(nil);
  WMIQuery.Connection:=Computer.WMIConnection;
  try
    WMIQuery.WQL.Add('select * from win32_process');
    WMIQuery.Active:=TRUE;
    if WMIQuery.Locate('name',ExtractFileName(FProcess),[loCaseInsensitive]) then
      Result:=WMIQuery.FieldByName('ProcessID').AsInteger;
    WMIQuery.Active:=FALSE;
  finally
    FreeAndNil(WMIQuery);
  end;
end;

function TAztecProcess.GetUncRemotePath(Computer: TAztecComputer): string;
begin
  Result := GetResolvedRemotePath(Computer, FRemotePathType, FRemotePath, false);
end;

function TAztecProcess.IsProcessRunning(Computer : TAztecComputer; ProcessID : Cardinal):boolean;
var
  WMIQuery:TWMIQuery;
begin
  WMIQuery:=TWMIQuery.Create(nil);
  try
    WMIQuery.Connection:=Computer.WMIConnection;
    WMIQuery.WQL.Add('select * from win32_process');
    WMIQuery.Active:=TRUE;
    Result:=WMIQuery.Locate('ProcessID',ProcessID,[]);
    WMIQuery.Active:=FALSE;
  finally
    FreeAndNil(WMIQuery);
  end;
end;

{ TAztecCreateProcess }

constructor TAztecCreateProcess.Create(const AProcessName:string);
begin
  inherited;
  FActionDescription:='Create Process';
  FProcess:=AProcessName;
  FVisibleProcess:=true;
  FWait:=false;
end;

function TAztecCreateProcess.Execute(Computer : TAztecComputer; var AResultString:string): boolean;
var
  WMIProcess:TWMIProcessControl;
  ProcessID: Cardinal;
  RemotePath: string;
begin
  Computer.Progress('Connecting',0);
  WMIProcess:=TWMIProcessControl.Create(nil);
  try
    WMIProcess.Credentials.Username:=Computer.WMIConnection.Credentials.Username;
    WMIProcess.Credentials.Password:=Computer.WMIConnection.Credentials.Password;
    WMIProcess.MachineName:=Computer.WMIConnection.MachineName;
    WMIProcess.Active:=TRUE;
    if FWait then
      Computer.Progress('Executing File',25)
    else
      Computer.Progress('Executing File',50);

    if FVisibleProcess then
       WMIProcess.StartupInfo.ShowWindow:=SW_SHOW
    else
       WMIProcess.StartUpInfo.ShowWindow:=SW_HIDE;
    RemotePath := GetUncRemotePath(Computer);
    RemoveQuotes(FProcess);
    ProcessID:=WMIProcess.StartProcess(RemotePath+'\'+FProcess+' '+Parameters, RemotePath, TRUE);
    Result := ProcessID>0;
    if Result and FWait then
    begin
      Computer.Progress('Await process completion',50);
      while IsProcessRunning(Computer,ProcessID) do
      begin
        Application.ProcessMessages;
        Sleep(100);
      end;
    end;
  finally
    FreeAndNil(WMIProcess);
    COmputer.Progress('Complete',100);
  end;
  AResultString:=FActionDescription+','+ExtractFileName(FProcess)+','+BooleanToString(Result);
end;

{ TAztecStopProcess }

constructor TAztecStopProcess.Create(const AProcess: string);
begin
  inherited;
  FActionDescription:='Stop Process';
end;

function TAztecStopProcess.Execute(Computer : TAztecComputer; var AResultString:string): boolean;
var
  WMIProcess:TWMIProcessControl;
  ProcessID:Cardinal;
  msg:string;
begin
  Computer.Progress('Connecting',0);
  WMIProcess:=TWMIProcessControl.Create(nil);
  try
    WMIProcess.Credentials.UserName:=Computer.WMIConnection.Credentials.UserName;
    WMIProcess.Credentials.Password:=Computer.WMIConnection.Credentials.Password;
    WMIProcess.MachineName:=Computer.WMIConnection.MachineName;
    WMIProcess.Active:=TRUE;
    Computer.Progress('Stopping Process',50);
    RemoveQuotes(FProcess);
    ProcessID:=FindProcessID(Computer);
    if ProcessID = 0 then
    begin
      msg := 'Not running';
      Result := true;
    end
    else
    begin
      WMIProcess.TerminateProcess(ProcessID,0);
      Result := not IsProcessRunning(Computer,ProcessID);
      msg := BooleanToString(Result);
    end
  finally
    FreeAndNil(WMIProcess);
    Computer.Progress('Complete',100);
  end;
   AResultString:=FActionDescription+','+ExtractFileName(FProcess)+','+BooleanToString(Result);
end;

end.
