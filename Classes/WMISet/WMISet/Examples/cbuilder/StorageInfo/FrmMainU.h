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
#include "WmiStorageInfo.hpp"
#include "FrmNewHostU.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <ToolWin.hpp>

const AnsiString LOCAL_HOST = "Local Host";
const AnsiString NETWORK = "Network";
const AnsiString NO_DATA = "NO_DATA";
const AnsiString DISKS = "Disk Drives";
const AnsiString TAPES = "Tapes";
const AnsiString FLOPPY_DRIVES = "Floppy Drives";
const AnsiString LOGICAL_DISKS = "Logical Disks";
const AnsiString CDROM_DRIVES = "CDROM Drives";
const AnsiString PARTITIONS = "Partitions";

#define   LEVEL_REMOTE_HOST 3

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
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TTreeView *tvBroswer;
        TPanel *pnlData;
        TListView *lvProperties;
        TToolBar *ToolBar1;
        TToolButton *ToolButton1;
        TWmiStorageInfo *WmiStorageInfo1;
        TImageList *ilToolbar;
        void __fastcall FormResize(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall tvBroswerExpanding(TObject *Sender,
          TTreeNode *Node, bool &AllowExpansion);
        void __fastcall tvBroswerChanging(TObject *Sender, TTreeNode *Node,
          bool &AllowChange);
        void __fastcall ToolButton1Click(TObject *Sender);
private:	// User declarations
        TCursor FStoredCursor;
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
        WideString __fastcall TForm1::BoolToStr(bool AValue);
        WideString __fastcall GetAvailabilityDescription(WORD Availability);
        WideString __fastcall DriveTypeToStr(DWORD ADriveType);
        WideString __fastcall MediaTypeToStr(DWORD AMediaType);
        WideString __fastcall FileSystemFlagsToStr(DWORD AFlags);
        void __fastcall SetWaitCursor();
        void __fastcall RestoreCursor();
        void __fastcall InitItems();
        bool __fastcall ProcessNodeExpanding(TTreeNode *ANode);
        bool __fastcall TForm1::LoadPartitions(TTreeNode *ANode);
        bool __fastcall TForm1::LoadDiskDrives(TTreeNode *ANode);
        bool __fastcall TForm1::LoadTapes(TTreeNode *ANode);
        bool __fastcall TForm1::LoadFloppyDrives(TTreeNode *ANode);
        bool __fastcall TForm1::LoadLogicalDisks(TTreeNode *ANode);
        bool __fastcall TForm1::LoadCDROMDrives(TTreeNode *ANode);
        bool __fastcall TForm1::DoConnect(TTreeNode *ANode);
        bool __fastcall TForm1::LoadRemoteHosts(TTreeNode *ANode);
        bool __fastcall TForm1::AddStorageDeviceNodes(TTreeNode *ANode);
        void __fastcall TForm1::ProcessChangingNode(TTreeNode *ANode);
        void __fastcall TForm1::AddPropertyItem(WideString ACaption, WideString AValue);
        void __fastcall TForm1::LoadDeviceProperties(TWmiDevice *ADrive);
        void __fastcall TForm1::LoadCommonDriveProperties(TWmiDriveBase ADrive);
        void __fastcall TForm1::LoadCommonDriveProperties(TWmiDriveBase *ADrive);
        void __fastcall TForm1::LoadDiskProperties(TTreeNode *ANode);
        void __fastcall TForm1::AddAccessPropertyItem(DWORD AAccess);
        void __fastcall TForm1::LoadPartitionProperties(TTreeNode *ANode);
        void __fastcall TForm1::LoadTapeProperties(TTreeNode *ANode);
        void __fastcall TForm1::LoadFloppyProperties(TTreeNode *ANode);
        void __fastcall TForm1::LoadLogicalDiskProperties(TTreeNode *ANode);
        void __fastcall TForm1::LoadCDROMProperties(TTreeNode *ANode);
        void __fastcall TForm1::ClearPropertyViewView();
        void __fastcall TForm1::CreateNewNetworkNode();
        TTreeNode* __fastcall TForm1::FindNeworkNode();




};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
