//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmEditBinaryValueU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFrmEditBinaryValue *FrmEditBinaryValue;
//---------------------------------------------------------------------------
__fastcall TFrmEditBinaryValue::TFrmEditBinaryValue(TComponent* Owner)
        : TForm(Owner)
{
}

char __fastcall TFrmEditBinaryValue::ByteToChar(byte AByte) {

 char vCh = AByte; 
 if (
       ((vCh >= '0') && (vCh <= '9')) ||
       ((vCh >= 'A') && (vCh <= 'F')) ||
       ((vCh >= 'a') && (vCh <= 'f'))
     ) {
      return vCh;
  } else {
      return '.';
  }
};

//---------------------------------------------------------------------------
void __fastcall TFrmEditBinaryValue::FormCreate(TObject *Sender)
{
   for (int i = 0; i < dgData->ColCount; i++) {
     dgData->ColWidths[i] = 20;
   }
   dgData->ColWidths[0] = 60;
   dgData->ColWidths[dgData->ColCount - 1] = 80;
}
//---------------------------------------------------------------------------

AnsiString __fastcall TFrmEditBinaryValue::GetCellText(int ACol, int ARow) {

  AnsiString Result = "";

  if (ACol == 0) {
      Result = IntToHex(ARow * 8, 4);
  } else 
  if (ACol == dgData->ColCount - 1) {
      AnsiString vStr = "";
      for (int i = 0; i < 7; i++) {
          int vIndex = ARow * 8 + i;
          if (vIndex < FValueData.ArrayHighBound(1)) {
              vStr = vStr + ByteToChar(FValueData.GetElement(vIndex));
          }
      };
      Result = vStr;
  } else {
    int vIndex = ARow * 8 + ACol;
    if (vIndex < FValueData.ArrayHighBound(1)) {
        Result = IntToHex((int) FValueData.GetElement(vIndex), 2);
    }
  };

  return Result;
};

//---------------------------------------------------------------------------
void __fastcall TFrmEditBinaryValue::dgDataDrawCell(TObject *Sender,
      int ACol, int ARow, TRect &Rect, TGridDrawState State)
{
  dgData->Canvas->TextRect(Rect, Rect.Left + 1, Rect.Top + 2, GetCellText(ACol, ARow));
}
//---------------------------------------------------------------------------
void __fastcall TFrmEditBinaryValue::dgDataGetEditText(TObject *Sender,
      int ACol, int ARow, AnsiString &Value)
{
  if ((ACol == 0) || (ACol == dgData->ColCount - 1)) {
     dgData->EditorMode = false;
  }   
  Value = GetCellText(ACol, ARow);
}
//---------------------------------------------------------------------------
void __fastcall TFrmEditBinaryValue::SetValueData(OleVariant Value) {
  FValueData = Value;
  int vHighBound = FValueData.ArrayHighBound(1);
  div_t vDiv = div(vHighBound, 8);
  dgData->RowCount = vDiv.quot + 1;
}

//---------------------------------------------------------------------------
