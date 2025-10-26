//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmNewJobU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TFrmNewJob::TFrmNewJob(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFrmNewJob::spbCommandClick(TObject *Sender)
{
  if (odCommand->Execute()) {
    edtCommand->Text = odCommand->FileName;
  }
}
//---------------------------------------------------------------------------
int __fastcall TFrmNewJob::getDaysOfWeek() {
  int mask = 1;
  int result = 0;
  for (int i = 0; i < clbDaysOfWeek->Items->Count; i++) {
      if (clbDaysOfWeek->Checked[i]) {
          result = result | mask;
      }
      mask *= 2;
  }
  return result;
}
//---------------------------------------------------------------------------
int __fastcall TFrmNewJob::getDaysOfMonth() {
  int mask = 1;
  int result = 0;
  for (int i = 0; i < clbDaysOfMonth->Items->Count; i++) {
      if (clbDaysOfMonth->Checked[i]) {
          result = result | mask;
      }
      mask *= 2;
  }
  return result;
}
void __fastcall TFrmNewJob::FormCreate(TObject *Sender)
{
  for (int i = 0; i < clbDaysOfMonth->Items->Count; i++) {
      clbDaysOfMonth->Checked[i] = true;
  }
  for (int i = 0; i < clbDaysOfWeek->Items->Count; i++) {
      clbDaysOfWeek->Checked[i] = true;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFrmNewJob::edtCommandChange(TObject *Sender)
{
  btnCreate->Enabled = edtCommand->Text != "";
}
//---------------------------------------------------------------------------
