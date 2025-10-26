//---------------------------------------------------------------------------

#ifndef FrmEditBinaryValueUH
#define FrmEditBinaryValueUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Grids.hpp>
//---------------------------------------------------------------------------
class TFrmEditBinaryValue : public TForm
{
__published:	// IDE-managed Components
        TLabel *lblValueName;
        TLabel *lblValueData;
        TEdit *edtValueName;
        TButton *btnOk;
        TButton *btnCancel;
        TDrawGrid *dgData;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall dgDataDrawCell(TObject *Sender, int ACol, int ARow,
          TRect &Rect, TGridDrawState State);
        void __fastcall dgDataGetEditText(TObject *Sender, int ACol,
          int ARow, AnsiString &Value);
private:	// User declarations
        OleVariant FValueData;
        void __fastcall SetValueData(OleVariant Value);
        char __fastcall ByteToChar(byte AByte);
        AnsiString __fastcall GetCellText(int ACol, int ARow);
public:		// User declarations
        __fastcall TFrmEditBinaryValue(TComponent* Owner);
	__property OleVariant ValueData = {read=FValueData, write=SetValueData};
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmEditBinaryValue *FrmEditBinaryValue;
//---------------------------------------------------------------------------
#endif
