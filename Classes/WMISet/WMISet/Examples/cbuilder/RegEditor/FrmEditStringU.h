//---------------------------------------------------------------------------

#ifndef FrmEditStringUH
#define FrmEditStringUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TFrmEditString : public TForm
{
__published:	// IDE-managed Components
        TLabel *lblValueName;
        TLabel *lblValueData;
        TEdit *edtValueName;
        TEdit *edtValueData;
        TButton *btnOk;
        TButton *btnCancel;
private:	// User declarations
public:		// User declarations
        __fastcall TFrmEditString(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmEditString *FrmEditString;
//---------------------------------------------------------------------------
#endif
