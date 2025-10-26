//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("VclCommonDcl50.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("CommPropEditors.pas");
USEUNIT("NTSelectionList.pas");
USEUNIT("DetectWinOS.pas");
USEUNIT("InitComSecurity.pas");
USEUNIT("RpcConstants.pas");
USEUNIT("NTStringTokenizer.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
