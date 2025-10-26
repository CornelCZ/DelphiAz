//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmSelectHostU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFrmSelectHost *FrmSelectHost;
//---------------------------------------------------------------------------
__fastcall TFrmSelectHost::TFrmSelectHost(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFrmSelectHost::chbConnectAsCurrentClick(TObject *Sender)
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
void __fastcall TFrmSelectHost::DisableEdit(TEdit *AEdit) {
    AEdit->Enabled   = false;
    AEdit->Color     = clBtnFace;
    AEdit->Text      = "";
};
//---------------------------------------------------------------------------
void __fastcall TFrmSelectHost::EnableEdit(TEdit *AEdit) {
    AEdit->Enabled   = true;
    AEdit->Color     = clWindow;
};
//---------------------------------------------------------------------------
void __fastcall TFrmSelectHost::cmbComputersDropDown(TObject *Sender)
{
  if (!FListLoaded) {
    TCursor vCursor = Screen->Cursor;
    Screen->Cursor = crHourGlass;
    __try {
      FWmiComponent->ListServers(cmbComputers->Items);
      if (cmbComputers->Items->IndexOf(FWmiComponent->SystemInfo->ComputerName) == -1) {
        cmbComputers->Items->Add(FWmiComponent->SystemInfo->ComputerName);
      }
      FListLoaded = true;
    } __finally {
      Screen->Cursor = vCursor;
    };
  };
}
//---------------------------------------------------------------------------
void __fastcall TFrmSelectHost::FormCreate(TObject *Sender)
{
  FListLoaded = false;
}
//---------------------------------------------------------------------------
