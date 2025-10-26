{ Mike Palmer
  (c) Copyright Zonal Retail Data Systems Ltd. All Rights Reserved }
unit uAztecComputerDetails;

interface

uses uCommon, uAztecAction,WMIConnection, uAztecComputer;

type
  TAztecHardware=class(TAztecAction)
  public
    constructor Create; override;
    destructor Destroy;override;
    function Execute(Computer : TAztecComputer; var AResultString:string):boolean;override;
  private
    FRAM:int64;
    FFDDCount:byte;
    FHDDCount:byte;
    FCDDCount:byte;
    FPrimaryHDDSize:int64;
  published
    property RAM:int64 read FRAM;
    property PrimaryHDDSize:int64 read FPrimaryHDDSize;
    property NoOfHDD:byte read FHDDCount;
    property NoOfFDD:byte read FFDDCount;
    property NoOfCDD:byte read FCDDCount;
  end;

  TAztecOS=class(TAztecAction)
  public
    constructor Create; override;
    destructor Destroy; override;
    function Execute(Computer : TAztecComputer; var AResultString:string):boolean;override;
  private
    FCSDVersion:string;
    FInstallDate:string;
    FLastBootup:string;
    FOSType:string;
    FSerialNumber:string;
    FServicePackID:string;
    FWindowsDirectory:string;
    FSystemDirectory:string;
    FCountryCode:string;
    FOSName:string;
  published
    property CSDVersion:string read FCSDVersion;
    property InstallDate:string read FInstallDate;
    property LastBootUpDate:string read FLastBootUp;
    property OSType:string read FOSType;
    property SerialNumber:string read FSerialNumber;
    property ServicePackID:string read FServicePackID;
    property WindowsDirectory:string read FWindowsDirectory;
    property SystemDirectory:string read FSystemDirectory;
    property CountryCode:string read FCountryCode;
    property OSName:string read FOSName;
  end;

  TAztecReboot=class(TAztecAction)
  public
    constructor Create; override;
    destructor Destroy; override;
    function Execute(Computer : TAztecComputer; var AResultString:string):boolean;override;
  private
    FReconnect:boolean;
  published
    property ReconnectWhenRebooted:boolean read FReconnect write FReconnect default FALSE;
  end;

implementation

uses Forms,Sysutils,WmiAbstract,WmiComponent,WmiOs,WmiStorageInfo,Dialogs;

{ TAztecHardware }

constructor TAztecHardware.Create;
begin
  inherited;
  FRAM:=0;
  FPrimaryHDDSize:=0;
  FHDDCount:=0;
  FFDDCount:=0;
  FCDDCount:=0;
  FActionDescription:='Get Hardware Details';
end;

destructor TAztecHardware.Destroy;
begin
  inherited;
end;

function TAztecHardware.Execute(Computer : TAztecComputer; var AResultString:string): boolean;
const
  GIGABYTE=1073741824;
  MEGABYTE=1048576;
var
  WMIHardwareDetails:TWMIOS;
  WMIHardwareStorage:TWMIStorageInfo;
begin
  Computer.Progress('Connecting',0);
  WMIHardwareDetails:=TWMIOS.Create(nil);
  try
    Result:=FALSE;
    WMIHardwareStorage:=TWMIStorageInfo.Create(nil);
    try
      WMIHardwareStorage.Credentials.UserName:=Computer.WMIConnection.Credentials.UserName;
      WMIHardwareStorage.Credentials.Password:=Computer.WMIConnection.Credentials.Password;
      WMIHardwareStorage.MachineName:=Computer.WMIConnection.MachineName;
      WMIHardwareStorage.Active:=TRUE;
      Computer.Progress('Retrieving Details',50);
      FPrimaryHDDSize:=WMIHardwareStorage.DiskDrives[0].Size;
      FHDDCount:=WMIHardwareStorage.DiskDrives.Count;
      FFDDCount:=WMIHardwareStorage.FloppyDrives.Count;
      FCDDCount:=WMIHardwareStorage.CDROMDrives.Count;
      WMIHardwareStorage.Active:=FALSE;
    finally
      FreeAndNil(WMIHardwareStorage);
    end;
    WMIHardwareDetails.Credentials.UserName:=Computer.WMIConnection.Credentials.UserName;
    WMIHardwareDetails.Credentials.Password:=Computer.WMIConnection.Credentials.Password;
    WMIHardwareDetails.MachineName:=Computer.WMIConnection.MachineName;
    WMIHardwareDetails.Active:=TRUE;
    FRAM:=WMIhardwareDetails.TotalVisibleMemorySize;
    Result:=TRUE;
  finally
    FreeAndNil(WMIHardwareDetails);
    FreeAndNil(WMIHardwareStorage);
    Computer.Progress('Complete',100);
  end;
  AResultString:=FActionDescription+','+Computer.WMIConnection.MachineName+','+BooleanToString(Result)+
    ',HDD Count:'+IntToStr(FHDDCount)+' FDD Count:'+IntToStr(FFDDCount)+' CDD Count:'+IntToStr(FCDDCount)+
    ' Primary HDD Size:'+FormatFloat('###Gb',FPrimaryHDDSize div GIGABYTE)+
    ' RAM:'+IntToStr(FRAM div 1024)+'Mb';
end;

{ TAztecOSDetails }

constructor TAztecOS.Create;
begin
  inherited;
  FActionDescription:='Get OS Details';
end;

destructor TAztecOS.Destroy;
begin
  inherited;
end;

function TAztecOS.Execute(Computer : TAztecComputer; var AResultString:string): boolean;
var
  OS:TWMIOS;
begin
  OS:=TWMIOS.Create(nil);
  Computer.Progress('Connecting',25);
  try
    Result:=FALSE;
    OS.Credentials.Username:=Computer.WMIConnection.Credentials.UserName;
    OS.Credentials.Password:=Computer.WMIConnection.Credentials.Password;
    OS.MachineName:=Computer.WMIConnection.MachineName;
    OS.Active:=TRUE;
    Computer.Progress('Retrieving Details',50);
    FCSDVersion:=OS.CSDVersion;
    FInstallDate:=FormatDateTime('dd/mm/yyyy hh:mm',OS.InstallDate);
    FLastBootup:=FormatDateTime('dd/mm/yyyy hh:mm',OS.LastBootUpTime);
    FOSType:=OS.OSTypeToStr(OS.OSType);
    FSerialNumber:=OS.SerialNumber;
    FServicePackID:=IntToStr(OS.ServicePackMajorVersion)+'.'+IntToStr(OS.ServicePackMinorVersion);
    FWindowsDirectory:=OS.WindowsDirectory;
    FSystemDirectory:=OS.SystemDirectory;
    FCountryCode:=OS.CountryCode;
    FOSName:=OS.Caption;
    Computer.Progress('Disconnecting',75);
    Result:=TRUE;
  finally
    FreeAndNil(OS);
    Computer.Progress('Complete',100);
  end;
  AResultString:=FActionDescription+','+Computer.WMIConnection.MachineName+','+BooleanToString(Result)+
    ',CSDVersion:'+FCSDVersion+' OS Installed On:'+FInstallDate+
    ' Last Reboot:'+FLastBootUp+' OS Type:'+FOSType+
    ' Serial Number:'+FSerialNumber+' Service Pack ID:'+FServicePackID+
    ' Windows Dir:'+FWindowsDirectory+' System Dir:'+FSystemDirectory+' Locale:'+FCountryCode+
    ' OS:'+FOSName;
end;

{ TAztecReboot }

constructor TAztecReboot.Create;
begin
  inherited;
  FActionDescription:='Reboot';
  FReconnect:=FALSE;
end;

destructor TAztecReboot.Destroy;
begin
  inherited;
end;

function TAztecReboot.Execute(Computer : TAztecComputer; var AResultString: string): boolean;
var
  OS:TWMIOS;
begin
  OS:=TWMIOS.Create(nil);
  Computer.Progress('Connecting',25);
  try
    Result:=FALSE;
    OS.Credentials.Username:=Computer.WMIConnection.Credentials.UserName;
    OS.Credentials.Password:=Computer.WMIConnection.Credentials.Password;
    OS.MachineName:=Computer.WMIConnection.MachineName;
    OS.Active:=TRUE;
    Computer.Progress('Initiating Reboot',50);
    OS.Reboot;
    while OS.Active do
    begin
      Application.ProcessMessages;
      Sleep(10);
    end;
    Computer.Progress('Reboot Initiated',75);
    if FReconnect then
       while not OS.Active do
       begin
         Application.ProcessMessages;
         Sleep(10);
       end;
    Result:=TRUE;
  finally
    FreeAndNil(OS);
    Computer.Progress('Complete',100);
  end;
  AResultString:=FActionDescription+','+Computer.WMIConnection.MachineName+','+BooleanToString(Result);
end;

end.
