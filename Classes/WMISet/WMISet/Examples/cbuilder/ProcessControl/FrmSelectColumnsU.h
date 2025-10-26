//---------------------------------------------------------------------------

#ifndef FrmSelectColumnsUH
#define FrmSelectColumnsUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TFrmSelectColumns : public TForm
{
__published:	// IDE-managed Components
        TBevel *Bevel1;
        TCheckBox *chbImageName;
        TCheckBox *chbIOOther;
        TCheckBox *chbPID;
        TCheckBox *chbIOOtherBytes;
        TCheckBox *chbCpuUsage;
        TCheckBox *chbPagedPool;
        TCheckBox *chbCpuTime;
        TCheckBox *chbNonPagedPool;
        TCheckBox *chbMemoryUsage;
        TCheckBox *chbBasePriority;
        TCheckBox *chbPeakMemoryUsage;
        TCheckBox *chbHandleCount;
        TCheckBox *chbPageFaults;
        TCheckBox *chbThreadCount;
        TCheckBox *chbIOReads;
        TCheckBox *chbVirtualMemory;
        TCheckBox *chbIOReadBytes;
        TCheckBox *chbSessionId;
        TCheckBox *chbIOWrites;
        TCheckBox *chbStartedAt;
        TCheckBox *chbIOWriteBytes;
        TCheckBox *chbFullPath;
        TButton *btnOk;
        TButton *btnCancel;
        void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TFrmSelectColumns(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmSelectColumns *FrmSelectColumns;
//---------------------------------------------------------------------------
#endif
