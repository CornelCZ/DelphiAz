//---------------------------------------------------------------------------

#ifndef FrmRegEditorMainUH
#define FrmRegEditorMainUH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "WmiAbstract.hpp"
#include "WmiComponent.hpp"
#include "WmiRegistry.hpp"
#include "FrmSelectHostU.h"
#include "FrmEditStringU.h"
#include "FrmEditDWORDU.h"
#include "FrmEditBinaryValueU.h"
#include "FrmAboutU.h"
#include "FrmGetNameU.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include <windef.h>

//---------------------------------------------------------------------------

const char *CAPTION_PREFIX = "Registry on ";
const char *DEFAULT_VALUE = "(Default)";

//---------------------------------------------------------------------------
class TFrmRegEditorMain : public TForm
{
__published:	// IDE-managed Components
        TSplitter *Splitter1;
        TTreeView *tvRegTree;
        TListView *lvValues;
        TWmiRegistry *WmiRegistry1;
        TMainMenu *MainMenu;
        TMenuItem *File1;
        TMenuItem *miSelectComputer;
        TMenuItem *N1;
        TMenuItem *miExit;
        TMenuItem *About1;
        TImageList *imlFolders;
        TPopupMenu *pmValue;
        TMenuItem *miNew;
        TMenuItem *miNewKey;
        TMenuItem *N4;
        TMenuItem *miNewStringValue;
        TMenuItem *miNewDWORDValue;
        TMenuItem *miNewBinaryValue;
        TMenuItem *N5;
        TMenuItem *miValueModify;
        TMenuItem *N3;
        TMenuItem *miValueDelete;
        TPopupMenu *pmKey;
        TMenuItem *miNew2;
        TMenuItem *miNewKey2;
        TMenuItem *MenuItem3;
        TMenuItem *miNewStringValue2;
        TMenuItem *miNewDWORDValue2;
        TMenuItem *miNewBinaryValue2;
        TMenuItem *MenuItem7;
        TMenuItem *miDeleteKey;
        TMenuItem *MenuItem10;
        void __fastcall miExitClick(TObject *Sender);
        void __fastcall tvRegTreeGetImageIndex(TObject *Sender,
          TTreeNode *Node);
        void __fastcall tvRegTreeChange(TObject *Sender, TTreeNode *Node);
        void __fastcall lvValuesResize(TObject *Sender);
        void __fastcall lvValuesColumnClick(TObject *Sender,
          TListColumn *Column);
        void __fastcall miSelectComputerClick(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall tvRegTreeMouseDown(TObject *Sender,
          TMouseButton Button, TShiftState Shift, int X, int Y);
        void __fastcall miNewStringValueClick(TObject *Sender);
        void __fastcall miNewDWORDValueClick(TObject *Sender);
        void __fastcall miNewBinaryValueClick(TObject *Sender);
        void __fastcall pmValuePopup(TObject *Sender);
        void __fastcall tvRegTreeExpanded(TObject *Sender,
          TTreeNode *Node);
        void __fastcall miNewKeyClick(TObject *Sender);
        void __fastcall miDeleteKeyClick(TObject *Sender);
        void __fastcall pmKeyPopup(TObject *Sender);
        void __fastcall miValueModifyClick(TObject *Sender);
        void __fastcall miValueDeleteClick(TObject *Sender);
        void __fastcall lvValuesDblClick(TObject *Sender);
        void __fastcall About1Click(TObject *Sender);
private:	// User declarations
        __fastcall TFrmRegEditorMain(TComponent* Owner);
        HKEY __fastcall RootNameToRootKey(AnsiString AName);
        AnsiString __fastcall TFrmRegEditorMain::RegTypeToString(DWORD AValue);
        void __fastcall MakeCaption();
        void __fastcall InitTree();
        void __fastcall PopulateNodeChildren(TTreeNode *Node);
        void __fastcall AddChildren(TTreeNode *ANode);
        AnsiString __fastcall GetNodePath(TTreeNode *ANode);
        unsigned  __fastcall GetRootKey(TTreeNode *ANode);
        void __fastcall DisplayValues(TTreeNode *Node);
        void __fastcall ResizeColumns();
        void __fastcall CreateValue(int AType);
        AnsiString __fastcall GetNewValueName();
        AnsiString __fastcall GetNewKeyName();
        void __fastcall CreateKey();
        void __fastcall DeleteKey();
        void __fastcall EditStringValue();
        void __fastcall EditDWORDValue();
        void __fastcall EditBinaryValue();
        void __fastcall ModifyValue();
        void __fastcall DeleteValue();

public:		// User declarations


};
//---------------------------------------------------------------------------
extern PACKAGE TFrmRegEditorMain *FrmRegEditorMain;
//---------------------------------------------------------------------------
#endif
