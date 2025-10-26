//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------
USEFORM("FrmScheculedJobMainU.cpp", FrmScheduledJobMain);
USEFORM("FrmNewJobU.cpp", FrmNewJob);
USEFORM("FrmSelectHostU.cpp", FrmSelectHost);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();
                 Application->CreateForm(__classid(TFrmScheduledJobMain), &FrmScheduledJobMain);
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
