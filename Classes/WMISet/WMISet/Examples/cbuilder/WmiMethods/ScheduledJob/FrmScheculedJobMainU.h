//---------------------------------------------------------------------------

#ifndef FrmScheculedJobMainUH
#define FrmScheculedJobMainUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "WmiAbstract.hpp"
#include "WmiConnection.hpp"
#include "WmiDataSet.hpp"
#include "WmiMethod.hpp"
#include "FrmNewJobU.h"
#include "FrmSelectHostU.h"
#include <ComCtrls.hpp>
#include <DB.hpp>
#include <DBGrids.hpp>
#include <Grids.hpp>
#include <ToolWin.hpp>
#include <ImgList.hpp>
//---------------------------------------------------------------------------
class TFrmScheduledJobMain : public TForm
{
__published:	// IDE-managed Components
        TToolBar *ToolBar1;
        TToolButton *tlbCreate;
        TDBGrid *DBGrid1;
        TDataSource *DataSource1;
        TWmiConnection *WmiConnection1;
        TWmiQuery *WmiQuery1;
        TWmiMethod *WmiMethodCreate;
        TWmiMethod *WmiMethodDelete;
        TImageList *ImageList1;
        TToolButton *tlbDelete;
        TToolButton *tlbSeparator;
        TToolButton *tlbRefresh;
        TToolButton *tlbConnect;
        TToolButton *ToolButton2;
        void __fastcall DataSource1DataChange(TObject *Sender,
          TField *Field);
        void __fastcall tlbDeleteClick(TObject *Sender);
        void __fastcall tlbRefreshClick(TObject *Sender);
        void __fastcall tlbCreateClick(TObject *Sender);
        void __fastcall DBGrid1DrawColumnCell(TObject *Sender,
          const TRect &Rect, int DataCol, TColumn *Column,
          TGridDrawState State);
        void __fastcall tlbConnectClick(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
        AnsiString __fastcall getErrorDescription(int errorCode);
        void __fastcall refresh();
        void __fastcall setButtonState();
        AnsiString __fastcall DaysOfWeekToStr(int days);
        AnsiString __fastcall DaysOfMonthToStr(int days);
        void __fastcall setFormCaption();

public:		// User declarations
        __fastcall TFrmScheduledJobMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmScheduledJobMain *FrmScheduledJobMain;
//---------------------------------------------------------------------------
#endif
