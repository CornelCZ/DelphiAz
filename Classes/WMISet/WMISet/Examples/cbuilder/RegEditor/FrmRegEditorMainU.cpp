//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmRegEditorMainU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "WmiAbstract"
#pragma link "WmiComponent"
#pragma link "WmiRegistry"
#pragma resource "*.dfm"
TFrmRegEditorMain *FrmRegEditorMain;
//---------------------------------------------------------------------------
__fastcall TFrmRegEditorMain::TFrmRegEditorMain(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
HKEY __fastcall TFrmRegEditorMain::RootNameToRootKey(AnsiString AName) {
  HKEY result = 0;
  if (CompareStr(AName, "HKEY_CLASSES_ROOT") == 0) {result = HKEY_CLASSES_ROOT;} else
  if (CompareStr(AName, "HKEY_CURRENT_USER") == 0) {result = HKEY_CURRENT_USER;} else
  if (CompareStr(AName, "HKEY_LOCAL_MACHINE") == 0) {result = HKEY_LOCAL_MACHINE;} else
  if (CompareStr(AName, "HKEY_USERS") == 0) {result = HKEY_USERS;} else
  if (CompareStr(AName, "HKEY_PERFORMANCE_DATA") == 0) {result = HKEY_PERFORMANCE_DATA;} else
  if (CompareStr(AName, "HKEY_CURRENT_CONFIG") == 0) {result = HKEY_CURRENT_CONFIG;} else
  if (CompareStr(AName, "HKEY_DYN_DATA") == 0) {result = HKEY_DYN_DATA;} else
    result =  0;
  return result;
};

//---------------------------------------------------------------------------
AnsiString __fastcall TFrmRegEditorMain::RegTypeToString(DWORD AValue) {
  switch (AValue) {
    case REG_NONE:                       return "REG_NONE";
    case REG_SZ:                         return "REG_SZ";
    case REG_EXPAND_SZ:                  return "REG_EXPAND_SZ";
    case REG_BINARY:                     return "REG_BINARY";
    case REG_DWORD:                      return "REG_DWORD";
    case REG_DWORD_BIG_ENDIAN:           return "REG_DWORD_BIG_ENDIAN";
    case REG_LINK:                       return "REG_LINK";
    case REG_MULTI_SZ:                   return "REG_MULTI_SZ";
    case REG_RESOURCE_LIST:              return "REG_RESOURCE_LIST";
    case REG_FULL_RESOURCE_DESCRIPTOR:   return "REG_FULL_RESOURCE_DESCRIPTOR";
    case REG_RESOURCE_REQUIREMENTS_LIST: return "REG_RESOURCE_REQUIREMENTS_LIST";
    default: return IntToStr(AValue);
  };
};

void __fastcall TFrmRegEditorMain::miExitClick(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::MakeCaption() {
  AnsiString tmp = "";
  if (CompareStr(WmiRegistry1->MachineName, "") == 0) {
      tmp = CAPTION_PREFIX;
      tmp += "local computer";
  } else {
      tmp = CAPTION_PREFIX + WmiRegistry1->MachineName;
  }
  Caption = tmp;
};
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::InitTree() {
  tvRegTree->Items->Clear();
  lvValues->Items->Clear();
  TTreeNode *vNode = tvRegTree->Items->AddChild(NULL, WmiRegistry1->RegRootToString((unsigned) HKEY_CLASSES_ROOT));
  tvRegTree->Items->AddChild(vNode, "");

  vNode = tvRegTree->Items->AddChild(NULL, WmiRegistry1->RegRootToString((unsigned) HKEY_CURRENT_USER));
  tvRegTree->Items->AddChild(vNode, "");

  vNode = tvRegTree->Items->AddChild(NULL, WmiRegistry1->RegRootToString((unsigned) HKEY_LOCAL_MACHINE));
  tvRegTree->Items->AddChild(vNode, "");

  vNode = tvRegTree->Items->AddChild(NULL, WmiRegistry1->RegRootToString((unsigned) HKEY_USERS));
  tvRegTree->Items->AddChild(vNode, "");

  vNode = tvRegTree->Items->AddChild(NULL, WmiRegistry1->RegRootToString((unsigned) HKEY_CURRENT_CONFIG));
  tvRegTree->Items->AddChild(vNode, "");

  vNode = tvRegTree->Items->AddChild(NULL, WmiRegistry1->RegRootToString((unsigned) HKEY_DYN_DATA));
  tvRegTree->Items->AddChild(vNode, "");
};

void __fastcall TFrmRegEditorMain::tvRegTreeGetImageIndex(TObject *Sender,
      TTreeNode *Node)
{
    if (!Node->HasChildren) {
        Node->ImageIndex = 1;
    } else {
        if (Node->Expanded) {
            Node->ImageIndex = 0;
        } else {
            Node->ImageIndex = 2;
        }
    };
    Node->StateIndex    = Node->ImageIndex;
    Node->SelectedIndex = Node->ImageIndex;
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::PopulateNodeChildren(TTreeNode *Node) {
  __try {
    Screen->Cursor = crHourGlass;
    TTreeNode *tmpNode = Node->getFirstChild();
    if ((tmpNode != NULL) && (CompareStr(tmpNode->Text, "") == 0)) {
       tvRegTree->Items->Delete(tmpNode);
       AddChildren(Node);
    };
  } __finally {
    Screen->Cursor = crDefault;
  };
};

//---------------------------------------------------------------------------
void __fastcall TFrmRegEditorMain::AddChildren(TTreeNode *ANode) {

  tvRegTree->Items->BeginUpdate();
  __try {
    TTreeNode *tmpNode = ANode;
    if (tmpNode->HasChildren) {
      tmpNode->DeleteChildren();
    }

    WmiRegistry1->RootKey = GetRootKey(ANode);
    WmiRegistry1->CurrentPath = GetNodePath(ANode);
    TStringList *vList = new TStringList();
    __try {
      WmiRegistry1->ListSubKeys(vList);
      vList->Sorted = true;
      for (int i = 0; i < vList->Count; i++) {
        tmpNode = tvRegTree->Items->AddChild(ANode, vList->Strings[i]);
        tvRegTree->Items->AddChild(tmpNode, "");
      };
    } __finally {
      vList->Free();
    };
  } __finally {
    tvRegTree->Items->EndUpdate();
  };
};

//---------------------------------------------------------------------------
AnsiString __fastcall TFrmRegEditorMain::GetNodePath(TTreeNode *ANode) {
  AnsiString Result = "";
  while (ANode->Parent != NULL) {
    Result = ANode->Text + "\\" + Result;
    ANode = ANode->Parent;
  };

  if ((Result.Length() > 0) && (Result[Result.Length()] == '\\')) {
    Result.Delete(Result.Length(), 1);
  }

  return Result;
};

//---------------------------------------------------------------------------
unsigned  __fastcall TFrmRegEditorMain::GetRootKey(TTreeNode *ANode) {
  while (ANode->Parent != NULL) {
    ANode = ANode->Parent;
  }
  return (unsigned) RootNameToRootKey(ANode->Text);
};

void __fastcall TFrmRegEditorMain::tvRegTreeChange(TObject *Sender,
      TTreeNode *Node)
{
  DisplayValues(Node);
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::DisplayValues(TTreeNode *Node) {
  lvValues->Items->BeginUpdate();
  __try {
    lvValues->Items->Clear();
    WmiRegistry1->RootKey = GetRootKey(Node);
    WmiRegistry1->CurrentPath = GetNodePath(Node);
    TStringList *vList = new TStringList();
    __try {
      WmiRegistry1->ListValues(vList);
      vList->Sorted = true;
      for (int i = 0; i < vList->Count; i++) {
        TListItem *vItem = lvValues->Items->Add();
        if (vList->Strings[i].Length() > 0) {
          vItem->Caption = vList->Strings[i];
        } else {
          vItem->Caption = DEFAULT_VALUE;
        }

        WmiRegistry1->ValueName = vList->Strings[i];
        vItem->SubItems->Add(RegTypeToString(WmiRegistry1->ValueType));

       Set <unsigned, REG_NONE, REG_QWORD> RegSet;
       RegSet << REG_SZ << REG_EXPAND_SZ << REG_BINARY << REG_DWORD << REG_MULTI_SZ;

        if (RegSet.Contains(WmiRegistry1->ValueType)) {
          vItem->SubItems->Add(VariantToString(WmiRegistry1->Value));
        } else {
          vItem->SubItems->Add("(Unknown)");
        }
      };
    } __finally {
      vList->Free();
    };
  } __finally {
    lvValues->Items->EndUpdate();
  };
};
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::lvValuesResize(TObject *Sender)
{
  ResizeColumns();
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::ResizeColumns() {
  lvValues->Columns->Items[2]->Width = lvValues->ClientWidth -
                                lvValues->Columns->Items[0]->Width -
                                lvValues->Columns->Items[1]->Width -1;
};

void __fastcall TFrmRegEditorMain::lvValuesColumnClick(TObject *Sender,
      TListColumn *Column)
{
  ResizeColumns();
}

//---------------------------------------------------------------------------
void __fastcall TFrmRegEditorMain::miSelectComputerClick(TObject *Sender)
{

  FrmSelectHost->FWmiComponent = WmiRegistry1;
  if (FrmSelectHost->ShowModal() == mrOk) {

    // save current credentials to be able to restore
    // them if new credentials are invalid.
    WideString vOldUserName = WmiRegistry1->Credentials->UserName;
    WideString vOldPassword = WmiRegistry1->Credentials->Password;
    WideString vOldMachineName = WmiRegistry1->MachineName;
    WmiRegistry1->Active = false;
    AnsiString vUserName = FrmSelectHost->edtUserName->Text;
    if (FrmSelectHost->edtDomain->Text.Length() > 0) {
      vUserName = FrmSelectHost->edtDomain->Text + "\\" + vUserName;
    }

    WmiRegistry1->Credentials->UserName = vUserName;
    WmiRegistry1->Credentials->Password = FrmSelectHost->edtPassword->Text;
    WmiRegistry1->MachineName = FrmSelectHost->cmbComputers->Text;


    TCursor vWasCursor = Screen->Cursor;
    Screen->Cursor = crHourGlass;
    try {
      __try {
        WmiRegistry1->Active = true;
        InitTree();
        MakeCaption();
      } __finally {
        Screen->Cursor = vWasCursor;
      };
    } catch(const Exception &e) {
          Application->MessageBox(e.Message.c_str(), "Error", MB_OK + MB_ICONSTOP);
          // restore previous credentials.
          WmiRegistry1->Credentials->UserName = vOldUserName;
          WmiRegistry1->Credentials->Password = vOldPassword;
          WmiRegistry1->MachineName           = vOldMachineName;
          WmiRegistry1->Active = true;
    };

  };
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::FormShow(TObject *Sender)
{
  WmiRegistry1->Active = true;
  InitTree();
  MakeCaption();

}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::FormActivate(TObject *Sender)
{
  lvValues->Refresh();
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::tvRegTreeMouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
  TPoint vPoint;
  vPoint.x = X;
  vPoint.y = Y;
  vPoint = ClientToScreen(vPoint);

  if ((Button == mbRight) && (tvRegTree->Selected != NULL)) {
      pmKey->Popup(vPoint.x, vPoint.y);
  }
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::CreateValue(int AType) {

  AnsiString vName = GetNewValueName();
  TListItem *vItem = lvValues->Items->Add();
  switch (AType) {
    case REG_SZ:
        WmiRegistry1->WriteString(vName, "");
        vItem->SubItems->Add("REG_SZ");
        vItem->SubItems->Add("");
        break;
    case REG_DWORD:
        WmiRegistry1->WriteInteger(vName, 0);
        vItem->SubItems->Add("REG_DWORD");
        vItem->SubItems->Add("0");
        break;
    case REG_BINARY:
        WmiRegistry1->WriteBinaryData(vName, (void *) AType, 0);
        vItem->SubItems->Add("REG_BINARY");
        vItem->SubItems->Add("{}");
        break;
  };

  vItem->Caption = vName;
};

//---------------------------------------------------------------------------
AnsiString __fastcall TFrmRegEditorMain::GetNewValueName() {
  TStrings *vList = new TStringList();
  AnsiString result = "";
  __try {
    WmiRegistry1->ListValues(vList);
    int i = 1;
    do {
      result = "New Value #" + IntToStr(i);
      i++;
    } while (vList->IndexOf(result) != -1);
  } __finally {
    delete(vList);
  };

  TFrmGetName *vForm = new TFrmGetName("New Key", result);
  __try {
    if (vForm->ShowModal() == mrOk) {
      result = vForm->edtName->Text;
    } else {
      Abort();
    }
  } __finally {
    delete(vForm);
  };

  return result;
};

//---------------------------------------------------------------------------
AnsiString __fastcall TFrmRegEditorMain::GetNewKeyName() {
  TStrings *vList = new TStringList();
  AnsiString result = "";
  __try {
    WmiRegistry1->ListSubKeys(vList);
    int i = 1;
    do {
      result = "New Key #" + IntToStr(i);
      i++;
    } while (vList->IndexOf(result) != -1);
  } __finally {
    delete(vList);
  };


  TFrmGetName *vForm = new TFrmGetName("New Key", result);
  __try {
    if (vForm->ShowModal() == mrOk) {
      result = vForm->edtName->Text;
    } else {
      Abort();
    }
  } __finally {
    delete(vForm);
  };

  return result;
};



void __fastcall TFrmRegEditorMain::miNewStringValueClick(TObject *Sender)
{
  CreateValue(REG_SZ);
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::miNewDWORDValueClick(TObject *Sender)
{
  CreateValue(REG_DWORD);
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::miNewBinaryValueClick(TObject *Sender)
{
  CreateValue(REG_BINARY);
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::CreateKey() {
  AnsiString vName = GetNewKeyName();
  PopulateNodeChildren(tvRegTree->Selected);
  tvRegTree->Selected->Expand(false);
  if (!WmiRegistry1->CreateKey(vName)) {
    Application->MessageBox("Error writing to the registry", "Error Creating Key", MB_ICONHAND+MB_OK);
  } else {
    tvRegTree->Selected = tvRegTree->Items->AddChild(tvRegTree->Selected, vName);
  };
};

void __fastcall TFrmRegEditorMain::pmValuePopup(TObject *Sender)
{
  miNew->Enabled = (lvValues->Selected == NULL);
  miValueModify->Enabled = !miNew->Enabled;
  miValueDelete->Enabled = !miNew->Enabled;
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::tvRegTreeExpanded(TObject *Sender,
      TTreeNode *Node)
{
  PopulateNodeChildren(Node);
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::miNewKeyClick(TObject *Sender)
{
  CreateKey();
}
//---------------------------------------------------------------------------
void __fastcall TFrmRegEditorMain::DeleteKey() {
  if (WmiRegistry1->DeleteKey(GetNodePath(tvRegTree->Selected))) {
      tvRegTree->Items->Delete(tvRegTree->Selected);
  } else {
      Application->MessageBox("Error while deleting key", "Error", MB_ICONHAND+MB_OK);
  };
};

void __fastcall TFrmRegEditorMain::miDeleteKeyClick(TObject *Sender)
{
  DeleteKey();
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::pmKeyPopup(TObject *Sender)
{
  miDeleteKey->Enabled = (tvRegTree->Selected != NULL) &&
                          (GetNodePath(tvRegTree->Selected).Length() > 0);
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::EditStringValue() {
  AnsiString vName = lvValues->Selected->Caption;
  if (CompareStr(vName, DEFAULT_VALUE) == 0) {
    vName = "";
  };

  TFrmEditString *vForm = new TFrmEditString(NULL);
  __try {
    vForm->edtValueName->Text = lvValues->Selected->Caption;
    vForm->edtValueData->Text = WmiRegistry1->ReadString(vName);

    if (vForm->ShowModal() == mrOk) {
      WmiRegistry1->WriteString(vName, vForm->edtValueData->Text);
      DisplayValues(tvRegTree->Selected);
    };
  } __finally {
    delete(vForm);
  };
};

//---------------------------------------------------------------------------
void __fastcall TFrmRegEditorMain::EditDWORDValue() {
  AnsiString vName = lvValues->Selected->Caption;
  if (CompareStr(vName, DEFAULT_VALUE) == 0) {
    vName = "";
  };

  TFrmEditDWORD *vForm = new TFrmEditDWORD(NULL);
  __try {
    vForm->edtValueName->Text = lvValues->Selected->Caption;
    vForm->ValueData = WmiRegistry1->ReadInteger(vName);

    if (vForm->ShowModal() == mrOk) {
      WmiRegistry1->WriteInteger(vName, vForm->ValueData);
      DisplayValues(tvRegTree->Selected);
    };
  } __finally {
    delete(vForm);
  };
};

//---------------------------------------------------------------------------
void __fastcall TFrmRegEditorMain::EditBinaryValue() {
  AnsiString vName = lvValues->Selected->Caption;
  if (CompareStr(vName, DEFAULT_VALUE) == 0) {
    vName = "";
  };

  TFrmEditBinaryValue *vForm = new TFrmEditBinaryValue(NULL);
  __try {
    vForm->edtValueName->Text = lvValues->Selected->Caption;
    vForm->ValueData = WmiRegistry1->ReadValue(vName);

    if (vForm->ShowModal() == mrOk) {
//      WmiRegistry1.WriteBinary(vName, ValueData);
      DisplayValues(tvRegTree->Selected);
    };
  } __finally {
    delete(vForm);
  };
};

//---------------------------------------------------------------------------
void __fastcall TFrmRegEditorMain::ModifyValue() {
  AnsiString vName = lvValues->Selected->Caption;
  if (CompareStr(vName, DEFAULT_VALUE) == 0) {
    vName = "";
  };

  switch (WmiRegistry1->GetValueType(vName)) {
    case REG_SZ:
      EditStringValue();
      break;
    case REG_DWORD:
      EditDWORDValue();
      break;
    case REG_BINARY:
      EditBinaryValue();
      break;
    default:
      Application->MessageBox("Editing is not implemented for this data type",
                              "Error", MB_OK + MB_ICONHAND);
  };
};

//---------------------------------------------------------------------------
void __fastcall TFrmRegEditorMain::miValueModifyClick(TObject *Sender)
{
  ModifyValue();
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::DeleteValue() {
  AnsiString vName = lvValues->Selected->Caption;
  if (CompareStr(vName, DEFAULT_VALUE) == 0) {
    vName = "";
  };

  WmiRegistry1->DeleteValue(vName);
  DisplayValues(tvRegTree->Selected);
};

void __fastcall TFrmRegEditorMain::miValueDeleteClick(TObject *Sender)
{
  DeleteValue();
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::lvValuesDblClick(TObject *Sender)
{
  if (lvValues->Selected != NULL) ModifyValue();
}
//---------------------------------------------------------------------------

void __fastcall TFrmRegEditorMain::About1Click(TObject *Sender)
{
  TFrmAbout *vForm = new TFrmAbout(NULL);
  __try {
    vForm->ShowModal();
  } __finally {
    vForm->Free();
  };
}
//---------------------------------------------------------------------------

