//---------------------------------------------------------------------------

#ifndef FrmEditDWORDUH
#define FrmEditDWORDUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TFrmEditDWORD : public TForm
{
__published:	// IDE-managed Components
        TLabel *lblValueName;
        TLabel *lblValueData;
        TEdit *edtValueName;
        TEdit *edtValueData;
        TButton *btnOk;
        TButton *btnCancel;
        TRadioGroup *rgBase;
        void __fastcall edtValueDataKeyPress(TObject *Sender, char &Key);
        void __fastcall rgBaseClick(TObject *Sender);
private:	// User declarations
        int __fastcall GetValueData();
        void __fastcall SetValueData(int Value);
        unsigned int __fastcall HexToInt(AnsiString AHexaDecimal);
public:		// User declarations
        __fastcall TFrmEditDWORD(TComponent* Owner);
	__property int ValueData = {read=GetValueData, write=SetValueData};
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmEditDWORD *FrmEditDWORD;
//---------------------------------------------------------------------------
#endif
