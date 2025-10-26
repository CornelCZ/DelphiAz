program StorageInfo;

uses
  Forms,
  FrmMainU in 'FrmMainU.pas' {FrmMain},
  FrmNewHostU in 'FrmNewHostU.pas' {FrmNewHost},
  FrmAboutU in 'FrmAboutU.pas' {FrmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmAbout, FrmAbout);
  Application.Run;
end.
