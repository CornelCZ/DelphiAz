//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmEditDWORDU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFrmEditDWORD *FrmEditDWORD;
//---------------------------------------------------------------------------
__fastcall TFrmEditDWORD::TFrmEditDWORD(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

int __fastcall TFrmEditDWORD::GetValueData() {
  if (rgBase->ItemIndex == 0) {
      return HexToInt(edtValueData->Text);
  } else {
      return StrToInt(edtValueData->Text);
  }
}

void __fastcall TFrmEditDWORD::SetValueData(int Value) {
  if (rgBase->ItemIndex == 0) {
      edtValueData->Text = IntToHex(Value, 1);
  } else {
      edtValueData->Text = IntToStr(Value);
  }
}

unsigned int __fastcall TFrmEditDWORD::HexToInt(AnsiString AHexaDecimal) {
  while (AHexaDecimal.Length() < 8) {
     AHexaDecimal = "0" + AHexaDecimal;
  }

  return StrToInt("0x"+AHexaDecimal.SubString(7, 2)) +
         StrToInt("0x"+AHexaDecimal.SubString(5, 2)) * 0x100 +
         StrToInt("0x"+AHexaDecimal.SubString(3, 2)) * 0x10000 +
         StrToInt("0x"+AHexaDecimal.SubString(1, 2)) * 0x1000000;
};


void __fastcall TFrmEditDWORD::edtValueDataKeyPress(TObject *Sender,
      char &Key)
{
  if (
       !(
       ((Key >= '0') && (Key <= '9')) ||
       ((Key >= 'A') && (Key <= 'F')) ||
       ((Key >= 'a') && (Key <= 'f')) ||
       (Key == (char) VK_BACK) ||
       (Key == (char) VK_DELETE) ||
       (Key == (char) VK_LEFT) ||
       (Key == (char) VK_RIGHT) ||
       (Key == (char) VK_TAB) ||
       (Key == (char) VK_BACK) ||
       (Key == (char) VK_BACK) ||
       (Key == (char) VK_BACK)
       )
     ) {
      Key = '\0x00';
  }

  if ((rgBase->ItemIndex == 1) && ((Key >= 'A') && (Key <= 'F'))) {
      Key = '\0x00';
  }
};

//---------------------------------------------------------------------------
void __fastcall TFrmEditDWORD::rgBaseClick(TObject *Sender)
{
    if (rgBase->ItemIndex == 0) {
        edtValueData->Text = IntToHex(StrToInt(edtValueData->Text), 1);
        edtValueData->MaxLength = 8;
    } else {
        edtValueData->Text = IntToStr(HexToInt(edtValueData->Text));
        edtValueData->MaxLength = 10;
    };
};
//---------------------------------------------------------------------------

