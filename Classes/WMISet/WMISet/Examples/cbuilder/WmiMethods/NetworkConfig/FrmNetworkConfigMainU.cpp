//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmNetworkConfigMainU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "WmiConnection"
#pragma link "WmiDataSet"
#pragma link "WmiMethod"
#pragma resource "*.dfm"
TFrmNetworkConfigMain *FrmNetworkConfigMain;
//---------------------------------------------------------------------------
__fastcall TFrmNetworkConfigMain::TFrmNetworkConfigMain(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFrmNetworkConfigMain::FormCreate(TObject *Sender)
{
  ClientWidth = cmbAdapters->Left + cmbAdapters->Width + 5;
  ClientHeight = dbeDNSPrimaryDomain->Top + dbeDNSPrimaryDomain->Height + 5;
  WmiConnection1->Connected = true;
  RefreshInfo();
  SetFormCaption();
}

//---------------------------------------------------------------------------
void __fastcall TFrmNetworkConfigMain::RefreshInfo() {

  wqConfigurations->Active = false;
  wqConfigurations->Active = true;
  wqAdapters->Active = false;
  wqAdapters->Active = true;

  int vWasIndex = cmbAdapters->ItemIndex;
  cmbAdapters->Items->Clear();
  wqConfigurations->DisableControls();
  __try {
    wqAdapters->First();
    // find all adapters of type 'Ethernet 802.3' that
    // have the flag IPEnabled set
    while (!wqAdapters->Eof) {
      TLocateOptions options; 
      if (wqConfigurations->Locate("Index", wqAdapters->FieldByName("Index")->AsString, options) &&
         wqConfigurations->FieldByName("IPEnabled")->AsBoolean) {
           cmbAdapters->Items->Add(
                 wqAdapters->FieldByName("Index")->AsString + ": " +
                 wqAdapters->FieldByName("Description")->AsString);
      }
      wqAdapters->Next();
    };
  } __finally {
    wqConfigurations->EnableControls();
  };

  if ((vWasIndex != -1) && (vWasIndex < cmbAdapters->Items->Count)) {
    cmbAdapters->ItemIndex = vWasIndex;
  } else
  if (cmbAdapters->Items->Count > 0) {
    cmbAdapters->ItemIndex = 0;
  } else {
    disableControls();
  }

  cmbAdaptersChange(NULL);
};

//---------------------------------------------------------------------------
void __fastcall TFrmNetworkConfigMain::disableControls() {
  wqConfigurations->Active  = false;
  wqAdapters->Active        = false;
  WmiConnection1->Connected = false;
  cmbAdapters->Enabled      =  false;
  btnSetStaticIP->Enabled   = false;
  btnEnableDHCP->Enabled    = false;
};

//---------------------------------------------------------------------------
void __fastcall TFrmNetworkConfigMain::cmbAdaptersChange(TObject *Sender)
{
  AnsiString s = cmbAdapters->Text;
  s = s.SubString(1, s.Pos(":") - 1);
  int vIndex = StrToInt(s);

  TLocateOptions options; 
  wqConfigurations->Locate("Index",  vIndex,  options);
  btnEnableDHCP->Enabled = !wqConfigurations->FieldByName("DHCPEnabled")->AsBoolean;
}
//---------------------------------------------------------------------------

AnsiString __fastcall TFrmNetworkConfigMain::RemoveBrackets(AnsiString text) {
  if ((text.Length() > 0) && (text[1] == '{')) text = text.SubString(2, text.Length()-1);
  if ((text.Length() > 0) && (text[text.Length()] == '}')) text = text.SubString(1, text.Length()-1);
  return text;
};

void __fastcall TFrmNetworkConfigMain::btnSetStaticIPClick(TObject *Sender)
{

  TFrmStaticAddress* form = new TFrmStaticAddress(NULL);
  __try {
    form->edtIPAddress->Text = RemoveBrackets(dbeIPAddress->Text);
    form->edtIPSubnetMask->Text = RemoveBrackets(dbeIPSubnet->Text);
    form->edtDefaultGateway->Text = RemoveBrackets(dbeDeafultIPGateway->Text);
    while (form->ShowModal() == mrOk) {
       Screen->Cursor = crHourGlass;
       __try {
         __try {
           // set static IP address
           WmiMethod1->WmiMethodName = "EnableStatic";
           WmiMethod1->InParams->ParamByName("IPAddress")->AsString = form->edtIPAddress->Text;
           WmiMethod1->InParams->ParamByName("SubnetMask")->AsString = form->edtIPSubnetMask->Text;
           if (WmiMethod1->Execute() != 0) {
             AnsiString s = WmiMethod1->LastWmiErrorDescription;
             Application->MessageBox(s.c_str(), "Cannot set static IP", MB_ICONHAND + MB_OK);
           };

           // set default gateway
           WmiMethod1->WmiMethodName = "SetGateways";
           WmiMethod1->InParams->ParamByName("DefaultIPGateway")->AsString = form->edtDefaultGateway->Text;
           if (WmiMethod1->Execute() == 0) {
             RefreshInfo();
             ShowMessage("You have to reboot the computer for the changes to take effect");
             break;
           } else {
             AnsiString s = WmiMethod1->LastWmiErrorDescription;
             Application->MessageBox(s.c_str(), "Cannot set default gateway", MB_ICONHAND + MB_OK);
           };

         } catch (const Exception &E) {
             AnsiString s = E.Message;
             Application->MessageBox(s.c_str(), "Error", MB_ICONHAND + MB_OK);
         };
       } __finally {
         Screen->Cursor = crDefault;
       };
    };
  } __finally {
    delete form;
  };
}

//---------------------------------------------------------------------------
void __fastcall TFrmNetworkConfigMain::btnEnableDHCPClick(TObject *Sender)
{
  Screen->Cursor = crHourGlass;
  __try {
    WmiMethod1->WmiMethodName = "EnableDHCP";
    if (WmiMethod1->Execute() != 0) {
      AnsiString s = WmiMethod1->LastWmiErrorDescription;
      Application->MessageBox(s.c_str(), "Error enabling DHCP", MB_ICONHAND + MB_OK);
    };

    WmiMethod1->WmiMethodName = "RenewDHCPLease";
    if (WmiMethod1->Execute() == 0) {
      RefreshInfo();
      ShowMessage("You have to reboot the computer for the changes to take effect");
    } else {
      AnsiString s = WmiMethod1->LastWmiErrorDescription;
      Application->MessageBox(s.c_str(), "Error renewing DHCP lease", MB_ICONHAND + MB_OK);
    };
  } __finally {
    Screen->Cursor = crDefault;
  };
}
//---------------------------------------------------------------------------

void __fastcall TFrmNetworkConfigMain::tlbRefreshClick(TObject *Sender)
{
  RefreshInfo();
}
//---------------------------------------------------------------------------

void __fastcall TFrmNetworkConfigMain::SetFormCaption() {
  if (WmiConnection1->MachineName.Length() == 0) {
    Caption = "Network configuration on local host";
  } else {
    Caption = "Network configuration on " + WmiConnection1->MachineName;
  }  
};

void __fastcall TFrmNetworkConfigMain::tlbConnectClick(TObject *Sender)
{

  if (FrmSelectHost->ShowModal() == mrOk) {
    // save current credentials to be able to restore
    // them if new credentials are invalid.
    WideString vOldUserName = WmiConnection1->Credentials->UserName;
    WideString vOldPassword = WmiConnection1->Credentials->Password;
    WideString vOldMachineName = WmiConnection1->MachineName;

    WmiConnection1->Connected = false;
    AnsiString vUserName = FrmSelectHost->edtUserName->Text;
    if (FrmSelectHost->edtDomain->Text.Length() > 0) {
      vUserName = FrmSelectHost->edtDomain->Text + "\\" + vUserName;
    }

    WmiConnection1->Credentials->UserName = vUserName;
    WmiConnection1->Credentials->Password = FrmSelectHost->edtPassword->Text;
    WmiConnection1->MachineName = FrmSelectHost->cmbComputers->Text;

    TCursor vWasCursor = Screen->Cursor;
    Screen->Cursor = crHourGlass;
    try {
      __try {
        WmiConnection1->Connected = true;
        SetFormCaption();
	RefreshInfo();
      } __finally {
        Screen->Cursor = vWasCursor;
      };
    } catch(const Exception &e) {
          Application->MessageBox(e.Message.c_str(), "Error", MB_OK + MB_ICONSTOP);
          // restore previous credentials.
          WmiConnection1->Credentials->UserName = vOldUserName;
          WmiConnection1->Credentials->Password = vOldPassword;
          WmiConnection1->MachineName           = vOldMachineName;
          WmiConnection1->Connected = true;
	  RefreshInfo();
    };
  };
}

//---------------------------------------------------------------------------

