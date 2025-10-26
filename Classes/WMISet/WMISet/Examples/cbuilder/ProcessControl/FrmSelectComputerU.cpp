//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmSelectComputerU.h"
#include "WmiAbstract.hpp"
#include "WmiComponent.hpp"
#include "WmiProcessControl.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFrmSelectComputer *FrmSelectComputer;
//---------------------------------------------------------------------------
__fastcall TFrmSelectComputer::TFrmSelectComputer(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFrmSelectComputer::chbConnectAsCurrentClick(TObject *Sender)
{
  if (chbConnectAsCurrent->Checked) {
    DisableEdit(edtDomain);
    DisableEdit(edtUserName);
    DisableEdit(edtPassword);
  } else {
    EnableEdit(edtDomain);
    EnableEdit(edtUserName);
    EnableEdit(edtPassword);
  };
}

//---------------------------------------------------------------------------
void __fastcall TFrmSelectComputer::DisableEdit(TEdit *AEdit) {
    AEdit->Enabled   = false;
    AEdit->Color     = clBtnFace;
    AEdit->Text      = "";
};

void __fastcall TFrmSelectComputer::EnableEdit(TEdit *AEdit) {
    AEdit->Enabled   = true;
    AEdit->Color     = clWindow;
};
void __fastcall TFrmSelectComputer::cmbComputersDropDown(TObject *Sender)
{
  if (!FListLoaded) {
    TWmiProcessControl *vControl = new TWmiProcessControl(NULL);
    TCursor vCursor = Screen->Cursor;
    Screen->Cursor = crHourGlass;
    __try {
      vControl->ListServers(cmbComputers->Items);
      if (cmbComputers->Items->IndexOf(vControl->SystemInfo->ComputerName) == -1) {
        cmbComputers->Items->Add(vControl->SystemInfo->ComputerName);
      }  
      FListLoaded = true;
    } __finally {
      Screen->Cursor = vCursor;
      vControl->Free();
    };
  };
}
//---------------------------------------------------------------------------
void __fastcall TFrmSelectComputer::FormCreate(TObject *Sender)
{
  FListLoaded = false;
}
//---------------------------------------------------------------------------
