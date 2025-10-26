unit FrmOsViewerMainU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin, ExtCtrls, Grids, //ValEdit,
  WmiAbstract, WmiComponent, WmiOs, FrmNewHostU, FrmAboutU,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  DetectWinOs;

type
  TFrmOsViewerMain = class(TForm)
    tvBrowser: TTreeView;
    Splitter1: TSplitter;
    ToolBar1: TToolBar;
    tlbNewHost: TToolButton;
    ilToolbar: TImageList;
    drgProperties: TDrawGrid;
    WmiOs1: TWmiOs;
    ToolButton1: TToolButton;
    tlbReboot: TToolButton;
    ToolButton2: TToolButton;
    tlbAbout: TToolButton;
    tlbRefresh: TToolButton;
    ToolButton4: TToolButton;
    procedure FormResize(Sender: TObject);
    procedure drgPropertiesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure drgPropertiesDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure drgPropertiesGetEditText(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure Splitter1Moved(Sender: TObject);
    procedure drgPropertiesSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure drgPropertiesExit(Sender: TObject);
    procedure drgPropertiesSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: String);
    procedure drgPropertiesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tvBrowserExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure tvBrowserChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure tlbNewHostClick(Sender: TObject);
    procedure tlbRebootClick(Sender: TObject);
    procedure tlbAboutClick(Sender: TObject);
    procedure tlbRefreshClick(Sender: TObject);
    procedure tvBrowserChange(Sender: TObject; Node: TTreeNode);
  private
    FEditValue: string;
    FStoredCursor: TCursor;
    procedure ResizeGridColumns;
    function GetValueByIndex(AIndex: integer): string;
    function QuickFixesToStr: string;
    procedure CommitChanges;
    procedure SetOsPropertyByIndex(AIndex: integer; AValue: string);
    procedure SetQuantumLength(AValue: string);
    procedure SetQuantumType(AValue: string);
    procedure InitItems;
    function ProcessNodeExpanding(ANode: TTreeNode): boolean;
    function LoadRemoteHosts(ANode: TTreeNode): boolean;
    procedure ProcessChangingNode(Node: TTreeNode);
    procedure SetWaitCursor;
    procedure RestoreCursor;
    function DoConnect(ANode: TTreeNode): boolean;
    procedure SetButtonState;
    procedure SetFormCaption;
    procedure CreateNewNetworkNode;
    function FindNeworkNode: TTreeNode;
    procedure SetWriteDebugInfo(AValue: boolean);
    function GetWriteDebugInfo: string;
    { Private declarations }
  public
    { Public declarations }
    procedure DoShowHint(var HintStr: String; var CanShow: Boolean; var HintInfo: THintInfo);
  end;


  // this class keeps user's credentials for host.
  TCredentials = class
  private
    FUserName: widestring;
    FPassword: widestring;
  public
    constructor Create(AUserName, APassword: widestring);

    property UserName: widestring read FUserName;
    property Password: widestring read FPassword; 
  end;

var
  FrmOsViewerMain: TFrmOsViewerMain;

implementation

{$R *.dfm}

const
  LOCAL_HOST = 'Local Host';
  NETWORK = 'Network';
  NO_DATA = 'NO_DATA';
  CNST_CAPTION = 'Operating System on ';

type
  TDataDefRec = record
    Index: integer;
    Caption: string;
    Editable: boolean;
    Hint: string;
  end;

const

  CAPTION_BootDevice                 = 'Boot Device';
  CAPTION_BuildNumber                = 'Build Number';
  CAPTION_BuildType                  = 'Build Type';
  CAPTION_Caption                    = 'Caption';
  CAPTION_CodeSet                    = 'Code Set';
  CAPTION_CountryCode                = 'Country Code';
  CAPTION_CSDVersion                 = 'Service Pack';
  CAPTION_CSName                     = 'Computer Name';
  CAPTION_CurrentTimeZone            = 'Current Time Zone';
  CAPTION_Debug                      = 'Debug build';
  CAPTION_Description                = 'Description';
  CAPTION_Distributed                = 'Distributed';
  CAPTION_EncryptionLevel            = 'Encryption Level';
  CAPTION_ForegroundApplicationBoost = 'Foreground Application Boost';
  CAPTION_FreePhysicalMemory         = 'Free Physical Memory';
  CAPTION_FreeSpaceInPagingFiles     = 'Free Space In Paging Files';
  CAPTION_FreeVirtualMemory          = 'Free Virtual Memory';
  CAPTION_InstallDate                = 'Install Date';
  CAPTION_LargeSystemCache           = 'Large System Cache';
  CAPTION_LastBootUpTime             = 'Last BootUp Time';
  CAPTION_LocalDateTime              = 'Local Date Time';
  CAPTION_Locale                     = 'Locale';
  CAPTION_Manufacturer               = 'Manufacturer';
  CAPTION_MaxNumberOfProcesses       = 'Max Number Of Processes';
  CAPTION_MaxProcessMemorySize       = 'Max Process MemorySize';
  CAPTION_NumberOfLicensedUsers      = 'Number Of Licensed Users';
  CAPTION_NumberOfProcesses          = 'Number Of Processes';
  CAPTION_NumberOfUsers              = 'Number Of Users';
  CAPTION_Organization               = 'Organization';
  CAPTION_OSLanguage                 = 'OS Language';
  CAPTION_OSName                     = 'OS Name';
  CAPTION_OSProductSuite             = 'OS Product Suite';
  CAPTION_OSType                     = 'OS Type';
  CAPTION_OtherTypeDescription       = 'Other Type Description';
  CAPTION_PlusProductID              = 'Plus Product ID';
  CAPTION_PlusVersionNumber          = 'Plus Version Number';
  CAPTION_Primary                    = 'Primary';
  CAPTION_QuantumLength              = 'Quantum Length';
  CAPTION_QuantumType                = 'Quantum Type';
  CAPTION_RegisteredUser             = 'Registered User';
  CAPTION_SerialNumber               = 'Serial Number';
  CAPTION_ServicePackMajorVersion    = 'Service Pack Major Version';
  CAPTION_ServicePackMinorVersion    = 'Service Pack Minor Version';
  CAPTION_SizeStoredInPagingFiles    = 'Size Stored In Paging Files';
  CAPTION_Status                     = 'Status';
  CAPTION_SuiteMask                  = 'Suite Mask';
  CAPTION_SystemDevice               = 'System Device';
  CAPTION_SystemDirectory            = 'System Directory';
  CAPTION_SystemDrive                = 'System Drive';
  CAPTION_TotalSwapSpaceSize         = 'Total Swap Space Size';
  CAPTION_TotalVirtualMemorySize     = 'Total Virtual Memory Size';
  CAPTION_TotalVisibleMemorySize     = 'Total Visible Memory Size';
  CAPTION_TimeZone                   = 'Time Zone';
  CAPTION_Version                    = 'Version';
  CAPTION_WindowsDirectory           = 'Windows Directory';
  CAPTION_QuickFixes                 = 'Quick Fixes';
  CAPTION_Recovery_AutoReboot        = 'Recovery: auto reboot';
  CAPTION_Recovery_DebugFilePath     = 'Recovery: debug file path';
  CAPTION_Recovery_KernelDumpOnly    = 'Recovery: kernel dump only';
  CAPTION_Recovery_OverwriteExistingDebugFile = 'Recovery: overwrite debug files';
  CAPTION_Recovery_SendAdminAlert    = 'Recovery: send admin alert';
  CAPTION_Recovery_WriteDebugInfo    = 'Recovery: write debug info';
  CAPTION_Recovery_WriteToSystemLog  = 'Recovery: write to system log';



  PROP_COUNT = 63;
  DATA_DEF: array[0..PROP_COUNT - 1] of TDataDefRec = (
    (Index: 0; Caption: CAPTION_BootDevice; Editable: false;
     Hint: 'Name of the disk drive from which the Win32 operating system boots.'),
    (Index: 1; Caption: CAPTION_BuildNumber; Editable: false;
     Hint: 'Build number of an operating system.'),
    (Index: 2; Caption: CAPTION_BuildType; Editable: false;
     Hint: 'Type of build used for an operating system.'),
    (Index: 3; Caption: CAPTION_Caption; Editable: false;
     Hint: 'Short description of the object—a one-line string. The string includes the operating system version. '),
    (Index: 4; Caption: CAPTION_CodeSet; Editable: false;
     Hint: 'Code page value an operating system uses. A code page contains a character table that an operating system uses to translate strings for different languages.'),
    (Index: 5; Caption: CAPTION_CountryCode; Editable: false;
     Hint: 'Code for the country/region that an operating system uses. Values are based on international phone dialing prefixes—also referred to as IBM country/region codes.'),
    (Index: 6; Caption: CAPTION_CSDVersion; Editable: false;
     Hint: 'Indicates the latest service pack installed on a computer system. '),
    (Index: 7; Caption: CAPTION_CSName; Editable: false;
     Hint: 'Name of the computer system.'),
    (Index: 8; Caption: CAPTION_CurrentTimeZone; Editable: false;
     Hint: 'Number of minutes an operating system is offset from Greenwich mean time (GMT).'),
    (Index: 9; Caption: CAPTION_Debug; Editable: false;
     Hint: 'Operating system is a checked (debug) build.'),
    (Index: 10; Caption: CAPTION_Description; Editable: true;
     Hint: 'Description of the Windows operating system.'),
    (Index: 11; Caption: CAPTION_Distributed; Editable: false;
     Hint: 'If operating system is distributed across several computer system nodes. '),
    (Index: 12; Caption: CAPTION_EncryptionLevel; Editable: false;
     Hint: 'Encryption level for secure transactions—40-bit, 128-bit, or n-bit.'),
    (Index: 13; Caption: CAPTION_ForegroundApplicationBoost; Editable: true;
     Hint: 'Increase in priority given to the foreground application. '+#$0D#$0A+' 0: None; 1: Minimum; 2: (Default) Maximum'),
    (Index: 14; Caption: CAPTION_FreePhysicalMemory; Editable: false;
     Hint: 'Number of kilobytes of physical memory currently unused and available.'),
    (Index: 15; Caption: CAPTION_FreeSpaceInPagingFiles; Editable: false;
     Hint: 'Number of kilobytes that can be mapped into the operating system paging files without causing any other pages to be swapped out.'),
    (Index: 16; Caption: CAPTION_FreeVirtualMemory; Editable: false;
     Hint: 'Number of kilobytes of virtual memory currently unused and available.'),
    (Index: 17; Caption: CAPTION_InstallDate; Editable: false;
     Hint: 'Date when the OS was installed. '),
    (Index: 18; Caption: CAPTION_LargeSystemCache; Editable: false;
     Hint: 'Windows Server 2003, Windows XP:  Indicates whether or not to optimize memory for applications or system performance. '+#$0D#$0A+'0: Optimize for applications; 1: Optimize for system performance'),
    (Index: 19; Caption: CAPTION_LastBootUpTime; Editable: false;
     Hint: 'Time when operating system was last booted.'),
    (Index: 20; Caption: CAPTION_LocalDateTime; Editable: true;
     Hint: 'Operating system''s version of the local date and time of day.'),
    (Index: 21; Caption: CAPTION_Locale; Editable: false;
     Hint: 'Language identifier used by the operating system.'),
    (Index: 22; Caption: CAPTION_Manufacturer; Editable: false;
     Hint: 'Name of the operating system manufacturer.'),
    (Index: 23; Caption: CAPTION_MaxNumberOfProcesses; Editable: false;
     Hint: 'Maximum number of process contexts the operating system can support.'),
    (Index: 24; Caption: CAPTION_MaxProcessMemorySize; Editable: false;
     Hint: 'Maximum number of kilobytes of memory that can be allocated to a process.'),
    (Index: 25; Caption: CAPTION_NumberOfLicensedUsers; Editable: false;
     Hint: 'Number of user licenses for the operating system. If unlimited, returns 0 (zero).'),
    (Index: 26; Caption: CAPTION_NumberOfProcesses; Editable: false;
     Hint: 'Number of process contexts currently loaded or running on the operating system.'),
    (Index: 27; Caption: CAPTION_NumberOfUsers; Editable: false;
     Hint: 'Number of user sessions for which the operating system is storing state information currently.'),
    (Index: 28; Caption: CAPTION_Organization; Editable: false;
     Hint: 'Company name for the registered user of the operating system.'),
    (Index: 29; Caption: CAPTION_OSLanguage; Editable: false;
     Hint: 'Language version of the operating system installed.'),
    (Index: 30; Caption: CAPTION_OSName; Editable: false;
     Hint: 'Operating system instance within a computer system.'),
    (Index: 31; Caption: CAPTION_OSProductSuite; Editable: false;
     Hint: 'Installed and licensed system product additions to the operating system.'),
    (Index: 32; Caption: CAPTION_OSType; Editable: false;
     Hint: 'Type of operating system.'),
    (Index: 33; Caption: CAPTION_OtherTypeDescription; Editable: false;
     Hint: 'Manufacturer and operating system type that is used when the operating system property OS Type is set to "Other". '),
    (Index: 34; Caption: CAPTION_PlusProductID; Editable: false;
     Hint: 'Identification number for the Windows Plus! operating system enhancement software—if installed.'),
    (Index: 35; Caption: CAPTION_PlusVersionNumber; Editable: false;
     Hint: 'Version number of the Windows Plus! operating system enhancement software—if installed.'),
    (Index: 36; Caption: CAPTION_Primary; Editable: false;
     Hint: 'Indicates primary operating system.'),
    (Index: 37; Caption: CAPTION_QuantumLength; Editable: true;
     Hint: 'Number of clock ticks per quantum.'+#$0D#$0A+'0: Unknown; 1: One tick; 2: Two ticks'),
    (Index: 38; Caption: CAPTION_QuantumType; Editable: true;
     Hint: 'Length type of quantums. Windows NT 4.0 Workstation/Windows 2000 defaults to '+
           'variable-length quantums where the foreground application has a longer quantum than '+
           'the background applications. Windows NT server defaults to fixed-length quantums.'+#$0D#$0A+
           '0: Unknown; 1: Fixed; 2: Variable'),
    (Index: 39; Caption: CAPTION_RegisteredUser; Editable: false;
     Hint: 'Name of the registered user of the operating system.'),
    (Index: 40; Caption: CAPTION_Recovery_AutoReboot; Editable: true;
     Hint: 'System will automatically reboot during a recovery operation.'),
    (Index: 41; Caption: CAPTION_Recovery_DebugFilePath; Editable: true;
     Hint: 'Full path to the debug file. A debug file is created with the memory state of the computer after a computer failure.'),
    (Index: 42; Caption: CAPTION_Recovery_KernelDumpOnly; Editable: true;
     Hint: 'Only kernel debug information will be written to the debug log file.'),
    (Index: 43; Caption: CAPTION_Recovery_OverwriteExistingDebugFile; Editable: true;
     Hint: 'New log file will overwrite an existing one.'),
    (Index: 44; Caption: CAPTION_Recovery_SendAdminAlert; Editable: true;
     Hint: 'Alert message will be sent to the system administrator in the event of an operating system failure.'),
    (Index: 45; Caption: CAPTION_Recovery_WriteDebugInfo; Editable: true;
     Hint: 'Debugging information is to be written to a log file.'),
    (Index: 46; Caption: CAPTION_Recovery_WriteToSystemLog; Editable: true;
     Hint: 'Events will be written to a system log.'),
    (Index: 47; Caption: CAPTION_SerialNumber; Editable: false;
     Hint: 'Operating system product serial identification number.'),
    (Index: 48; Caption: CAPTION_ServicePackMajorVersion; Editable: false;
     Hint: 'Major version number of the service pack installed on the computer system.'),
    (Index: 49; Caption: CAPTION_ServicePackMinorVersion; Editable: false;
     Hint: 'Minor version number of the service pack installed on the computer system.'),
    (Index: 50; Caption: CAPTION_SizeStoredInPagingFiles; Editable: false;
     Hint: 'Total number of kilobytes that can be stored in the operating system''s paging files'),
    (Index: 51; Caption: CAPTION_Status; Editable: false;
     Hint: 'Current status of the operating system.'),
    (Index: 52; Caption: CAPTION_SuiteMask; Editable: false;
     Hint: 'Windows Server 2003, Windows XP:  the product suites available on the system.'),
    (Index: 53; Caption: CAPTION_SystemDevice; Editable: false;
     Hint: 'Physical disk partition on which the operating system is installed.'),
    (Index: 54; Caption: CAPTION_SystemDirectory; Editable: false;
     Hint: 'System directory of the operating system.'),
    (Index: 55; Caption: CAPTION_SystemDrive; Editable: false;
     Hint: 'Windows Server 2003, Windows XP:  Letter of the disk drive on which the operating system resides.'),
    (Index: 56; Caption: CAPTION_TotalSwapSpaceSize; Editable: false;
     Hint: 'Total swap space in kilobytes.'),
    (Index: 57; Caption: CAPTION_TotalVirtualMemorySize; Editable: false;
     Hint: 'Number of kilobytes of virtual memory.'),
    (Index: 58; Caption: CAPTION_TotalVisibleMemorySize; Editable: false;
     Hint: 'Total amount of physical memory available to the operating system.'),
    (Index: 59; Caption: CAPTION_TimeZone; Editable: false;
     Hint: 'Operating system''s time zone'),
    (Index: 60; Caption: CAPTION_Version; Editable: false;
     Hint: 'Version number of the operating system.'),
    (Index: 61; Caption: CAPTION_WindowsDirectory; Editable: false;
     Hint: 'Windows directory of the operating system.'),
    (Index: 62; Caption: CAPTION_QuickFixes; Editable: false;
     Hint: 'List of installed quick fixes')
  );


{$IFNDEF Delphi6}
function BoolToStr(B: Boolean; UseBoolStrs: Boolean = False): string;
const
  cSimpleBoolStrs: array [boolean] of String = ('0', '-1');
begin
  if UseBoolStrs then
  begin
    if B then Result := 'True'
     else Result := 'False';
  end
  else
    Result := cSimpleBoolStrs[B];
end;

function StrToBool(const S: string): Boolean;
begin
  if UpperCase(S) = 'TRUE' then Result := true
    else
  if UpperCase(S) = 'FALSE' then Result := false
    else raise Exception.Create('Invalid boolean value '+S);
end;

{$ENDIF}

constructor TCredentials.Create(AUserName, APassword: widestring);
begin
  inherited Create;
  FUserName := AUserName;
  FPassword := APassword;
end;

{ TFrmOsViewerMain }
procedure TFrmOsViewerMain.FormResize(Sender: TObject);
begin
  ResizeGridColumns;
end;

procedure TFrmOsViewerMain.ResizeGridColumns;
begin
  drgProperties.ColWidths[1] := drgProperties.ClientWidth - drgProperties.ColWidths[0] - 1;
end;

procedure TFrmOsViewerMain.drgPropertiesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ResizeGridColumns;
end;

procedure TFrmOsViewerMain.FormShow(Sender: TObject);
begin
  InitItems;
  Application.OnShowHint := DoShowHint;
  Application.HintHidePause := 10000;
  Application.HintPause := 2000;

  WmiOs1.Active := true;
  drgProperties.RowCount := PROP_COUNT + 1;
end;

function TFrmOsViewerMain.QuickFixesToStr: string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to WmiOs1.QuickFixes.Count - 1 do
  begin
    Result := Result + WmiOs1.QuickFixes[i].HotFixId;
    if i <> WmiOs1.QuickFixes.Count - 1 then
      Result := Result + ', ';
  end;
end;


function TFrmOsViewerMain.GetValueByIndex(AIndex: integer): string;
begin
  Result := '';
  if not WmiOs1.Active then Exit;

  if DATA_DEF[AIndex].Caption = CAPTION_BootDevice then Result := WmiOs1.BootDevice else
  if DATA_DEF[AIndex].Caption = CAPTION_BuildNumber then Result := WmiOs1.BuildNumber else
  if DATA_DEF[AIndex].Caption = CAPTION_BuildType then Result := WmiOs1.BuildType else
  if DATA_DEF[AIndex].Caption = CAPTION_Caption then Result := WmiOs1.Caption else
  if DATA_DEF[AIndex].Caption = CAPTION_CodeSet then Result := WmiOs1.CodeSet else
  if DATA_DEF[AIndex].Caption = CAPTION_CountryCode then Result := WmiOs1.CountryCode else
  if DATA_DEF[AIndex].Caption = CAPTION_CSDVersion then Result := WmiOs1.CSDVersion else
  if DATA_DEF[AIndex].Caption = CAPTION_CSName then Result := WmiOs1.CSName else
  if DATA_DEF[AIndex].Caption = CAPTION_CurrentTimeZone then Result := IntToStr(WmiOs1.CurrentTimeZone) else
  if DATA_DEF[AIndex].Caption = CAPTION_Debug then Result := BoolToStr(WmiOs1.Debug, true) else
  if DATA_DEF[AIndex].Caption = CAPTION_Description then Result := WmiOs1.Description else
  if DATA_DEF[AIndex].Caption = CAPTION_Distributed then Result := BoolToStr(WmiOs1.Distributed, true) else
  if DATA_DEF[AIndex].Caption = CAPTION_EncryptionLevel then Result := IntToStr(WmiOs1.EncryptionLevel) else
  if DATA_DEF[AIndex].Caption = CAPTION_ForegroundApplicationBoost then Result := IntToStr(WmiOs1.ForegroundApplicationBoost) else
  if DATA_DEF[AIndex].Caption = CAPTION_FreePhysicalMemory then Result := IntToStr(WmiOs1.FreePhysicalMemory) else
  if DATA_DEF[AIndex].Caption = CAPTION_FreeSpaceInPagingFiles then Result := IntToStr(WmiOs1.FreeSpaceInPagingFiles) else
  if DATA_DEF[AIndex].Caption = CAPTION_FreeVirtualMemory then Result := IntToStr(WmiOs1.FreeVirtualMemory) else
  if DATA_DEF[AIndex].Caption = CAPTION_InstallDate then Result := DateToStr(WmiOs1.InstallDate) else
  if DATA_DEF[AIndex].Caption = CAPTION_LargeSystemCache then Result := IntToStr(WmiOs1.LargeSystemCache) else
  if DATA_DEF[AIndex].Caption = CAPTION_LastBootUpTime then Result := DateTimeToStr(WmiOs1.LastBootUpTime) else
  if DATA_DEF[AIndex].Caption = CAPTION_LocalDateTime then Result := DateTimeToStr(WmiOs1.LocalDateTime) else
  if DATA_DEF[AIndex].Caption = CAPTION_Locale then Result := WmiOs1.Locale else
  if DATA_DEF[AIndex].Caption = CAPTION_Manufacturer then Result := WmiOs1.Manufacturer else
  if DATA_DEF[AIndex].Caption = CAPTION_MaxNumberOfProcesses then Result := IntToStr(WmiOs1.MaxNumberOfProcesses) else
  if DATA_DEF[AIndex].Caption = CAPTION_MaxProcessMemorySize then Result := IntToStr(WmiOs1.MaxProcessMemorySize) else
  if DATA_DEF[AIndex].Caption = CAPTION_NumberOfLicensedUsers then Result := IntToStr(WmiOs1.NumberOfLicensedUsers) else
  if DATA_DEF[AIndex].Caption = CAPTION_NumberOfProcesses then Result := IntToStr(WmiOs1.NumberOfProcesses) else
  if DATA_DEF[AIndex].Caption = CAPTION_NumberOfUsers then Result := IntToStr(WmiOs1.NumberOfUsers) else
  if DATA_DEF[AIndex].Caption = CAPTION_Organization then Result := WmiOs1.Organization else
  if DATA_DEF[AIndex].Caption = CAPTION_OSLanguage then Result := IntToStr(WmiOs1.OSLanguage) else
  if DATA_DEF[AIndex].Caption = CAPTION_OSName then Result := WmiOs1.OSName else
  if DATA_DEF[AIndex].Caption = CAPTION_OSProductSuite then Result := IntToStr(WmiOs1.OSProductSuite) else
  if DATA_DEF[AIndex].Caption = CAPTION_OSType then Result := WmiOs1.OSTypeToStr(WmiOs1.OSType) else
  if DATA_DEF[AIndex].Caption = CAPTION_OtherTypeDescription then Result := WmiOs1.OtherTypeDescription else
  if DATA_DEF[AIndex].Caption = CAPTION_PlusProductID then Result := WmiOs1.PlusProductID else
  if DATA_DEF[AIndex].Caption = CAPTION_PlusVersionNumber then Result := WmiOs1.PlusVersionNumber else
  if DATA_DEF[AIndex].Caption = CAPTION_Primary then Result := BoolToStr(WmiOs1.Primary, true) else
  if DATA_DEF[AIndex].Caption = CAPTION_QuantumLength then Result := WmiOs1.QuantumLengthToStr(WmiOs1.QuantumLength) else
  if DATA_DEF[AIndex].Caption = CAPTION_QuantumType then Result := WmiOs1.QuantumTypeToStr(WmiOs1.QuantumType) else
  if DATA_DEF[AIndex].Caption = CAPTION_RegisteredUser then Result := WmiOs1.RegisteredUser else
  if DATA_DEF[AIndex].Caption = CAPTION_SerialNumber then Result := WmiOs1.SerialNumber else
  if DATA_DEF[AIndex].Caption = CAPTION_ServicePackMajorVersion then Result := IntToStr(WmiOs1.ServicePackMajorVersion) else
  if DATA_DEF[AIndex].Caption = CAPTION_ServicePackMinorVersion then Result := IntToStr(WmiOs1.ServicePackMinorVersion) else
  if DATA_DEF[AIndex].Caption = CAPTION_SizeStoredInPagingFiles then Result := IntToStr(WmiOs1.SizeStoredInPagingFiles) else
  if DATA_DEF[AIndex].Caption = CAPTION_Status then Result := WmiOs1.Status else
  if DATA_DEF[AIndex].Caption = CAPTION_SuiteMask then Result := WmiOs1.SuiteMaskToStr(WmiOs1.SuiteMask) else
  if DATA_DEF[AIndex].Caption = CAPTION_SystemDevice then Result := WmiOs1.SystemDevice else
  if DATA_DEF[AIndex].Caption = CAPTION_SystemDirectory then Result := WmiOs1.SystemDirectory else
  if DATA_DEF[AIndex].Caption = CAPTION_SystemDrive then Result := WmiOs1.SystemDrive else
  if DATA_DEF[AIndex].Caption = CAPTION_TotalSwapSpaceSize then Result := IntToStr(WmiOs1.TotalSwapSpaceSize) else
  if DATA_DEF[AIndex].Caption = CAPTION_TotalVirtualMemorySize then Result := IntToStr(WmiOs1.TotalVirtualMemorySize) else
  if DATA_DEF[AIndex].Caption = CAPTION_TotalVisibleMemorySize then Result := IntToStr(WmiOs1.TotalVisibleMemorySize) else
  if DATA_DEF[AIndex].Caption = CAPTION_TimeZone then Result := IntToStr(WmiOs1.CurrentTimeZone) else
  if DATA_DEF[AIndex].Caption = CAPTION_Version then Result := WmiOs1.Version else
  if DATA_DEF[AIndex].Caption = CAPTION_WindowsDirectory then Result := WmiOs1.WindowsDirectory else
  if DATA_DEF[AIndex].Caption = CAPTION_QuickFixes then Result := QuickFixesToStr else
  if DATA_DEF[AIndex].Caption = CAPTION_Recovery_AutoReboot then Result := BoolToStr(WmiOs1.Recovery.AutoReboot, true) else
  if DATA_DEF[AIndex].Caption = CAPTION_Recovery_DebugFilePath then Result := WmiOs1.Recovery.DebugFilePath else
  if DATA_DEF[AIndex].Caption = CAPTION_Recovery_KernelDumpOnly then Result := BoolToStr(WmiOs1.Recovery.KernelDumpOnly, true) else
  if DATA_DEF[AIndex].Caption = CAPTION_Recovery_OverwriteExistingDebugFile then Result := BoolToStr(WmiOs1.Recovery.OverwriteExistingDebugFile, true) else
  if DATA_DEF[AIndex].Caption = CAPTION_Recovery_SendAdminAlert then Result := BoolToStr(WmiOs1.Recovery.SendAdminAlert, true) else
  if DATA_DEF[AIndex].Caption = CAPTION_Recovery_WriteDebugInfo then Result := GetWriteDebugInfo else
  if DATA_DEF[AIndex].Caption = CAPTION_Recovery_WriteToSystemLog then Result := BoolToStr(WmiOs1.Recovery.WriteToSystemLog, true);
end;

function TFrmOsViewerMain.GetWriteDebugInfo: string;
begin
  if not IsWindowsXPOrHigher then
  begin
    Result := BoolToStr(WmiOs1.Recovery.WriteDebugInfo, true);
  end else
  begin
    Result := BoolToStr(WmiOs1.Recovery.DebugInfoType > 0, true);
  end;
end;



procedure TFrmOsViewerMain.drgPropertiesDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if ARow = 0 then
  begin
    with drgProperties.Canvas do Font.Style := Font.Style + [fsBold];
    case ACol of
      0: drgProperties.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 2, 'Property');
      1: drgProperties.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 2, 'Value');
    end;
  end else
  begin
    case ACol of
      0: begin
           with drgProperties.Canvas do
             if DATA_DEF[ARow -1].Editable then
               Font.Style := Font.Style + [fsBold]
               else Font.Style := Font.Style - [fsBold];
           drgProperties.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 2, DATA_DEF[ARow -1].Caption);
         end;
      1: begin
           drgProperties.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 2, GetValueByIndex(ARow - 1));
         end;
    end;
  end;
end;

procedure TFrmOsViewerMain.drgPropertiesGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  Value := GetValueByIndex(ARow - 1);
  if (not DATA_DEF[ARow -1].Editable) or (not WmiOs1.Active) then drgProperties.EditorMode := false;
end;

procedure TFrmOsViewerMain.Splitter1Moved(Sender: TObject);
begin
  ResizeGridColumns;
end;

procedure TFrmOsViewerMain.DoShowHint(var HintStr: String;
  var CanShow: Boolean; var HintInfo: THintInfo);
var
  ACol, ARow: integer;
begin
  if HintInfo.HintControl = drgProperties then
  begin
    with HintInfo do
    begin
      drgProperties.MouseToCell(CursorPos.X, CursorPos.Y, ACol, ARow);
      CanShow := ARow > 0;

      if CanShow then
      begin
        if ACol = 0 then HintStr := DATA_DEF[ARow - 1].Hint
          else HintStr := GetValueByIndex(ARow - 1);
      end else
      begin
        HintStr := '';
      end;  
    end;
  end;
end;

procedure TFrmOsViewerMain.SetQuantumLength(AValue: string);
begin
  AValue := UpperCase(AValue);
  if AValue = 'UNKNOWN' then WmiOs1.QuantumLength := QL_UNKNOWN else
  if AValue = 'ONE TICK' then WmiOs1.QuantumLength := QL_ONE_TICK else
  if AValue = 'TWO TICKS' then WmiOs1.QuantumLength := QL_TWO_TICKS else
    WmiOs1.QuantumLength := StrToInt(AValue);
end;

procedure TFrmOsViewerMain.SetQuantumType(AValue: string);
begin
  AValue := UpperCase(AValue);
  if AValue = 'UNKNOWN' then WmiOs1.QuantumType := QT_UNKNOWN else
  if AValue = 'FIXED' then WmiOs1.QuantumType := QT_FIXED else
  if AValue = 'VARIABLE' then WmiOs1.QuantumType := QT_VARIABLE else
    WmiOs1.QuantumType := StrToInt(AValue);
end;

procedure TFrmOsViewerMain.SetWriteDebugInfo(AValue: boolean);
begin
  if IsWindowsXPOrHigher then
  begin
    if AValue then WmiOs1.Recovery.DebugInfoType := DIT_SMALL_MEMORY
      else WmiOs1.Recovery.DebugInfoType := DIT_NONE;
  end else
  begin
    WmiOs1.Recovery.WriteDebugInfo := AValue;
  end;
end;

procedure TFrmOsViewerMain.SetOsPropertyByIndex(AIndex: integer; AValue: string);
begin
  if WmiOs1.Active then
  begin
    if DATA_DEF[AIndex].Caption = CAPTION_Description then WmiOs1.Description := AValue else
    if DATA_DEF[AIndex].Caption = CAPTION_ForegroundApplicationBoost then WmiOs1.ForegroundApplicationBoost := StrToInt(AValue) else
    if DATA_DEF[AIndex].Caption = CAPTION_LocalDateTime then WmiOs1.LocalDateTime := StrToDateTime(AValue) else
    if DATA_DEF[AIndex].Caption = CAPTION_QuantumLength then SetQuantumLength(AValue) else
    if DATA_DEF[AIndex].Caption = CAPTION_QuantumType then SetQuantumType(AValue) else
    if DATA_DEF[AIndex].Caption = CAPTION_Recovery_AutoReboot then WmiOs1.Recovery.AutoReboot := StrToBool(AValue) else
    if DATA_DEF[AIndex].Caption = CAPTION_Recovery_DebugFilePath then WmiOs1.Recovery.DebugFilePath := AValue else
    if DATA_DEF[AIndex].Caption = CAPTION_Recovery_KernelDumpOnly then WmiOs1.Recovery.KernelDumpOnly := StrToBool(AValue) else
    if DATA_DEF[AIndex].Caption = CAPTION_Recovery_OverwriteExistingDebugFile then WmiOs1.Recovery.OverwriteExistingDebugFile := StrToBool(AValue) else
    if DATA_DEF[AIndex].Caption = CAPTION_Recovery_SendAdminAlert then WmiOs1.Recovery.SendAdminAlert := StrToBool(AValue) else
    if DATA_DEF[AIndex].Caption = CAPTION_Recovery_WriteDebugInfo then SetWriteDebugInfo(StrToBool(AValue)) else
    if DATA_DEF[AIndex].Caption = CAPTION_Recovery_WriteToSystemLog then WmiOs1.Recovery.WriteToSystemLog := StrToBool(AValue) else
  end;
end;

procedure TFrmOsViewerMain.CommitChanges;
begin
  SetOsPropertyByIndex(drgProperties.Selection.Top - 1, FEditValue);
end;

procedure TFrmOsViewerMain.drgPropertiesSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if drgProperties.EditorMode then CommitChanges;
end;

procedure TFrmOsViewerMain.drgPropertiesExit(Sender: TObject);
begin
  if drgProperties.EditorMode then CommitChanges;
end;

procedure TFrmOsViewerMain.drgPropertiesSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  FEditValue := Value;
end;

procedure TFrmOsViewerMain.drgPropertiesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (drgProperties.EditorMode) then CommitChanges;
end;


procedure TFrmOsViewerMain.InitItems;
var
  vItem: TTreeNode;
begin
  tvBrowser.Items.Add(nil, LOCAL_HOST);
  vItem := tvBrowser.Items.Add(nil, NETWORK);
  tvBrowser.Items.AddChild(vItem, NO_DATA);
end;

procedure TFrmOsViewerMain.tvBrowserExpanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
begin
  AllowExpansion := ProcessNodeExpanding(Node);
end;

function TFrmOsViewerMain.ProcessNodeExpanding(ANode: TTreeNode): boolean;
begin
  Result := true;
  if (ANode.Count = 1) and (ANode.getFirstChild.Text = NO_DATA) then
  begin
    Result := false;
    if (ANode.Text = NETWORK) then Result := LoadRemoteHosts(ANode)
  end
end;

function TFrmOsViewerMain.LoadRemoteHosts(ANode: TTreeNode): boolean;
var
  AList: TStrings;
  i: integer;
begin
  ANode.DeleteChildren;
  AList := TStringList.Create;
  SetWaitCursor;
  try
    WmiOs1.ListServers(AList);
    for i := 0 to AList.Count - 1 do
    begin
      tvBrowser.Items.AddChild(ANode, AList[i]);
    end;
  finally
    AList.Free;
    RestoreCursor;
  end;
  Result := true;
end;

procedure TFrmOsViewerMain.tvBrowserChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
  ProcessChangingNode(Node);
end;

procedure TFrmOsViewerMain.ProcessChangingNode(Node: TTreeNode);
var
  vCredentials: TCredentials;
begin
  if Node.Text = LOCAL_HOST then
  begin
    DoConnect(Node);
  end else
  if Node.Text = NETWORK then
  begin
    WmiOs1.Active := false;
  end else
  begin
    vCredentials := TCredentials (Node.Data);
    if vCredentials <> nil then DoConnect(Node);
  end;
  SetFormCaption;
  drgProperties.Refresh;
  drgProperties.EditorMode := false;
end;


procedure TFrmOsViewerMain.SetWaitCursor;
begin
  FStoredCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
end;

procedure TFrmOsViewerMain.RestoreCursor;
begin
  Screen.Cursor := FStoredCursor;
end;

function TFrmOsViewerMain.DoConnect(ANode: TTreeNode): boolean;
var
  vCredentials: TCredentials;
  vForm: TFrmNewHost;
begin
  Result := false;

  // do not reconnect if already connected to desired host. 
  if (ANode.Text = WmiOs1.MachineName) and
     (WmiOs1.Active) then
  begin
    Result := true;
    Exit;
  end;

  // if the node represents the local host, clear credentials.
  // Otherwise try 1) to connect without credentiols. If it fails 2) ask user
  // for credentials and try co connect again.
  // if connection is a sucess, remember sucessfull credentials, so
  // user does not have to enter them again.

  SetWaitCursor;
  try
    WmiOs1.Active := false;
    if ANode.Text = LOCAL_HOST then
    begin
      // connect to local host;
      WmiOs1.Credentials.Clear;
      WmiOs1.MachineName := '';
      WmiOs1.Active := true;
      Result := true;
    end else
    begin
      if (ANode.Data = nil) then
      begin
        // connect for the first time
        // try default credentials fisrt:
        try
          WmiOs1.Credentials.Clear;
          WmiOs1.MachineName := ANode.Text;
          WmiOs1.Active := true;
          Result := true;
        except
          // expected exception: the credentials are not valid
        end;

        // default credentials did not work.
        // try to connect with user's provided credentials
        if not WmiOs1.Active then
        begin
          vForm := TFrmNewHost.Create(nil);
          vForm.MachineName := ANode.Text;
          try
            while vForm.ShowModal = mrOk do
              try
                WmiOs1.Active := false;
                WmiOs1.Credentials.Clear;
                WmiOs1.MachineName := ANode.Text;
                WmiOs1.Credentials.UserName := vForm.UserName;
                WmiOs1.Credentials.Password := vForm.edtPassword.Text;
                WmiOs1.Active := true;

                // connected successfully; remember credentials
                ANode.Data := TCredentials.Create(vForm.UserName, vForm.edtPassword.Text);
                Result := true;
                Break;
              except
                on e: Exception do
                  Application.MessageBox(PChar(e.Message), 'Error', ID_OK);
              end;
          finally
            vForm.Free;
          end;
        end;
      end else
      begin

        // reconnect with existing credentials
        vCredentials := TCredentials (ANode.Data);
        WmiOs1.MachineName := ANode.Text;
        WmiOs1.Credentials.UserName := vCredentials.UserName;
        WmiOs1.Credentials.Password := vCredentials.Password;
        WmiOs1.Active := true;
        Result := true;
      end;
    end;
  finally
    RestoreCursor;
  end;
end;

procedure TFrmOsViewerMain.SetButtonState;
begin
  tlbRefresh.Enabled := (tvBrowser.Selected <> nil) and (tvBrowser.Selected.Text <> NETWORK);
  tlbReboot.Enabled := tlbRefresh.Enabled;
end;

procedure TFrmOsViewerMain.SetFormCaption;
begin
  if WmiOs1.Active then
  begin
    if WmiOs1.MachineName <> '' then
      Caption := CNST_CAPTION + WmiOs1.MachineName
      else Caption := CNST_CAPTION + LOCAL_HOST;
  end else
  begin
    Caption := 'Operating System Viewer';
  end;
end;

procedure TFrmOsViewerMain.tlbNewHostClick(Sender: TObject);
begin
  CreateNewNetworkNode;
  SetButtonState;
end;

procedure TFrmOsViewerMain.CreateNewNetworkNode;
var
  vForm: TFrmNewHost;
  vNode: TTreeNode;
begin
  vForm := TFrmNewHost.Create(nil);
  try
    while vForm.ShowModal = mrOk do
      try

        WmiOs1.Active := false;
        WmiOs1.Credentials.Clear;
        WmiOs1.MachineName := vForm.edtHostName.Text;
        WmiOs1.Credentials.UserName := vForm.UserName;
        WmiOs1.Credentials.Password := vForm.edtPassword.Text;
        WmiOs1.Active := true;

        // connected successfully; add the new host to a list.
        vNode := FindNeworkNode;
        if (vNode.getFirstChild <> nil) and
           (vNode.getFirstChild.Text = NO_DATA) then vNode.DeleteChildren;

        vNode := tvBrowser.Items.AddChild(vNode, vForm.edtHostName.Text);
        vNode.Data := TCredentials.Create(vForm.UserName, vForm.edtPassword.Text);
        tvBrowser.Selected := vNode;
        Break;

      except
        on e: Exception do
          Application.MessageBox(PChar(e.Message), 'Error', ID_OK);
      end;
  finally
    vForm.Free;
  end;
end;

function TFrmOsViewerMain.FindNeworkNode: TTreeNode;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to tvBrowser.Items.Count - 1 do
    if tvBrowser.Items[i].Text = NETWORK then
    begin
      Result := tvBrowser.Items[i];
      Exit;
    end;
end;

procedure TFrmOsViewerMain.tlbRebootClick(Sender: TObject);
begin
  if WmiOs1.Active then WmiOs1.Reboot;
end;

procedure TFrmOsViewerMain.tlbAboutClick(Sender: TObject);
begin
  with TFrmAbout.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFrmOsViewerMain.tlbRefreshClick(Sender: TObject);
begin
  WmiOs1.Refresh;
end;

procedure TFrmOsViewerMain.tvBrowserChange(Sender: TObject;
  Node: TTreeNode);
begin
  SetButtonState;
end;

end.
