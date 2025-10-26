//---------------------------------------------------------------------------

#ifndef FrmAboutUH
#define FrmAboutUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TFrmAbout : public TForm
{
__published:	// IDE-managed Components
        TButton *btnOk;
        TMemo *memAbout;
private:	// User declarations
public:		// User declarations
        __fastcall TFrmAbout(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmAbout *FrmAbout;
//---------------------------------------------------------------------------
#endif
