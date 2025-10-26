//---------------------------------------------------------------------------

#ifndef FrmStaticAddressUH
#define FrmStaticAddressUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TFrmStaticAddress : public TForm
{
__published:	// IDE-managed Components
        TLabel *lblIPAddress;
        TLabel *lblSubnetMask;
        TLabel *Label1;
        TEdit *edtIPAddress;
        TEdit *edtIPSubnetMask;
        TButton *btnSetStaticAddress;
        TButton *btnCancel;
        TEdit *edtDefaultGateway;
        void __fastcall edtIPAddressChange(TObject *Sender);
private:	// User declarations
        void __fastcall SetButtonState();
public:		// User declarations
        __fastcall TFrmStaticAddress(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmStaticAddress *FrmStaticAddress;
//---------------------------------------------------------------------------
#endif
