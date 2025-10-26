//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmNewTaskU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFrmNewTask *FrmNewTask;
//---------------------------------------------------------------------------
__fastcall TFrmNewTask::TFrmNewTask(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFrmNewTask::edtFileNameChange(TObject *Sender)
{
  btnStart->Enabled = edtFileName->Text.Trim().Length() > 0;
}
//---------------------------------------------------------------------------
