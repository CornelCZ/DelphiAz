//---------------------------------------------------------------------------

#ifndef FrmGetNameUH
#define FrmGetNameUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TFrmGetName : public TForm
{
__published:	// IDE-managed Components
        TLabel *lblPrompt;
        TEdit *edtName;
        TButton *btnOk;
        TButton *Cancel;
private:	// User declarations
public:		// User declarations
        __fastcall TFrmGetName(AnsiString APrompt, AnsiString AValue);
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmGetName *FrmGetName;
//---------------------------------------------------------------------------
#endif
