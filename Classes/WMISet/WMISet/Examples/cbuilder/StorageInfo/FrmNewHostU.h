//---------------------------------------------------------------------------

#ifndef FrmNewHostUH
#define FrmNewHostUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TFrmNewHost : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TEdit *edtHostName;
        TGroupBox *grbCredentials;
        TLabel *lblDomain;
        TLabel *lblUserName;
        TLabel *lblPassword;
        TEdit *edtDomain;
        TEdit *edtUserName;
        TEdit *edtPassword;
        TButton *btnConnect;
        TButton *btnCancel;
        void __fastcall OnEditChanged(TObject *Sender);
private:	// User declarations
        __fastcall WideString GetMachineName();
        __fastcall void SetMachineName(WideString Value);
        __fastcall WideString GetUserName();
public:		// User declarations
        __fastcall TFrmNewHost(TComponent* Owner);
__published:
        __property WideString MachineName = {read = GetMachineName, write = SetMachineName};
        __property WideString UserName = {read = GetUserName};
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmNewHost *FrmNewHost;
//---------------------------------------------------------------------------
#endif
