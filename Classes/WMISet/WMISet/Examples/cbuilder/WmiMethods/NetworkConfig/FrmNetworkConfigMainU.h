//---------------------------------------------------------------------------

#ifndef FrmNetworkConfigMainUH
#define FrmNetworkConfigMainUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "WmiConnection.hpp"
#include "WmiDataSet.hpp"
#include "WmiMethod.hpp"
#include "wbem_script_support.h"
#include "FrmStaticAddressU.h"
#include "FrmSelectHostU.h"
#include <ComCtrls.hpp>
#include <DB.hpp>
#include <DBCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Mask.hpp>
#include <ToolWin.hpp>
#include <ComCtrls.hpp>
#include <DB.hpp>
#include <DBCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Mask.hpp>
#include <ToolWin.hpp>
//---------------------------------------------------------------------------
class TFrmNetworkConfigMain : public TForm
{
__published:	// IDE-managed Components
        TLabel *lblNetworkAdapter;
        TBevel *Bevel1;
        TLabel *lblMACAddress;
        TLabel *Label2;
        TLabel *lblIPSubnet;
        TLabel *lblDeafultIPGateway;
        TLabel *Label3;
        TToolBar *ToolBar1;
        TToolButton *tlbConnect;
        TToolButton *ToolButton3;
        TToolButton *tlbRefresh;
        TComboBox *cmbAdapters;
        TDBEdit *dbeMACAddress;
        TDBEdit *dbeIPAddress;
        TDBEdit *dbeIPSubnet;
        TDBEdit *dbeDeafultIPGateway;
        TButton *btnSetStaticIP;
        TButton *btnEnableDHCP;
        TDBEdit *dbeDNSPrimaryDomain;
        TWmiConnection *WmiConnection1;
        TWmiQuery *wqConfigurations;
        TDataSource *dsConfigurations;
        TWmiMethod *WmiMethod1;
        TImageList *ImageList1;
        TWmiQuery *wqAdapters;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall cmbAdaptersChange(TObject *Sender);
        void __fastcall btnSetStaticIPClick(TObject *Sender);
        void __fastcall btnEnableDHCPClick(TObject *Sender);
        void __fastcall tlbRefreshClick(TObject *Sender);
        void __fastcall tlbConnectClick(TObject *Sender);
private:	// User declarations
        void __fastcall RefreshInfo();
        AnsiString __fastcall RemoveBrackets(AnsiString text);
        void __fastcall SetFormCaption();
        void __fastcall disableControls();

public:		// User declarations
        __fastcall TFrmNetworkConfigMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFrmNetworkConfigMain *FrmNetworkConfigMain;
//---------------------------------------------------------------------------
#endif
