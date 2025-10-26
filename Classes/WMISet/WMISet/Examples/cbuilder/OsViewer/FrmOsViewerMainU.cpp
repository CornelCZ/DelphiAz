//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmOsViewerMainU.h"
#include "FrmNewHostU.h"
#include "FrmAboutU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "WmiAbstract"
#pragma link "WmiComponent"
#pragma link "WmiOs"
#pragma resource "*.dfm"
TFrmOsViewerMain *FrmOsViewerMain;
//---------------------------------------------------------------------------

__fastcall TCredentials::TCredentials(WideString AUserName, WideString APassword)
{
        FUserName = AUserName;
        FPassword = APassword;
}
//---------------------------------------------------------------------------

__fastcall TFrmOsViewerMain::TFrmOsViewerMain(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFrmOsViewerMain::FormResize(TObject *Sender)
{
  ResizeGridColumns();
}
//---------------------------------------------------------------------------
void __fastcall TFrmOsViewerMain::ResizeGridColumns() {
  drgProperties->ColWidths[1] = drgProperties->ClientWidth - drgProperties->ColWidths[0] - 1;
};
//---------------------------------------------------------------------------


void __fastcall TFrmOsViewerMain::FormMouseUp(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
  ResizeGridColumns();
}
//---------------------------------------------------------------------------

void __fastcall TFrmOsViewerMain::FormShow(TObject *Sender)
{
  InitItems();
  Application->OnShowHint    = DoShowHint;
  Application->HintHidePause = 10000;
  Application->HintPause     = 2000;

  WmiOs1->Active = true;
  drgProperties->RowCount = PROP_COUNT + 1;
}
//---------------------------------------------------------------------------
AnsiString __fastcall TFrmOsViewerMain::QuickFixesToStr() {
  AnsiString Result = "";
  for (int i = 0; i < WmiOs1->QuickFixes->Count; i++) {
    Result = Result + WmiOs1->QuickFixes->Items[i]->HotFixId;
    if (i != WmiOs1->QuickFixes->Count - 1) {
      Result = Result + ", ";
    }
  };
  return Result;
};
//---------------------------------------------------------------------------

AnsiString __fastcall TFrmOsViewerMain::GetValueByIndex(int AIndex) {
  AnsiString Result = "";
  if (!WmiOs1->Active) {
    return Result;
  };

  if (DATA_DEF[AIndex].Caption == CAPTION_BootDevice) {Result = WmiOs1->BootDevice;}  else
  if (DATA_DEF[AIndex].Caption == CAPTION_BuildNumber) {Result = WmiOs1->BuildNumber;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_BuildType) {Result = WmiOs1->BuildType;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Caption) {Result = WmiOs1->Caption ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_CodeSet) {Result = WmiOs1->CodeSet ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_CountryCode) {Result = WmiOs1->CountryCode ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_CSDVersion) {Result = WmiOs1->CSDVersion ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_CSName) {Result = WmiOs1->CSName ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_CurrentTimeZone) {Result = IntToStr(WmiOs1->CurrentTimeZone);} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Debug) {Result = BoolToStr(WmiOs1->Debug, true) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Description) {Result = WmiOs1->Description ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Distributed) {Result = BoolToStr(WmiOs1->Distributed, true) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_EncryptionLevel) {Result = IntToStr(WmiOs1->EncryptionLevel) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_ForegroundApplicationBoost) {Result = IntToStr(WmiOs1->ForegroundApplicationBoost) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_FreePhysicalMemory) {Result = IntToStr(WmiOs1->FreePhysicalMemory) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_FreeSpaceInPagingFiles) {Result = IntToStr(WmiOs1->FreeSpaceInPagingFiles) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_FreeVirtualMemory) {Result = IntToStr(WmiOs1->FreeVirtualMemory) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_InstallDate) {Result = DateToStr(WmiOs1->InstallDate) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_LargeSystemCache) {Result = IntToStr(WmiOs1->LargeSystemCache) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_LastBootUpTime) {Result = DateTimeToStr(WmiOs1->LastBootUpTime) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_LocalDateTime) {Result = DateTimeToStr(WmiOs1->LocalDateTime) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Locale) {Result = WmiOs1->Locale ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Manufacturer) {Result = WmiOs1->Manufacturer ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_MaxNumberOfProcesses) {Result = IntToStr(WmiOs1->MaxNumberOfProcesses) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_MaxProcessMemorySize) {Result = IntToStr(WmiOs1->MaxProcessMemorySize) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_NumberOfLicensedUsers) {Result = IntToStr(WmiOs1->NumberOfLicensedUsers) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_NumberOfProcesses) {Result = IntToStr(WmiOs1->NumberOfProcesses) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_NumberOfUsers) {Result = IntToStr(WmiOs1->NumberOfUsers) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Organization) {Result = WmiOs1->Organization ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_OSLanguage) {Result = IntToStr(WmiOs1->OSLanguage) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_OSName) {Result = WmiOs1->OSName ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_OSProductSuite) {Result = IntToStr(WmiOs1->OSProductSuite) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_OSType) {Result = WmiOs1->OSTypeToStr(WmiOs1->OSType) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_OtherTypeDescription) {Result = WmiOs1->OtherTypeDescription ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_PlusProductID) {Result = WmiOs1->PlusProductID ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_PlusVersionNumber) {Result = WmiOs1->PlusVersionNumber ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Primary) {Result = BoolToStr(WmiOs1->Primary, true) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_QuantumLength) {Result = WmiOs1->QuantumLengthToStr(WmiOs1->QuantumLength) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_QuantumType) {Result = WmiOs1->QuantumTypeToStr(WmiOs1->QuantumType) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_RegisteredUser) {Result = WmiOs1->RegisteredUser ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_SerialNumber) {Result = WmiOs1->SerialNumber ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_ServicePackMajorVersion) {Result = IntToStr(WmiOs1->ServicePackMajorVersion) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_ServicePackMinorVersion) {Result = IntToStr(WmiOs1->ServicePackMinorVersion) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_SizeStoredInPagingFiles) {Result = IntToStr(WmiOs1->SizeStoredInPagingFiles) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Status) {Result = WmiOs1->Status ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_SuiteMask) {Result = WmiOs1->SuiteMaskToStr(WmiOs1->SuiteMask) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_SystemDevice) {Result = WmiOs1->SystemDevice ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_SystemDirectory) {Result = WmiOs1->SystemDirectory ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_SystemDrive) {Result = WmiOs1->SystemDrive ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_TotalSwapSpaceSize) {Result = IntToStr(WmiOs1->TotalSwapSpaceSize) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_TotalVirtualMemorySize) {Result = IntToStr(WmiOs1->TotalVirtualMemorySize) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_TotalVisibleMemorySize) {Result = IntToStr(WmiOs1->TotalVisibleMemorySize) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_TimeZone) {Result = IntToStr(WmiOs1->CurrentTimeZone) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Version) {Result = WmiOs1->Version ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_WindowsDirectory) {Result = WmiOs1->WindowsDirectory ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_QuickFixes) {Result = QuickFixesToStr() ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Recovery_AutoReboot) {Result = BoolToStr(WmiOs1->Recovery->AutoReboot, true) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Recovery_DebugFilePath) {Result = WmiOs1->Recovery->DebugFilePath ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Recovery_KernelDumpOnly) {Result = BoolToStr(WmiOs1->Recovery->KernelDumpOnly, true) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Recovery_OverwriteExistingDebugFile) {Result = BoolToStr(WmiOs1->Recovery->OverwriteExistingDebugFile, true) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Recovery_SendAdminAlert) {Result = BoolToStr(WmiOs1->Recovery->SendAdminAlert, true) ;} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Recovery_WriteDebugInfo) {Result = GetWriteDebugInfo();} else
  if (DATA_DEF[AIndex].Caption == CAPTION_Recovery_WriteToSystemLog) {Result = BoolToStr(WmiOs1->Recovery->WriteToSystemLog, true);};
  return Result; 
};
//---------------------------------------------------------------------------

AnsiString __fastcall TFrmOsViewerMain::GetWriteDebugInfo() {
  if (!IsWindowsXPOrHigher) {
    return BoolToStr(WmiOs1->Recovery->WriteDebugInfo, true);
  } else {
    return BoolToStr((WmiOs1->Recovery->DebugInfoType > 0), true);
  };
};

//---------------------------------------------------------------------------


void __fastcall TFrmOsViewerMain::drgPropertiesDrawCell(TObject *Sender,
      int ACol, int ARow, TRect &Rect, TGridDrawState State)  {
  if (ARow == 0) {
      drgProperties->Canvas->Font->Style = TFontStyles()<< fsBold;
      if (ACol == 0) {
          drgProperties->Canvas->TextRect(Rect, Rect.Left + 1, Rect.Top + 2, "Property");
      } else {
          drgProperties->Canvas->TextRect(Rect, Rect.Left + 1, Rect.Top + 2, "Value");
      }
  } else {
      if (ACol == 0) {
          if (DATA_DEF[ARow -1].Editable) {
             drgProperties->Canvas->Font->Style = TFontStyles()<< fsBold;
          } else {
             drgProperties->Canvas->Font->Style = TFontStyles();
          }
          drgProperties->Canvas->TextRect(Rect, Rect.Left + 1, Rect.Top + 2, DATA_DEF[ARow -1].Caption);
      } else {
          drgProperties->Canvas->TextRect(Rect, Rect.Left + 1, Rect.Top + 2, GetValueByIndex(ARow - 1));
      }
  };
}
//---------------------------------------------------------------------------

void __fastcall TFrmOsViewerMain::drgPropertiesGetEditText(TObject *Sender,
      int ACol, int ARow, AnsiString &Value)
{
  Value = GetValueByIndex(ARow - 1);
  if ((!DATA_DEF[ARow -1].Editable) || (!WmiOs1->Active)) {
      drgProperties->EditorMode = false;
  }
}
//---------------------------------------------------------------------------

void __fastcall TFrmOsViewerMain::Splitter1Moved(TObject *Sender)
{
  ResizeGridColumns();
}

//---------------------------------------------------------------------------
void __fastcall TFrmOsViewerMain::DoShowHint(AnsiString &HintStr,
  bool &CanShow, THintInfo &HintInfo) {
  int ACol = 0;
  int ARow = 0;
  if (HintInfo.HintControl == drgProperties) {
      drgProperties->MouseToCell(HintInfo.CursorPos.x, HintInfo.CursorPos.y, ACol, ARow);
      CanShow = ARow > 0;

      if (CanShow) {
          if (ACol == 0) {
              HintStr = DATA_DEF[ARow - 1].Hint;
          } else {
              HintStr = GetValueByIndex(ARow - 1);
          }
      } else {
          HintStr = "";
      };
  };
};

//---------------------------------------------------------------------------
void __fastcall TFrmOsViewerMain::SetQuantumLength(AnsiString AValue) {
  AValue = UpperCase(AValue);
  if (CompareStr(AValue, "UNKNOWN") == 0) {WmiOs1->QuantumLength = QL_UNKNOWN;} else
  if (CompareStr(AValue, "ONE TICK") == 0) {WmiOs1->QuantumLength = QL_ONE_TICK;} else
  if (CompareStr(AValue, "TWO TICKS") == 0) {WmiOs1->QuantumLength = QL_TWO_TICKS;} else {
      WmiOs1->QuantumLength = StrToInt(AValue);
  }
};

//---------------------------------------------------------------------------
void __fastcall TFrmOsViewerMain::SetQuantumType(AnsiString AValue) {
  AValue = UpperCase(AValue);
  if (CompareStr(AValue, "UNKNOWN") == 0) {WmiOs1->QuantumType = QT_UNKNOWN;} else
  if (CompareStr(AValue, "FIXED") == 0) {WmiOs1->QuantumType = QT_FIXED;} else
  if (CompareStr(AValue, "VARIABLE") == 0) {WmiOs1->QuantumType = QT_VARIABLE;} else {
    WmiOs1->QuantumType = StrToInt(AValue);
  }
};

//---------------------------------------------------------------------------
void __fastcall TFrmOsViewerMain::SetWriteDebugInfo(bool AValue) {
  if (IsWindowsXPOrHigher()) {
      if (AValue) {
          WmiOs1->Recovery->DebugInfoType = DIT_SMALL_MEMORY;
      } else {
         WmiOs1->Recovery->DebugInfoType = DIT_NONE;
      }
  } else {
      WmiOs1->Recovery->WriteDebugInfo = AValue;
  };
};

//---------------------------------------------------------------------------
void __fastcall TFrmOsViewerMain::SetOsPropertyByIndex(int AIndex, AnsiString AValue) {
  if (WmiOs1->Active) {
    if (DATA_DEF[AIndex].Caption == CAPTION_Description) {WmiOs1->Description = AValue ;} else
    if (DATA_DEF[AIndex].Caption == CAPTION_ForegroundApplicationBoost) {WmiOs1->ForegroundApplicationBoost = StrToInt(AValue) ;} else
    if (DATA_DEF[AIndex].Caption == CAPTION_LocalDateTime) {WmiOs1->LocalDateTime = StrToDateTime(AValue) ;} else
    if (DATA_DEF[AIndex].Caption == CAPTION_QuantumLength) {SetQuantumLength(AValue) ;} else
    if (DATA_DEF[AIndex].Caption == CAPTION_QuantumType) {SetQuantumType(AValue) ;} else
    if (DATA_DEF[AIndex].Caption == CAPTION_Recovery_AutoReboot) {WmiOs1->Recovery->AutoReboot = StrToBool(AValue) ;} else
    if (DATA_DEF[AIndex].Caption == CAPTION_Recovery_DebugFilePath) {WmiOs1->Recovery->DebugFilePath = AValue ;} else
    if (DATA_DEF[AIndex].Caption == CAPTION_Recovery_KernelDumpOnly) {WmiOs1->Recovery->KernelDumpOnly = StrToBool(AValue) ;} else
    if (DATA_DEF[AIndex].Caption == CAPTION_Recovery_OverwriteExistingDebugFile) {WmiOs1->Recovery->OverwriteExistingDebugFile = StrToBool(AValue) ;} else
    if (DATA_DEF[AIndex].Caption == CAPTION_Recovery_SendAdminAlert) {WmiOs1->Recovery->SendAdminAlert = StrToBool(AValue) ;} else
    if (DATA_DEF[AIndex].Caption == CAPTION_Recovery_WriteDebugInfo) {SetWriteDebugInfo(StrToBool(AValue)) ;} else
    if (DATA_DEF[AIndex].Caption == CAPTION_Recovery_WriteToSystemLog) {WmiOs1->Recovery->WriteToSystemLog = StrToBool(AValue) ;};
  };
};

//---------------------------------------------------------------------------
void __fastcall TFrmOsViewerMain::CommitChanges() {
  SetOsPropertyByIndex(drgProperties->Selection.Top - 1, FEditValue);
};

void __fastcall TFrmOsViewerMain::drgPropertiesSelectCell(TObject *Sender,
      int ACol, int ARow, bool &CanSelect)
{
  if (drgProperties->EditorMode) CommitChanges();
}
//---------------------------------------------------------------------------

void __fastcall TFrmOsViewerMain::drgPropertiesExit(TObject *Sender)
{
  if (drgProperties->EditorMode) CommitChanges();
}
//---------------------------------------------------------------------------

void __fastcall TFrmOsViewerMain::drgPropertiesSetEditText(TObject *Sender,
      int ACol, int ARow, const AnsiString Value)
{
  FEditValue = Value;
}
//---------------------------------------------------------------------------

void __fastcall TFrmOsViewerMain::drgPropertiesKeyDown(TObject *Sender,
      WORD &Key, TShiftState Shift)
{
  if ((Key == VK_RETURN) && (drgProperties->EditorMode)) {
      CommitChanges();
  }
}
//---------------------------------------------------------------------------

void __fastcall TFrmOsViewerMain::InitItems() {
  tvBrowser->Items->Add(NULL, LOCAL_HOST);
  TTreeNode *vItem = tvBrowser->Items->Add(NULL, NETWORK);
  tvBrowser->Items->AddChild(vItem, NO_DATA);
};

void __fastcall TFrmOsViewerMain::tvBrowserExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  AllowExpansion = ProcessNodeExpanding(Node);
}
//---------------------------------------------------------------------------

bool __fastcall TFrmOsViewerMain::ProcessNodeExpanding(TTreeNode *ANode) {
  if ((ANode->Count == 1) && (ANode->getFirstChild()->Text == NO_DATA)) {
    if (ANode->Text == NETWORK) {
        return LoadRemoteHosts(ANode);
    } else {
        return false;
    }
  }
  return true;
};

//---------------------------------------------------------------------------
bool __fastcall TFrmOsViewerMain::LoadRemoteHosts(TTreeNode *ANode) {
  ANode->DeleteChildren();
  TStringList *AList = new TStringList();
  SetWaitCursor();
  __try {
      WmiOs1->ListServers(AList);
      for (int i = 0; i < AList->Count; i++) {
          TTreeNode *vNode = tvBrowser->Items->AddChild(ANode, AList->Strings[i]);
          tvBrowser->Items->AddChild(vNode, NO_DATA);
      };
  } __finally {
      AList->Free();
      RestoreCursor();
  };
  return true;
};

void __fastcall TFrmOsViewerMain::tvBrowserChanging(TObject *Sender,
      TTreeNode *Node, bool &AllowChange)
{
  ProcessChangingNode(Node);
}

//---------------------------------------------------------------------------
void __fastcall TFrmOsViewerMain::ProcessChangingNode(TTreeNode *Node) {

  if (Node->Text == LOCAL_HOST) {
    DoConnect(Node);
  } else
  if (Node->Text == NETWORK) {
    WmiOs1->Active = false;
  } else {
    TCredentials *vCredentials = (TCredentials *) Node->Data;
    if (vCredentials != NULL) DoConnect(Node);
  };
  SetFormCaption();
  drgProperties->Refresh();
  drgProperties->EditorMode = false;
};

//---------------------------------------------------------------------------
void __fastcall TFrmOsViewerMain::SetWaitCursor() {
  FStoredCursor = Screen->Cursor;
  Screen->Cursor = crHourGlass;
};

//---------------------------------------------------------------------------
void __fastcall TFrmOsViewerMain::RestoreCursor() {
  Screen->Cursor = FStoredCursor;
};

//---------------------------------------------------------------------------
bool __fastcall TFrmOsViewerMain::DoConnect(TTreeNode *ANode) {
  // do not reconnect if already connected to desired host.
  if ((ANode->Text == WmiOs1->MachineName) &&
      (WmiOs1->Active)) {
    return true;
  };

  // if the node represents the local host, clear credentials.
  // Otherwise try 1) to connect without credentiols. If it fails 2) ask user
  // for creadentials and try co connect again.
  // if connection is a sucess, remember sucessfull credentials, so
  // user does not have to enter them again.

  bool result = false;
  SetWaitCursor();
  __try {
    WmiOs1->Active = false;
    if (ANode->Text == LOCAL_HOST) {
      // connect to local host;
      WmiOs1->Credentials->Clear();
      WmiOs1->MachineName = "";
      WmiOs1->Active = true;
      result = true;
    } else {
      if (ANode->Data == NULL) {
        // connect for the first time
        // try default credentials fisrt:
        try {
          WmiOs1->Credentials->Clear();
          WmiOs1->MachineName = ANode->Text;
          WmiOs1->Active = true;
          result = true;
        } catch (...) {
          // expected exception: the credentials are not valid
        };

        // default credentials did not work.
        // try to connect with user's provided credentials
        if (!WmiOs1->Active) {
          TFrmNewHost *vForm = new TFrmNewHost(NULL);
          vForm->MachineName = ANode->Text;
          __try {
            while (vForm->ShowModal() == mrOk) {
              try {
                WmiOs1->Active = false;
                WmiOs1->Credentials->Clear();
                WmiOs1->MachineName = ANode->Text;
                WmiOs1->Credentials->UserName = vForm->UserName;
                WmiOs1->Credentials->Password = vForm->edtPassword->Text;
                WmiOs1->Active = true;

                // connected successfully; remember credentials
                ANode->Data = new TCredentials(vForm->UserName, vForm->edtPassword->Text);
                result = true;
                break;
              } catch (const Exception &e) {
                  Application->MessageBox(e.Message.c_str(), "Error", ID_OK);
              };
            }
          } __finally {
            vForm->Free();
          };
        };
      } else {
        // reconnect with existing credentials
        TCredentials *vCredentials = (TCredentials *) ANode->Data;
        WmiOs1->MachineName = ANode->Text;
        WmiOs1->Credentials->UserName = vCredentials->UserName;
        WmiOs1->Credentials->Password = vCredentials->Password;
        WmiOs1->Active = true;
        result = true;
      };
    };
  } __finally {
    RestoreCursor();
  };

  return result;
};

//---------------------------------------------------------------------------
void __fastcall TFrmOsViewerMain::SetButtonState() {
  tlbRefresh->Enabled = (tvBrowser->Selected != NULL) && (CompareStr(tvBrowser->Selected->Text, NETWORK) != 0);
  tlbReboot->Enabled = tlbRefresh->Enabled;
};

//---------------------------------------------------------------------------
void __fastcall TFrmOsViewerMain::SetFormCaption() {
    if (WmiOs1->Active) {
        if (CompareStr(WmiOs1->MachineName, "") != 0) {
            Caption = CNST_CAPTION + WmiOs1->MachineName;
        } else {
            AnsiString tmp = CNST_CAPTION;
            Caption = tmp + LOCAL_HOST;
        }
    } else {
        Caption = "Operating System Viewer";
    };
};


void __fastcall TFrmOsViewerMain::tlbNewHostClick(TObject *Sender)
{
  CreateNewNetworkNode();
  SetButtonState();
}
//---------------------------------------------------------------------------

void __fastcall TFrmOsViewerMain::CreateNewNetworkNode() {
  TFrmNewHost *vForm = new TFrmNewHost(NULL);
  __try {
    while (vForm->ShowModal() == mrOk) {
      try {

        WmiOs1->Active = false;
        WmiOs1->Credentials->Clear();
        WmiOs1->MachineName = vForm->edtHostName->Text;
        WmiOs1->Credentials->UserName = vForm->UserName;
        WmiOs1->Credentials->Password = vForm->edtPassword->Text;
        WmiOs1->Active = true;

        // connected successfully; add the new host to a list.
        TTreeNode *vNode = FindNeworkNode();
        if ((vNode->getFirstChild() != NULL) &&
            (vNode->getFirstChild()->Text == NO_DATA)) {
           vNode->DeleteChildren();
        }

        vNode = tvBrowser->Items->AddChild(vNode, vForm->edtHostName->Text);
        vNode->Data = new TCredentials(vForm->UserName, vForm->edtPassword->Text);
        tvBrowser->Selected = vNode;
        break;
      } catch (const Exception &e) {
          Application->MessageBox(e.Message.c_str(), "Error", ID_OK);
      };
    }
  } __finally {
    vForm->Free();
  };
};

//---------------------------------------------------------------------------
TTreeNode * __fastcall TFrmOsViewerMain::FindNeworkNode() {
  for (int i = 0; i <  tvBrowser->Items->Count; i++) {
    if (tvBrowser->Items->Item[i]->Text == NETWORK) {
      return tvBrowser->Items->Item[i];
    };
  }
  return NULL;
};

void __fastcall TFrmOsViewerMain::tlbRebootClick(TObject *Sender)
{
  if (WmiOs1->Active) WmiOs1->Reboot();
}
//---------------------------------------------------------------------------

void __fastcall TFrmOsViewerMain::tlbAboutClick(TObject *Sender)
{
  TFrmAbout *vForm = new TFrmAbout(NULL);
  __try {
    vForm->ShowModal();
  } __finally {
    vForm->Free();
  };
}
//---------------------------------------------------------------------------

void __fastcall TFrmOsViewerMain::tlbRefreshClick(TObject *Sender)
{
  WmiOs1->Refresh();
}
//---------------------------------------------------------------------------

void __fastcall TFrmOsViewerMain::tvBrowserChange(TObject *Sender,
      TTreeNode *Node)
{
  SetButtonState();
}
//---------------------------------------------------------------------------

