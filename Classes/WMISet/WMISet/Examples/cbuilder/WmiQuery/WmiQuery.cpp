//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------
USEFORM("FrmMainU.cpp", FrmMain);
USEFORM("FrmAboutU.cpp", FrmAbout);
USEFORM("FrmNewHostU.cpp", FrmNewHost);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();
                 Application->CreateForm(__classid(TFrmMain), &FrmMain);
                 Application->CreateForm(__classid(TFrmAbout), &FrmAbout);
                 Application->CreateForm(__classid(TFrmNewHost), &FrmNewHost);
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
