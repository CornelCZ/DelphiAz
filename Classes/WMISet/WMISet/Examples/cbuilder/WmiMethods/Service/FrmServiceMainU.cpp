//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmServiceMainU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "WmiAbstract"
#pragma link "WmiConnection"
#pragma link "WmiDataSet"
#pragma link "WmiMethod"
#pragma resource "*.dfm"
TFrmServicemain *FrmServicemain;
//---------------------------------------------------------------------------
__fastcall TFrmServicemain::TFrmServicemain(TComponent* Owner)
        : TForm(Owner) {
}
//---------------------------------------------------------------------------
void __fastcall TFrmServicemain::DataSource1DataChange(TObject *Sender,
      TField *Field) {
  setButtonState();
}

//---------------------------------------------------------------------------
void __fastcall TFrmServicemain::setButtonState() {
  tlbStart->Enabled = (WmiQuery1->FieldByName("State")->AsString == "Stopped");
  tlbStop->Enabled = (WmiQuery1->FieldByName("State")->AsString == "Running")  &&
                     (WmiQuery1->FieldByName("AcceptStop")->AsBoolean);
  tlbPause->Enabled = (WmiQuery1->FieldByName("State")->AsString == "Running")  &&
                     (WmiQuery1->FieldByName("AcceptPause")->AsBoolean);
  tlbResume->Enabled = (WmiQuery1->FieldByName("State")->AsString == "Paused");
}  

//---------------------------------------------------------------------------
void __fastcall TFrmServicemain::tlbStartClick(TObject *Sender) {
  executeMethod("StartService");
}
//---------------------------------------------------------------------------
void __fastcall TFrmServicemain::refresh() {
  TLocateOptions options;
  AnsiString selected = WmiQuery1->FieldByName("name")->AsString;

  WmiQuery1->DisableControls();
  Screen->Cursor = crHourGlass;
  __try {
    WmiQuery1->Close();
    WmiQuery1->Open();
    WmiQuery1->Locate("name", selected, options);
  } __finally {
    WmiQuery1->EnableControls();
    Screen->Cursor = crDefault;
  }
  setButtonState();
}

void __fastcall TFrmServicemain::tlbRefreshClick(TObject *Sender)
{
  refresh();        
}
//---------------------------------------------------------------------------

void __fastcall TFrmServicemain::tlbStopClick(TObject *Sender) {
  executeMethod("StopService");
}
//---------------------------------------------------------------------------

void __fastcall TFrmServicemain::tlbPauseClick(TObject *Sender) {
  executeMethod("PauseService");
}
//---------------------------------------------------------------------------
void __fastcall TFrmServicemain::tlbResumeClick(TObject *Sender) {
  executeMethod("ResumeService");
}
//---------------------------------------------------------------------------
void __fastcall TFrmServicemain::executeMethod(AnsiString methodName) {
  WmiMethod1->WmiMethodName = methodName;
  if (WmiMethod1->Execute() != 0) {
        AnsiString s = WmiMethod1->LastWmiErrorDescription;
        Application->MessageBoxA(s.c_str(), "Error", MB_ICONHAND + MB_OK) ;
  } else {
        refresh();
  }
}

void __fastcall TFrmServicemain::tlbConnectClick(TObject *Sender) {
 
  if (FrmSelectHost->ShowModal() == mrOk) {
    // save current credentials to be able to restore
    // them if new credentials are invalid.
    WideString vOldUserName = WmiConnection1->Credentials->UserName;
    WideString vOldPassword = WmiConnection1->Credentials->Password;
    WideString vOldMachineName = WmiConnection1->MachineName;

    WmiConnection1->Connected = false;
    AnsiString vUserName = FrmSelectHost->edtUserName->Text;
    if (FrmSelectHost->edtDomain->Text.Length() > 0) { 
      vUserName = FrmSelectHost->edtDomain->Text + "\\" + vUserName;
    }  
      
    WmiConnection1->Credentials->UserName = vUserName;
    WmiConnection1->Credentials->Password = FrmSelectHost->edtPassword->Text;
    WmiConnection1->MachineName = FrmSelectHost->cmbComputers->Text;

    TCursor vWasCursor = Screen->Cursor;
    Screen->Cursor = crHourGlass;
    try {
      __try {
        WmiConnection1->Connected = true;
        WmiQuery1->Active = true;
        setFormCaption();
        refresh();
      } __finally {
        Screen->Cursor = vWasCursor;
      };
    } catch(const Exception &e) {
          Application->MessageBox(e.Message.c_str(), "Error", MB_OK + MB_ICONSTOP);
          // restore previous credentials.
          WmiConnection1->Credentials->UserName = vOldUserName;
          WmiConnection1->Credentials->Password = vOldPassword;
          WmiConnection1->MachineName           = vOldMachineName;
          WmiConnection1->Connected = true;
          WmiQuery1->Active = true;
    };
  };
}
//---------------------------------------------------------------------------
void __fastcall TFrmServicemain::setFormCaption() {
  if (WmiConnection1->MachineName.Length() == 0) {
    Caption = "Services on local host";
  } else {
    Caption = "Services on "+ WmiConnection1->MachineName;
  }
}


void __fastcall TFrmServicemain::FormCreate(TObject *Sender)
{
  setFormCaption();
}
//---------------------------------------------------------------------------

