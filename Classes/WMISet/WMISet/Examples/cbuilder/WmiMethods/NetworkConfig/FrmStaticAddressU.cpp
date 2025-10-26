//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmStaticAddressU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFrmStaticAddress *FrmStaticAddress;
//---------------------------------------------------------------------------
__fastcall TFrmStaticAddress::TFrmStaticAddress(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFrmStaticAddress::edtIPAddressChange(TObject *Sender)
{
  SetButtonState();
}

//---------------------------------------------------------------------------
void __fastcall TFrmStaticAddress::SetButtonState() {
  btnSetStaticAddress->Enabled = (edtIPAddress->Text.Trim() != "") &&
                                 (edtDefaultGateway->Text.Trim() != "") &&
                                 (edtIPSubnetMask->Text.Trim() != "");
};
