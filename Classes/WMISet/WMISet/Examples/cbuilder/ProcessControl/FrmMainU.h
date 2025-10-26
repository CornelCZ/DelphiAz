//---------------------------------------------------------------------------

#ifndef FrmMainUH
#define FrmMainUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "WmiAbstract.hpp"
#include "WmiComponent.hpp"
#include "WmiProcessControl.hpp"
#include "FrmSelectColumnsU.h"
#include "FrmSelectHostU.h"
#include "FrmNewTaskU.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Menus.hpp>
//---------------------------------------------------------------------------

const int COLUMN_COUNT           = 22;
const int TAG_IMAGE_NAME         = 0;
const int TAG_PID                = 1;
const int TAG_SESSION_ID         = 2;
const int TAG_CPU                = 3;
const int TAG_CPU_TIME           = 4;
const int TAG_MEMORY_USAGE       = 5;
const int TAG_PEAK_MEMORY_USAGE  = 6;
const int TAG_PAGE_FAULTS        = 7;
const int TAG_IO_READS           = 8;
const int TAG_IO_READ_BYTES      = 9;
const int TAG_VIRTUAL_MEMORY_SIZE= 10;
const int TAG_PAGED_POOL         = 11;
const int TAG_NON_PAGED_POOL     = 12;
const int TAG_BASE_PRIORITY      = 13;
const int TAG_HANDLE_COUNT       = 14;
const int TAG_THREAD_COUNT       = 15;
const int TAG_IO_WRITES          = 16;
const int TAG_IO_WRITE_BYTES     = 17;
const int TAG_IO_OTHER           = 18;
const int TAG_IO_OTHER_BYTES     = 19;
const int TAG_STARTED            = 20;
const int TAG_FULL_PATH          = 21;

typedef struct _TColumnRec {
    int         Index;
    TAlignment  Alignment;
    char        *FullName;
    char        *ShortName;  
    bool        Visible;
    int         Width;
    int         Tag;
} TColumnRec, *PColumnRec;

TColumnRec TABLE_DEF[COLUMN_COUNT] = {
   {0,  taLeftJustify,  "Image Name",                   "Image Name",      true,  150,  TAG_IMAGE_NAME},
   {1,  taRightJustify, "PID (Process Identifier}",     "PID",             true,  40,   TAG_PID},
   {2,  taRightJustify, "Session ID",                   "Session ID",      false, 80,   TAG_SESSION_ID},
   {3,  taLeftJustify,  "CPU Usage",                    "CPU",             true,  40,   TAG_CPU},
   {4,  taLeftJustify,  "CPU Time",                     "CPU Time",        true,  75,   TAG_CPU_TIME},
   {5,  taRightJustify, "Memory Usage",                 "Mem Usage",       true,  90,   TAG_MEMORY_USAGE},
   {6,  taRightJustify, "Peak Memory Usage",            "Peak Mem Usage",  false, 150,  TAG_PEAK_MEMORY_USAGE},
   {7,  taRightJustify, "Page Faults",                  "Page Faults",     false, 110,  TAG_PAGE_FAULTS},
   {8,  taRightJustify, "I/O Reads",                    "I/O Reads",       false, 80,   TAG_IO_READS},
   {9,  taRightJustify, "I/O Read Bytes",               "I/O Read Bytes",  false, 150,  TAG_IO_READ_BYTES},
   {10, taRightJustify, "Virtual Memory Size",          "VM Size",         false, 80,   TAG_VIRTUAL_MEMORY_SIZE},
   {11, taRightJustify, "Paged Pool",                   "Paged Pool",      false, 90,   TAG_PAGED_POOL},
   {12, taRightJustify, "Non-paged Pool",               "NP Pool",         false, 80,   TAG_NON_PAGED_POOL},
   {13, taRightJustify, "Base Priority",                "Base Pri",        false, 70,   TAG_BASE_PRIORITY},
   {14, taRightJustify, "Handle Count",                 "Handles",         false, 70,   TAG_HANDLE_COUNT},
   {15, taRightJustify, "Thread Count",                 "Threads",         false, 70,   TAG_THREAD_COUNT},
   {16, taRightJustify, "I/O Writes",                   "I/O Writes",      false, 80,   TAG_IO_WRITES},
   {17, taRightJustify, "I/O Write Bytes",              "I/O Write Bytes", false, 110,  TAG_IO_WRITE_BYTES},
   {18, taRightJustify, "I/O Other",                    "I/O Other",       false, 80,   TAG_IO_OTHER},
   {19, taRightJustify, "I/O Other Bytes",              "I/O Other Bytes", false, 120,  TAG_IO_OTHER_BYTES},
   {20, taLeftJustify,  "Started at",                   "Started at",      false, 150,  TAG_STARTED},
   {21, taLeftJustify,  "Full Path",                    "Full Path",       false, 220,  TAG_FULL_PATH}
   };

WideString DateTimeToStringDef(TDateTime ADateTime);
int GetVisibleColumnIndex(int ATag); 
PColumnRec GetColumnRecByIndex(int AIndex);
PColumnRec GetColumnRecByTag(int ATag);
WideString BytesToSizeString(__int64 ABytes);


class TFrmMain : public TForm
{
__published:	// IDE-managed Components
        TStatusBar *stbInfo;
        TPageControl *pcMain;
        TTabSheet *tsProcesses;
        TPanel *pnlBottom;
        TPanel *pnlButton;
        TButton *btnTerminate;
        TListView *lvProcesses;
        TTabSheet *tsTrace;
        TListBox *lbProcessTrace;
        TMainMenu *mnuMain;
        TMenuItem *miFile;
        TMenuItem *miSelectComputer;
        TMenuItem *miNewTask;
        TMenuItem *N1;
        TMenuItem *miExit;
        TMenuItem *Options1;
        TMenuItem *miRefresh;
        TMenuItem *miUpdateSpeed;
        TMenuItem *miHigh;
        TMenuItem *miNormal;
        TMenuItem *miLow;
        TMenuItem *miPaused;
        TMenuItem *N2;
        TMenuItem *miSelectColumns;
        TWmiProcessControl *wmiProcesses;
        TTimer *tmRefresh;
        void __fastcall miExitClick(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall OnChangeSpeed(TObject *Sender);
        void __fastcall tmRefreshTimer(TObject *Sender);
        void __fastcall miRefreshClick(TObject *Sender);
        void __fastcall btnTerminateClick(TObject *Sender);
        void __fastcall miSelectColumnsClick(TObject *Sender);
        void __fastcall miSelectComputerClick(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall miNewTaskClick(TObject *Sender);
        void __fastcall wmiProcessesProcessStarted(TObject *Sender,
          DWORD ProcessId, WideString ExecutablePath);
        void __fastcall wmiProcessesProcessStopped(TObject *Sender,
          DWORD ProcessId, WideString ExecutablePath);
private:	// User declarations
        // the list of process IDs and their respective CPU time,
        // as measured last time. This is required to calculate deltas.
        TStrings *FPrevProcessList;
        __int64 FPrevTotalProcessTime;
        __int64 FPrevIdleTime;

        // The new list of process IDs and their CPU time.
        TStrings *FNewProcessList;
        __int64 FNewTotalProcessTime;
        __int64 FNewIdleTime;

public:		// User declarations
        __fastcall TFrmMain(TComponent* Owner);
        void __fastcall ReloadProcesses();
        void __fastcall BuildColumns();
        void __fastcall UpdateFormCaption();
        
        
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmMain *FrmMain;
//---------------------------------------------------------------------------
#endif
