//---------------------------------------------------------------------------

#ifndef FrmNewTaskUH
#define FrmNewTaskUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TFrmNewTask : public TForm
{
__published:	// IDE-managed Components
        TLabel *lblFileName;
        TEdit *edtFileName;
        TButton *btnStart;
        TButton *btnCancel;
        void __fastcall edtFileNameChange(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TFrmNewTask(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmNewTask *FrmNewTask;
//---------------------------------------------------------------------------
#endif
