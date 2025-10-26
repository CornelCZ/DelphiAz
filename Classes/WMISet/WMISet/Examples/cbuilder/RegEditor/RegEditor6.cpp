//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------
USEFORM("FrmRegEditorMainU.cpp", FrmRegEditorMain);
USEFORM("FrmSelectHostU.cpp", FrmSelectHost);
USEFORM("FrmEditStringU.cpp", FrmEditString);
USEFORM("FrmEditDWORDU.cpp", FrmEditDWORD);
USEFORM("FrmEditBinaryValueU.cpp", FrmEditBinaryValue);
USEFORM("FrmAboutU.cpp", FrmAbout);
USEFORM("FrmGetNameU.cpp", FrmGetName);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();
                 Application->CreateForm(__classid(TFrmRegEditorMain), &FrmRegEditorMain);
                 Application->CreateForm(__classid(TFrmSelectHost), &FrmSelectHost);
                 Application->CreateForm(__classid(TFrmEditDWORD), &FrmEditDWORD);
                 Application->CreateForm(__classid(TFrmEditBinaryValue), &FrmEditBinaryValue);
                 Application->CreateForm(__classid(TFrmAbout), &FrmAbout);
                 Application->CreateForm(__classid(TFrmGetName), &FrmGetName);
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
