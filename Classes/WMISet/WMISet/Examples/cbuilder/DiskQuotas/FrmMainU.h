//---------------------------------------------------------------------------

#ifndef FrmMainUH
#define FrmMainUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "WmiAbstract.hpp"
#include "WmiComponent.hpp"
#include "WmiDiskQuotaControl.hpp"
#include "FrmNewHostU.h"
#include "FrmNewDiskQuotaU.h"
#include "DetectWinOS.hpp"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <ToolWin.hpp>

const char *LOCAL_HOST    = "Local Host";
const char *NETWORK       = "Network";
const char *NO_DATA       = "NO_DATA";
const char *CNST_NO_LIMIT = "No limit";

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
        TPageControl *pcQuotas;
        TTabSheet *tsSettings;
        TPanel *pnlSettings;
        TLabel *Label1;
        TLabel *lblLoggingOptions;
        TBevel *Bevel1;
        TLabel *Label2;
        TLabel *Label3;
        TCheckBox *chbEnableManagement;
        TCheckBox *chbDenyIfExceeded;
        TRadioButton *rbDoNotLimitDiskSpace;
        TCheckBox *chbLogWhenOverLimit;
        TButton *btnApply;
        TButton *btnCancel;
        TPanel *pnlLimits;
        TLabel *lblWarningLimit;
        TEdit *edtLimit;
        TEdit *edtWarning;
        TRadioButton *rbLimitDiskSpace;
        TTabSheet *tsUserQuotas;
        TPanel *pnlQuotas;
        TListView *lvQuotas;
        TToolBar *tlbQuotas;
        TToolButton *tlbNew;
        TToolButton *tlbDelete;
        TToolBar *Toolbar;
        TToolButton *tlbNewHost;
        TPanel *pnlNotSupported;
        TWmiDiskQuotaControl *WmiDiskQuotaControl1;
        TImageList *imlToolbar;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall tvBrowserExpanding(TObject *Sender,
          TTreeNode *Node, bool &AllowExpansion);
        void __fastcall tlbNewHostClick(TObject *Sender);
        void __fastcall tvBrowserChanging(TObject *Sender, TTreeNode *Node,
          bool &AllowChange);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall chbEnableManagementClick(TObject *Sender);
        void __fastcall btnApplyClick(TObject *Sender);
        void __fastcall btnCancelClick(TObject *Sender);
        void __fastcall rbDoNotLimitDiskSpaceClick(TObject *Sender);
        void __fastcall rbLimitDiskSpaceClick(TObject *Sender);
        void __fastcall tlbDeleteClick(TObject *Sender);
        void __fastcall lvQuotasChange(TObject *Sender, TListItem *Item,
          TItemChange Change);
        void __fastcall tlbNewClick(TObject *Sender);
private:	// User declarations
        TCursor FStoredCursor;
public:		// User declarations
        __fastcall TFrmMain(TComponent* Owner);
        void __fastcall InitItems();
        bool __fastcall ProcessNodeExpanding(TTreeNode *ANode);
        bool __fastcall AddVolumeNodes(TTreeNode *ANode);
        bool __fastcall LoadRemoteHosts(TTreeNode *ANode);
        bool __fastcall DoConnect(TTreeNode *ANode);
        void __fastcall SetWaitCursor();
        void __fastcall RestoreCursor();
        void __fastcall CreateNewNetworkNode();
        TTreeNode * __fastcall FindNeworkNode();
        void __fastcall ProcessChangingNode(TTreeNode *ANode);
        void __fastcall ClearControls(TWinControl *ARoot);
        void __fastcall LoadQuotaSettings();
        void __fastcall ApplyQuotaSetting();
        void __fastcall LoadDiskQuotas();
        void __fastcall LoadInformation(TTreeNode *ANode);
        TColor __fastcall GetColor(bool AEnabled);
        void __fastcall EnableControls(TControl *ARoot, bool AEnabled, TControl *Exclude);
        void __fastcall ShowError(TWinControl  *AControl, AnsiString AError);
        void __fastcall ValidateChanges();
        void __fastcall CancelChangesInQuotaSettings();
        void __fastcall DeleteSelectedQuota();
        void __fastcall CreateNewQuota();





};

//---------------------------------------------------------------------------
extern PACKAGE TFrmMain *FrmMain;
//---------------------------------------------------------------------------
#endif
