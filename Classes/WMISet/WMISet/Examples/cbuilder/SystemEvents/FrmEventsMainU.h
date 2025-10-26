//---------------------------------------------------------------------------

#ifndef FrmEventsMainUH
#define FrmEventsMainUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "WmiAbstract.hpp"
#include "WmiComponent.hpp"
#include "WmiSystemEvents.hpp"
#include "DetectWinOs.hpp"
#include "FrmNewHostU.h"
#include "FrmAboutU.h"
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <ToolWin.hpp>
//---------------------------------------------------------------------------

const char *LOCAL_HOST = "Local Host";
const char *NETWORK = "Network";
const char *NO_DATA = "NO_DATA";
const char *CNST_CAPTION = "Watch for Events on ";

enum TWmiEventType {
    wetEventLogApplication = 0,
    wetEventLogSystem,
    wetEventLogSecurity,
    wetUserAccount,
    wetGroupAccount,
    wetGroupMembership,
    wetNetworkConnect,
    wetNetworkDisconnect,
    wetPrinter,
    wetPrintJob,
    wetSessionLogon,
    wetSessionLogoff,
    wetCDROMInserted,
    wetCDROMEjected,
    wetService,
    wetDocking};


class TFrmEventsMain : public TForm
{
__published:	// IDE-managed Components
        TSplitter *Splitter1;
        TToolBar *ToolBar1;
        TToolButton *tlbNewHost;
        TToolButton *ToolButton1;
        TToolButton *tlbAbout;
        TTreeView *tvBrowser;
        TPageControl *pcMain;
        TTabSheet *tsWatch;
        TPanel *Panel1;
        TCheckBox *chbSoundOnEvent;
        TButton *btnClear;
        TListView *lvWatch;
        TTabSheet *tsSetup;
        TGroupBox *GroupBox1;
        TCheckBox *chbApplication;
        TCheckBox *chbSystem;
        TCheckBox *chbSecurity;
        TGroupBox *GroupBox2;
        TCheckBox *chbUser;
        TCheckBox *chbGroup;
        TCheckBox *chbMembership;
        TGroupBox *GroupBox3;
        TCheckBox *chbConnect;
        TCheckBox *chbDisconnect;
        TGroupBox *GroupBox4;
        TCheckBox *chbLogon;
        TCheckBox *chbLogoff;
        TGroupBox *GroupBox5;
        TCheckBox *chbPrinter;
        TCheckBox *chbJob;
        TGroupBox *GroupBox6;
        TCheckBox *chbCDROMInserted;
        TCheckBox *chbCDROMEjected;
        TGroupBox *GroupBox7;
        TCheckBox *chbService;
        TCheckBox *chbDocking;
        TMemo *memSetup;
        TTabSheet *tsAdvanced;
        TLabel *Label1;
        TPanel *pnlTop;
        TLabel *lblNameSpace;
        TComboBox *cmnNameSpaces;
        TPanel *pnlBottom;
        TPanel *pnlButtons;
        TSpeedButton *sbRegisterQuery;
        TMemo *memQuery;
        TImageList *ilToolbar;
        TWmiSystemEvents *WmiSystemEvents1;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall tvBrowserExpanding(TObject *Sender,
          TTreeNode *Node, bool &AllowExpansion);
        void __fastcall tvBrowserChanging(TObject *Sender, TTreeNode *Node,
          bool &AllowChange);
        void __fastcall tlbNewHostClick(TObject *Sender);
        void __fastcall tvBrowserChange(TObject *Sender, TTreeNode *Node);
        void __fastcall tlbAboutClick(TObject *Sender);
        void __fastcall chbConnectClick(TObject *Sender);
        void __fastcall chbDisconnectClick(TObject *Sender);
        void __fastcall chbApplicationClick(TObject *Sender);
        void __fastcall FormResize(TObject *Sender);
        void __fastcall chbSystemClick(TObject *Sender);
        void __fastcall chbSecurityClick(TObject *Sender);
        void __fastcall btnClearClick(TObject *Sender);
        void __fastcall chbUserClick(TObject *Sender);
        void __fastcall chbGroupClick(TObject *Sender);
        void __fastcall chbMembershipClick(TObject *Sender);
        void __fastcall chbPrinterClick(TObject *Sender);
        void __fastcall chbJobClick(TObject *Sender);
        void __fastcall chbLogonClick(TObject *Sender);
        void __fastcall chbLogoffClick(TObject *Sender);
        void __fastcall chbServiceClick(TObject *Sender);
        void __fastcall chbDockingClick(TObject *Sender);
        void __fastcall chbCDROMInsertedClick(TObject *Sender);
        void __fastcall chbCDROMEjectedClick(TObject *Sender);
        void __fastcall sbRegisterQueryClick(TObject *Sender);
private:	// User declarations
        TCursor FStoredCursor;
        void __fastcall InitItems();
        bool __fastcall ProcessNodeExpanding(TTreeNode *ANode);
        bool __fastcall LoadRemoteHosts(TTreeNode *ANode);
        void __fastcall ProcessChangingNode(TTreeNode *Node);
        void __fastcall SetWaitCursor();
        void __fastcall RestoreCursor();
        bool __fastcall DoConnect(TTreeNode *ANode);
        AnsiString __fastcall GetMachineName();
        void __fastcall SetFormCaption();
        void __fastcall SetButtonState();
        TTreeNode * __fastcall FindNeworkNode();
        void __fastcall CreateNewNetworkNode();
        void __fastcall AddEventRecord(AnsiString AText);
        void __fastcall SoundOnEvent();
        void __fastcall RegisterEvent(TWmiEventType AEventType, bool IfRegister);

        void __fastcall OnNetworkConnected(TObject *ASender);
        void __fastcall OnNetworkDisconnected(TObject *ASender);
        void __fastcall OnEventLogApplication(TObject *ASender, const OleVariant &Instance, WideString EventLog, WideString AMessage);
        void __fastcall OnEventLogSystem(TObject *ASender, const OleVariant &Instance, WideString EventLog, WideString AMessage);
        void __fastcall OnEventLogSecurity(TObject *ASender, const OleVariant &Instance, WideString EventLog, WideString AMessage);
        void __fastcall OnUserAccount(TObject *ASender, const OleVariant &Instance, WideString Name, WideString Domain, TWmiEventAction Action);
        void __fastcall OnGroupAccount(TObject *ASender, const OleVariant &Instance, WideString Name, WideString Domain, TWmiEventAction Action);
        void __fastcall OnGroupMembership(TObject *ASender,
                                const OleVariant &Instance, WideString AGroupName, WideString AGroupDomain,
                                WideString AUserName, WideString AUserDomain, TWmiEventAction Action);
        void __fastcall OnPrinter(TObject *ASender, const OleVariant &Instance, WideString Name, TWmiEventAction Action);
        void __fastcall OnPrintJob(TObject *ASender, const OleVariant &Instance, WideString Document, int JobID,
                                WideString JobStatus, TWmiEventAction Action); 
        void __fastcall OnUserLogon(TObject *ASender, WideString LogonId, WideString Name, WideString Domain);
        void __fastcall OnUserLogoff(TObject *ASender, WideString LogonId, WideString Name, WideString Domain);
        void __fastcall OnService(TObject *ASender, const OleVariant &Instance, WideString AServiceName, WideString AState, TWmiEventAction Action);
        void __fastcall OnDocking(TObject *ASender);
        void __fastcall OnCDROMEjected(TObject *ASender, const OleVariant &Instance, WideString ADrive);
        void __fastcall OnCDROMInserted(TObject *ASender, const OleVariant &Instance, WideString ADrive);
        void __fastcall TFrmEventsMain::OnCustomEvent(TObject *Sender, TEventInfoHolder *EventInfo, const OleVariant &Event);

public:		// User declarations
        __fastcall TFrmEventsMain(TComponent* Owner);
};

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
extern PACKAGE TFrmEventsMain *FrmEventsMain;
//---------------------------------------------------------------------------
#endif
