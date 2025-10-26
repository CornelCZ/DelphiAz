//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmSelectColumnsU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFrmSelectColumns *FrmSelectColumns;
//---------------------------------------------------------------------------
__fastcall TFrmSelectColumns::TFrmSelectColumns(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFrmSelectColumns::FormCreate(TObject *Sender)
{
  ClientWidth = btnCancel->Left + btnCancel->Width + 7; 
  ClientHeight = btnCancel->Top + btnCancel->Height + 7; 
}
//---------------------------------------------------------------------------
