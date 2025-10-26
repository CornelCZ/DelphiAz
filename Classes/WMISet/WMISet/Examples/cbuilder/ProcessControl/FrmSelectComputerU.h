//---------------------------------------------------------------------------

#ifndef FrmSelectComputerUH
#define FrmSelectComputerUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TFrmSelectComputer : public TForm
{
__published:	// IDE-managed Components
        TLabel *lblSelectComputer;
        TComboBox *cmbComputers;
        TPanel *pnlCredentials;
        TLabel *lblDomain;
        TLabel *lblUserName;
        TLabel *Label1;
        TEdit *edtDomain;
        TEdit *edtUserName;
        TEdit *edtPassword;
        TCheckBox *chbConnectAsCurrent;
        TButton *btnOk;
        TButton *btnCancel;
        void __fastcall chbConnectAsCurrentClick(TObject *Sender);
        void __fastcall cmbComputersDropDown(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
        bool FListLoaded;
public:		// User declarations
        __fastcall TFrmSelectComputer(TComponent* Owner);
        void __fastcall DisableEdit(TEdit *AEdit);
        void __fastcall EnableEdit(TEdit *AEdit);

};
//---------------------------------------------------------------------------
extern PACKAGE TFrmSelectComputer *FrmSelectComputer;
//---------------------------------------------------------------------------
#endif
