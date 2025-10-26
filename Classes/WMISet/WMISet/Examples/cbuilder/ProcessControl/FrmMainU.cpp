//---------------------------------------------------------------------------

#include <vcl.h>
#include <math.h>
#include <systdate.h>
#pragma hdrstop

#include "FrmMainU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "WmiAbstract"
#pragma link "WmiComponent"
#pragma link "WmiProcessControl"
#pragma resource "*.dfm"

TFrmMain *FrmMain;

//---------------------------------------------------------------------------
PColumnRec GetColumnRecByTag(int ATag) {
  for (int i = 0; i < COLUMN_COUNT; i++) {
    if (TABLE_DEF[i].Tag == ATag) {
      return &TABLE_DEF[i];
    };
  }  
  throw new Exception("Column not found");
};

//---------------------------------------------------------------------------
PColumnRec GetColumnRecByIndex(int AIndex) {
  for (int i = 0; i < COLUMN_COUNT; i++) {
    if (TABLE_DEF[i].Index == AIndex) {
      return &TABLE_DEF[i];
    };
  }  
  throw new Exception("Column not found");
};

//---------------------------------------------------------------------------
int GetVisibleColumnIndex(int ATag) { 
  int result = 0;
  for (int i = 0; i < COLUMN_COUNT ; i++) {
      if (TABLE_DEF[i].Tag == ATag) {
          if (!TABLE_DEF[i].Visible) {
              result = -1;
          }
          return result;
      } else {
          if (TABLE_DEF[i].Visible) {
              result++;
          }
      };
  }
  throw new Exception("Column not found");
};

//---------------------------------------------------------------------------
WideString DateTimeToStringDef(TDateTime ADateTime) {
  if (ADateTime.Val == 0) {
      return "";
  } else {
      return DateTimeToStr(ADateTime);
  }
};

//---------------------------------------------------------------------------
AnsiString ProcessorTimeToString(__int64 A100Nonasec) {
  // Show time as number of hours, minutes, seconds;
  // number of hours may be more than 24;
  AnsiString result = "";
  double vTmp = 60;
  vTmp = vTmp * 60 * 24 * 10000000;
  TDateTime vDateTime = A100Nonasec /vTmp;
  double vOneHour  = 1.0/24.0;
  double vHours  = floor(vDateTime.Val / vOneHour);
  DateTimeToString(result, ":nn:ss", vDateTime);
  int intHours = vHours;
  result = IntToStr(intHours) + result;
  return result;
};

//---------------------------------------------------------------------------
WideString BytesToSizeString(__int64 ABytes) {
  if (ABytes < 1024) {
      return IntToStr(ABytes);
  } else  if ((ABytes >= 1024) && (ABytes < 10000)) {
      double vValue = ABytes / 1024;
      TVarRec v[] = {vValue}; 
      return Format("%2.1n K", v, 1);
  } else {
      double vValue = ABytes / 1024;
      TVarRec v[] = {vValue}; 
      return Format("%6.0n K", v, 1);
  }
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::ReloadProcesses() {
  UpdateFormCaption();

  lvProcesses->Items->BeginUpdate();
  __try {
      int vBottomIndex = 0;
      if (lvProcesses->TopItem != NULL) {
          vBottomIndex = lvProcesses->TopItem->Index + lvProcesses->VisibleRowCount - 1;
      }  

      unsigned int vOldSelectedProcessId = -1;
      if (lvProcesses->Selected != NULL) {
          vOldSelectedProcessId = wmiProcesses->Processes->Items[lvProcesses->Selected->Index]->ProcessId;
      }
    
      lvProcesses->Items->Clear();
      wmiProcesses->Refresh();
      FNewProcessList->Clear();
      FNewTotalProcessTime = 0;
      for (int iProcess = 0; iProcess < wmiProcesses->Processes->Count; iProcess++) {
         TWmiProcess *vProcess = wmiProcesses->Processes->Items[iProcess];
         TListItem *vItem = lvProcesses->Items->Add();
         vItem->Caption = vProcess->Caption;
         __int64 vCpuTime = vProcess->KernelModeTime + vProcess->UserModeTime;
         FNewProcessList->Add(IntToStr(vProcess->ProcessId) + "=" + IntToStr(vCpuTime));
         if (vProcess->ProcessId == 0) {
             FNewIdleTime = vCpuTime;
         } else {    
             FNewTotalProcessTime = FNewTotalProcessTime + vCpuTime;
         }    

         if (vOldSelectedProcessId == vProcess->ProcessId) {
             lvProcesses->Selected = vItem;
         }    

         for (int iColumn = 1; iColumn < COLUMN_COUNT; iColumn++) {
             TColumnRec *vColumnRec = GetColumnRecByIndex(iColumn);
             if (vColumnRec->Visible) {
               switch (vColumnRec->Tag) {
                 case TAG_PID:
                   vItem->SubItems->Add(IntToStr(vProcess->ProcessId));
                   break;
                 case TAG_SESSION_ID:
                   vItem->SubItems->Add(IntToStr(vProcess->SessionId));
                   break;
                 case TAG_CPU:
                   vItem->SubItems->Add(""); // this is just a place holder; value will be added later
                   break;
                 case TAG_CPU_TIME:
                   vItem->SubItems->Add(ProcessorTimeToString(vCpuTime));
                   break;
                 case TAG_MEMORY_USAGE:
                   vItem->SubItems->Add(BytesToSizeString(vProcess->WorkingSetSize));
                   break;
                 case TAG_PEAK_MEMORY_USAGE:
                   vItem->SubItems->Add(BytesToSizeString(vProcess->PeakWorkingSetSize));
                   break;
                 case TAG_PAGE_FAULTS:
                   vItem->SubItems->Add(IntToStr(vProcess->PageFaults));
                   break;
                 case TAG_IO_READS:
                   vItem->SubItems->Add(IntToStr(vProcess->ReadOperationCount));
                   break;
                 case TAG_IO_READ_BYTES:
                   vItem->SubItems->Add(BytesToSizeString(vProcess->ReadTransferCount));
                   break;
                 case TAG_VIRTUAL_MEMORY_SIZE:
                   vItem->SubItems->Add(BytesToSizeString(vProcess->PeakVirtualSize));
                   break;
                 case TAG_PAGED_POOL:
                   vItem->SubItems->Add(BytesToSizeString(vProcess->QuotaPagePoolUsage));
                   break;
                 case TAG_NON_PAGED_POOL:
                   vItem->SubItems->Add(BytesToSizeString(vProcess->QuotaNonPagePoolUsage));
                   break;
                 case TAG_BASE_PRIORITY:
                   vItem->SubItems->Add(IntToStr(vProcess->Priority));
                   break;
                 case TAG_HANDLE_COUNT:
                   vItem->SubItems->Add(IntToStr(vProcess->HandleCount));
                   break;
                 case TAG_THREAD_COUNT:
                   vItem->SubItems->Add(IntToStr(vProcess->ThreadCount));
                   break;
                 case TAG_IO_WRITES:
                   vItem->SubItems->Add(IntToStr(vProcess->WriteOperationCount));
                   break;
                 case TAG_IO_WRITE_BYTES:
                   vItem->SubItems->Add(BytesToSizeString(vProcess->WriteTransferCount));
                   break;
                 case TAG_IO_OTHER:
                   vItem->SubItems->Add(IntToStr(vProcess->OtherOperationCount));
                   break;
                 case TAG_IO_OTHER_BYTES:
                   vItem->SubItems->Add(BytesToSizeString(vProcess->OtherTransferCount));
                   break;
                 case TAG_STARTED:
                   vItem->SubItems->Add(DateTimeToStringDef(vProcess->CreationDate));
                   break;
                 case TAG_FULL_PATH:
                   vItem->SubItems->Add(vProcess->ExecutablePath);
                   break;
                 default: throw new Exception("Unknown column"); 
               };
             };
         };
      };

      // calculate deltas
      __int64 vDeltaIdle = FNewIdleTime - FPrevIdleTime;
      __int64 vTotalDeltaCpu  = FNewTotalProcessTime - FPrevTotalProcessTime;

      TVarRec v[] = {FNewProcessList->Count}; 
      stbInfo->Panels->Items[0]->Text = Format("Processes: %d ", v, 1);
      if ((vTotalDeltaCpu + vDeltaIdle) != 0) {
        double vCpuUsage = (vTotalDeltaCpu/(vTotalDeltaCpu + vDeltaIdle)) * 100;
        TVarRec v1[] = {vCpuUsage};
        stbInfo->Panels->Items[1]->Text = Format("CPU Usage: %2.0f %", v1, 1);
      }  

      // If corresponding column is visible,  fill in CPU  usage for each process
      int iColumn = GetVisibleColumnIndex(TAG_CPU);
      if (iColumn != -1) {
        for (int iProcess = 0; iProcess < FNewProcessList->Count; iProcess++) {
          AnsiString vName        = FNewProcessList->Names[iProcess];
          __int64 vCpuTime        = StrToInt64(FNewProcessList->Values[vName]);
          __int64 vPrevCpuTime    = StrToInt64Def(FPrevProcessList->Values[vName], 0);
          __int64 vProcessDeltaCpu = vCpuTime - vPrevCpuTime;
          double vCpuUsage            = (vProcessDeltaCpu/(vTotalDeltaCpu + vDeltaIdle)) * 100;
          TListItem *vItem = lvProcesses->Items->Item[iProcess];
          TVarRec v2[] = {vCpuUsage};
          vItem->SubItems->Strings[iColumn - 1] = Format("%2.0f ", v2, 1);
        };
      };

      // save current times to be able to calculate deltas next time:
      FPrevProcessList->Assign(FNewProcessList);
      FPrevIdleTime = FNewIdleTime;
      FPrevTotalProcessTime = FNewTotalProcessTime;

      if (vBottomIndex >= lvProcesses->Items->Count) {
          vBottomIndex = lvProcesses->Items->Count - 1;
      }  

      if (vBottomIndex >= 0) {
          lvProcesses->Items->Item[vBottomIndex]->MakeVisible(true);
      }  
  } __finally {
      lvProcesses->Items->EndUpdate();
  };
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::BuildColumns() {
  lvProcesses->Columns->BeginUpdate();
  __try {
      lvProcesses->Columns->Clear();
      for (int i = 0; i < COLUMN_COUNT; i++) {
        if (TABLE_DEF[i].Visible) {
          TListColumn *vColumn  = lvProcesses->Columns->Add();
          vColumn->Caption      = TABLE_DEF[i].ShortName;
          vColumn->Width        = TABLE_DEF[i].Width;
          vColumn->Alignment    = TABLE_DEF[i].Alignment;
        };
      };
  } __finally {
      lvProcesses->Columns->EndUpdate();
  };
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::UpdateFormCaption() {
  AnsiString s1 = "Processes on ";
  AnsiString s2 = Trim(wmiProcesses->MachineName);
  if (s2.Length() == 0) {
      Caption = s1 + "local computer";
  } else {
      Caption = s1 + s2;
  }    
};

//---------------------------------------------------------------------------
__fastcall TFrmMain::TFrmMain(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::miExitClick(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::FormCreate(TObject *Sender)
{
  FPrevProcessList = new TStringList();
  FNewProcessList  = new TStringList();

  lvProcesses->DoubleBuffered = true;
  wmiProcesses->Active = true;
  BuildColumns();
  ReloadProcesses();
}
//---------------------------------------------------------------------------


void __fastcall TFrmMain::OnChangeSpeed(TObject *Sender)
{
  TMenuItem *vMenuItem = (TMenuItem *)Sender;
  vMenuItem->Checked = true;
  
  int vInterval = vMenuItem->Tag;
  tmRefresh->Enabled = vInterval != 0;
  tmRefresh->Interval = vInterval;
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::tmRefreshTimer(TObject *Sender)
{
  ReloadProcesses();
}
//---------------------------------------------------------------------------


void __fastcall TFrmMain::miRefreshClick(TObject *Sender)
{
  ReloadProcesses();
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::btnTerminateClick(TObject *Sender)
{
  if (lvProcesses->Selected != NULL) {
    AnsiString vMessage = "WARNING: terminating the process may cause data loss and ";
    vMessage += "system instability. Do you want to continue? ";
    if (Application->MessageBox(vMessage.c_str(), "Warning", MB_ICONWARNING + MB_YESNO) == IDYES) {
      int vIndex = lvProcesses->Selected->Index;
      wmiProcesses->Processes->Items[vIndex]->Terminate(0);
      ReloadProcesses();
    };
  };  
}

//---------------------------------------------------------------------------
void __fastcall TFrmMain::miSelectColumnsClick(TObject *Sender)
{
  TFrmSelectColumns *vForm = new TFrmSelectColumns(NULL); 
  __try {
      vForm->chbIOOther->Checked         = GetColumnRecByTag(TAG_IO_OTHER)->Visible;
      vForm->chbPID->Checked             = GetColumnRecByTag(TAG_PID)->Visible;
      vForm->chbIOOtherBytes->Checked    = GetColumnRecByTag(TAG_IO_OTHER_BYTES)->Visible;
      vForm->chbCpuUsage->Checked        = GetColumnRecByTag(TAG_CPU)->Visible;
      vForm->chbPagedPool->Checked       = GetColumnRecByTag(TAG_PAGED_POOL)->Visible;
      vForm->chbCpuTime->Checked         = GetColumnRecByTag(TAG_CPU_TIME)->Visible;
      vForm->chbNonPagedPool->Checked    = GetColumnRecByTag(TAG_NON_PAGED_POOL)->Visible;
      vForm->chbMemoryUsage->Checked     = GetColumnRecByTag(TAG_MEMORY_USAGE)->Visible;
      vForm->chbBasePriority->Checked    = GetColumnRecByTag(TAG_BASE_PRIORITY)->Visible;
      vForm->chbPeakMemoryUsage->Checked = GetColumnRecByTag(TAG_PEAK_MEMORY_USAGE)->Visible;
      vForm->chbHandleCount->Checked     = GetColumnRecByTag(TAG_HANDLE_COUNT)->Visible;
      vForm->chbPageFaults->Checked      = GetColumnRecByTag(TAG_PAGE_FAULTS)->Visible;
      vForm->chbThreadCount->Checked     = GetColumnRecByTag(TAG_THREAD_COUNT)->Visible;
      vForm->chbIOReads->Checked         = GetColumnRecByTag(TAG_IO_READS)->Visible;
      vForm->chbVirtualMemory->Checked   = GetColumnRecByTag(TAG_VIRTUAL_MEMORY_SIZE)->Visible;
      vForm->chbIOReadBytes->Checked     = GetColumnRecByTag(TAG_IO_READ_BYTES)->Visible;
      vForm->chbSessionId->Checked       = GetColumnRecByTag(TAG_SESSION_ID)->Visible;
      vForm->chbIOWrites->Checked        = GetColumnRecByTag(TAG_IO_WRITES)->Visible;
      vForm->chbStartedAt->Checked       = GetColumnRecByTag(TAG_STARTED)->Visible;
      vForm->chbIOWriteBytes->Checked    = GetColumnRecByTag(TAG_IO_WRITE_BYTES)->Visible;
      vForm->chbFullPath->Checked        = GetColumnRecByTag(TAG_FULL_PATH)->Visible;

      if (vForm->ShowModal() == mrOk) {
        GetColumnRecByTag(TAG_IO_OTHER)->Visible            = vForm->chbIOOther->Checked;
        GetColumnRecByTag(TAG_PID)->Visible                 = vForm->chbPID->Checked;             
        GetColumnRecByTag(TAG_IO_OTHER_BYTES)->Visible      = vForm->chbIOOtherBytes->Checked;
        GetColumnRecByTag(TAG_CPU)->Visible                 = vForm->chbCpuUsage->Checked;        
        GetColumnRecByTag(TAG_PAGED_POOL)->Visible          = vForm->chbPagedPool->Checked;       
        GetColumnRecByTag(TAG_CPU_TIME)->Visible            = vForm->chbCpuTime->Checked;         
        GetColumnRecByTag(TAG_NON_PAGED_POOL)->Visible      = vForm->chbNonPagedPool->Checked;    
        GetColumnRecByTag(TAG_MEMORY_USAGE)->Visible        = vForm->chbMemoryUsage->Checked;     
        GetColumnRecByTag(TAG_BASE_PRIORITY)->Visible       = vForm->chbBasePriority->Checked;
        GetColumnRecByTag(TAG_PEAK_MEMORY_USAGE)->Visible   = vForm->chbPeakMemoryUsage->Checked;
        GetColumnRecByTag(TAG_HANDLE_COUNT)->Visible        = vForm->chbHandleCount->Checked;     
        GetColumnRecByTag(TAG_PAGE_FAULTS)->Visible         = vForm->chbPageFaults->Checked;      
        GetColumnRecByTag(TAG_THREAD_COUNT)->Visible        = vForm->chbThreadCount->Checked;     
        GetColumnRecByTag(TAG_IO_READS)->Visible            = vForm->chbIOReads->Checked;         
        GetColumnRecByTag(TAG_VIRTUAL_MEMORY_SIZE)->Visible = vForm->chbVirtualMemory->Checked;   
        GetColumnRecByTag(TAG_IO_READ_BYTES)->Visible       = vForm->chbIOReadBytes->Checked;     
        GetColumnRecByTag(TAG_SESSION_ID)->Visible          = vForm->chbSessionId->Checked;       
        GetColumnRecByTag(TAG_IO_WRITES)->Visible           = vForm->chbIOWrites->Checked;        
        GetColumnRecByTag(TAG_STARTED)->Visible             = vForm->chbStartedAt->Checked;       
        GetColumnRecByTag(TAG_IO_WRITE_BYTES)->Visible      = vForm->chbIOWriteBytes->Checked;    
        GetColumnRecByTag(TAG_FULL_PATH)->Visible           = vForm->chbFullPath->Checked;

        BuildColumns();
        ReloadProcesses();        
      };

  } __finally {
    vForm->Free();
  }; 
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::miSelectComputerClick(TObject *Sender) {
 
  if (FrmSelectHost->ShowModal() == mrOk) {
    // save current credentials to be able to restore
    // them if new credentials are invalid.
    WideString vOldUserName = wmiProcesses->Credentials->UserName;
    WideString vOldPassword = wmiProcesses->Credentials->Password;
    WideString vOldMachineName = wmiProcesses->MachineName;

    wmiProcesses->Active = false;
    tmRefresh->Enabled   = false;
    AnsiString vUserName = FrmSelectHost->edtUserName->Text;
    if (FrmSelectHost->edtDomain->Text.Length() > 0) { 
      vUserName = FrmSelectHost->edtDomain->Text + "\\" + vUserName;
    }  
      
    wmiProcesses->Credentials->UserName = vUserName;
    wmiProcesses->Credentials->Password = FrmSelectHost->edtPassword->Text;
    wmiProcesses->MachineName = FrmSelectHost->cmbComputers->Text;

    TCursor vWasCursor = Screen->Cursor;
    Screen->Cursor = crHourGlass;
    try {
      __try {
        wmiProcesses->Active = true;
        ReloadProcesses();
        tmRefresh->Enabled   = true;
        lbProcessTrace->Items->Add(wmiProcesses->MachineName);
      } __finally {
        Screen->Cursor = vWasCursor;
      };
    } catch(const Exception &e) {
          Application->MessageBox(e.Message.c_str(), "Error", MB_OK + MB_ICONSTOP);
          // restore previous credentials.
          wmiProcesses->Credentials->UserName = vOldUserName;
          wmiProcesses->Credentials->Password = vOldPassword;
          wmiProcesses->MachineName           = vOldMachineName; 
          wmiProcesses->Active = true;
          ReloadProcesses();
          tmRefresh->Enabled   = true;
    };
  };
};
//---------------------------------------------------------------------------

void __fastcall TFrmMain::FormDestroy(TObject *Sender)
{
    FPrevProcessList->Free();
    FNewProcessList->Free();
}

//---------------------------------------------------------------------------
void __fastcall TFrmMain::miNewTaskClick(TObject *Sender)
{
  if (FrmNewTask->ShowModal() == mrOk) {
      AnsiString vPath = ExtractFilePath(FrmNewTask->edtFileName->Text);
      if (vPath.Length() == 0) {
          vPath = "c:\\";
      }    
      wmiProcesses->StartProcess(FrmNewTask->edtFileName->Text, vPath, false);
  };
}

//---------------------------------------------------------------------------
void __fastcall TFrmMain::wmiProcessesProcessStarted(TObject *Sender,
      DWORD ProcessId, WideString ExecutablePath)
{
  lbProcessTrace->Items->Add("Process started: "+ IntToStr(ProcessId) + " " + ExecutablePath);
}

//---------------------------------------------------------------------------
void __fastcall TFrmMain::wmiProcessesProcessStopped(TObject *Sender,
      DWORD ProcessId, WideString ExecutablePath)
{
  lbProcessTrace->Items->Add("Process finished: "+ IntToStr(ProcessId) + " " + ExecutablePath);
}
//---------------------------------------------------------------------------

