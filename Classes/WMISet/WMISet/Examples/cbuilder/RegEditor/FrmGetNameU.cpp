//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmGetNameU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFrmGetName *FrmGetName;
//---------------------------------------------------------------------------
__fastcall TFrmGetName::TFrmGetName(AnsiString APrompt, AnsiString AValue)
        : TForm((TComponent *) NULL)
{
  lblPrompt->Caption = APrompt;
  Caption = APrompt;
  edtName->Text = AValue;
}
//---------------------------------------------------------------------------
