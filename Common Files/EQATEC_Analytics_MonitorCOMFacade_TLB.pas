unit EQATEC_Analytics_MonitorCOMFacade_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.130.1.0.1.0.1.6  $
// File generated on 13/08/2013 10:25:41 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Dev\Trunk\Bin\AnalyticsMonitorCOMFacade.tlb (1)
// LIBID: {7DE636D3-A83E-4BCC-92B5-593B54443B4A}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
//   (2) v2.0 mscorlib, (C:\Windows\Microsoft.NET\Framework\v2.0.50727\mscorlib.tlb)
//   (3) v4.0 StdVCL, (C:\Windows\SysWOW64\stdvcl40.dll)
// Errors:
//   Hint: Parameter 'type' of IAnalyticsMonitorCOM.TrackExceptionRawMessage changed to 'type_'
//   Error creating palette bitmap of (TAnalyticsMonitorCOM) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TAnalyticsMonitorSettingsCOM) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TInstallationProperties) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TProxyConfigurationCOM) : Server mscoree.dll contains no icons
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, mscorlib_TLB, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  EQATEC_Analytics_MonitorCOMFacadeMajorVersion = 3;
  EQATEC_Analytics_MonitorCOMFacadeMinorVersion = 1;

  LIBID_EQATEC_Analytics_MonitorCOMFacade: TGUID = '{7DE636D3-A83E-4BCC-92B5-593B54443B4A}';

  IID_IAnalyticsMonitorCOM: TGUID = '{D0C5D97E-137F-49D2-BC70-25C9825A5705}';
  CLASS_AnalyticsMonitorCOM: TGUID = '{6FDF6E13-CE1D-4AE5-B198-ED58E28AD87A}';
  IID_IAnalyticsMonitorSettingsCOM: TGUID = '{1BFF8D4C-CFF2-4877-8310-6578CBF545A9}';
  CLASS_AnalyticsMonitorSettingsCOM: TGUID = '{22D69191-639A-4F32-A306-57C97B034E0E}';
  IID_IInstallationProperties: TGUID = '{C1D88DE9-7C2F-4ACB-AAA6-166C2F20DA00}';
  CLASS_InstallationProperties: TGUID = '{8F2367D4-2223-4F78-9563-E727BEF2FF5D}';
  IID_IAnalyticsMonitorStatusCOM: TGUID = '{44F0EB0B-11E1-4DFE-BDA0-62B7D2DDAD8A}';
  IID_ILookupCallback: TGUID = '{83942578-03D5-4402-8EC0-E7842C06734F}';
  IID_IMonitorEventListener: TGUID = '{DF5E3E60-3825-4071-A074-7AA8EEE77716}';
  IID_IProxyConfigurationCOM: TGUID = '{BBFC94FA-D952-4DB9-9433-441B64D48C66}';
  IID_IVersionAvailableEventArgsCOM: TGUID = '{4A160010-E82E-4A14-83A6-897271283AFA}';
  CLASS_LookupReplyCOM: TGUID = '{E72E0D11-89DD-43DE-989F-31D66502E2DC}';
  CLASS_ProxyConfigurationCOM: TGUID = '{2EDD64FD-97A9-3897-B8CB-CC67C5286856}';
  CLASS_VersionAvailableEventArgsCOM: TGUID = '{C4606BC6-AB3A-476F-BB7D-F48F011F289D}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IAnalyticsMonitorCOM = interface;
  IAnalyticsMonitorCOMDisp = dispinterface;
  IAnalyticsMonitorSettingsCOM = interface;
  IAnalyticsMonitorSettingsCOMDisp = dispinterface;
  IInstallationProperties = interface;
  IInstallationPropertiesDisp = dispinterface;
  IAnalyticsMonitorStatusCOM = interface;
  ILookupCallback = interface;
  IMonitorEventListener = interface;
  IProxyConfigurationCOM = interface;
  IProxyConfigurationCOMDisp = dispinterface;
  IVersionAvailableEventArgsCOM = interface;
  IVersionAvailableEventArgsCOMDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  AnalyticsMonitorCOM = IAnalyticsMonitorCOM;
  AnalyticsMonitorSettingsCOM = IAnalyticsMonitorSettingsCOM;
  InstallationProperties = IInstallationProperties;
  LookupReplyCOM = _Object;
  ProxyConfigurationCOM = IProxyConfigurationCOM;
  VersionAvailableEventArgsCOM = IVersionAvailableEventArgsCOM;


// *********************************************************************//
// Interface: IAnalyticsMonitorCOM
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D0C5D97E-137F-49D2-BC70-25C9825A5705}
// *********************************************************************//
  IAnalyticsMonitorCOM = interface(IDispatch)
    ['{D0C5D97E-137F-49D2-BC70-25C9825A5705}']
    function InitializeMonitor(const productKey: WideString; const currentVersion: WideString; 
                               const serverUri: WideString): WordBool; safecall;
    procedure Start; safecall;
    procedure Stop; safecall;
    procedure TrackExceptionRawMessage(const type_: WideString; const reason: WideString; 
                                       const stacktrace: WideString; 
                                       const contextMessage: WideString); safecall;
    procedure TrackFeature(const featureName: WideString); safecall;
    procedure TrackFeatureStart(const featureName: WideString); safecall;
    procedure TrackFeatureStop(const featureName: WideString); safecall;
    procedure SendLog(const logMessage: WideString); safecall;
    function GetMonitorInfo: WideString; safecall;
    function InitializeMonitorWithSettingsObj(const settingsCom: IAnalyticsMonitorSettingsCOM): WordBool; safecall;
    procedure AddEventListener(const newListener: IMonitorEventListener); safecall;
    procedure TrackFeatureValue(const featureName: WideString; featureValue: Int64); safecall;
    procedure TrackFeatureCancel(const featureName: WideString); safecall;
    procedure ForceSync; safecall;
    procedure Lookup(const key: WideString; timeoutInMilliseconds: Integer; 
                     const callback: ILookupCallback); safecall;
    procedure SendLog_2(const logMessage: WideString; data: PSafeArray; const mimetype: WideString); safecall;
    procedure SetInstallationInfo(const installationId: WideString); safecall;
    function GetStatus: IAnalyticsMonitorStatusCOM; safecall;
    procedure SetInstallationInfoAndProperties(const installationId: WideString; 
                                               const properties: IInstallationProperties); safecall;
  end;

// *********************************************************************//
// DispIntf:  IAnalyticsMonitorCOMDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D0C5D97E-137F-49D2-BC70-25C9825A5705}
// *********************************************************************//
  IAnalyticsMonitorCOMDisp = dispinterface
    ['{D0C5D97E-137F-49D2-BC70-25C9825A5705}']
    function InitializeMonitor(const productKey: WideString; const currentVersion: WideString; 
                               const serverUri: WideString): WordBool; dispid 1;
    procedure Start; dispid 2;
    procedure Stop; dispid 3;
    procedure TrackExceptionRawMessage(const type_: WideString; const reason: WideString; 
                                       const stacktrace: WideString; 
                                       const contextMessage: WideString); dispid 4;
    procedure TrackFeature(const featureName: WideString); dispid 5;
    procedure TrackFeatureStart(const featureName: WideString); dispid 6;
    procedure TrackFeatureStop(const featureName: WideString); dispid 7;
    procedure SendLog(const logMessage: WideString); dispid 8;
    function GetMonitorInfo: WideString; dispid 9;
    function InitializeMonitorWithSettingsObj(const settingsCom: IAnalyticsMonitorSettingsCOM): WordBool; dispid 10;
    procedure AddEventListener(const newListener: IMonitorEventListener); dispid 11;
    procedure TrackFeatureValue(const featureName: WideString; featureValue: {??Int64}OleVariant); dispid 12;
    procedure TrackFeatureCancel(const featureName: WideString); dispid 13;
    procedure ForceSync; dispid 14;
    procedure Lookup(const key: WideString; timeoutInMilliseconds: Integer; 
                     const callback: ILookupCallback); dispid 15;
    procedure SendLog_2(const logMessage: WideString; data: {??PSafeArray}OleVariant; 
                        const mimetype: WideString); dispid 16;
    procedure SetInstallationInfo(const installationId: WideString); dispid 17;
    function GetStatus: IAnalyticsMonitorStatusCOM; dispid 18;
    procedure SetInstallationInfoAndProperties(const installationId: WideString; 
                                               const properties: IInstallationProperties); dispid 22;
  end;

// *********************************************************************//
// Interface: IAnalyticsMonitorSettingsCOM
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1BFF8D4C-CFF2-4877-8310-6578CBF545A9}
// *********************************************************************//
  IAnalyticsMonitorSettingsCOM = interface(IDispatch)
    ['{1BFF8D4C-CFF2-4877-8310-6578CBF545A9}']
    procedure SetProductId(const productId: WideString); safecall;
    procedure SetCurrentVersion(const currentVersion: WideString); safecall;
    procedure SetServerUri(const serverUri: WideString); safecall;
    procedure SetTestMode(testMode: WordBool); safecall;
    procedure SetProxyConfig(const proxyConfig: IProxyConfigurationCOM); safecall;
    procedure SetDailyNetworkUtilizationInKB(dailyUtilization: Integer); safecall;
    procedure SetMaxStorageSizeInKB(maxStorageSize: Integer); safecall;
    procedure SetSynchronizeAutomatically(doSynchronizeAutomatically: WordBool); safecall;
    procedure SetUseSSL(useSSL: WordBool); safecall;
  end;

// *********************************************************************//
// DispIntf:  IAnalyticsMonitorSettingsCOMDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1BFF8D4C-CFF2-4877-8310-6578CBF545A9}
// *********************************************************************//
  IAnalyticsMonitorSettingsCOMDisp = dispinterface
    ['{1BFF8D4C-CFF2-4877-8310-6578CBF545A9}']
    procedure SetProductId(const productId: WideString); dispid 1;
    procedure SetCurrentVersion(const currentVersion: WideString); dispid 2;
    procedure SetServerUri(const serverUri: WideString); dispid 3;
    procedure SetTestMode(testMode: WordBool); dispid 4;
    procedure SetProxyConfig(const proxyConfig: IProxyConfigurationCOM); dispid 5;
    procedure SetDailyNetworkUtilizationInKB(dailyUtilization: Integer); dispid 6;
    procedure SetMaxStorageSizeInKB(maxStorageSize: Integer); dispid 7;
    procedure SetSynchronizeAutomatically(doSynchronizeAutomatically: WordBool); dispid 8;
    procedure SetUseSSL(useSSL: WordBool); dispid 9;
  end;

// *********************************************************************//
// Interface: IInstallationProperties
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C1D88DE9-7C2F-4ACB-AAA6-166C2F20DA00}
// *********************************************************************//
  IInstallationProperties = interface(IDispatch)
    ['{C1D88DE9-7C2F-4ACB-AAA6-166C2F20DA00}']
    procedure Clear; safecall;
    procedure Add(const key: WideString; const value: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IInstallationPropertiesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C1D88DE9-7C2F-4ACB-AAA6-166C2F20DA00}
// *********************************************************************//
  IInstallationPropertiesDisp = dispinterface
    ['{C1D88DE9-7C2F-4ACB-AAA6-166C2F20DA00}']
    procedure Clear; dispid 1610743808;
    procedure Add(const key: WideString; const value: WideString); dispid 1610743809;
  end;

// *********************************************************************//
// Interface: IAnalyticsMonitorStatusCOM
// Flags:     (256) OleAutomation
// GUID:      {44F0EB0B-11E1-4DFE-BDA0-62B7D2DDAD8A}
// *********************************************************************//
  IAnalyticsMonitorStatusCOM = interface(IUnknown)
    ['{44F0EB0B-11E1-4DFE-BDA0-62B7D2DDAD8A}']
    function IsStarted(out pRetVal: WordBool): HResult; stdcall;
    function Runtime(out pRetVal: Int64): HResult; stdcall;
    function CookieId(out pRetVal: WideString): HResult; stdcall;
    function IsConnected(out pRetVal: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ILookupCallback
// Flags:     (256) OleAutomation
// GUID:      {83942578-03D5-4402-8EC0-E7842C06734F}
// *********************************************************************//
  ILookupCallback = interface(IUnknown)
    ['{83942578-03D5-4402-8EC0-E7842C06734F}']
    function OnCallback(const callbackReply: _Object): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMonitorEventListener
// Flags:     (256) OleAutomation
// GUID:      {DF5E3E60-3825-4071-A074-7AA8EEE77716}
// *********************************************************************//
  IMonitorEventListener = interface(IUnknown)
    ['{DF5E3E60-3825-4071-A074-7AA8EEE77716}']
    function NewVersion(const versionInfo: IVersionAvailableEventArgsCOM): HResult; stdcall;
    function NewLogMessage(const newLog: WideString): HResult; stdcall;
    function NewErrorMessage(const newError: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IProxyConfigurationCOM
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BBFC94FA-D952-4DB9-9433-441B64D48C66}
// *********************************************************************//
  IProxyConfigurationCOM = interface(IDispatch)
    ['{BBFC94FA-D952-4DB9-9433-441B64D48C66}']
    procedure SetProxyConnectionStr(const proxyConnectionStr: WideString); safecall;
    procedure SetProxyUserName(const proxyUserName: WideString); safecall;
    procedure SetProxyPass(const proxyPass: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IProxyConfigurationCOMDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BBFC94FA-D952-4DB9-9433-441B64D48C66}
// *********************************************************************//
  IProxyConfigurationCOMDisp = dispinterface
    ['{BBFC94FA-D952-4DB9-9433-441B64D48C66}']
    procedure SetProxyConnectionStr(const proxyConnectionStr: WideString); dispid 1;
    procedure SetProxyUserName(const proxyUserName: WideString); dispid 2;
    procedure SetProxyPass(const proxyPass: WideString); dispid 3;
  end;

// *********************************************************************//
// Interface: IVersionAvailableEventArgsCOM
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4A160010-E82E-4A14-83A6-897271283AFA}
// *********************************************************************//
  IVersionAvailableEventArgsCOM = interface(IDispatch)
    ['{4A160010-E82E-4A14-83A6-897271283AFA}']
    function Get_OfficialVersion: WideString; safecall;
    function Get_DownloadUri: WideString; safecall;
    function Get_VersionDescription: WideString; safecall;
    function Get_CurrentVersionDeprecated: WordBool; safecall;
    function Get_ReleaseDate: WideString; safecall;
    function Get_currentVersion: WideString; safecall;
    function Get_AdditionalInfo: WideString; safecall;
    property OfficialVersion: WideString read Get_OfficialVersion;
    property DownloadUri: WideString read Get_DownloadUri;
    property VersionDescription: WideString read Get_VersionDescription;
    property CurrentVersionDeprecated: WordBool read Get_CurrentVersionDeprecated;
    property ReleaseDate: WideString read Get_ReleaseDate;
    property currentVersion: WideString read Get_currentVersion;
    property AdditionalInfo: WideString read Get_AdditionalInfo;
  end;

// *********************************************************************//
// DispIntf:  IVersionAvailableEventArgsCOMDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4A160010-E82E-4A14-83A6-897271283AFA}
// *********************************************************************//
  IVersionAvailableEventArgsCOMDisp = dispinterface
    ['{4A160010-E82E-4A14-83A6-897271283AFA}']
    property OfficialVersion: WideString readonly dispid 1;
    property DownloadUri: WideString readonly dispid 2;
    property VersionDescription: WideString readonly dispid 3;
    property CurrentVersionDeprecated: WordBool readonly dispid 4;
    property ReleaseDate: WideString readonly dispid 7;
    property currentVersion: WideString readonly dispid 5;
    property AdditionalInfo: WideString readonly dispid 6;
  end;

// *********************************************************************//
// The Class CoAnalyticsMonitorCOM provides a Create and CreateRemote method to          
// create instances of the default interface IAnalyticsMonitorCOM exposed by              
// the CoClass AnalyticsMonitorCOM. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAnalyticsMonitorCOM = class
    class function Create: IAnalyticsMonitorCOM;
    class function CreateRemote(const MachineName: string): IAnalyticsMonitorCOM;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TAnalyticsMonitorCOM
// Help String      : 
// Default Interface: IAnalyticsMonitorCOM
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TAnalyticsMonitorCOMProperties= class;
{$ENDIF}
  TAnalyticsMonitorCOM = class(TOleServer)
  private
    FIntf:        IAnalyticsMonitorCOM;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TAnalyticsMonitorCOMProperties;
    function      GetServerProperties: TAnalyticsMonitorCOMProperties;
{$ENDIF}
    function      GetDefaultInterface: IAnalyticsMonitorCOM;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IAnalyticsMonitorCOM);
    procedure Disconnect; override;
    function InitializeMonitor(const productKey: WideString; const currentVersion: WideString; 
                               const serverUri: WideString): WordBool;
    procedure Start;
    procedure Stop;
    procedure TrackExceptionRawMessage(const type_: WideString; const reason: WideString; 
                                       const stacktrace: WideString; 
                                       const contextMessage: WideString);
    procedure TrackFeature(const featureName: WideString);
    procedure TrackFeatureStart(const featureName: WideString);
    procedure TrackFeatureStop(const featureName: WideString);
    procedure SendLog(const logMessage: WideString);
    function GetMonitorInfo: WideString;
    function InitializeMonitorWithSettingsObj(const settingsCom: IAnalyticsMonitorSettingsCOM): WordBool;
    procedure AddEventListener(const newListener: IMonitorEventListener);
    procedure TrackFeatureValue(const featureName: WideString; featureValue: Int64);
    procedure TrackFeatureCancel(const featureName: WideString);
    procedure ForceSync;
    procedure Lookup(const key: WideString; timeoutInMilliseconds: Integer; 
                     const callback: ILookupCallback);
    procedure SendLog_2(const logMessage: WideString; data: PSafeArray; const mimetype: WideString);
    procedure SetInstallationInfo(const installationId: WideString);
    function GetStatus: IAnalyticsMonitorStatusCOM;
    procedure SetInstallationInfoAndProperties(const installationId: WideString; 
                                               const properties: IInstallationProperties);
    property DefaultInterface: IAnalyticsMonitorCOM read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TAnalyticsMonitorCOMProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TAnalyticsMonitorCOM
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TAnalyticsMonitorCOMProperties = class(TPersistent)
  private
    FServer:    TAnalyticsMonitorCOM;
    function    GetDefaultInterface: IAnalyticsMonitorCOM;
    constructor Create(AServer: TAnalyticsMonitorCOM);
  protected
  public
    property DefaultInterface: IAnalyticsMonitorCOM read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoAnalyticsMonitorSettingsCOM provides a Create and CreateRemote method to          
// create instances of the default interface IAnalyticsMonitorSettingsCOM exposed by              
// the CoClass AnalyticsMonitorSettingsCOM. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAnalyticsMonitorSettingsCOM = class
    class function Create: IAnalyticsMonitorSettingsCOM;
    class function CreateRemote(const MachineName: string): IAnalyticsMonitorSettingsCOM;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TAnalyticsMonitorSettingsCOM
// Help String      : 
// Default Interface: IAnalyticsMonitorSettingsCOM
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TAnalyticsMonitorSettingsCOMProperties= class;
{$ENDIF}
  TAnalyticsMonitorSettingsCOM = class(TOleServer)
  private
    FIntf:        IAnalyticsMonitorSettingsCOM;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TAnalyticsMonitorSettingsCOMProperties;
    function      GetServerProperties: TAnalyticsMonitorSettingsCOMProperties;
{$ENDIF}
    function      GetDefaultInterface: IAnalyticsMonitorSettingsCOM;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IAnalyticsMonitorSettingsCOM);
    procedure Disconnect; override;
    procedure SetProductId(const productId: WideString);
    procedure SetCurrentVersion(const currentVersion: WideString);
    procedure SetServerUri(const serverUri: WideString);
    procedure SetTestMode(testMode: WordBool);
    procedure SetProxyConfig(const proxyConfig: IProxyConfigurationCOM);
    procedure SetDailyNetworkUtilizationInKB(dailyUtilization: Integer);
    procedure SetMaxStorageSizeInKB(maxStorageSize: Integer);
    procedure SetSynchronizeAutomatically(doSynchronizeAutomatically: WordBool);
    procedure SetUseSSL(useSSL: WordBool);
    property DefaultInterface: IAnalyticsMonitorSettingsCOM read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TAnalyticsMonitorSettingsCOMProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TAnalyticsMonitorSettingsCOM
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TAnalyticsMonitorSettingsCOMProperties = class(TPersistent)
  private
    FServer:    TAnalyticsMonitorSettingsCOM;
    function    GetDefaultInterface: IAnalyticsMonitorSettingsCOM;
    constructor Create(AServer: TAnalyticsMonitorSettingsCOM);
  protected
  public
    property DefaultInterface: IAnalyticsMonitorSettingsCOM read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoInstallationProperties provides a Create and CreateRemote method to          
// create instances of the default interface IInstallationProperties exposed by              
// the CoClass InstallationProperties. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoInstallationProperties = class
    class function Create: IInstallationProperties;
    class function CreateRemote(const MachineName: string): IInstallationProperties;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TInstallationProperties
// Help String      : 
// Default Interface: IInstallationProperties
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TInstallationPropertiesProperties= class;
{$ENDIF}
  TInstallationProperties = class(TOleServer)
  private
    FIntf:        IInstallationProperties;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TInstallationPropertiesProperties;
    function      GetServerProperties: TInstallationPropertiesProperties;
{$ENDIF}
    function      GetDefaultInterface: IInstallationProperties;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IInstallationProperties);
    procedure Disconnect; override;
    procedure Clear;
    procedure Add(const key: WideString; const value: WideString);
    property DefaultInterface: IInstallationProperties read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TInstallationPropertiesProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TInstallationProperties
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TInstallationPropertiesProperties = class(TPersistent)
  private
    FServer:    TInstallationProperties;
    function    GetDefaultInterface: IInstallationProperties;
    constructor Create(AServer: TInstallationProperties);
  protected
  public
    property DefaultInterface: IInstallationProperties read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoLookupReplyCOM provides a Create and CreateRemote method to          
// create instances of the default interface _Object exposed by              
// the CoClass LookupReplyCOM. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLookupReplyCOM = class
    class function Create: _Object;
    class function CreateRemote(const MachineName: string): _Object;
  end;

// *********************************************************************//
// The Class CoProxyConfigurationCOM provides a Create and CreateRemote method to          
// create instances of the default interface IProxyConfigurationCOM exposed by              
// the CoClass ProxyConfigurationCOM. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoProxyConfigurationCOM = class
    class function Create: IProxyConfigurationCOM;
    class function CreateRemote(const MachineName: string): IProxyConfigurationCOM;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TProxyConfigurationCOM
// Help String      : 
// Default Interface: IProxyConfigurationCOM
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TProxyConfigurationCOMProperties= class;
{$ENDIF}
  TProxyConfigurationCOM = class(TOleServer)
  private
    FIntf:        IProxyConfigurationCOM;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TProxyConfigurationCOMProperties;
    function      GetServerProperties: TProxyConfigurationCOMProperties;
{$ENDIF}
    function      GetDefaultInterface: IProxyConfigurationCOM;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IProxyConfigurationCOM);
    procedure Disconnect; override;
    procedure SetProxyConnectionStr(const proxyConnectionStr: WideString);
    procedure SetProxyUserName(const proxyUserName: WideString);
    procedure SetProxyPass(const proxyPass: WideString);
    property DefaultInterface: IProxyConfigurationCOM read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TProxyConfigurationCOMProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TProxyConfigurationCOM
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TProxyConfigurationCOMProperties = class(TPersistent)
  private
    FServer:    TProxyConfigurationCOM;
    function    GetDefaultInterface: IProxyConfigurationCOM;
    constructor Create(AServer: TProxyConfigurationCOM);
  protected
  public
    property DefaultInterface: IProxyConfigurationCOM read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoVersionAvailableEventArgsCOM provides a Create and CreateRemote method to          
// create instances of the default interface IVersionAvailableEventArgsCOM exposed by              
// the CoClass VersionAvailableEventArgsCOM. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoVersionAvailableEventArgsCOM = class
    class function Create: IVersionAvailableEventArgsCOM;
    class function CreateRemote(const MachineName: string): IVersionAvailableEventArgsCOM;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'EQATEC';

implementation

uses ComObj;

class function CoAnalyticsMonitorCOM.Create: IAnalyticsMonitorCOM;
begin
  Result := CreateComObject(CLASS_AnalyticsMonitorCOM) as IAnalyticsMonitorCOM;
end;

class function CoAnalyticsMonitorCOM.CreateRemote(const MachineName: string): IAnalyticsMonitorCOM;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AnalyticsMonitorCOM) as IAnalyticsMonitorCOM;
end;

procedure TAnalyticsMonitorCOM.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{6FDF6E13-CE1D-4AE5-B198-ED58E28AD87A}';
    IntfIID:   '{D0C5D97E-137F-49D2-BC70-25C9825A5705}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TAnalyticsMonitorCOM.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IAnalyticsMonitorCOM;
  end;
end;

procedure TAnalyticsMonitorCOM.ConnectTo(svrIntf: IAnalyticsMonitorCOM);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TAnalyticsMonitorCOM.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TAnalyticsMonitorCOM.GetDefaultInterface: IAnalyticsMonitorCOM;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TAnalyticsMonitorCOM.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TAnalyticsMonitorCOMProperties.Create(Self);
{$ENDIF}
end;

destructor TAnalyticsMonitorCOM.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TAnalyticsMonitorCOM.GetServerProperties: TAnalyticsMonitorCOMProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TAnalyticsMonitorCOM.InitializeMonitor(const productKey: WideString; 
                                                const currentVersion: WideString; 
                                                const serverUri: WideString): WordBool;
begin
  Result := DefaultInterface.InitializeMonitor(productKey, currentVersion, serverUri);
end;

procedure TAnalyticsMonitorCOM.Start;
begin
  DefaultInterface.Start;
end;

procedure TAnalyticsMonitorCOM.Stop;
begin
  DefaultInterface.Stop;
end;

procedure TAnalyticsMonitorCOM.TrackExceptionRawMessage(const type_: WideString; 
                                                        const reason: WideString; 
                                                        const stacktrace: WideString; 
                                                        const contextMessage: WideString);
begin
  DefaultInterface.TrackExceptionRawMessage(type_, reason, stacktrace, contextMessage);
end;

procedure TAnalyticsMonitorCOM.TrackFeature(const featureName: WideString);
begin
  DefaultInterface.TrackFeature(featureName);
end;

procedure TAnalyticsMonitorCOM.TrackFeatureStart(const featureName: WideString);
begin
  DefaultInterface.TrackFeatureStart(featureName);
end;

procedure TAnalyticsMonitorCOM.TrackFeatureStop(const featureName: WideString);
begin
  DefaultInterface.TrackFeatureStop(featureName);
end;

procedure TAnalyticsMonitorCOM.SendLog(const logMessage: WideString);
begin
  DefaultInterface.SendLog(logMessage);
end;

function TAnalyticsMonitorCOM.GetMonitorInfo: WideString;
begin
  Result := DefaultInterface.GetMonitorInfo;
end;

function TAnalyticsMonitorCOM.InitializeMonitorWithSettingsObj(const settingsCom: IAnalyticsMonitorSettingsCOM): WordBool;
begin
  Result := DefaultInterface.InitializeMonitorWithSettingsObj(settingsCom);
end;

procedure TAnalyticsMonitorCOM.AddEventListener(const newListener: IMonitorEventListener);
begin
  DefaultInterface.AddEventListener(newListener);
end;

procedure TAnalyticsMonitorCOM.TrackFeatureValue(const featureName: WideString; featureValue: Int64);
begin
  DefaultInterface.TrackFeatureValue(featureName, featureValue);
end;

procedure TAnalyticsMonitorCOM.TrackFeatureCancel(const featureName: WideString);
begin
  DefaultInterface.TrackFeatureCancel(featureName);
end;

procedure TAnalyticsMonitorCOM.ForceSync;
begin
  DefaultInterface.ForceSync;
end;

procedure TAnalyticsMonitorCOM.Lookup(const key: WideString; timeoutInMilliseconds: Integer; 
                                      const callback: ILookupCallback);
begin
  DefaultInterface.Lookup(key, timeoutInMilliseconds, callback);
end;

procedure TAnalyticsMonitorCOM.SendLog_2(const logMessage: WideString; data: PSafeArray; 
                                         const mimetype: WideString);
begin
  DefaultInterface.SendLog_2(logMessage, data, mimetype);
end;

procedure TAnalyticsMonitorCOM.SetInstallationInfo(const installationId: WideString);
begin
  DefaultInterface.SetInstallationInfo(installationId);
end;

function TAnalyticsMonitorCOM.GetStatus: IAnalyticsMonitorStatusCOM;
begin
  Result := DefaultInterface.GetStatus;
end;

procedure TAnalyticsMonitorCOM.SetInstallationInfoAndProperties(const installationId: WideString; 
                                                                const properties: IInstallationProperties);
begin
  DefaultInterface.SetInstallationInfoAndProperties(installationId, properties);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TAnalyticsMonitorCOMProperties.Create(AServer: TAnalyticsMonitorCOM);
begin
  inherited Create;
  FServer := AServer;
end;

function TAnalyticsMonitorCOMProperties.GetDefaultInterface: IAnalyticsMonitorCOM;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoAnalyticsMonitorSettingsCOM.Create: IAnalyticsMonitorSettingsCOM;
begin
  Result := CreateComObject(CLASS_AnalyticsMonitorSettingsCOM) as IAnalyticsMonitorSettingsCOM;
end;

class function CoAnalyticsMonitorSettingsCOM.CreateRemote(const MachineName: string): IAnalyticsMonitorSettingsCOM;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AnalyticsMonitorSettingsCOM) as IAnalyticsMonitorSettingsCOM;
end;

procedure TAnalyticsMonitorSettingsCOM.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{22D69191-639A-4F32-A306-57C97B034E0E}';
    IntfIID:   '{1BFF8D4C-CFF2-4877-8310-6578CBF545A9}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TAnalyticsMonitorSettingsCOM.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IAnalyticsMonitorSettingsCOM;
  end;
end;

procedure TAnalyticsMonitorSettingsCOM.ConnectTo(svrIntf: IAnalyticsMonitorSettingsCOM);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TAnalyticsMonitorSettingsCOM.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TAnalyticsMonitorSettingsCOM.GetDefaultInterface: IAnalyticsMonitorSettingsCOM;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TAnalyticsMonitorSettingsCOM.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TAnalyticsMonitorSettingsCOMProperties.Create(Self);
{$ENDIF}
end;

destructor TAnalyticsMonitorSettingsCOM.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TAnalyticsMonitorSettingsCOM.GetServerProperties: TAnalyticsMonitorSettingsCOMProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TAnalyticsMonitorSettingsCOM.SetProductId(const productId: WideString);
begin
  DefaultInterface.SetProductId(productId);
end;

procedure TAnalyticsMonitorSettingsCOM.SetCurrentVersion(const currentVersion: WideString);
begin
  DefaultInterface.SetCurrentVersion(currentVersion);
end;

procedure TAnalyticsMonitorSettingsCOM.SetServerUri(const serverUri: WideString);
begin
  DefaultInterface.SetServerUri(serverUri);
end;

procedure TAnalyticsMonitorSettingsCOM.SetTestMode(testMode: WordBool);
begin
  DefaultInterface.SetTestMode(testMode);
end;

procedure TAnalyticsMonitorSettingsCOM.SetProxyConfig(const proxyConfig: IProxyConfigurationCOM);
begin
  DefaultInterface.SetProxyConfig(proxyConfig);
end;

procedure TAnalyticsMonitorSettingsCOM.SetDailyNetworkUtilizationInKB(dailyUtilization: Integer);
begin
  DefaultInterface.SetDailyNetworkUtilizationInKB(dailyUtilization);
end;

procedure TAnalyticsMonitorSettingsCOM.SetMaxStorageSizeInKB(maxStorageSize: Integer);
begin
  DefaultInterface.SetMaxStorageSizeInKB(maxStorageSize);
end;

procedure TAnalyticsMonitorSettingsCOM.SetSynchronizeAutomatically(doSynchronizeAutomatically: WordBool);
begin
  DefaultInterface.SetSynchronizeAutomatically(doSynchronizeAutomatically);
end;

procedure TAnalyticsMonitorSettingsCOM.SetUseSSL(useSSL: WordBool);
begin
  DefaultInterface.SetUseSSL(useSSL);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TAnalyticsMonitorSettingsCOMProperties.Create(AServer: TAnalyticsMonitorSettingsCOM);
begin
  inherited Create;
  FServer := AServer;
end;

function TAnalyticsMonitorSettingsCOMProperties.GetDefaultInterface: IAnalyticsMonitorSettingsCOM;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoInstallationProperties.Create: IInstallationProperties;
begin
  Result := CreateComObject(CLASS_InstallationProperties) as IInstallationProperties;
end;

class function CoInstallationProperties.CreateRemote(const MachineName: string): IInstallationProperties;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_InstallationProperties) as IInstallationProperties;
end;

procedure TInstallationProperties.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{8F2367D4-2223-4F78-9563-E727BEF2FF5D}';
    IntfIID:   '{C1D88DE9-7C2F-4ACB-AAA6-166C2F20DA00}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TInstallationProperties.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IInstallationProperties;
  end;
end;

procedure TInstallationProperties.ConnectTo(svrIntf: IInstallationProperties);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TInstallationProperties.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TInstallationProperties.GetDefaultInterface: IInstallationProperties;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TInstallationProperties.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TInstallationPropertiesProperties.Create(Self);
{$ENDIF}
end;

destructor TInstallationProperties.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TInstallationProperties.GetServerProperties: TInstallationPropertiesProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TInstallationProperties.Clear;
begin
  DefaultInterface.Clear;
end;

procedure TInstallationProperties.Add(const key: WideString; const value: WideString);
begin
  DefaultInterface.Add(key, value);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TInstallationPropertiesProperties.Create(AServer: TInstallationProperties);
begin
  inherited Create;
  FServer := AServer;
end;

function TInstallationPropertiesProperties.GetDefaultInterface: IInstallationProperties;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoLookupReplyCOM.Create: _Object;
begin
  Result := CreateComObject(CLASS_LookupReplyCOM) as _Object;
end;

class function CoLookupReplyCOM.CreateRemote(const MachineName: string): _Object;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LookupReplyCOM) as _Object;
end;

class function CoProxyConfigurationCOM.Create: IProxyConfigurationCOM;
begin
  Result := CreateComObject(CLASS_ProxyConfigurationCOM) as IProxyConfigurationCOM;
end;

class function CoProxyConfigurationCOM.CreateRemote(const MachineName: string): IProxyConfigurationCOM;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ProxyConfigurationCOM) as IProxyConfigurationCOM;
end;

procedure TProxyConfigurationCOM.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{2EDD64FD-97A9-3897-B8CB-CC67C5286856}';
    IntfIID:   '{BBFC94FA-D952-4DB9-9433-441B64D48C66}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TProxyConfigurationCOM.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IProxyConfigurationCOM;
  end;
end;

procedure TProxyConfigurationCOM.ConnectTo(svrIntf: IProxyConfigurationCOM);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TProxyConfigurationCOM.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TProxyConfigurationCOM.GetDefaultInterface: IProxyConfigurationCOM;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TProxyConfigurationCOM.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TProxyConfigurationCOMProperties.Create(Self);
{$ENDIF}
end;

destructor TProxyConfigurationCOM.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TProxyConfigurationCOM.GetServerProperties: TProxyConfigurationCOMProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TProxyConfigurationCOM.SetProxyConnectionStr(const proxyConnectionStr: WideString);
begin
  DefaultInterface.SetProxyConnectionStr(proxyConnectionStr);
end;

procedure TProxyConfigurationCOM.SetProxyUserName(const proxyUserName: WideString);
begin
  DefaultInterface.SetProxyUserName(proxyUserName);
end;

procedure TProxyConfigurationCOM.SetProxyPass(const proxyPass: WideString);
begin
  DefaultInterface.SetProxyPass(proxyPass);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TProxyConfigurationCOMProperties.Create(AServer: TProxyConfigurationCOM);
begin
  inherited Create;
  FServer := AServer;
end;

function TProxyConfigurationCOMProperties.GetDefaultInterface: IProxyConfigurationCOM;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoVersionAvailableEventArgsCOM.Create: IVersionAvailableEventArgsCOM;
begin
  Result := CreateComObject(CLASS_VersionAvailableEventArgsCOM) as IVersionAvailableEventArgsCOM;
end;

class function CoVersionAvailableEventArgsCOM.CreateRemote(const MachineName: string): IVersionAvailableEventArgsCOM;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_VersionAvailableEventArgsCOM) as IVersionAvailableEventArgsCOM;
end;

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TAnalyticsMonitorCOM, TAnalyticsMonitorSettingsCOM, TInstallationProperties, TProxyConfigurationCOM]);
end;

end.
