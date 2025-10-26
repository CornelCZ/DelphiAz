//---------------------------------------------------------------------------

#ifndef FrmServiceMainUH
#define FrmServiceMainUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "WmiAbstract.hpp"
#include "WmiConnection.hpp"
#include "WmiDataSet.hpp"
#include "WmiMethod.hpp"
#include "FrmSelectHostU.h"
#include <ComCtrls.hpp>
#include <DB.hpp>
#include <DBGrids.hpp>
#include <Grids.hpp>
#include <ImgList.hpp>
#include <ToolWin.hpp>
//---------------------------------------------------------------------------
class TFrmServicemain : public TForm
{
__published:	// IDE-managed Components
        TWmiConnection *WmiConnection1;
        TWmiQuery *WmiQuery1;
        TWmiMethod *WmiMethod1;
        TDBGrid *DBGrid1;
        TToolBar *ToolBar1;
        TDataSource *DataSource1;
        TToolButton *tlbStart;
        TToolButton *tlbPause;
        TToolButton *tlbStop;
        TImageList *ilToolBar;
        TToolButton *tlbResume;
        TToolButton *ToolButton1;
        TToolButton *tlbRefresh;
        TToolButton *tlbConnect;
        TToolButton *ToolButton3;
        void __fastcall DataSource1DataChange(TObject *Sender,
          TField *Field);
        void __fastcall tlbStartClick(TObject *Sender);
        void __fastcall tlbRefreshClick(TObject *Sender);
        void __fastcall tlbStopClick(TObject *Sender);
        void __fastcall tlbPauseClick(TObject *Sender);
        void __fastcall tlbResumeClick(TObject *Sender);
        void __fastcall tlbConnectClick(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
        void __fastcall refresh();
        void __fastcall setButtonState();
        void __fastcall executeMethod(AnsiString methodName);
        void __fastcall setFormCaption();

public:		// User declarations
        __fastcall TFrmServicemain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmServicemain *FrmServicemain;
//---------------------------------------------------------------------------
#endif
