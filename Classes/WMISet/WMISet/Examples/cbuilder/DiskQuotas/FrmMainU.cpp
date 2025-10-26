//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmMainU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "WmiAbstract"
#pragma link "WmiComponent"
#pragma link "WmiDiskQuotaControl"
#pragma link "DetectWinOS"
#pragma resource "*.dfm"

TFrmMain *FrmMain;

bool IsControlOfType(TControl * vControl, AnsiString AClassName)
{
  TClass ClassRef;

  for (ClassRef = vControl->ClassType();
      ClassRef != NULL;
      ClassRef = ClassRef->ClassParent()) {

    if (String(ClassRef->ClassName()) == AClassName) {
      return true;
    }
  };

  return false;
}


//---------------------------------------------------------------------------
__fastcall TCredentials::TCredentials(WideString AUserName, WideString APassword)
{
        FUserName = AUserName;
        FPassword = APassword;
}

//---------------------------------------------------------------------------
__fastcall TFrmMain::TFrmMain(TComponent* Owner)
        : TForm(Owner)
{
}

//---------------------------------------------------------------------------
void __fastcall TFrmMain::InitItems() {
  TTreeNode *vItem = tvBrowser->Items->Add(NULL, LOCAL_HOST);
  tvBrowser->Items->AddChild(vItem, NO_DATA);
  vItem = tvBrowser->Items->Add(NULL, NETWORK);
  tvBrowser->Items->AddChild(vItem, NO_DATA);
};

//---------------------------------------------------------------------------
bool __fastcall TFrmMain::ProcessNodeExpanding(TTreeNode *ANode) {
  bool result = true;
  if ((ANode->Count == 1) && (ANode->getFirstChild()->Text == NO_DATA)) {
    result = false;
    if (ANode->Text == LOCAL_HOST) {
        result = AddVolumeNodes(ANode);
    } else
    if (ANode->Text == NETWORK) {
        result = LoadRemoteHosts(ANode);
    } else
    if ((ANode->Parent != NULL) && (ANode->Parent->Text == NETWORK)) {
        if (DoConnect(ANode)) {
            result = AddVolumeNodes(ANode);
        }
    }
  }
  return result;
};


//---------------------------------------------------------------------------
bool __fastcall TFrmMain::AddVolumeNodes(TTreeNode *ANode) {

  ANode->DeleteChildren();
  WideString vMachineName = "";
  if (ANode->Text != LOCAL_HOST) {
      vMachineName = ANode->Text;
  }    

  if ((vMachineName != WmiDiskQuotaControl1->MachineName) ||
      (!WmiDiskQuotaControl1->Active)) {
      WmiDiskQuotaControl1->Active = false;
      WmiDiskQuotaControl1->Credentials->Clear();
      TCredentials *vCredentials = (TCredentials *) ANode->Data;
      if (vCredentials != NULL) {
          WmiDiskQuotaControl1->Credentials->UserName = vCredentials->UserName;
          WmiDiskQuotaControl1->Credentials->Password = vCredentials->Password;
      };
      WmiDiskQuotaControl1->Active = true;
  };

  TStringList *vList = new TStringList();
  __try {
      WmiDiskQuotaControl1->ListLogicalDisks(vList);
      for (int i = 0; i < vList->Count; i++) {
        tvBrowser->Items->AddChild(ANode, vList->Strings[i]);
      }  
  } __finally {
      vList->Free();
  };

  return true;
};

//---------------------------------------------------------------------------
bool __fastcall TFrmMain::LoadRemoteHosts(TTreeNode *ANode) {
  ANode->DeleteChildren();
  TStringList *AList = new TStringList();
  SetWaitCursor();
  __try {
      WmiDiskQuotaControl1->ListServers(AList);
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

//---------------------------------------------------------------------------
bool __fastcall TFrmMain::DoConnect(TTreeNode *ANode) {
  // do not reconnect if already connected to desired host.
  if ((ANode->Text == WmiDiskQuotaControl1->MachineName) &&
      (WmiDiskQuotaControl1->Active)) {
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
    WmiDiskQuotaControl1->Active = false;
    if (ANode->Text == LOCAL_HOST) {
      // connect to local host;
      WmiDiskQuotaControl1->Credentials->Clear();
      WmiDiskQuotaControl1->MachineName = "";
      WmiDiskQuotaControl1->Active = true;
      result = true;
    } else {
      if (ANode->Data == NULL) {
        // connect for the first time
        // try default credentials fisrt:
        try {
          WmiDiskQuotaControl1->Credentials->Clear();
          WmiDiskQuotaControl1->MachineName = ANode->Text;
          WmiDiskQuotaControl1->Active = true;
          result = true;
        } catch (...) {
          // expected exception: the credentials are not valid
        };

        // default credentials did not work.
        // try to connect with user's provided credentials
        if (!WmiDiskQuotaControl1->Active) {
          TFrmNewHost *vForm = new TFrmNewHost(NULL);
          vForm->MachineName = ANode->Text;
          __try {
            while (vForm->ShowModal() == mrOk) {
              try {
                WmiDiskQuotaControl1->Active = false;
                WmiDiskQuotaControl1->Credentials->Clear();
                WmiDiskQuotaControl1->MachineName = ANode->Text;
                WmiDiskQuotaControl1->Credentials->UserName = vForm->UserName;
                WmiDiskQuotaControl1->Credentials->Password = vForm->edtPassword->Text;
                WmiDiskQuotaControl1->Active = true;

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
        WmiDiskQuotaControl1->MachineName = ANode->Text;
        WmiDiskQuotaControl1->Credentials->UserName = vCredentials->UserName;
        WmiDiskQuotaControl1->Credentials->Password = vCredentials->Password;
        WmiDiskQuotaControl1->Active = true;
        result = true;
      };
    };
  } __finally {
    RestoreCursor();
  };

  return result;
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::SetWaitCursor() {
  FStoredCursor = Screen->Cursor;
  Screen->Cursor = crHourGlass;
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::RestoreCursor() {
  Screen->Cursor = FStoredCursor;
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::CreateNewNetworkNode() {
  TFrmNewHost *vForm = new TFrmNewHost(NULL);
  __try {
    while (vForm->ShowModal() == mrOk) {
      try {

        WmiDiskQuotaControl1->Active = false;
        WmiDiskQuotaControl1->Credentials->Clear();
        WmiDiskQuotaControl1->MachineName = vForm->edtHostName->Text;
        WmiDiskQuotaControl1->Credentials->UserName = vForm->UserName;
        WmiDiskQuotaControl1->Credentials->Password = vForm->edtPassword->Text;
        WmiDiskQuotaControl1->Active = true;

        // connected successfully; add the new host to a list.
        TTreeNode *vNode = FindNeworkNode();
        if ((vNode->getFirstChild() != NULL) &&
            (vNode->getFirstChild()->Text == NO_DATA)) {
           vNode->DeleteChildren();
        }   

        vNode = tvBrowser->Items->AddChild(vNode, vForm->edtHostName->Text);
        vNode->Data = new TCredentials(vForm->UserName, vForm->edtPassword->Text);
        AddVolumeNodes(vNode);
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
TTreeNode * __fastcall TFrmMain::FindNeworkNode() {
  for (int i = 0; i <  tvBrowser->Items->Count; i++) {
    if (tvBrowser->Items->Item[i]->Text == NETWORK) {
      return tvBrowser->Items->Item[i];
    };
  }
  return NULL;
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::ProcessChangingNode(TTreeNode *ANode) {
  LoadInformation(ANode);
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::ClearControls(TWinControl *ARoot) {

  if (IsControlOfType(ARoot, "TCustomEdit")) {
    (dynamic_cast<TCustomEdit *>(ARoot))->Clear();
  } else
  if (IsControlOfType(ARoot, "TCustomComboBox")) {
    (dynamic_cast<TCustomComboBox *>(ARoot))->ItemIndex = -1;
  } else
  if (IsControlOfType(ARoot, "TCheckBox")) {
    (dynamic_cast<TCheckBox *>(ARoot))->Checked = false;
  } else
  if (IsControlOfType(ARoot, "TRadioButton")) {
    (dynamic_cast<TRadioButton *>(ARoot))->Checked = false;
  };
  
  for (int i = 0; i < ARoot->ControlCount; i++) {
    if (IsControlOfType(ARoot->Controls[i], "TWinControl")) {
      ClearControls(dynamic_cast<TWinControl *>(ARoot->Controls[i]));
    }  
  }    
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::LoadQuotaSettings() {

  TWmiQuotaSetting *vSetting = WmiDiskQuotaControl1->QuotaSettings->Items[0];
  chbEnableManagement->Checked = vSetting->State != QUOTAS_DISABLE;
  if (chbEnableManagement->Checked) {
    chbDenyIfExceeded->Checked = vSetting->State == QUOTAS_ENFORCE;
    rbDoNotLimitDiskSpace->Checked = WideSameStr(vSetting->DefaultLimit, NO_LIMIT);
    rbLimitDiskSpace->Checked = !rbDoNotLimitDiskSpace->Checked;
    if (rbDoNotLimitDiskSpace->Checked) {
      edtLimit->Text = CNST_NO_LIMIT;
      edtWarning->Text = CNST_NO_LIMIT;
    } else {
      edtLimit->Text = vSetting->DefaultLimit;
      edtWarning->Text = vSetting->DefaultWarningLimit;
    };

    chbLogWhenOverLimit->Checked = vSetting->ExceededNotification;
  } else {
    ClearControls(pnlSettings);
  };
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::ApplyQuotaSetting() {
  ValidateChanges();
  TWmiQuotaSetting *vSetting = WmiDiskQuotaControl1->QuotaSettings->Items[0];

  DWORD vState = 0;
  if (!chbEnableManagement->Checked) {
      vState = QUOTAS_DISABLE;
  } else if (!chbDenyIfExceeded->Checked) {
      vState = QUOTAS_TRACK;
  } else {
      vState = QUOTAS_ENFORCE;
  }    

  vSetting->State = vState;
  if (rbDoNotLimitDiskSpace->Checked) {
    vSetting->DefaultLimit = NO_LIMIT;
    vSetting->DefaultWarningLimit = NO_LIMIT;
  } else {
    vSetting->DefaultLimit = edtLimit->Text;
    vSetting->DefaultWarningLimit = edtWarning->Text;
  };

  vSetting->ExceededNotification = chbLogWhenOverLimit->Checked;
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::LoadDiskQuotas() {
  lvQuotas->Items->Clear();
  for (int i = 0; i < WmiDiskQuotaControl1->DiskQuotas->Count; i++) {
      TListItem *vItem = lvQuotas->Items->Add();
      vItem->Caption = WmiDiskQuotaControl1->DiskQuotas->Items[i]->Account;
      vItem->SubItems->Add(IntToStr(WmiDiskQuotaControl1->DiskQuotas->Items[i]->DiskSpaceUsed));
      if (WideSameStr(WmiDiskQuotaControl1->DiskQuotas->Items[i]->Limit, NO_LIMIT)) {
          vItem->SubItems->Add("No limit");
      } else {
          vItem->SubItems->Add(WmiDiskQuotaControl1->DiskQuotas->Items[i]->Limit);
      }  
      if (WideSameStr(WmiDiskQuotaControl1->DiskQuotas->Items[i]->WarningLimit, NO_LIMIT)) {
          vItem->SubItems->Add("No limit");
      } else {
          vItem->SubItems->Add(WmiDiskQuotaControl1->DiskQuotas->Items[i]->WarningLimit);
      }
      vItem->SubItems->Add(QuotaStatusToString(WmiDiskQuotaControl1->DiskQuotas->Items[i]->Status));
  };
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::LoadInformation(TTreeNode *ANode) {
  if ((ANode->Text.Length() == 2) && (ANode->Text[2] == ':')) {
    if (DoConnect(ANode->Parent)) {
        WmiDiskQuotaControl1->FilterVolume = ANode->Text;
        WmiDiskQuotaControl1->DiskQuotas->ClearEntities();
        WmiDiskQuotaControl1->QuotaSettings->ClearEntities();
        if (WmiDiskQuotaControl1->QuotaSettings->Count > 0) {
           LoadQuotaSettings();
           LoadDiskQuotas();
        }
    };
    pnlNotSupported->Visible = WmiDiskQuotaControl1->QuotaSettings->Count == 0;
    pnlSettings->Visible = !pnlNotSupported->Visible;
    pnlQuotas->Visible = !pnlNotSupported->Visible;
  } else {
    pnlNotSupported->Visible = false;
    pnlSettings->Visible = false;
    pnlQuotas->Visible = false;
  };
};

//---------------------------------------------------------------------------
TColor __fastcall TFrmMain::GetColor(bool AEnabled) {
  if (AEnabled) {
      return clWindow;
  } else {
      return clBtnFace;
  }    
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::EnableControls(TControl *ARoot, bool AEnabled, TControl *Exclude) {

  if (IsControlOfType(ARoot, "TEdit")) {
     ((TEdit *)ARoot)->Enabled = AEnabled;
     ((TEdit *)ARoot)->Color = GetColor(AEnabled);
     ((TEdit *)ARoot)->Text = "";
  } else
  if (IsControlOfType(ARoot, "TComboBox")) {
    ((TComboBox *)ARoot)->Enabled = AEnabled;
    ((TComboBox *)ARoot)->Color = GetColor(AEnabled);
    if (!AEnabled) {
      ((TComboBox *)ARoot)->ItemIndex = -1;
    }  
  } else
  if (IsControlOfType(ARoot, "TRadioButton")) {
    ((TRadioButton *) ARoot)->Enabled = AEnabled;
    if (!AEnabled) {
      ((TRadioButton *) ARoot)->Checked = false;
    }  
  } else
  if (IsControlOfType(ARoot, "TCheckBox")) {
    ((TCheckBox *) ARoot)->Enabled = AEnabled;
    if (ARoot != Exclude) {
      if (!AEnabled) {
        ((TCheckBox *) ARoot)->Checked = false;
      }  
    }  
  };

  if (IsControlOfType(ARoot, "TWinControl")) {
    for (int i = 0; i < ((TWinControl *) ARoot)->ControlCount; i++) {
      EnableControls(((TWinControl *) ARoot)->Controls[i], AEnabled, Exclude);
    }  
  }    
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::ShowError(TWinControl  *AControl, AnsiString AError) {
  if (AControl->CanFocus()) {
    AControl->SetFocus();
  }  
  Application->MessageBox(AError.c_str(), "Error", MB_OK + MB_ICONHAND);
  Abort();
}; 

//---------------------------------------------------------------------------
void __fastcall TFrmMain::ValidateChanges() {
  if (rbLimitDiskSpace->Checked) {
    if (edtLimit->Text.Length() == 0) {
        ShowError(edtLimit, "Limit is required");
    }    

    if (edtWarning->Text.Length() == 0) {
        ShowError(edtWarning, "Warning limit is required");
    }    
  };
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::CancelChangesInQuotaSettings() {
  LoadQuotaSettings();
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::DeleteSelectedQuota() {
  if (lvQuotas->Selected != NULL) {
     TWmiDiskQuota *vQuota = WmiDiskQuotaControl1->DiskQuotas->Items[lvQuotas->Selected->Index];
     if (vQuota->DiskSpaceUsed == 0) {
       WmiDiskQuotaControl1->DiskQuotas->Delete(lvQuotas->Selected->Index);
       LoadDiskQuotas();
     } else {
       Application->MessageBox("This quota shows the space used. \
        Delete all of files that are charged to this account, then try again",
        "Error", MB_OK + MB_ICONHAND);   
     };  
  };
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::CreateNewQuota() {
  TFrmNewDiskQuota *vForm = new TFrmNewDiskQuota(NULL);
  __try {
    WmiDiskQuotaControl1->ListAccounts(vForm->cmbUser->Items);
    while (vForm->ShowModal() == mrOk) {
      try {
          WideString vLimit = vForm->cmbLimit->Text;
          if (WideSameStr(vLimit, "No Limit")) {
              vLimit = NO_LIMIT;
          }    
          WideString vWarningLimit = vForm->cmbWarningLimit->Text;
          if (WideSameStr(vWarningLimit, "No Limit")) {
              vWarningLimit = NO_LIMIT;
          }    
          WmiDiskQuotaControl1->DiskQuotas->Add(vForm->cmbUser->Text,
                                                tvBrowser->Selected->Text,
                                                vWarningLimit,
                                                vLimit);
          break;
      } catch (const Exception &e) {
          ShowMessage(e.Message);
      };
    };
  } __finally {
    vForm->Free();
  };
};


//---------------------------------------------------------------------------
void __fastcall TFrmMain::FormCreate(TObject *Sender)
{
  InitItems();
}

//---------------------------------------------------------------------------
void __fastcall TFrmMain::tvBrowserExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  AllowExpansion = ProcessNodeExpanding(Node);
}

//---------------------------------------------------------------------------
void __fastcall TFrmMain::tlbNewHostClick(TObject *Sender)
{
  CreateNewNetworkNode();
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::tvBrowserChanging(TObject *Sender,
      TTreeNode *Node, bool &AllowChange)
{
  ProcessChangingNode(Node);
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::FormShow(TObject *Sender)
{
  if (!IsWindowsXPOrHigher()) {
    Application->MessageBox("This program is designed for Windows XP and higher",
        "Warning", MB_OK);
  }
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::chbEnableManagementClick(TObject *Sender)
{
  if (!chbEnableManagement->Checked) {
    EnableControls(pnlSettings, false, chbEnableManagement);
    EnableControls(chbEnableManagement, true, chbEnableManagement);
  } else {
    EnableControls(pnlSettings, true, chbEnableManagement);
    TWmiQuotaSetting *vSetting = WmiDiskQuotaControl1->QuotaSettings->Items[0];
    if (vSetting->State != QUOTAS_DISABLE) {
      LoadQuotaSettings();
    }  
  };
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::btnApplyClick(TObject *Sender)
{
  ApplyQuotaSetting();
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::btnCancelClick(TObject *Sender)
{
  CancelChangesInQuotaSettings();
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::rbDoNotLimitDiskSpaceClick(TObject *Sender)
{
  EnableControls(pnlLimits, false, NULL);
  rbLimitDiskSpace->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::rbLimitDiskSpaceClick(TObject *Sender)
{
  EnableControls(pnlLimits, true, rbLimitDiskSpace);
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::tlbDeleteClick(TObject *Sender)
{
  DeleteSelectedQuota();
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::lvQuotasChange(TObject *Sender, TListItem *Item,
      TItemChange Change)
{
  tlbDelete->Enabled = lvQuotas->Selected != NULL;
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::tlbNewClick(TObject *Sender)
{
  CreateNewQuota();
  LoadDiskQuotas();
}
//---------------------------------------------------------------------------

