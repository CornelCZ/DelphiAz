unit uEQATECMonitor;

interface

uses windows, sysutils, Forms, winsock, Registry, EQATEC_Analytics_MonitorCOMFacade_TLB;

type

   TEQATECMonitor = class(TObject)
      constructor create;
      destructor destroy; override;
      
   private
      ActivityLogFileName : string;
      featureName : string;
      function GetUserFromWindows():string;
      function LocalIP():string;
      function GetVersionInfoFromFile():string;
      function GetComputerName():string;
      function GetProgramFilesDir: string;
      function GetEQATECIsEnabled: Boolean;
                                         
   public      
      settings : IAnalyticsMonitorSettingsCOM;
      monitor : TAnalyticsMonitorCOM;
      monitorIsStarted : wordbool;
      moduleName : string;
      function TriggerEQATECTestException: Boolean;
      procedure SetupMonitor(module : string);
      procedure TrackException(className, message, stack, reason: string);
      procedure StartMonitor;
      procedure StopMonitor;   
      procedure WriteToLogFile(msg : string; includeDT : boolean);
      procedure SendLogMessage(msg: string; testmsg: boolean = FALSE);
      procedure TrackFeatureStart(currentFeaturename: string);
      procedure TrackFeatureStop();
      procedure CloseDown(appTitle : string);
      procedure EQATECAppException(AppTitle : string; E: Exception);
      function IsEQATECEnabled: boolean;
   end;                           

var
   EQATECMonitor : TEQATECMonitor;
         
implementation


procedure TEQATECMonitor.SetupMonitor(module : string);
var
   iProperties : IInstallationProperties;
   sUserName : string;
   sLocalIP : string;
   sCompanyName : string;
   productVersion : string;
   productID : string;
   productKey : string; 
   s : widestring;
begin
   if IsEQATECEnabled then
   begin
     moduleName := StringReplace(module,'&&','&', [rfReplaceAll, rfIgnoreCase]);
     productKey := 'A07DCA1CA4864C50AEA572B844D62DD1';
     productID := GetComputerName();
     sUserName := GetUserFromWindows();
     sLocalIP := LocalIP();
     iProperties := CoInstallationProperties.Create;
     iProperties.Add('User Name', sUserName);
     iProperties.Add('Company', sCompanyName);
     iProperties.Add('Local IP Address', sLocalIP);
     iProperties.Add('Module',moduleName);

     settings := CoAnalyticsMonitorSettingsCOM.Create;
     productVersion := GetVersionInfoFromFile();
     settings.SetCurrentVersion(productVersion);
     settings.SetProductId(productKey);

     monitor := TAnalyticsMonitorCOM.Create(nil);  
     monitor.InitializeMonitorWithSettingsObj(settings);
     monitor.SetInstallationInfoAndProperties(productID, iProperties);
     ActivityLogFileName := ExtractFilePath(Application.ExeName)+moduleName+'EQATECMonitoring.log';
     StartMonitor;
     s := monitor.GetMonitorInfo;
   end;
         
end;

procedure TEQATECMonitor.CloseDown(appTitle : string);
begin
  if (IsEQATECEnabled and monitorIsStarted) then 
  begin
    TrackFeatureStop();
    SendLogMessage(appTitle+' stopping.', TRUE);
    StopMonitor();
  end;
end;
    
procedure TEQATECMonitor.EQATECAppException(AppTitle : string; E: Exception);
begin
   if monitorIsStarted then
   begin
      AppTitle := StringReplace(AppTitle, '&&', '&', [rfReplaceAll, rfIgnoreCase]);
      TrackException(e.ClassName, e.Message, 'stack-'+e.Message, 'Error in ' + AppTitle);
      SendLogMessage(AppTitle+' exception occurred.', TRUE);
   end; 
end;

function TEQATECMonitor.GetProgramFilesDir: string;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion', False);
    Result := reg.ReadString('ProgramFilesDir');
  finally
    reg.Free;
  end;
end;

procedure TEQATECMonitor.SendLogMessage(msg : string; testmsg : boolean = FALSE);
begin
   if (testmsg and TriggerEQATECTestException) or not testmsg then
      monitor.SendLog(msg)
end;   

function TEQATECMonitor.IsEQATECEnabled() : boolean;
begin
   result := GetEQATECIsEnabled;
end;

function TEQATECMonitor.GetEQATECIsEnabled() : Boolean;
var
   EQATECEnabled : string;
begin
  EQATECEnabled := '';
  with TRegistry.Create do try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('SOFTWARE\Zonal\Aztec', false);
    if ValueExists('IsEQATECEnabled') then
      EQATECEnabled := ReadString('IsEQATECEnabled');
  finally
    free;
  end;
  Result := ('Y' = UpperCase(EQATECEnabled)  )
end;

procedure TEQATECMonitor.StartMonitor;
begin
   monitor.Start();
   monitor.GetStatus.IsStarted(monitorIsStarted);
   if (monitorIsStarted) then
      monitor.SendLog(moduleName+' started.');
end;   

procedure TEQATECMonitor.StopMonitor;
begin
   monitor.stop();
   monitor.GetStatus.IsStarted(monitorIsStarted);
   if not (monitorIsStarted) then
      monitor.SendLog(moduleName+' stopped.')
end;   

function TEQATECMonitor.GetUserFromWindows():string;
Var
    UserName : string;
    UserNameLen : Dword;
begin
    UserNameLen := 255;
    SetLength(userName, UserNameLen) ;
    If GetUserName(PChar(UserName), UserNameLen) Then
      Result := Copy(UserName,1,UserNameLen - 1)
    Else
      Result := 'Unknown';
end;
      
function TEQATECMonitor.GetComputerName():string;
begin
   Result := GetEnvironmentVariable('COMPUTERNAME');
end;
 
function TEQATECMonitor.LocalIP():string;
type
  pu_long = ^u_long;
var
  varTWSAData : TWSAData;
  varPHostEnt : PHostEnt;
  varTInAddr : TInAddr;
  namebuf : Array[0..255] of char;
begin
  If WSAStartup($101,varTWSAData) <> 0 Then
  Result := 'No. IP Address'
  Else Begin
    gethostname(namebuf,sizeof(namebuf));
    varPHostEnt := gethostbyname(namebuf);
    varTInAddr.S_addr := u_long(pu_long(varPHostEnt^.h_addr_list^)^);
    Result := inet_ntoa(varTInAddr);
  End;
  WSACleanup;
end;

function TEQATECMonitor.GetVersionInfoFromFile():string;
var
   filename : string;
   VerInfoSize: DWORD; 
   VerInfo: Pointer; 
   VerValueSize: DWORD; 
   VerValue: PVSFixedFileInfo; 
   Dummy: DWORD; 
begin
   filename := Application.ExeName;
   VerInfoSize := GetFileVersionInfoSize(PChar(fileName), Dummy); 
   GetMem(VerInfo, VerInfoSize); 
   GetFileVersionInfo(PChar(fileName), 0, VerInfoSize, VerInfo); 
   if VerInfo = nil then
      result := '0.0.0.0'
   else
   begin
     VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize); 
     with VerValue^ do 
     begin 
        Result := IntToStr(dwFileVersionMS shr 16); 
        Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF); 
        Result := Result + '.' + IntToStr(dwFileVersionLS shr 16); 
        Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF); 
     end;
   end; 
   FreeMem(VerInfo, VerInfoSize); 
end; 

procedure TEQATECMonitor.TrackFeatureStart(currentFeaturename : string);
begin
   featureName := currentFeatureName;   
   monitor.TrackFeatureStart(featureName);   
end;

procedure TEQATECMonitor.TrackFeatureStop();
begin
   if monitorIsStarted then  monitor.TrackFeatureStop(featureName);   
end;



procedure TEQATECMonitor.TrackException(className :string; message : string; stack : string; reason : string);
begin
   if (monitorIsStarted) then
      EQATECMonitor.monitor.TrackExceptionRawMessage(className, message, stack, reason);
end; 

function TEQATECMonitor.TriggerEQATECTestException():Boolean;
var
   excFileName : string;
   programFilesDir : string;
begin
   programFilesDir := GetProgramFilesDir();
   excFileName := programFilesDir+'\Zonal\Aztec\Tools\TriggerEQATECTestException.exc' ;
   result := IsEQATECEnabled and FileExists(excFileName);
end;

procedure TEQATECMonitor.WriteToLogFile(msg : string; includeDT : boolean);
var
  F: TextFile;
begin
    AssignFile(F, ActivityLogFileName);
    Reset(F);
    if FileExists(ActivityLogFileName) then
      Append(F)
    else
      Rewrite(F);
    if (includeDT) then
      msg := FormatDateTime('dd-mmm-yyyy hh:mm:ss', now) + ' ' + msg;  
    Write(F, msg);
    CloseFile(F);
end;

constructor TEQATECMonitor.create;
begin
end;

destructor TEQATECMonitor.destroy;
begin
   if (monitor <> nil) then
      monitor.Stop;
end;

initialization
   EQATECMonitor := TEQATECMonitor.create;

finalization
   EQATECMonitor.Free;
      
end.
