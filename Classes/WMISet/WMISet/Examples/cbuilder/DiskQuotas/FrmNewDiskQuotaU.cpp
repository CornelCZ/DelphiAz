//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmNewDiskQuotaU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFrmNewDiskQuota *FrmNewDiskQuota;
//---------------------------------------------------------------------------
__fastcall TFrmNewDiskQuota::TFrmNewDiskQuota(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFrmNewDiskQuota::OnControlChange(TObject *Sender)
{
  btnOk->Enabled = (cmbUser->Text.Length() != 0) &&
                   (cmbWarningLimit->Text.Length() != 0) &&
                   (cmbLimit->Text.Length() != 0);
}
//---------------------------------------------------------------------------
void __fastcall TFrmNewDiskQuota::cmbLimitKeyPress(TObject *Sender,
      char &Key)
{
  if (! (Key >= '0' && Key <= '9') ||
         Key == Char(VK_BACK) ||
         Key == Char(VK_DELETE) ||
         Key == Char(VK_LEFT) ||
         Key == Char(VK_RIGHT) ||
         Key == Char(VK_TAB)
      ) {
      Key = 0;
  }    
}
//---------------------------------------------------------------------------
