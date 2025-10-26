//---------------------------------------------------------------------------

#ifndef FrmOsViewerMainUH
#define FrmOsViewerMainUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "WmiAbstract.hpp"
#include "WmiComponent.hpp"
#include "WmiOs.hpp"
#include "FrmNewHostU.h"
#include "FrmAboutU.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <ImgList.hpp>
#include <ToolWin.hpp>

//---------------------------------------------------------------------------
const char *LOCAL_HOST = "Local Host";
const char *NETWORK = "Network";
const char *NO_DATA = "NO_DATA";
const char *CNST_CAPTION = "Operating System on ";

typedef struct _TDataDefRec {
    int Index;
    const char *Caption;
    bool Editable;
    const char *Hint;
} TDataDefRec, *PDataDefRec;

const char *CAPTION_BootDevice                 = "Boot Device";
const char *CAPTION_BuildNumber                = "Build Number";
const char *CAPTION_BuildType                  = "Build Type";
const char *CAPTION_Caption                    = "Caption";
const char *CAPTION_CodeSet                    = "Code Set";
const char *CAPTION_CountryCode                = "Country Code";
const char *CAPTION_CSDVersion                 = "Service Pack";
const char *CAPTION_CSName                     = "Computer Name";
const char *CAPTION_CurrentTimeZone            = "Current Time Zone";
const char *CAPTION_Debug                      = "Debug build";
const char *CAPTION_Description                = "Description";
const char *CAPTION_Distributed                = "Distributed";
const char *CAPTION_EncryptionLevel            = "Encryption Level";
const char *CAPTION_ForegroundApplicationBoost = "Foreground Application Boost";
const char *CAPTION_FreePhysicalMemory         = "Free Physical Memory";
const char *CAPTION_FreeSpaceInPagingFiles     = "Free Space In Paging Files";
const char *CAPTION_FreeVirtualMemory          = "Free Virtual Memory";
const char *CAPTION_InstallDate                = "Install Date";
const char *CAPTION_LargeSystemCache           = "Large System Cache";
const char *CAPTION_LastBootUpTime             = "Last BootUp Time";
const char *CAPTION_LocalDateTime              = "Local Date Time";
const char *CAPTION_Locale                     = "Locale";
const char *CAPTION_Manufacturer               = "Manufacturer";
const char *CAPTION_MaxNumberOfProcesses       = "Max Number Of Processes";
const char *CAPTION_MaxProcessMemorySize       = "Max Process MemorySize";
const char *CAPTION_NumberOfLicensedUsers      = "Number Of Licensed Users";
const char *CAPTION_NumberOfProcesses          = "Number Of Processes";
const char *CAPTION_NumberOfUsers              = "Number Of Users";
const char *CAPTION_Organization               = "Organization";
const char *CAPTION_OSLanguage                 = "OS Language";
const char *CAPTION_OSName                     = "OS Name";
const char *CAPTION_OSProductSuite             = "OS Product Suite";
const char *CAPTION_OSType                     = "OS Type";
const char *CAPTION_OtherTypeDescription       = "Other Type Description";
const char *CAPTION_PlusProductID              = "Plus Product ID";
const char *CAPTION_PlusVersionNumber          = "Plus Version Number";
const char *CAPTION_Primary                    = "Primary";
const char *CAPTION_QuantumLength              = "Quantum Length";
const char *CAPTION_QuantumType                = "Quantum Type";
const char *CAPTION_RegisteredUser             = "Registered User";
const char *CAPTION_SerialNumber               = "Serial Number";
const char *CAPTION_ServicePackMajorVersion    = "Service Pack Major Version";
const char *CAPTION_ServicePackMinorVersion    = "Service Pack Minor Version";
const char *CAPTION_SizeStoredInPagingFiles    = "Size Stored In Paging Files";
const char *CAPTION_Status                     = "Status";
const char *CAPTION_SuiteMask                  = "Suite Mask";
const char *CAPTION_SystemDevice               = "System Device";
const char *CAPTION_SystemDirectory            = "System Directory";
const char *CAPTION_SystemDrive                = "System Drive";
const char *CAPTION_TotalSwapSpaceSize         = "Total Swap Space Size";
const char *CAPTION_TotalVirtualMemorySize     = "Total Virtual Memory Size";
const char *CAPTION_TotalVisibleMemorySize     = "Total Visible Memory Size";
const char *CAPTION_TimeZone                   = "Time Zone";
const char *CAPTION_Version                    = "Version";
const char *CAPTION_WindowsDirectory           = "Windows Directory";
const char *CAPTION_QuickFixes                 = "Quick Fixes";
const char *CAPTION_Recovery_AutoReboot        = "Recovery: auto reboot";
const char *CAPTION_Recovery_DebugFilePath     = "Recovery: debug file path";
const char *CAPTION_Recovery_KernelDumpOnly    = "Recovery: kernel dump only";
const char *CAPTION_Recovery_OverwriteExistingDebugFile = "Recovery: overwrite debug files";
const char *CAPTION_Recovery_SendAdminAlert    = "Recovery: send admin alert";
const char *CAPTION_Recovery_WriteDebugInfo    = "Recovery: write debug info";
const char *CAPTION_Recovery_WriteToSystemLog  = "Recovery: write to system log";

const int PROP_COUNT = 63;
  TDataDefRec DATA_DEF[PROP_COUNT] = {
    {0, CAPTION_BootDevice, false, "Name of the disk drive from which the Win32 operating system boots."},
    {1, CAPTION_BuildNumber, false, "Build number of an operating system."},
    {2, CAPTION_BuildType, false, "Type of build used for an operating system."},
    {3, CAPTION_Caption, false, "Short description of the object—a one-line string. The string includes the operating system version. "},
    {4, CAPTION_CodeSet, false, "Code page value an operating system uses. A code page contains a character table that an operating system uses to translate strings for different languages."},
    {5, CAPTION_CountryCode, false, "Code for the country/region that an operating system uses. Values are based on international phone dialing prefixes—also referred to as IBM country/region codes."},
    {6, CAPTION_CSDVersion, false, "Indicates the latest service pack installed on a computer system. "},
    {7, CAPTION_CSName, false, "Name of the computer system."},
    {8, CAPTION_CurrentTimeZone, false, "Number of minutes an operating system is offset from Greenwich mean time {GMT}."},
    {9, CAPTION_Debug, false, "Operating system is a checked {debug} build."},
    {10, CAPTION_Description, true, "Description of the Windows operating system."},
    {11, CAPTION_Distributed, false, "If operating system is distributed across several computer system nodes. "},
    {12, CAPTION_EncryptionLevel, false, "Encryption level for secure transactions—40-bit, 128-bit, or n-bit."},
    {13, CAPTION_ForegroundApplicationBoost, true, "Increase in priority given to the foreground application. \n 0: None; 1: Minimum; 2: {Default} Maximum"},
    {14, CAPTION_FreePhysicalMemory, false, "Number of kilobytes of physical memory currently unused and available."},
    {15, CAPTION_FreeSpaceInPagingFiles, false, "Number of kilobytes that can be mapped into the operating system paging files without causing any other pages to be swapped out."},
    {16, CAPTION_FreeVirtualMemory, false, "Number of kilobytes of virtual memory currently unused and available."},
    {17, CAPTION_InstallDate, false, "Date when the OS was installed. "},
    {18, CAPTION_LargeSystemCache, false, "Windows Server 2003, Windows XP:  Indicates whether or not to optimize memory for applications or system performance. \n \
                                          0: Optimize for applications; 1: Optimize for system performance"},
    {19, CAPTION_LastBootUpTime, false, "Time when operating system was last booted."},
    {20, CAPTION_LocalDateTime, true, "Operating system""s version of the local date and time of day."},
    {21, CAPTION_Locale, false, "Language identifier used by the operating system."},
    {22, CAPTION_Manufacturer, false, "Name of the operating system manufacturer."},
    {23, CAPTION_MaxNumberOfProcesses, false, "Maximum number of process contexts the operating system can support."},
    {24, CAPTION_MaxProcessMemorySize, false, "Maximum number of kilobytes of memory that can be allocated to a process."},
    {25, CAPTION_NumberOfLicensedUsers, false, "Number of user licenses for the operating system. If unlimited, returns 0 (zero)."},
    {26, CAPTION_NumberOfProcesses, false, "Number of process contexts currently loaded or running on the operating system."},
    {27, CAPTION_NumberOfUsers, false, "Number of user sessions for which the operating system is storing state information currently."},
    {28, CAPTION_Organization, false, "Company name for the registered user of the operating system."},
    {29, CAPTION_OSLanguage, false, "Language version of the operating system installed."},
    {30, CAPTION_OSName, false, "Operating system instance within a computer system."},
    {31, CAPTION_OSProductSuite, false, "Installed and licensed system product additions to the operating system."},
    {32, CAPTION_OSType, false, "Type of operating system."},
    {33, CAPTION_OtherTypeDescription, false, "Manufacturer and operating system type that is used when the operating system property OS Type is set to \"Other\". "},
    {34, CAPTION_PlusProductID, false, "Identification number for the Windows Plus! operating system enhancement software—if installed."},
    {35, CAPTION_PlusVersionNumber, false, "Version number of the Windows Plus! operating system enhancement software—if installed."},
    {36, CAPTION_Primary, false, "Indicates primary operating system."},
    {37, CAPTION_QuantumLength, true, "Number of clock ticks per quantum. \n 0: Unknown; 1: One tick; 2: Two ticks"},
    {38, CAPTION_QuantumType, true, "Length type of quantums. Windows NT 4.0 Workstation/Windows 2000 defaults to \
           variable-length quantums where the foreground application has a longer quantum than  \
           the background applications. Windows NT server defaults to fixed-length quantums. \n  \
           0: Unknown; 1: Fixed; 2: Variable"},
    {39, CAPTION_RegisteredUser, false, "Name of the registered user of the operating system."},
    {40, CAPTION_Recovery_AutoReboot, true, "System will automatically reboot during a recovery operation."},
    {41, CAPTION_Recovery_DebugFilePath, true, "Full path to the debug file. A debug file is created with the memory state of the computer after a computer failure."},
    {42, CAPTION_Recovery_KernelDumpOnly, true, "Only kernel debug information will be written to the debug log file."},
    {43, CAPTION_Recovery_OverwriteExistingDebugFile, true, "New log file will overwrite an existing one."},
    {44, CAPTION_Recovery_SendAdminAlert, true, "Alert message will be sent to the system administrator in the event of an operating system failure."},
    {45, CAPTION_Recovery_WriteDebugInfo, true, "Debugging information is to be written to a log file."},
    {46, CAPTION_Recovery_WriteToSystemLog, true, "Events will be written to a system log."},
    {47, CAPTION_SerialNumber, false, "Operating system product serial identification number."},
    {48, CAPTION_ServicePackMajorVersion, false, "Major version number of the service pack installed on the computer system."},
    {49, CAPTION_ServicePackMinorVersion, false, "Minor version number of the service pack installed on the computer system."},
    {50, CAPTION_SizeStoredInPagingFiles, false, "Total number of kilobytes that can be stored in the operating system""s paging files"},
    {51, CAPTION_Status, false, "Current status of the operating system."},
    {52, CAPTION_SuiteMask, false, "Windows Server 2003, Windows XP:  the product suites available on the system."},
    {53, CAPTION_SystemDevice, false, "Physical disk partition on which the operating system is installed."},
    {54, CAPTION_SystemDirectory, false, "System directory of the operating system."},
    {55, CAPTION_SystemDrive, false, "Windows Server 2003, Windows XP:  Letter of the disk drive on which the operating system resides."},
    {56, CAPTION_TotalSwapSpaceSize, false, "Total swap space in kilobytes."},
    {57, CAPTION_TotalVirtualMemorySize, false, "Number of kilobytes of virtual memory."},
    {58, CAPTION_TotalVisibleMemorySize, false, "Total amount of physical memory available to the operating system."},
    {59, CAPTION_TimeZone, false, "Operating system""s time zone"},
    {60, CAPTION_Version, false, "Version number of the operating system."},
    {61, CAPTION_WindowsDirectory, false, "Windows directory of the operating system."},
    {62, CAPTION_QuickFixes, false, "List of installed quick fixes"}
  };



//---------------------------------------------------------------------------
class TCredentials : public TObject
{
private:
    WideString FUserName;
    WideString FPassword;
public:
    __fastcall TCredentials(WideString AUserName, WideString APassword);

    __property WideString UserName = {read=FUserName};
    __property WideString Password = {read=FPassword};
};

//---------------------------------------------------------------------------
class TFrmOsViewerMain : public TForm
{
__published:	// IDE-managed Components
        TSplitter *Splitter1;
        TTreeView *tvBrowser;
        TToolBar *ToolBar1;
        TToolButton *tlbNewHost;
        TToolButton *ToolButton1;
        TToolButton *tlbRefresh;
        TToolButton *ToolButton4;
        TToolButton *tlbReboot;
        TToolButton *ToolButton2;
        TToolButton *tlbAbout;
        TDrawGrid *drgProperties;
        TImageList *ilToolbar;
        TWmiOs *WmiOs1;
        void __fastcall FormResize(TObject *Sender);
        void __fastcall FormMouseUp(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall drgPropertiesDrawCell(TObject *Sender, int ACol,
          int ARow, TRect &Rect, TGridDrawState State);
        void __fastcall drgPropertiesGetEditText(TObject *Sender, int ACol,
          int ARow, AnsiString &Value);
        void __fastcall Splitter1Moved(TObject *Sender);
        void __fastcall drgPropertiesSelectCell(TObject *Sender, int ACol,
          int ARow, bool &CanSelect);
        void __fastcall drgPropertiesExit(TObject *Sender);
        void __fastcall drgPropertiesSetEditText(TObject *Sender, int ACol,
          int ARow, const AnsiString Value);
        void __fastcall drgPropertiesKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
        void __fastcall tvBrowserExpanding(TObject *Sender,
          TTreeNode *Node, bool &AllowExpansion);
        void __fastcall tvBrowserChanging(TObject *Sender, TTreeNode *Node,
          bool &AllowChange);
        void __fastcall tlbNewHostClick(TObject *Sender);
        void __fastcall tlbRebootClick(TObject *Sender);
        void __fastcall tlbAboutClick(TObject *Sender);
        void __fastcall tlbRefreshClick(TObject *Sender);
        void __fastcall tvBrowserChange(TObject *Sender, TTreeNode *Node);
private:	// User declarations
        AnsiString FEditValue;
        TCursor FStoredCursor;
        void __fastcall ResizeGridColumns();
        AnsiString __fastcall QuickFixesToStr();
        AnsiString __fastcall GetValueByIndex(int AIndex);
        AnsiString __fastcall GetWriteDebugInfo();
        void __fastcall DoShowHint(AnsiString &HintStr, bool &CanShow, THintInfo &HintInfo);
        void __fastcall SetQuantumLength(AnsiString AValue);
        void __fastcall SetQuantumType(AnsiString AValue);
        void __fastcall SetWriteDebugInfo(bool AValue);
        void __fastcall SetOsPropertyByIndex(int AIndex, AnsiString AValue);
        void __fastcall CommitChanges();
        void __fastcall InitItems();
        bool __fastcall ProcessNodeExpanding(TTreeNode *ANode);
        bool __fastcall LoadRemoteHosts(TTreeNode *ANode);
        void __fastcall ProcessChangingNode(TTreeNode *Node);
        void __fastcall SetWaitCursor();
        void __fastcall RestoreCursor();
        bool __fastcall DoConnect(TTreeNode *ANode);
        void __fastcall SetButtonState();
        void __fastcall SetFormCaption();
        void __fastcall CreateNewNetworkNode();
        TTreeNode * __fastcall FindNeworkNode();
public:		// User declarations
        __fastcall TFrmOsViewerMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmOsViewerMain *FrmOsViewerMain;
//---------------------------------------------------------------------------
#endif
