program RegEditor;

uses
  Forms,
  FrmRegEditorMainU in 'FrmRegEditorMainU.pas' {FrmRegEditorMain},
  FrmSelectComputerU in 'FrmSelectComputerU.pas' {FrmSelectComputer},
  FrmEditStringU in 'FrmEditStringU.pas' {FrmEditString},
  FrmEditDWORDU in 'FrmEditDWORDU.pas' {FrmEditDWORD},
  FrmEditBinaryU in 'FrmEditBinaryU.pas' {FrmEditBinaryValue},
  FrmAboutU in 'FrmAboutU.pas' {FrmAbout},
  FrmGetNameU in 'FrmGetNameU.pas' {FrmGetName};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmRegEditorMain, FrmRegEditorMain);
  Application.CreateForm(TFrmSelectComputer, FrmSelectComputer);
  Application.CreateForm(TFrmGetName, FrmGetName);
  Application.Run;
end.
