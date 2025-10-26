//---------------------------------------------------------------------------

#ifndef FrmNewJobUH
#define FrmNewJobUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <CheckLst.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
class TFrmNewJob : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TEdit *edtCommand;
        TSpeedButton *spbCommand;
        TDateTimePicker *dtpStartTime;
        TLabel *lblStartTime;
        TCheckBox *chbRunRepeatedly;
        TCheckListBox *clbDaysOfWeek;
        TLabel *lblDaysOfWeek;
        TCheckBox *chbInteract;
        TLabel *lblDaysOfMonth;
        TCheckListBox *clbDaysOfMonth;
        TButton *btnCreate;
        TButton *btnCancel;
        TOpenDialog *odCommand;
        void __fastcall spbCommandClick(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall edtCommandChange(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TFrmNewJob(TComponent* Owner);
        int __fastcall getDaysOfWeek();
        int __fastcall getDaysOfMonth();
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmNewJob *FrmNewJob;
//---------------------------------------------------------------------------
#endif
