//---------------------------------------------------------------------------

#ifndef FrmNewDiskQuotaUH
#define FrmNewDiskQuotaUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TFrmNewDiskQuota : public TForm
{
__published:	// IDE-managed Components
        TLabel *lblUserName;
        TLabel *lblWarningLimit;
        TLabel *lblLimit;
        TComboBox *cmbWarningLimit;
        TComboBox *cmbLimit;
        TButton *btnOk;
        TButton *btnCancel;
        TComboBox *cmbUser;
        void __fastcall OnControlChange(TObject *Sender);
        void __fastcall cmbLimitKeyPress(TObject *Sender, char &Key);
private:	// User declarations
public:		// User declarations
        __fastcall TFrmNewDiskQuota(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmNewDiskQuota *FrmNewDiskQuota;
//---------------------------------------------------------------------------
#endif
