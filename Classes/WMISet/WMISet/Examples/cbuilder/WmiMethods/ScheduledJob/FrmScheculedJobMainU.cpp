//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmScheculedJobMainU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "WmiAbstract"
#pragma link "WmiConnection"
#pragma link "WmiDataSet"
#pragma link "WmiMethod"
#pragma resource "*.dfm"
TFrmScheduledJobMain *FrmScheduledJobMain;

AnsiString __fastcall TFrmScheduledJobMain::getErrorDescription(int errorCode) {
   switch (errorCode) {
      case 0: return "Success";
      case 1: return "Not Supported";
      case 2: return "Access Denied";
      case 8: return "Interactive process";
      case 9: return "The directory path to the service executable file was not found.";
      case 21: return "Status Invalid Parameter";
      case 22: return "Status Invalid Service Account";
      default: return "";
   }
}

//---------------------------------------------------------------------------
__fastcall TFrmScheduledJobMain::TFrmScheduledJobMain(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFrmScheduledJobMain::DataSource1DataChange(
      TObject *Sender, TField *Field)
{
  setButtonState();
}
//---------------------------------------------------------------------------
void __fastcall TFrmScheduledJobMain::tlbDeleteClick(TObject *Sender)
{
  WmiMethodDelete->Execute();
  int result = WmiMethodDelete->OutParams->ParamByName("ReturnValue")->AsInteger;
  if (result != 0) {
        Application->MessageBoxA(getErrorDescription(result).c_str(), "Error", MB_ICONHAND + MB_OK) ;
  } else {
        refresh();
  }
}
//---------------------------------------------------------------------------
void __fastcall TFrmScheduledJobMain::refresh() {
  TLocateOptions options;
  int selected = -1;
  if (WmiQuery1->RecordCount > 0) {
    selected = WmiQuery1->FieldByName("JobId")->AsInteger;
  }  

  WmiQuery1->DisableControls();
  Screen->Cursor = crHourGlass;
  __try {
    WmiQuery1->Close();
    WmiQuery1->Open();
    if (selected != -1) {
      WmiQuery1->Locate("JobId", selected, options);
    }  
  } __finally {
    WmiQuery1->EnableControls();
    Screen->Cursor = crDefault;
  }
  setButtonState();
}
//---------------------------------------------------------------------------
void __fastcall TFrmScheduledJobMain::setButtonState() {
  tlbDelete->Enabled = WmiQuery1->RecordCount > 0;
}

void __fastcall TFrmScheduledJobMain::tlbRefreshClick(TObject *Sender)
{
    refresh();
}
//---------------------------------------------------------------------------

void __fastcall TFrmScheduledJobMain::tlbCreateClick(TObject *Sender)
{
  TFrmNewJob *FrmNewJob = new TFrmNewJob(NULL);
  __try {
    while (true)  {
        if (FrmNewJob->ShowModal() == mrOk) {
            WmiMethodCreate->InParams->ParamByName("Command")->AsString = FrmNewJob->edtCommand->Text;
            WmiMethodCreate->InParams->ParamByName("StartTime")->AsTime = FrmNewJob->dtpStartTime->Time;
            WmiMethodCreate->InParams->ParamByName("InteractWithDesktop")->AsBoolean = FrmNewJob->chbInteract->Checked;
            WmiMethodCreate->InParams->ParamByName("RunRepeatedly")->AsBoolean = FrmNewJob->chbRunRepeatedly->Checked;
            if (FrmNewJob->chbRunRepeatedly->Checked) {
                WmiMethodCreate->InParams->ParamByName("DaysOfWeek")->AsInteger = FrmNewJob->getDaysOfWeek();
                WmiMethodCreate->InParams->ParamByName("DaysOfMonth")->AsInteger = FrmNewJob->getDaysOfMonth();
            }
            WmiMethodCreate->Execute();

            int result = WmiMethodCreate->OutParams->ParamByName("ReturnValue")->AsInteger;
            if (result != 0) {
                  Application->MessageBoxA(getErrorDescription(result).c_str(), "Error", MB_ICONHAND + MB_OK) ;
            } else {
                  refresh();
                  break;
            }
        } else {
          break;
        }
    }
  } __finally {
     delete FrmNewJob;
  }
}
//---------------------------------------------------------------------------

void __fastcall TFrmScheduledJobMain::DBGrid1DrawColumnCell(
      TObject *Sender, const TRect &Rect, int DataCol, TColumn *Column,
      TGridDrawState State)
{
  if ((Column->FieldName == "DaysOfWeek") && (Column->Field != NULL)) {
      AnsiString sDaysOfWeek = DaysOfWeekToStr(Column->Field->AsInteger);
      DBGrid1->Canvas->TextRect(Rect, Rect.Left + 1, Rect.Top + 1, sDaysOfWeek);
  }
  if ((Column->FieldName == "DaysOfMonth") && (Column->Field != NULL)) {
      AnsiString sDaysOfMonth = DaysOfMonthToStr(Column->Field->AsInteger);
      DBGrid1->Canvas->TextRect(Rect, Rect.Left + 1, Rect.Top + 1, sDaysOfMonth);
  }
}
//---------------------------------------------------------------------------

AnsiString __fastcall TFrmScheduledJobMain::DaysOfWeekToStr(int days) {
  if (days == 127) {
    return "All";
  } else {
    AnsiString result = "";
    int mask = 1;
    for (int i = 0; i < 7; i++) {
      int day = mask & days;
      if (day != 0) {
        switch (day) {
          case 1: {result += "Mon "; break; }
          case 2: {result += "Tue "; break; }
          case 4: {result += "Wed "; break; }
          case 8: {result += "Thu "; break; }
          case 16: {result += "Fri "; break; }
          case 32: {result += "Sat "; break; }
          case 64: {result += "Sun "; break; }
          default:;
        }
      }
      mask *= 2;
    }
    return result;
  }  
}

AnsiString __fastcall TFrmScheduledJobMain::DaysOfMonthToStr(int days) {
  if (days == 2147483647) {
    return "All";
  } else {
    AnsiString result = "";
    int mask = 1;
    for (int i = 0; i < 32; i++) {
        int day = mask & days;
        if (day != 0) {
          result += IntToStr(i+1) + ",";
        }
        mask *= 2;
    }
    return result;
  }
}
void __fastcall TFrmScheduledJobMain::tlbConnectClick(TObject *Sender) {

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
void __fastcall TFrmScheduledJobMain::setFormCaption() {
  if (WmiConnection1->MachineName.Length() == 0) {
    Caption = "Scheduled jobs on local host";
  } else {
    Caption = "Scheduled jobs on "+ WmiConnection1->MachineName;
  }
}
//---------------------------------------------------------------------------

void __fastcall TFrmScheduledJobMain::FormCreate(TObject *Sender)
{
  setFormCaption();
}
//---------------------------------------------------------------------------

