//---------------------------------------------------------------------------

#ifndef FrmMainUH
#define FrmMainUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <math.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <ToolWin.hpp>
#include <ImgList.hpp>
#include <DBGrids.hpp>
#include "WmiConnection.hpp"
#include "WmiDataSet.hpp"
#include "FrmNewHostU.h"
#include "FrmAboutU.h"
#include <DB.hpp>
#include <Buttons.hpp>

const char *LOCAL_HOST    = "Local Host";
const char *NETWORK       = "Network";
const char *NO_DATA       = "NO_DATA";
const double SECOND       = 1.0/24.0/60.0/60.0;


//---------------------------------------------------------------------------
class TCredentials : public TObject
{
private:
    WideString FUserName;
    WideString FPassword;
public:
    __fastcall TCredentials(WideString AUserName, WideString APassword);

    __property WideString UserName = {read=FUserName};
    __property WideString Password = {read=FPassword};
};

//---------------------------------------------------------------------------
class TFrmMain : public TForm
{
__published:	// IDE-managed Components
        TSplitter *Splitter1;
        TTreeView *tvBrowser;
        TPanel *pnlRight;
        TMemo *memWQL;
        TSplitter *Splitter2;
        TStatusBar *StatusBar;
        TToolBar *ToolBar1;
        TToolButton *tlbNewHost;
        TToolButton *tlbConnect;
        TToolButton *ToolButton1;
        TToolButton *tlbPrevQuery;
        TToolButton *tlbNextQuery;
        TToolButton *ToolButton2;
        TToolButton *tlbExecute;
        TToolButton *ToolButton3;
        TCheckBox *chbIrregular;
        TToolButton *ToolButton4;
        TToolButton *tlbAbout;
        TImageList *ilToolbar;
        TWmiConnection *WmiConnection1;
        TWmiQuery *WmiQuery1;
        TDataSource *dsWQL;
        TDBGrid *DBGrid1;
        TLabel *Label1;
        TComboBox *cmbNameSpace;
        TLabel *lblClasses;
        TComboBox *cmbClasses;
        TSpeedButton *spbInsert;
        TToolButton *ToolButton5;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall tvBrowserExpanding(TObject *Sender,
          TTreeNode *Node, bool &AllowExpansion);
        void __fastcall tvBrowserChanging(TObject *Sender, TTreeNode *Node,
          bool &AllowChange);
        void __fastcall tlbNewHostClick(TObject *Sender);
        void __fastcall tlbExecuteClick(TObject *Sender);
        void __fastcall tlbConnectClick(TObject *Sender);
        void __fastcall tvBrowserChange(TObject *Sender, TTreeNode *Node);
        void __fastcall tvBrowserCustomDrawItem(TCustomTreeView *Sender,
          TTreeNode *Node, TCustomDrawState State, bool &DefaultDraw);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall tlbPrevQueryClick(TObject *Sender);
        void __fastcall tlbNextQueryClick(TObject *Sender);
        void __fastcall WmiQuery1BeforeScroll(TDataSet *DataSet);
        void __fastcall WmiQuery1AfterScroll(TDataSet *DataSet);
        void __fastcall chbIrregularClick(TObject *Sender);
        void __fastcall tlbAboutClick(TObject *Sender);
        void __fastcall cmbNameSpaceChange(TObject *Sender);
        void __fastcall WmiConnection1AfterConnect(TObject *Sender);
        void __fastcall spbInsertClick(TObject *Sender);
private:	// User declarations

        TCursor FStoredCursor;
        TStringList *FHistory;
        int FHistoryIndex;

        bool __fastcall DoConnect(TTreeNode *ANode);
        void __fastcall SetWaitCursor();
        void __fastcall RestoreCursor();
        void __fastcall InitItems();
        bool __fastcall ProcessNodeExpanding(TTreeNode *ANode);
        bool __fastcall LoadRemoteHosts(TTreeNode *ANode);
        void __fastcall ProcessChangingNode(TTreeNode *Node);
        void __fastcall CreateNewNetworkNode();
        TTreeNode * __fastcall FindNeworkNode();
        void __fastcall SetButtonState();
        void __fastcall OnShowHint(AnsiString &HintStr, bool &CanShow, THintInfo &HintInfo);

public:		// User declarations
        __fastcall TFrmMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmMain *FrmMain;
//---------------------------------------------------------------------------
#endif
