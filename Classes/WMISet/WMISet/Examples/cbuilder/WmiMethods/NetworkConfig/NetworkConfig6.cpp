//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------
USEFORM("FrmNetworkConfigMainU.cpp", FrmNetworkConfigMain);
USEFORM("FrmStaticAddressU.cpp", FrmStaticAddress);
USEFORM("FrmSelectHostU.cpp", FrmSelectHost);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();
                 Application->CreateForm(__classid(TFrmNetworkConfigMain), &FrmNetworkConfigMain);
                 Application->CreateForm(__classid(TFrmStaticAddress), &FrmStaticAddress);
                 Application->CreateForm(__classid(TFrmSelectHost), &FrmSelectHost);
                 Application->Run();
        }
        catch (Exception &exception)
        {
                 Application->ShowException(&exception);
        }
        catch (...)
        {
                 try
                 {
                         throw Exception("");
                 }
                 catch (Exception &exception)
                 {
                         Application->ShowException(&exception);
                 }
        }
        return 0;
}
//---------------------------------------------------------------------------
