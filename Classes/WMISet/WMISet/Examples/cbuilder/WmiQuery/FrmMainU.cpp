//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmMainU.h"
#include "FrmNewHostU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "WmiConnection"
#pragma link "WmiDataSet"
#pragma resource "*.dfm"
TFrmMain *FrmMain;

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
bool __fastcall TFrmMain::DoConnect(TTreeNode *ANode) {
  // do not reconnect if already connected to desired host.
  if ((ANode->Text == WmiConnection1->MachineName) &&
      (WmiConnection1->Connected)) {
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
    WmiConnection1->Connected = false;
    if (ANode->Text == LOCAL_HOST) {
      // connect to local host;
      WmiConnection1->Credentials->Clear();
      WmiConnection1->MachineName = "";
      WmiConnection1->Connected = true;
      result = true;
    } else {
      if (ANode->Data == NULL) {
        // connect for the first time
        // try default credentials fisrt:
        try {
          WmiConnection1->Credentials->Clear();
          WmiConnection1->MachineName = ANode->Text;
          WmiConnection1->Connected = true;
          result = true;
        } catch (...) {
          // expected exception: the credentials are not valid
        };

        // default credentials did not work.
        // try to connect with user's provided credentials
        if (!WmiConnection1->Connected) {
          TFrmNewHost *vForm = new TFrmNewHost(NULL);
          vForm->MachineName = ANode->Text;
          __try {
            while (vForm->ShowModal() == mrOk) {
              try {
                WmiConnection1->Connected = false;
                WmiConnection1->Credentials->Clear();
                WmiConnection1->MachineName = ANode->Text;
                WmiConnection1->Credentials->UserName = vForm->UserName;
                WmiConnection1->Credentials->Password = vForm->edtPassword->Text;
                WmiConnection1->Connected = true;

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
        WmiConnection1->MachineName = ANode->Text;
        WmiConnection1->Credentials->UserName = vCredentials->UserName;
        WmiConnection1->Credentials->Password = vCredentials->Password;
        WmiConnection1->Connected = true;
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
void __fastcall TFrmMain::OnShowHint(AnsiString &HintStr, bool &CanShow, THintInfo &HintInfo) {
  if ((HintInfo.HintControl == DBGrid1) &&
      (WmiQuery1->Active) && (WmiQuery1->IrregularView)) {
    HintStr = WmiQuery1->Fields->Fields[0]->AsString;
    HintInfo.HideTimeout = 20000;
  } else {
    HintStr = "";
  };
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::InitItems() {
  tvBrowser->Items->Add(NULL, LOCAL_HOST);
  TTreeNode *vItem = tvBrowser->Items->Add(NULL, NETWORK);
  tvBrowser->Items->AddChild(vItem, NO_DATA);
};

//---------------------------------------------------------------------------
bool __fastcall TFrmMain::ProcessNodeExpanding(TTreeNode *ANode) {
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
bool __fastcall TFrmMain::LoadRemoteHosts(TTreeNode *ANode) {
  ANode->DeleteChildren();
  TStringList *AList = new TStringList();
  SetWaitCursor();
  __try {
      WmiConnection1->ListServers(AList);
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
void __fastcall TFrmMain::ProcessChangingNode(TTreeNode *Node) {

  if (Node->Text == LOCAL_HOST) {
    DoConnect(Node);
    tlbConnect->Down = true;
  } else
  if (Node->Text == NETWORK) {
    tlbConnect->Down = false;
    WmiConnection1->Connected = false;
  } else {
    TCredentials *vCredentials = (TCredentials *) Node->Data;
    tlbConnect->Down = vCredentials != NULL;
    if (vCredentials != NULL) DoConnect(Node);
  };
  SetButtonState();
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::CreateNewNetworkNode() {
  TFrmNewHost *vForm = new TFrmNewHost(NULL);
  __try {
    while (vForm->ShowModal() == mrOk) {
      try {

        WmiConnection1->Connected = false;
        WmiConnection1->Credentials->Clear();
        WmiConnection1->MachineName = vForm->edtHostName->Text;
        WmiConnection1->Credentials->UserName = vForm->UserName;
        WmiConnection1->Credentials->Password = vForm->edtPassword->Text;
        WmiConnection1->Connected = true;

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
TTreeNode * __fastcall TFrmMain::FindNeworkNode() {
  for (int i = 0; i <  tvBrowser->Items->Count; i++) {
    if (tvBrowser->Items->Item[i]->Text == NETWORK) {
      return tvBrowser->Items->Item[i];
    };
  }
  return NULL;
};

//---------------------------------------------------------------------------
void __fastcall TFrmMain::SetButtonState() {

  if (tvBrowser->Selected != NULL) {
    TTreeNode *ANode = tvBrowser->Selected;
    tlbConnect->Enabled = (ANode->Text != LOCAL_HOST) &&
                          (ANode->Text != NETWORK);
    tlbExecute->Enabled = WmiConnection1->Connected;
  } else {
    tlbConnect->Enabled = false;
    tlbExecute->Enabled = false;
  };

  tlbPrevQuery->Enabled = FHistoryIndex > 0;
  tlbNextQuery->Enabled = FHistoryIndex < FHistory->Count - 1;

};

void __fastcall TFrmMain::FormCreate(TObject *Sender)
{
  FHistory = new TStringList();
  FHistory->Duplicates = dupIgnore;
  FHistory->Add("select * from Win32_UserAccount");
  FHistory->Add("select Domain, Name from Win32_Group");
  FHistory->Add("select * from Win32_Service where state=\"Running\"");
  FHistory->Add("ASSOCIATORS OF {Win32_Group.Domain=\"BUILTIN\",Name=\"Administrators\"}\x0D\x0A WHERE ResultClass = Win32_UserAccount");
  FHistory->Add("select * from Win32_DiskDrive");
  FHistoryIndex = FHistory->Count - 1;

  Application->OnShowHint = OnShowHint;
  InitItems();
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::tvBrowserExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  AllowExpansion = ProcessNodeExpanding(Node);
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::tvBrowserChanging(TObject *Sender,
      TTreeNode *Node, bool &AllowChange)
{
  ProcessChangingNode(Node);
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::tlbNewHostClick(TObject *Sender)
{
  CreateNewNetworkNode();
  SetButtonState();
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::tlbExecuteClick(TObject *Sender)
{
  WmiQuery1->Active = false;
  WmiQuery1->WQL->Text = memWQL->Lines->Text;

  SetWaitCursor();
  __try {
    TDateTime vStartTime = Now();
    WmiQuery1->Active = true;
    int execTime = Floor((double)(Now() - vStartTime) / SECOND);
    StatusBar->Panels->Items[0]->Text = "Execution time: " +
                                IntToStr(execTime) + " sec";
  } __finally {
    RestoreCursor();
  };

  // remember executed query in the history.
  if (FHistory->IndexOf(memWQL->Text) == -1) {
    FHistory->Add(memWQL->Text);
  }
  FHistoryIndex = FHistory->Count - 1;
  SetButtonState();
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::tlbConnectClick(TObject *Sender)
{
  // connect to remote host.
  TObject *vObject = (TObject *) tvBrowser->Selected->Data;
  if (vObject == NULL) {
    tlbConnect->Down = DoConnect(tvBrowser->Selected);
  } else {
    WmiConnection1->Connected = false;
    vObject->Free();
    tvBrowser->Selected->Data = NULL;
    tlbConnect->Down = false;
  };
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::tvBrowserChange(TObject *Sender, TTreeNode *Node)
{
  SetButtonState();
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::tvBrowserCustomDrawItem(TCustomTreeView *Sender,
      TTreeNode *Node, TCustomDrawState State, bool &DefaultDraw)
{
  // show connected server with underlined font.
  if ((Node->Data != NULL) || (Node->Text == LOCAL_HOST)) {
    tvBrowser->Canvas->Font->Style = TFontStyles()<< fsUnderline;
  };
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::FormDestroy(TObject *Sender)
{
  FHistory->Free();
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::tlbPrevQueryClick(TObject *Sender)
{
  FHistoryIndex--;
  memWQL->Lines->Text = FHistory->Strings[FHistoryIndex];
  SetButtonState();
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::tlbNextQueryClick(TObject *Sender)
{
  FHistoryIndex++;
  memWQL->Lines->Text = FHistory->Strings[FHistoryIndex];
  SetButtonState();
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::WmiQuery1BeforeScroll(TDataSet *DataSet)
{
  SetWaitCursor();
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::WmiQuery1AfterScroll(TDataSet *DataSet)
{
  RestoreCursor();
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::chbIrregularClick(TObject *Sender)
{
  WmiQuery1->IrregularView = chbIrregular->Checked;
  DBGrid1->ShowHint        = chbIrregular->Checked;
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::tlbAboutClick(TObject *Sender)
{
  TFrmAbout *vForm = new TFrmAbout(NULL);
  __try {
    vForm->ShowModal();
  } __finally {
    vForm->Free();
  };
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::cmbNameSpaceChange(TObject *Sender) {

  TCursor vCursor = Screen->Cursor;
  Screen->Cursor = crHourGlass;
  __try {
    bool vWasConnected = WmiConnection1->Connected;
    AnsiString vOldNameSpace = WmiConnection1->NameSpace;
    if (WmiConnection1->Connected) WmiConnection1->Connected = false;
    __try {
      WmiConnection1->NameSpace = cmbNameSpace->Text;
      WmiConnection1->Connected = vWasConnected;
    } catch (...) {
      cmbNameSpace->ItemIndex = cmbNameSpace->Items->IndexOf(vOldNameSpace);
      WmiConnection1->NameSpace = vOldNameSpace;
      WmiConnection1->Connected = vWasConnected;
      throw;
    };
  } __finally {
    Screen->Cursor = vCursor;
  };
};
//---------------------------------------------------------------------------

void __fastcall TFrmMain::WmiConnection1AfterConnect(TObject *Sender)
{
  cmbClasses->Items->Clear();
  WmiConnection1->ListClasses(cmbClasses->Items);
  cmbClasses->Sorted = true;
}
//---------------------------------------------------------------------------

void __fastcall TFrmMain::spbInsertClick(TObject *Sender)
{
  if (cmbClasses->Text.Length() >  0) {
    memWQL->SelLength = 0;
    memWQL->SelText = cmbClasses->Text;
    memWQL->SelLength = 0;
  };
}
//---------------------------------------------------------------------------

