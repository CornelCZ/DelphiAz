//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmEventsMainU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "WmiAbstract"
#pragma link "WmiComponent"
#pragma link "WmiSystemEvents"
#pragma resource "*.dfm"
TFrmEventsMain *FrmEventsMain;

//---------------------------------------------------------------------------

__fastcall TCredentials::TCredentials(WideString AUserName, WideString APassword)
{
        FUserName = AUserName;
        FPassword = APassword;
}

//---------------------------------------------------------------------------
__fastcall TFrmEventsMain::TFrmEventsMain(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFrmEventsMain::FormCreate(TObject *Sender)
{
  pcMain->ActivePage = tsSetup;
  InitItems();
  WmiSystemEvents1->Active = true;
  chbLogon->Enabled = IsWindowsXPOrHigher();
  chbLogoff->Enabled = chbLogon->Enabled;
  chbDocking->Enabled = chbLogon->Enabled;
}
//---------------------------------------------------------------------------
void __fastcall TFrmEventsMain::InitItems() {
  tvBrowser->Items->Add(NULL, LOCAL_HOST);
  TTreeNode *vItem = tvBrowser->Items->Add(NULL, NETWORK);
  tvBrowser->Items->AddChild(vItem, NO_DATA);
};

void __fastcall TFrmEventsMain::tvBrowserExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  AllowExpansion = ProcessNodeExpanding(Node);
}
//---------------------------------------------------------------------------
bool __fastcall TFrmEventsMain::ProcessNodeExpanding(TTreeNode *ANode) {
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
bool __fastcall TFrmEventsMain::LoadRemoteHosts(TTreeNode *ANode) {
  ANode->DeleteChildren();
  TStringList *AList = new TStringList();
  SetWaitCursor();
  __try {
      WmiSystemEvents1->ListServers(AList);
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


void __fastcall TFrmEventsMain::tvBrowserChanging(TObject *Sender,
      TTreeNode *Node, bool &AllowChange)
{
  ProcessChangingNode(Node);
}
//---------------------------------------------------------------------------
void __fastcall TFrmEventsMain::ProcessChangingNode(TTreeNode *Node) {

  if (Node->Text == LOCAL_HOST) {
    DoConnect(Node);
  } else
  if (Node->Text == NETWORK) {
    WmiSystemEvents1->Active = false;
  } else {
    TCredentials *vCredentials = (TCredentials *) Node->Data;
    if (vCredentials != NULL) DoConnect(Node);
  };
  SetFormCaption();
};
//---------------------------------------------------------------------------
void __fastcall TFrmEventsMain::SetWaitCursor() {
  FStoredCursor = Screen->Cursor;
  Screen->Cursor = crHourGlass;
};
//---------------------------------------------------------------------------
void __fastcall TFrmEventsMain::RestoreCursor() {
  Screen->Cursor = FStoredCursor;
};
//---------------------------------------------------------------------------
bool __fastcall TFrmEventsMain::DoConnect(TTreeNode *ANode) {
  // do not reconnect if already connected to desired host.
  if ((ANode->Text == WmiSystemEvents1->MachineName) &&
      (WmiSystemEvents1->Active)) {
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
    WmiSystemEvents1->Active = false;
    if (ANode->Text == LOCAL_HOST) {
      // connect to local host;
      WmiSystemEvents1->Credentials->Clear();
      WmiSystemEvents1->MachineName = "";
      WmiSystemEvents1->Active = true;
      result = true;
    } else {
      if (ANode->Data == NULL) {
        // connect for the first time
        // try default credentials fisrt:
        try {
          WmiSystemEvents1->Credentials->Clear();
          WmiSystemEvents1->MachineName = ANode->Text;
          WmiSystemEvents1->Active = true;
          result = true;
        } catch (...) {
          // expected exception: the credentials are not valid
        };

        // default credentials did not work.
        // try to connect with user's provided credentials
        if (!WmiSystemEvents1->Active) {
          TFrmNewHost *vForm = new TFrmNewHost(NULL);
          vForm->MachineName = ANode->Text;
          __try {
            while (vForm->ShowModal() == mrOk) {
              try {
                WmiSystemEvents1->Active = false;
                WmiSystemEvents1->Credentials->Clear();
                WmiSystemEvents1->MachineName = ANode->Text;
                WmiSystemEvents1->Credentials->UserName = vForm->UserName;
                WmiSystemEvents1->Credentials->Password = vForm->edtPassword->Text;
                WmiSystemEvents1->Active = true;

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
        WmiSystemEvents1->MachineName = ANode->Text;
        WmiSystemEvents1->Credentials->UserName = vCredentials->UserName;
        WmiSystemEvents1->Credentials->Password = vCredentials->Password;
        WmiSystemEvents1->Active = true;
        result = true;
      };
    };
  } __finally {
    RestoreCursor();
  };

  return result;
};

//---------------------------------------------------------------------------
AnsiString __fastcall TFrmEventsMain::GetMachineName() {
  if (WmiSystemEvents1->MachineName.Length() != 0) {
    return WmiSystemEvents1->MachineName;
  } else {
    return LOCAL_HOST;
  }  
};

void __fastcall TFrmEventsMain::SetFormCaption() {
  if (WmiSystemEvents1->Active) {
    Caption = CNST_CAPTION + GetMachineName();
  } else {
    Caption = "System Events Viewer";
  };
};

void __fastcall TFrmEventsMain::tlbNewHostClick(TObject *Sender)
{
  CreateNewNetworkNode();
  SetButtonState();
}
//---------------------------------------------------------------------------
void __fastcall TFrmEventsMain::SetButtonState() {
};
//---------------------------------------------------------------------------
void __fastcall TFrmEventsMain::CreateNewNetworkNode() {
  TFrmNewHost *vForm = new TFrmNewHost(NULL);
  __try {
    while (vForm->ShowModal() == mrOk) {
      try {

        WmiSystemEvents1->Active = false;
        WmiSystemEvents1->Credentials->Clear();
        WmiSystemEvents1->MachineName = vForm->edtHostName->Text;
        WmiSystemEvents1->Credentials->UserName = vForm->UserName;
        WmiSystemEvents1->Credentials->Password = vForm->edtPassword->Text;
        WmiSystemEvents1->Active = true;

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
TTreeNode * __fastcall TFrmEventsMain::FindNeworkNode() {
  for (int i = 0; i <  tvBrowser->Items->Count; i++) {
    if (tvBrowser->Items->Item[i]->Text == NETWORK) {
      return tvBrowser->Items->Item[i];
    };
  }
  return NULL;
};



void __fastcall TFrmEventsMain::tvBrowserChange(TObject *Sender,
      TTreeNode *Node)
{
  SetButtonState();
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::tlbAboutClick(TObject *Sender)
{
  TFrmAbout *vForm = new TFrmAbout(NULL);
  __try {
    vForm->ShowModal();
  } __finally {
    vForm->Free();
  };
}
//---------------------------------------------------------------------------
void __fastcall TFrmEventsMain::chbConnectClick(TObject *Sender)
{
  RegisterEvent(wetNetworkConnect, chbConnect->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::AddEventRecord(AnsiString AText) {
  SoundOnEvent();
  TListItem* vItem = lvWatch->Items->Add();
  vItem->Caption = AText;
};
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnNetworkConnected(TObject *ASender) {
  AddEventRecord("Network adapter is now connected");
};
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnNetworkDisconnected(TObject *ASender) {
  AddEventRecord("Network adapter was disconnected");
};
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::SoundOnEvent() {
  if (chbSoundOnEvent->Checked) Beep();
};

//---------------------------------------------------------------------------
void __fastcall TFrmEventsMain::chbDisconnectClick(TObject *Sender)
{
  RegisterEvent(wetNetworkDisconnect, chbDisconnect->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::chbApplicationClick(TObject *Sender)
{
  RegisterEvent(wetEventLogApplication, chbApplication->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnEventLogApplication(TObject *ASender, const OleVariant &Instance, WideString EventLog, WideString AMessage) {
  AddEventRecord("A new record was inserted into Application event log. The message is: "+AMessage);
};
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnEventLogSystem(TObject *ASender, const OleVariant &Instance, WideString EventLog, WideString AMessage) {
  AddEventRecord("A new record was inserted into System event log. The message is: "+AMessage);
};
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnEventLogSecurity(TObject *ASender, const OleVariant &Instance, WideString EventLog, WideString AMessage) {
  AddEventRecord("A new record was inserted into Security event log. The message is: "+AMessage);
};
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::FormResize(TObject *Sender)
{
  lvWatch->Columns->Items[0]->Width = lvWatch->ClientWidth - 1;
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::chbSystemClick(TObject *Sender)
{
  RegisterEvent(wetEventLogSystem, chbSystem->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::chbSecurityClick(TObject *Sender)
{
  RegisterEvent(wetEventLogSecurity, chbSecurity->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::btnClearClick(TObject *Sender)
{
  lvWatch->Items->Clear();
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::chbUserClick(TObject *Sender)
{
  RegisterEvent(wetUserAccount, chbUser->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnUserAccount(TObject *ASender,
  const OleVariant &Instance, WideString Name, WideString Domain, TWmiEventAction Action) {

  AnsiString vAction;
  switch (Action) {
     case weaCreated:
       vAction = "created";
       break;
     case weaDeleted:
       vAction = "deleted";
       break;
     case weaModified:
       vAction = "modified";
       break;
  };
  AddEventRecord("User account \""+Domain + "\\" + Name + "\" was "+ vAction);
};
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnGroupAccount(TObject *ASender,
  const OleVariant &Instance, WideString Name, WideString Domain, TWmiEventAction Action) {

  AnsiString vAction;
  switch (Action) {
     case weaCreated:
       vAction = "created";
       break;
     case weaDeleted:
       vAction = "deleted";
       break;
     case weaModified:
       vAction = "modified";
       break;
  };
  AddEventRecord("User group \""+Domain + "\\"+Name + "\" was "+ vAction);
};
//---------------------------------------------------------------------------



void __fastcall TFrmEventsMain::chbGroupClick(TObject *Sender)
{
  RegisterEvent(wetGroupAccount, chbGroup->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnGroupMembership(TObject *ASender,
      const OleVariant &Instance, WideString AGroupName, WideString AGroupDomain,
      WideString AUserName, WideString AUserDomain, TWmiEventAction Action) {
  switch (Action) {
     case weaCreated:
       AddEventRecord("A user \""+AUserDomain+"\\"+AUserName + "\" was added to the group \""+
                      AGroupDomain+"\\"+AGroupName + "\"");
       break;               
     case weaDeleted:
       AddEventRecord("A user \""+AUserDomain+"\\"+AUserName + "\" was deleted from the group \""+
                      AGroupDomain+"\\"+AGroupName + "\"");
       break;               
     case weaModified:
       AddEventRecord("A membership of the user \""+AUserDomain+"\\"+AUserName + "\" in the group \""+
                      AGroupDomain+"\\"+AGroupName + "\" was modified");
       break;               
  };
};
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::chbMembershipClick(TObject *Sender)
{
  RegisterEvent(wetGroupMembership, chbMembership->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::RegisterEvent(TWmiEventType AEventType, bool IfRegister) {
    SetWaitCursor();
    __try {
      switch (AEventType) {
        case wetEventLogApplication:
          if (IfRegister) WmiSystemEvents1->OnEventLogApplication = &OnEventLogApplication;
            else WmiSystemEvents1->OnEventLogApplication = NULL;
          break;  
        case wetEventLogSystem:
          if (IfRegister) WmiSystemEvents1->OnEventLogSystem = OnEventLogSystem;
            else WmiSystemEvents1->OnEventLogSystem = NULL;
          break;  
        case wetEventLogSecurity:
          if (IfRegister) WmiSystemEvents1->OnEventLogSecurity = OnEventLogSecurity;
            else WmiSystemEvents1->OnEventLogSecurity = NULL;
          break;  
        case wetUserAccount:
          if (IfRegister) WmiSystemEvents1->OnUserAccount = OnUserAccount;
            else WmiSystemEvents1->OnUserAccount = NULL;
          break;  
        case wetGroupAccount:
          if (IfRegister) WmiSystemEvents1->OnGroupAccount = OnGroupAccount;
            else WmiSystemEvents1->OnGroupAccount = NULL;
          break;  
        case wetGroupMembership:
          if (IfRegister) WmiSystemEvents1->OnGroupMembership = OnGroupMembership;
            else WmiSystemEvents1->OnGroupMembership = NULL;
          break;
        case wetNetworkConnect:
          if (IfRegister) WmiSystemEvents1->OnNetworkConnect = OnNetworkConnected;
            else WmiSystemEvents1->OnNetworkConnect = NULL;
          break;
        case wetNetworkDisconnect:
          if (IfRegister) WmiSystemEvents1->OnNetworkDisconnect = OnNetworkDisconnected;
            else WmiSystemEvents1->OnNetworkDisconnect = NULL;
          break;
        case wetPrinter:
          if (IfRegister) WmiSystemEvents1->OnPrinter = OnPrinter;
            else WmiSystemEvents1->OnPrinter = NULL;
          break;
        case wetPrintJob:
          if (IfRegister) WmiSystemEvents1->OnPrintJob = OnPrintJob;
            else WmiSystemEvents1->OnPrintJob = NULL;
          break;  
        case wetSessionLogon:
          if (IfRegister) WmiSystemEvents1->OnUserLogon = OnUserLogon;
            else WmiSystemEvents1->OnUserLogon = NULL;
          break;  
        case wetSessionLogoff:
          if (IfRegister) WmiSystemEvents1->OnUserLogoff = OnUserLogoff;
            else WmiSystemEvents1->OnUserLogoff = NULL;
          break;  
        case wetCDROMInserted:
          if (IfRegister) WmiSystemEvents1->OnCDROMInserted = OnCDROMInserted;
            else WmiSystemEvents1->OnCDROMInserted = NULL;
          break;  
        case wetCDROMEjected:
          if (IfRegister) WmiSystemEvents1->OnCDROMEjected = OnCDROMEjected;
            else WmiSystemEvents1->OnCDROMEjected = NULL;
          break;  
        case wetService:
          if (IfRegister) WmiSystemEvents1->OnService = OnService;
            else WmiSystemEvents1->OnService = NULL;
          break;  
        case wetDocking:
          if (IfRegister) WmiSystemEvents1->OnDocking = OnDocking;
            else WmiSystemEvents1->OnDocking = NULL;
          break;  
      };
    } __finally {
      RestoreCursor();
    };
};
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnPrinter(TObject *ASender, const OleVariant &Instance,
  WideString Name, TWmiEventAction Action) {

  AnsiString vAction;
  switch (Action) {
     case weaCreated:
       vAction = "installed";
       break;
     case weaDeleted:
       vAction = "deleted";
       break;
     case weaModified:
       vAction = "modified";
       break;
  };
  AddEventRecord("Printer \""+Name + "\" was "+ vAction);
};

void __fastcall TFrmEventsMain::chbPrinterClick(TObject *Sender)
{
  RegisterEvent(wetPrinter, chbPrinter->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnPrintJob(TObject *ASender,
      const OleVariant &Instance, WideString Document, int JobID,
      WideString JobStatus, TWmiEventAction Action) {

  AnsiString vAction;
  switch (Action) {
     case weaCreated:
       vAction = "was created";
       break;
     case weaDeleted:
       vAction = "has finished";
       break;
     case weaModified:
       vAction = "has modified";
       break;
  };
  AddEventRecord("Job \""+IntToStr(JobID) + "\"("+ Document +") "+ vAction +
                 ". Last job status is " + JobStatus);
};

void __fastcall TFrmEventsMain::chbJobClick(TObject *Sender)
{
  RegisterEvent(wetPrintJob, chbJob->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnUserLogon(TObject *ASender, WideString LogonId,
        WideString Name, WideString Domain) {
  AddEventRecord("The user " + Domain + "\\" + Name + " logged on to "+GetMachineName() +
                 ". LogonId is "+LogonId);
};
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnUserLogoff(TObject *ASender, WideString LogonId,
        WideString Name, WideString Domain) {
  AddEventRecord("The user " + Domain + "\\" + Name + " logged off "+GetMachineName() +
                 ". LogonId is "+LogonId);
};

void __fastcall TFrmEventsMain::chbLogonClick(TObject *Sender)
{
  RegisterEvent(wetSessionLogon, chbLogon->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::chbLogoffClick(TObject *Sender)
{
  RegisterEvent(wetSessionLogoff, chbLogoff->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::chbServiceClick(TObject *Sender)
{
  RegisterEvent(wetService, chbService->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnService(TObject *ASender, const OleVariant &Instance,
  WideString AServiceName, WideString AState, TWmiEventAction Action) {

  AnsiString vAction;
  switch (Action) {
     case weaCreated:
       vAction = " was installed";
       break;
     case weaDeleted:
       vAction = " was deinstalled";
       break;
     case weaModified:
       vAction = " has changed its state";
  };
  AddEventRecord("The service "+AServiceName + vAction + ". Last service state: "+AState);
};
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnDocking(TObject *ASender) {
  AddEventRecord("The docking state has changed.");
};

void __fastcall TFrmEventsMain::chbDockingClick(TObject *Sender)
{
  RegisterEvent(wetDocking, chbDocking->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnCDROMEjected(TObject *ASender,
  const OleVariant &Instance, WideString ADrive) {

  AddEventRecord("CD disk was ejected from drive "+ ADrive);
};
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnCDROMInserted(TObject *ASender,
  const OleVariant &Instance, WideString ADrive) {

  AddEventRecord("CD disk was insetred into drive "+ ADrive);
};

void __fastcall TFrmEventsMain::chbCDROMInsertedClick(TObject *Sender)
{
  RegisterEvent(wetCDROMInserted, chbCDROMInserted->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::chbCDROMEjectedClick(TObject *Sender)
{
  RegisterEvent(wetCDROMEjected, chbCDROMEjected->Checked);
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::sbRegisterQueryClick(TObject *Sender) {
  if (sbRegisterQuery->Down) {
    __try {
      WmiSystemEvents1->RegisterWmiEvent(cmnNameSpaces->Text,
              memQuery->Lines->Text,
              "",
              &OnCustomEvent,
              NULL,
              0);

      memQuery->Enabled = false;
      cmnNameSpaces->Enabled = false;
    } catch (...) {
      sbRegisterQuery->Down = false;
      throw;
    };
  } else {
    WmiSystemEvents1->UnregisterWmiEvent(memQuery->Lines->Text);
    memQuery->Enabled = true;
    cmnNameSpaces->Enabled = true;
  };
}
//---------------------------------------------------------------------------

void __fastcall TFrmEventsMain::OnCustomEvent(TObject *Sender,
  TEventInfoHolder *EventInfo, const OleVariant &Event) {
  AddEventRecord("User defined event happened. It was caused by this notification query: "+ EventInfo->EventQuery);
};

