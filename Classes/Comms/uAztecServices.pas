{ Mike Palmer
  (c) Copyright Zonal Retail Data Systems Ltd. All Rights Reserved }

unit uAztecServices;

interface

uses uAztecAction, uAztecComputer, uCommon, WMIDataSet, SysUtils,WMIConnection, Dialogs, uAztecFiles;

type
   TAztecService=class(TAztecAction)
   public
     constructor Create(const ADisplayName:string); reintroduce; virtual;
   protected
     FServiceName:string;
     FServiceExeName:string;
     FDisplayName:string;
     FInteractWithDesktop:boolean;
     FAutomatic:boolean;
   published
     property ServiceModule:string read FServiceExeName write FServiceExeName;
     property ServiceName:string read FServiceName write FServiceName;
     property DisplayName:string read FDisplayName write FDisplayName;
     property InteractWithDesktop:boolean read FInteractWithDesktop write FInteractWithDesktop default TRUE;
     property StartUpAutomatic:boolean read FAutomatic write FAutomatic default TRUE;
   end;

   TAztecInstallService=class(TAztecService)
   public
     constructor Create(const AServiceName:string); reintroduce;
     function Execute(Computer : TAztecComputer; var AResultString:string):boolean; override;
   private
     FRemotePathType:TPathType;
     FRemotePath:string;
     function GetResolvedRemotePath(Computer : TAztecComputer): string;
   published
     property RemotePath:string read FRemotePath write FRemotePath;
     property RemotePathType:TPathType read FRemotePathType write FRemotePathType;
   end;

   TAztecUninstallService=class(TAztecService)
   public
     constructor Create(const AServiceName:string); reintroduce;
     function Execute(Computer : TAztecComputer; var AResultString:string):boolean; override;
   end;

   TAztecSimpleServiceAction=class(TAztecService)
   protected
     function DoServiceAction(Computer : TAztecComputer; methodName, progressMsg : String; var AResultString:string):boolean;
   end;

   TAztecStopService=class(TAztecSimpleServiceAction)
   public
     constructor Create(const ADisplayName:string); override;
     function Execute(Computer : TAztecComputer; var AResultString:string):boolean; override;
   end;

   TAztecStartService=class(TAztecSimpleServiceAction)
   public
     constructor Create(const ADisplayName:string); override;
     function Execute(Computer : TAztecComputer; var AResultString:string):boolean; override;
   end;

   TAztecRestartService=class(TAztecSimpleServiceAction)
   public
     constructor Create(const ADisplayName:string); override;
     function Execute(Computer : TAztecComputer; var AResultString:string):boolean; override;
   end;


implementation

uses WMIMethod, Windows, WMIRegistry, uAztecProcess;

{ TAztecService }

constructor TAztecService.Create(const ADisplayName:string);
begin
  inherited Create;
  FDisplayName:=ADisplayName;
  FConnectionNeeded:=TRUE;
end;

{ TAztecSimpleServiceAction }
function TAztecSimpleServiceAction.DoServiceAction(Computer : TAztecComputer; methodName, progressMsg : String; var AResultString:string):boolean;
var
  WMIQuery:TWMIQuery;
  Service:TWMIMethod;
begin
  try
    Computer.Progress(progressMsg,0);
    Service:=TWMIMethod.Create(nil);
    WMIQuery:=TWMIQuery.Create(nil);

    WMIQuery.Asynchronous:=TRUE;
    WMIQuery.Connection := Computer.WMIConnection;
    WMIQuery.WQL.Add('select * from win32_service where displayname='+QuotedStr(FDisplayName));
    WMIQuery.Active:=TRUE;
    Service.WMIMethodName:=methodName;
    Service.WmiObjectSource:=WMIQuery;
    Service.Execute;
    Sleep(100);
    WMIQuery.Close;
    Result:=TRUE;
  finally
    FreeAndNil(Service);
    FreeAndNil(WMIQuery);
    Computer.Progress('Complete',100);
  end;
  AResultString:=FActionDescription+','+FDisplayName+','+BooleanToString(Result);
end;

{ TAztecStopService }
constructor TAztecStopService.Create(const ADisplayName: string);
begin
  inherited;
  FActionDescription:='Stop Service';
end;

function TAztecStopService.Execute(Computer : TAztecComputer; var AResultString:string): boolean;
begin
  Result := DoServiceAction(Computer, 'StopService', 'Stopping Service', AResultString);
end;

{ TAztecStartService }

constructor TAztecStartService.Create(const ADisplayName: string);
begin
  inherited;
  FActionDescription:='Start Service';
end;

function TAztecStartService.Execute(Computer : TAztecComputer; var AResultString:string): boolean;
begin
  Result := DoServiceAction(Computer, 'StartService', 'Starting Service', AResultString);
end;

{ TAztecRestartService }
constructor TAztecRestartService.Create(const ADisplayName: string);
begin
  inherited;
  FActionDescription:='Restart Service';
end;

function TAztecRestartService.Execute(Computer : TAztecComputer; var AResultString:string): boolean;
begin
  DoServiceAction(Computer, 'StopService', 'Stopping Service', AResultString);
  Result := DoServiceAction(Computer, 'StartService', 'Starting Service', AResultString);

  AResultString:=FActionDescription+','+FDisplayName+','+BooleanToString(Result);
end;

{ TAztecInstallService }

constructor TAztecInstallService.Create(const AServiceName: string);
begin
  inherited;
  FDisplayName:='';
  FServiceName:=AServiceName;
  FActionDescription:='Install Service';
  FAutomatic:=TRUE;
  FInteractWithDesktop:=TRUE;
  FRemotePathType:=ptAztec;
end;

function TAztecInstallService.Execute(Computer : TAztecComputer; var AResultString:string): boolean;
var
  InstallServiceRegistry:TWMIRegistry;
  InstallService:TAztecCreateProcess;
  ResultMessage:string;
begin
  Computer.Progress('Connecting',0);
  InstallService:=TAztecCreateProcess.Create(GetResolvedRemotePath(Computer)+'\'+FServiceExeName);
  InstallService.Parameters:='/install /silent';
  InstallService.WaitForObject:=TRUE;
  InstallService.RemotePathType:=FRemotePathType;
  InstallService.Execute(Computer, ResultMessage);
  FreeAndNil(InstallService);
  InstallServiceRegistry:=TWMIRegistry.Create(nil);
  try
    Result:=FALSE;
    with InstallServiceRegistry do
    begin
      Credentials.Username:=Computer.WMIConnection.Credentials.UserName;
      Credentials.Password:=Computer.WMIConnection.Credentials.Password;
      MachineName:=Computer.WMIConnection.MachineName;
      RootKey:=HKEY_LOCAL_MACHINE;
      Active:=TRUE;
      if not KeyExists('SYSTEM\CurrentControlSet\Services\'+FServiceName) then
         CreateKey('SYSTEM\CurrentControlSet\Services\'+FServiceName);
      Computer.Progress('Installing Service',25);
      CurrentPath:='SYSTEM\CurrentControlSet\Services\'+FServiceName;
      if FAutomatic then
         WriteInteger('Start',2)
      else
         WriteInteger('Start',3);
      if FInteractWithDesktop then
         WriteInteger('Type',272)
      else
         WriteInteger('Type',16);
      ResultMessage:=GetResolvedRemotePath(Computer);
      ResultMessage:=StringReplace(ResultMessage, '$', ':', []);
      WriteString('ImagePath',ResultMessage+'\'+ExtractFileName(FServiceExeName));
      Result:=TRUE;
    end;
    InstallServiceRegistry.Active:=FALSE;
  finally
    FreeAndNil(InstallService);
    Computer.Progress('Complete',100);
  end;
  AResultString:=FActionDescription+','+ExtractFileName(FServiceName)+','+BooleanToString(Result);
end;

function TAztecInstallService.GetResolvedRemotePath(Computer : TAztecComputer): string;
var
  UserName, Password, MachineName: string;
begin
  UserName := Computer.WMIConnection.Credentials.UserName;
  Password := Computer.WMIConnection.Credentials.Password;
  MachineName := Computer.WMIConnection.MachineName;
  case FRemotePathType of
    ptCustom        : Result := FRemotePath;
    ptAPOS          : Result := GetRemoteAPOSDirectory(UserName, Password, MachineName);
    ptAPOSData      : Result := GetRemoteAPOSDataDirectory(UserName, Password, MachineName);
    ptPRIZM         : Result := GetRemotePRIZMDirectory(UserName, Password, MachineName);
    ptPRIZMData     : Result := GetRemotePRIZMDataDirectory(UserName, Password, MachineName);
    ptPRIZMPrivate  : Result := GetRemotePRIZMPrivateDirectory(UserName, Password, MachineName);
    ptProgramFiles  : Result := GetRemoteProgramFilesDirectory(UserName, Password, MachineName);
    ptWindows       : Result := GetRemoteWindowsDirectory(UserName, Password, MachineName);
    ptWindowsSystem : Result := GetRemoteWindowsSystemDirectory(UserName, Password, MachineName);
    ptAztec         : Result := GetRemoteAztecDirectory(UserName, Password, MachineName);
    ptTemp          : Result := 'c$\Temp';
  end;
  Result:=StringReplace(Result, ':', '$', []);
end;

{ TAztecUninstallService }

constructor TAztecUninstallService.Create(const AServiceName: string);
begin
  inherited;
  FActionDescription:='UnInstall Service';
  FDisplayName:='';
  FServiceName:=AServiceName;
end;

function TAztecUninstallService.Execute(Computer: TAztecComputer; var AResultString:string): boolean;
var
  UnInstallServiceRegistry:TWMIRegistry;
  UnInstallService:TAztecCreateProcess;
  ResultMessage:string;
  ProcessName:string;
begin
  Result:=FALSE;
  Computer.Progress('Connecting',0);
  UninstallServiceRegistry:=TWMIRegistry.Create(nil);
  try
    with UninstallServiceRegistry do
    begin
      Credentials.Username:=Computer.WMIConnection.Credentials.UserName;
      Credentials.Password:=Computer.WMIConnection.Credentials.Password;
      MachineName:=Computer.WMIConnection.MachineName;
      RootKey:=HKEY_LOCAL_MACHINE;
      Active:=TRUE;
      if KeyExists('SYSTEM\CurrentControlSet\Services\'+FServiceName) then
      begin
        Computer.Progress('Uninstalling Service',25);
        CurrentPath:='SYSTEM\CurrentControlSet\Services\'+FServiceName;
        ProcessName:=UnInstallServiceRegistry.ReadString('ImagePath');
        while pos ( '"', ProcessName ) > 0 do
          Delete(ProcessName,pos('"',ProcessName),1);
        Active:=FALSE;
        UninstallService:=TAztecCreateProcess.Create(ProcessName);
        UninstallService.Parameters:='/uninstall /silent';
        UninstallService.WaitForObject:=TRUE;
        UninstallService.Execute(Computer, ResultMessage);
        FreeAndNil(UninstallService);
        Result:=TRUE;
      end;
    end;
  finally
    FreeAndNil(UninstallServiceRegistry);
    Computer.Progress('Complete',100);
  end;
  AResultString:=FActionDescription+','+FDisplayName+','+BooleanToString(Result);
end;

end.
