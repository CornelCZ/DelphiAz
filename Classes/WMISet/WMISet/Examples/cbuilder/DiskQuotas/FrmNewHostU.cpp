//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmNewHostU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFrmNewHost *FrmNewHost;
//---------------------------------------------------------------------------
__fastcall TFrmNewHost::TFrmNewHost(TComponent* Owner)
        : TForm(Owner) {
};

//---------------------------------------------------------------------------
void __fastcall TFrmNewHost::SetMachineName(WideString Value) {
  edtHostName->Text = Value;
  edtHostName->Enabled = (Value.Length() == 0);
}

//---------------------------------------------------------------------------
WideString __fastcall TFrmNewHost::GetUserName() {
  WideString result = edtUserName->Text;
  if (edtDomain->Text.Trim() != "") {
        result = edtDomain->Text + "\\" + result;
  }
  return result;
}

//---------------------------------------------------------------------------
WideString __fastcall TFrmNewHost::GetMachineName() {
        return edtHostName->Text;
}


void __fastcall TFrmNewHost::OnEditChanged(TObject *Sender)
{
  btnConnect->Enabled = edtHostName->Text.Trim().Length() != 0 &&
                        edtUserName->Text.Trim().Length() != 0;
}
//---------------------------------------------------------------------------

