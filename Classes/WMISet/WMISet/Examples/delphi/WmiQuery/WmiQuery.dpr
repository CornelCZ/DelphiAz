program WmiQuery;

uses
  Forms,
  FrmMainU in 'FrmMainU.pas' {FrmMain},
  FrmAboutU in 'FrmAboutU.pas' {FrmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
