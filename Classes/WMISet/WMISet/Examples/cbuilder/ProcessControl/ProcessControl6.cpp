//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------
USEFORM("FrmMainU.cpp", FrmMain);
USEFORM("FrmSelectColumnsU.cpp", FrmSelectColumns);
USEFORM("FrmNewTaskU.cpp", FrmNewTask);
USEFORM("FrmSelectHostU.cpp", FrmSelectHost);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();
                 Application->CreateForm(__classid(TFrmMain), &FrmMain);
                 Application->CreateForm(__classid(TFrmNewTask), &FrmNewTask);
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
